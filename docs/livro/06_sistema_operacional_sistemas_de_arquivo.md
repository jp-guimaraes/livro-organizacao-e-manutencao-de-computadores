# Capítulo 6 — Sistema Operacional e Sistemas de Arquivo

Neste capítulo você vai estudar o papel do sistema operacional como camada de interface entre hardware, software e usuário; a forma como os sistemas de arquivo organizam o armazenamento secundário em unidades chamadas clusters; a operação de formatação e suas implicações sobre a permanência real dos dados; o conceito de partição e as duas soluções de tabela de partição em uso — MBR e GPT; e o procedimento de inicialização do computador, do POST ao carregamento do sistema operacional. O Capítulo 7 dá sequência direta a este, tratando da instalação propriamente dita.

---

## 6.1 O sistema operacional como interface

Um sistema operacional (SO, do inglês *Operating System*, OS) é um software cuja função central é atuar como **interface** entre o hardware do computador e os demais softwares e usuários. O termo *interface* designa aquilo que se coloca entre duas faces, mediando a relação entre elas sem se confundir com nenhuma delas.

Em termos de camadas, o hardware ocupa a base do sistema; sobre ele executa o sistema operacional, cujo núcleo é chamado de **kernel**; e acima do sistema operacional executam os demais programas — desde o próprio ambiente gráfico (o menu iniciar, os ícones, as janelas) até os aplicativos que o usuário abre, como um navegador ou um editor de texto.


!!! warning "Figura pendente"
    diagrama em camadas — hardware na base, kernel do sistema operacional no meio, aplicativos e usuário no topo


### 6.1.1 Abstração e plataforma

O Capítulo 2 (§2.1) apresentou os conceitos de **plataforma** e **abstração em camadas** a partir do exemplo do navegador. Aplicados ao sistema operacional: um desenvolvedor de software não precisa saber qual é o modelo da memória RAM instalada, a marca do disco ou a velocidade da placa de vídeo do computador em que seu programa vai rodar — ele apenas chama funções do sistema operacional, e é o SO quem trata da comunicação efetiva com aquele hardware específico. Um programa feito para a plataforma Windows não roda nativamente em outra plataforma, a menos que exista uma versão também disponível para ela — o que caracteriza um software **multiplataforma**. O Microsoft Word, por exemplo, existe para Windows e para macOS, mas não tem versão nativa para Linux (é a comunidade, não a Microsoft, quem mantém camadas de compatibilidade para rodá-lo lá). No caso de uma aplicação web, a própria plataforma é o navegador, e não o sistema operacional subjacente.

Antes da consolidação dos sistemas operacionais modernos, um programa era escrito diretamente para o hardware que o executaria — de forma semelhante ao que ocorre hoje com uma placa Arduino, cujo código precisa ser adaptado ou reescrito se a arquitetura mudar.

Historicamente, a superação dessa dependência direta ocorreu em duas etapas principais de abstração. A primeira etapa resolveu a variabilidade dos periféricos: cada teclado, monitor ou unidade de disco possuía particularidades próprias, obrigando quem programava a lidar manualmente com os registradores de cada dispositivo. O surgimento de camadas padronizadas de entrada e saída — o **BIOS** (*Basic Input Output System*, aprofundado no Capítulo 6, §6.6) —  nos microcomputadores, unificou o acesso a essa camada básica de hardware.

Contudo, mesmo com o suporte do BIOS, sistemas simples (como o antigo MS-DOS) ainda operavam de forma monotarefa: cada programa ocupava sozinho os recursos da máquina, sendo necessário encerrá-lo por completo para iniciar outro, exatamente como em um microcontrolador simples. A evolução definitiva dos sistemas operacionais resolveu esse gargalo ao assumir o gerenciamento dinâmico dos recursos, viabilizando uma propriedade fundamental: **a execução de múltiplos programas concorrentemente**, alternando (chaveando) o processador e a memória de forma coordenada entre eles.


### 6.1.2 Da era monofunção à multitarefa

**Exemplo.** Antes dos smartphones modernos, cada função dependia de um dispositivo dedicado: um iPod para ouvir música, uma câmera para fotografar, um telefone para ligar, um bloco de papel para anotar. Esses aparelhos eram **monofunção**. O smartphone moderno reúne um hardware capaz de realizar todas essas tarefas e, sobre ele, instala um sistema operacional capaz de gerenciar múltiplos programas simultaneamente — permitindo, por exemplo, ouvir música no Spotify enquanto se recebe uma mensagem e um e-mail ao mesmo tempo. É o sistema operacional que faz a interface entre esses vários programas aplicativos, o usuário e o hardware do aparelho.

Existem hoje dezenas de sistemas operacionais reais em uso — diferentes versões do Windows, distribuições Linux (Ubuntu, Debian, Arch, entre muitas outras), macOS, Android, iOS, e sistemas voltados especificamente a servidores, como o FreeBSD. Cada um tem requisitos, pontos fortes e pontos fracos próprios: não existe "o melhor sistema operacional" em termos absolutos — existe o mais adequado a uma demanda específica.

---

## 6.2 Sistemas de arquivo e a unidade mínima de alocação: o cluster

O **sistema de arquivo** é o protocolo — o conjunto de combinados — pelo qual o sistema operacional organiza e localiza dados dentro de uma unidade de armazenamento secundário. Sistemas operacionais diferentes utilizam, em geral, sistemas de arquivo diferentes: o Windows usa hoje o **NTFS** (e usou historicamente o FAT); distribuições Linux usam tipicamente **EXT4**; Android, iOS e macOS têm, cada um, seus próprios sistemas de arquivo.

Um programa não acessa o disco diretamente: quando um editor de texto salva um arquivo (em Python, por exemplo, com `open(...)`), ele faz **chamadas de sistema**, pedindo ao sistema operacional que crie e grave o arquivo — por isso o mesmo programa é executado de formas diferentes no Windows, no Linux ou no macOS. O sistema de arquivo, por sua vez, guarda bytes sem interpretá-los: quem decide que a letra `a` vira o byte `0x61` (`0110 0001`) é o programa, seguindo uma tabela de codificação como a ASCII ou a UTF-8; o sistema de arquivo registra onde esses bytes estão e quais metadados os acompanham.

Para que uma mídia removível funcione em sistemas operacionais diferentes, ela precisa usar um sistema de arquivo que todos reconheçam — caso do **FAT32**, antigo e simples, ainda comum em pendrives e câmeras, e do seu sucessor **exFAT**, padrão de fábrica de pendrives e cartões acima de 32 GB. O FAT32 tem um limite prático importante: não aceita arquivos maiores que 4 GB.

A unidade mínima de alocação de espaço em disco para arquivos e diretórios é o **cluster**: um grupo de setores consecutivos (o setor é a menor unidade que o próprio disco lê ou grava — Capítulo 5) que o sistema de arquivo trata como uma unidade só. Dentro de uma mesma partição, todos os clusters têm o mesmo tamanho.

Ao formatar uma unidade de armazenamento, o sistema operacional solicita, entre outras informações, o **tamanho da unidade de alocação** (o tamanho do cluster). No NTFS, o Windows oferece desde 512 bytes até 2 MB (os tamanhos acima de 64 KB passaram a ser aceitos a partir do Windows 10, versão 1709), além de um tamanho padrão sugerido para o dispositivo — 4 KB para a maioria dos volumes `[1]`.


!!! warning "Figura pendente"
    janela de formatação do Windows mostrando a escolha do sistema de arquivo (FAT32, NTFS, exFAT) e do tamanho da unidade de alocação


### 6.2.1 File slack

Como cada arquivo ocupa um número inteiro de clusters, raramente o tamanho lógico de um arquivo coincide exatamente com o espaço físico que ele ocupa em disco. Essa diferença é chamada de **file slack**.

**Exemplo.** Nas propriedades de um arquivo de áudio real usado em demonstração, o tamanho do arquivo (tamanho lógico) era de 27.550.336 bytes (26,2 MB), enquanto o tamanho em disco (espaço físico ocupado) era de 27.553.792 bytes — uma diferença decorrente de o arquivo não preencher por completo o último cluster que lhe foi atribuído.

**Exemplo com clusters diferentes.** Um arquivo de texto de 5.322 bytes, gravado numa partição NTFS com cluster padrão de 4 KB, ocupa 8 KB em disco — dois clusters. Acrescentar mais 20 bytes não altera esse valor: o segundo cluster ainda tinha folga. Com a mesma partição reformatada com cluster de 2 MB, um arquivo de apenas 1.243 bytes passa a ocupar 2 MB em disco — o cluster inteiro.

### 6.2.2 Fragmentação

A escolha do tamanho do cluster no momento da formatação gera compromissos entre quatro cenários possíveis, resumidos na tabela a seguir.

| Cenário | Cluster | Arquivo | Efeito |
|---|---|---|---|
| 1 | Pequeno | Pequeno | Cenário ideal, mas irreal em um computador de uso geral |
| 2 | Pequeno | Grande | Fragmentação: o arquivo é quebrado em muitos pedaços |
| 3 | Grande | Pequeno | File slack elevado: grande parte do disco é desperdiçada |
| 4 | Grande | Grande | Cenário aceitável, mas também irreal isoladamente |

Como um computador moderno lida simultaneamente com arquivos pequenos e grandes, a situação real está sempre mais próxima dos cenários 2 e 3, exigindo um meio-termo na escolha do tamanho do cluster. O cenário 3 — cluster grande com arquivo pequeno — é considerado o mais prejudicial, por gerar o maior desperdício proporcional de espaço em disco.

A **fragmentação** ocorre porque, à medida que arquivos são apagados e recriados de tamanhos distintos, os espaços livres deixados por exclusões (buracos) nem sempre comportam o próximo arquivo a ser gravado por inteiro, obrigando o sistema operacional a dividir um mesmo arquivo em blocos não contíguos no disco. A ferramenta de **desfragmentação** existe justamente para reorganizar esses blocos e reduzir esse efeito.

O custo da fragmentação vem, sobretudo, do movimento mecânico da cabeça de leitura do HD, que precisa saltar entre regiões do disco para ler um mesmo arquivo. Em unidades de estado sólido (SSD), sem partes móveis, esse impacto é desprezível — por isso o Windows não desfragmenta SSDs da forma tradicional: a ferramenta "Otimizar unidades" apenas informa ao SSD quais blocos estão livres (comando TRIM). Desfragmentar um SSD consumiria ciclos de escrita, que são limitados (Capítulo 5).

---

## 6.3 A operação de formatação

**Formatar** uma unidade de armazenamento significa atribuir a ela um sistema de arquivo — ou seja, "colocá-la em um formato", um combinado que o sistema operacional passa a reconhecer e utilizar. Antes da formatação, uma partição sem sistema de arquivo atribuído não pode ser usada pelo sistema operacional: nenhum programa consegue gravar ou ler dados nela.

Um efeito colateral direto da formatação é a perda de todos os arquivos e diretórios anteriormente existentes naquela unidade.

### 6.3.1 O que a formatação realmente faz: metadados, exclusão e recuperação de dados

Cada dado gravado em disco é acompanhado de **metadados** — dados sobre o próprio dado. Convém distinguir dois tipos: os **metadados do sistema de arquivo** (nome, tamanho, datas de criação, modificação e último acesso, dono, permissões, atributos de somente leitura ou oculto), registrados pelo sistema de arquivo fora do conteúdo do arquivo; e os **metadados internos ao arquivo** (o autor de uma planilha, o título de um PDF, o álbum de uma música nas *tags* ID3, os dados da câmera de uma foto em EXIF), gravados pelo programa que criou o arquivo como parte do seu conteúdo — e que, por isso, viajam com ele para qualquer computador. Um mecanismo semelhante a uma tabela de referências indica onde cada arquivo começa e onde termina dentro do disco.

**Exemplo.** Suponha uma sequência de células de memória em que o valor 1001 foi gravado, seguido do valor 101. Sem uma marcação adicional, não é possível saber onde termina um número e começa o outro. A solução é registrar, para cada dado, uma referência com a posição inicial e o comprimento (por exemplo: "o dado A começa aqui e tem comprimento 4"). Apagar um arquivo consiste, nesse esquema, simplesmente em remover essa referência — não em reescrever os bits do dado propriamente dito.

Essa é a razão pela qual formatar ou apagar um arquivo não desgasta uma memória flash (como um pendrive ou SSD) na mesma proporção que reescrever cada bit: a operação normalmente descarta apenas a tabela de referências, preservando o conteúdo bruto até que aquele espaço seja reutilizado.

A **lixeira** do sistema operacional é uma lista de arquivos cuja referência está marcada como "pode ser removida no futuro", mas ainda não foi de fato eliminada — uma camada extra de segurança contra exclusões acidentais. Enquanto o dado permanecer fisicamente gravado, softwares de recuperação de dados podem restaurá-lo, mesmo após a formatação: eles percorrem o disco bit a bit em busca de cabeçalhos característicos de cada tipo de arquivo (por exemplo, os bytes iniciais que identificam um `.docx`) — os cabeçalhos e rodapés que funcionam como a **assinatura** de cada tipo de arquivo — e, supondo que o conteúdo foi gravado de forma contígua, reconstroem o que estiver entre o início e o fim identificados. Essa técnica é chamada de *file carving*; um exemplo de ferramenta que a implementa é o Foremost.

Nos sistemas de arquivo comuns, um cluster pertence a um único arquivo. Mas, quando um arquivo novo ocupa um cluster antes usado e não o preenche por completo, a sobra — o file slack (§6.2.1) — ainda pode conter restos do arquivo anterior. Em computação forense, esse resíduo é chamado de *slack space*.

A recuperação após uma formatação vale para a **formatação rápida**, que apenas recria as estruturas do sistema de arquivo. No Windows (desde o Vista), a **formatação completa** também grava zeros em todo o volume.

**Apagamento seguro.** Quando o objetivo é impedir a recuperação — por exemplo, antes de vender ou descartar um disco —, o caminho é destruir os padrões que as ferramentas de recuperação procuram, sobrescrevendo toda a unidade. Métodos antigos recomendavam várias passadas; para HDs modernos, uma passada completa é suficiente `[6]`. Em SSDs, sobrescrever pelo sistema operacional não garante o apagamento: o controlador distribui as gravações entre as células (*wear leveling*) e mantém uma área reserva invisível ao sistema. Nesse caso, recomenda-se o comando de apagamento do próprio dispositivo (Secure Erase/Sanitize), ou manter a unidade criptografada e descartar a chave. Criptografia e apagamento seguro não se excluem — podem ser combinados.

**Aplicação prática.** Se um computador estiver infectado por um malware capturando dados do usuário, formatar o disco elimina o malware — mas também elimina, junto com ele, todos os demais dados do usuário, incluindo aqueles que se desejaria preservar. É, na expressão usada em aula, "matar uma mosca com uma bazuca": resolve o problema, mas com um custo desproporcional se não houver backup prévio (Capítulo 7, §7.2.1).


!!! warning "Figura pendente"
    esquema comparando a tabela de referências antes e depois da exclusão de um arquivo


---

## 6.4 Partições: divisão lógica do disco

Uma **partição** é uma divisão lógica de um disco físico — não uma divisão física real.

Todo disco precisa ter **ao menos uma partição** para que o sistema operacional possa atribuir a ele um sistema de arquivo e utilizá-lo — mesmo que essa única partição ocupe a totalidade do espaço físico disponível. O espaço que não pertence a nenhuma partição é chamado de **espaço não alocado** e não pode ser usado para guardar arquivos. A partição é, portanto, o **alvo** da formatação. Para os programas, é indiferente gravar numa partição ou num disco inteiro: uma partição de 50 GB é tratada exatamente como seria um segundo disco ou um pendrive de 50 GB.

Cada partição é formada por múltiplos clusters. O Windows atribui uma **letra de unidade** a cada partição que reconhece (`C:`, `D:`...) e passa a tratá-las como se fossem discos diferentes — o que permite, por exemplo, definir permissões ou cotas por unidade. Fisicamente, porém, continua existindo um único disco: não é possível remover só uma partição e levá-la para outro computador — para isso, é preciso copiar os dados para outro dispositivo.

### 6.4.1 Sistemas de arquivo por partição e o conceito de dual boot

Cada partição pode ter atrelado a si um sistema de arquivo próprio, independente das demais partições do mesmo disco. Essa propriedade tem duas consequências práticas relevantes:

- **Modularização de uso.** É possível reservar cotas de espaço distintas para finalidades diferentes — por exemplo, dividir um mesmo disco entre dois usuários de uma mesma máquina.
- **Coexistência de sistemas operacionais.** Como sistemas operacionais diferentes exigem sistemas de arquivo diferentes (o Windows opera sobre NTFS; uma distribuição Linux como o Ubuntu opera sobre EXT4), um único disco físico pode conter partições distintas, cada uma com seu próprio sistema operacional instalado.

Quando um computador com múltiplos sistemas operacionais instalados é ligado e apresenta uma tela de escolha entre eles, esse mecanismo é chamado de **dual boot** (ou *multi boot*, se houver mais de dois sistemas). *Boot* é o termo em inglês para o procedimento de inicialização; dual boot significa, portanto, que há mais de uma forma possível de inicializar aquele computador, cada uma delas carregando um sistema operacional diferente, tratado em detalhe no Capítulo 7, §7.5.

| Sistema operacional | Sistema de arquivo típico |
|---|---|
| Windows | NTFS (historicamente, FAT) |
| Linux (ex.: Ubuntu) | EXT4 (historicamente, EXT3) |
| Pendrives / mídias removíveis | FAT32 ou exFAT |


!!! warning "Figura pendente"
    captura do gerenciador de disco do Windows mostrando um disco físico dividido em múltiplas partições


### 6.4.2 Um sistema operacional por vez — e a virtualização

No dual boot, os sistemas operacionais **não** rodam ao mesmo tempo: cada um, quando inicializado, assume o controle total do hardware (processador, memória, USB, disco), e não é possível que dois sistemas comandem o mesmo hardware simultaneamente. Para trocar de sistema, é preciso reiniciar o computador.

Para executar mais de um sistema operacional ao mesmo tempo, recorre-se à **virtualização** — em que um sistema continua sendo o dominante do hardware:

- **Máquina virtual (VM):** um sistema operacional completo roda como um programa aplicativo sobre outro, com o apoio de recursos de virtualização do próprio processador.
- **Emulador:** imita por software um hardware *diferente* (por exemplo, um console antigo), com custo de desempenho bem maior que o de uma VM.
- **WSL (*Windows Subsystem for Linux*):** no Windows, executa um núcleo Linux numa máquina virtual leve e integrada ao sistema, com desempenho próximo ao nativo.
- **Contêineres (ex.: Docker):** não trazem um sistema operacional próprio — compartilham o núcleo do hospedeiro e isolam apenas a aplicação, suas bibliotecas e sua infraestrutura, o que os torna muito mais leves que uma VM.
- **Hipervisores dedicados (ex.: Proxmox):** dividem o hardware inteiro — núcleos, memória, armazenamento, até periféricos e placas de rede — entre várias máquinas virtuais que rodam simultaneamente.

---

## 6.5 Tabelas de partição: MBR e GPT

As informações sobre quantas partições um disco possui, onde cada uma começa e termina, e qual sistema de arquivo está atrelado a cada uma constituem, elas próprias, um conjunto de metadados que precisa ser gravado em algum lugar do disco. A estrutura responsável por essa organização é chamada de **tabela de partições**.

Existem duas soluções de tabela de partição amplamente utilizadas: **MBR** (mais antiga) e **GPT** (mais recente).

### 6.5.1 Master Boot Record (MBR)

O **MBR** (*Master Boot Record*) grava a tabela de partições em um setor específico no início do disco, usando endereçamento de **32 bits**. Dessa limitação de endereçamento decorrem duas restrições centrais:

- O tamanho máximo de uma partição é de **2 TB**.
- É possível criar no máximo **quatro partições primárias** `[2]`.

Para superar o limite de quatro partições, uma das partições primárias pode ser convertida em **partição estendida**, dentro da qual é possível criar até **128 partições lógicas**. Uma consequência prática dessa regra é que múltiplas partições lógicas devem estar todas contidas dentro de uma única partição estendida — não é possível, por exemplo, dividir 64 partições lógicas entre duas partições primárias diferentes.

**Exemplo.** Um disco já dividido em quatro partições primárias atingiu o limite da tabela MBR. Para criar uma quinta divisão, uma das quatro partições primárias precisa ser apagada e recriada como partição estendida; somente dentro dela é possível abrir novas partições lógicas adicionais.

### 6.5.2 GUID Partition Table (GPT)

O **GPT** (*GUID Partition Table*) foi desenvolvido para superar as limitações do MBR, mantendo **retrocompatibilidade** com ele — isto é, softwares e firmwares mais antigos, mesmo sem reconhecer o GPT, ainda conseguem ler as informações essenciais gravadas no mesmo local histórico do disco.

Cada disco identificado em GPT recebe um **GUID** (*Globally Unique Identifier*), um identificador único análogo a um endereço IP em uma rede. Usando endereçamento de **64 bits**, o GPT permite partições na ordem de zettabytes `[3]`, até **128 partições** — o padrão adotado pelo Windows; a especificação GPT em si permite um número de partições configurável, tipicamente maior `[4]` — sem a necessidade do artifício de partições estendidas, e inclui um mecanismo de **redundância**: como historicamente ataques que reescreviam apenas o setor da tabela de partições eram suficientes para inutilizar o acesso a um disco inteiro (sem apagar os dados propriamente ditos, mas destruindo a referência para encontrá-los), o GPT mantém cópias redundantes dessa informação.

| Característica | MBR | GPT |
|---|---|---|
| Época de criação | Mais antiga | Mais recente |
| Endereçamento | 32 bits | 64 bits |
| Tamanho máximo de partição | 2 TB | Na casa de zettabytes |
| Partições primárias | Até 4 | Até 128 (sem partição estendida) |
| Partições lógicas | Até 128, dentro de uma partição estendida | Não se aplica |
| Redundância da tabela | Não | Sim |
| Firmware associado historicamente | BIOS | UEFI |


!!! warning "Figura pendente"
    diagrama do layout de um disco em MBR — código de inicialização, tabela de partições e partições de dados


---

## 6.6 BIOS, UEFI e o procedimento de inicialização

O **BIOS** (*Basic Input/Output System*), introduzido no Capítulo 1 a propósito do IBM PC, é o conjunto de softwares gravado na placa-mãe responsável por inicializar o hardware e oferecer uma interface básica de entrada e saída antes de qualquer sistema operacional ser carregado. Ele é composto, entre outros elementos, por dois programas centrais: o **POST** e o **Setup**. O **UEFI** (*Unified Extensible Firmware Interface*) é a evolução moderna desse firmware, com interface gráfica navegável por mouse — em contraste com as telas de texto do BIOS tradicional.

### 6.6.1 POST

O **POST** (*Power On Self Test*, autoteste de inicialização) é o primeiro programa executado quando o computador é ligado. Sua função é varrer os componentes de hardware — processador, memória, teclado, entre outros — em busca de falhas, antes de liberar o controle da CPU para qualquer outro software.

Se algum componente essencial falhar no teste, o POST comunica o erro por meio de sinais sonoros (bips), já que, sem memória funcional, ele não tem como exibir uma mensagem na tela — mostrar algo na tela já é, em si, uma operação de software que depende de memória disponível. A quantidade e o padrão de bips indicam, conforme o manual da placa-mãe, qual componente falhou (por exemplo, ausência ou defeito de memória RAM); o Capítulo 9 aprofunda o POST sob a ótica dos componentes de hardware que ele avalia.

Do ponto de vista do diagnóstico técnico, um POST bem-sucedido indica que processador, memória e placa-mãe estão minimamente funcionais — o que não exclui problemas de hardware que só se manifestem sob carga (como superaquecimento durante o uso), nem problemas de software, que só podem ocorrer depois que o POST é concluído com sucesso.

### 6.6.2 Setup

O **Setup** é o programa que permite alterar as configurações de hardware do computador — frequência do processador e da memória (overclock), habilitação ou desabilitação de funcionalidades, data e hora do sistema, e a **ordem de inicialização** (*boot order*), entre outras.

Essas configurações — incluindo a informação de qual dispositivo de armazenamento contém o sistema operacional a ser carregado — precisam ser preservadas mesmo com o computador desligado. Por isso, ficam gravadas em uma pequena memória flash não volátil na própria placa-mãe, dedicada a esse fim; o Capítulo 9 trata da bateria que mantém essa memória energizada com o computador desligado da tomada.

### 6.6.3 Boot: carregamento do sistema operacional

Concluído o POST com sucesso, o próximo passo padrão é o **boot** (inicialização) do sistema operacional: a cópia do sistema operacional da memória secundária, onde está instalado, para a memória primária (RAM), de onde ele passa a ser executado — retomando o conceito de hierarquia de memória apresentado no Capítulo 1 (Seção 1.10) e aprofundado no Capítulo 5.

Para saber onde procurar o sistema operacional entre as possivelmente várias partições e discos existentes, o computador consulta a variável de ordem de inicialização gravada na memória da placa-mãe (Seção 6.6.2). É possível interromper esse fluxo padrão e forçar a inicialização a partir de outro dispositivo — como um pendrive — de duas formas: alterando permanentemente a ordem de boot dentro do Setup, ou acionando, na tela do POST, um atalho de teclado que abre o chamado **boot menu**, uma lista de dispositivos disponíveis para inicialização imediata (nas máquinas descritas em aula, a tecla de atalho variava entre **F9**, **F11**/**F12** ou a sequência **10 → F12**, dependendo do fabricante).


!!! warning "Figura pendente"
    tela de POST/BIOS de um computador real, mostrando o logotipo do fabricante e a instrução para acessar o boot menu



!!! warning "Figura pendente"
    tela de Setup/BIOS com a configuração de ordem de inicialização (boot order) destacada


### 6.6.4 Segurança e ética do acesso físico

Um ponto central para a formação de um técnico de informática é a compreensão de que **o acesso físico a uma máquina muda todos os paradigmas de segurança** — formulação que corresponde à "Lei nº 3" das clássicas "10 Immutable Laws of Security" da Microsoft `[5]`. Se é possível interromper o boot padrão e carregar, em vez do sistema operacional instalado, um programa alternativo a partir de um pendrive — por exemplo, um Live CD/USB (Capítulo 7, §7.3) —, é possível se tornar administrador daquela máquina sem conhecer nenhuma senha, e a partir daí acessar, copiar ou apagar qualquer dado nela contido, independentemente das proteções de software configuradas pelo usuário original.

Essa mesma técnica que permite, de forma legítima, recuperar o acesso a uma máquina cujo usuário esqueceu a senha, pode ser usada de forma ilegítima para violar dados de terceiros sem autorização. Por essa razão, deixar um pendrive ou dispositivo USB como primeira opção na ordem de inicialização é considerado uma **falha de segurança grave**: qualquer pessoa com acesso físico breve à máquina pode assumir controle administrativo total sobre ela. O uso ético dessas técnicas — e a orientação de nunca acessar dados sensíveis de um cliente sem que ele esteja presente e ciente do procedimento — é parte inseparável da formação técnica apresentada neste capítulo.

---

## Síntese do capítulo

Este capítulo apresentou o sistema operacional como a camada de interface entre hardware, software e usuário, detalhando como essa camada organiza o armazenamento secundário — introduzido no Capítulo 5 em termos de blocos, páginas e setores — por meio de clusters, sistemas de arquivo e partições. Foram estudadas as duas soluções de tabela de partição em uso, MBR e GPT, e o procedimento completo de inicialização do computador: POST, Setup/BIOS e boot. Esses conceitos formam a base necessária para o Capítulo 7, no qual o processo completo de instalação de um sistema operacional é tratado em detalhe — da preparação da mídia à instalação de drivers, passando por backup, dual boot, diagnóstico via Live CD/USB e a manutenção contínua dessa camada de software.

---

## Referências

1. MICROSOFT. "NTFS overview." Disponível em: <https://learn.microsoft.com/en-us/windows-server/storage/file-server/ntfs-overview>.
2. MICROSOFT. "Windows support for hard disks exceeding 2 TB." Disponível em: <https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/support-for-hard-disks-exceeding-2-tb>; UEFI FORUM. "FAQ: Drive Partition Limits." Disponível em: <https://uefi.org/sites/default/files/resources/UEFI_Drive_Partition_Limits_Fact_Sheet.pdf>.
3. UEFI FORUM. "FAQ: Drive Partition Limits." Disponível em: <https://uefi.org/sites/default/files/resources/UEFI_Drive_Partition_Limits_Fact_Sheet.pdf>.
4. MICROSOFT. "Windows and GPT FAQ." Disponível em: <https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/windows-and-gpt-faq>.
5. MICROSOFT. "10 Immutable Laws of Security (Version 2.0)." Disponível em: <https://learn.microsoft.com/en-us/archive/blogs/rhalbheer/ten-immutable-laws-of-security-version-2-0>.
6. NIST. "SP 800-88 Rev. 1: Guidelines for Media Sanitization." Disponível em: <https://csrc.nist.gov/pubs/sp/800/88/r1/final>.
