# Capítulo 3 — Sistema operacional, sistemas de arquivo e instalação

Neste capítulo você vai estudar o papel do sistema operacional como camada de interface entre hardware, software e usuário; a forma como os sistemas de arquivo organizam o armazenamento secundário em unidades chamadas clusters; a operação de formatação e suas implicações sobre a permanência real dos dados; o conceito de partição e as duas soluções de tabela de partição em uso — MBR e GPT; o procedimento de inicialização do computador, do POST ao carregamento do sistema operacional; e o processo completo de instalação de um sistema operacional, incluindo backup, particionamento avançado, instalação em dual boot e instalação de drivers.

---

## 3.1 O sistema operacional como interface

Um sistema operacional (SO, do inglês *Operating System*, OS) é um software cuja função central é atuar como **interface** entre o hardware do computador e os demais softwares e usuários. O termo *interface* designa aquilo que se coloca entre duas faces, mediando a relação entre elas sem se confundir com nenhuma delas.

**Analogia.** Uma calçada não é a rua nem é a casa: é o elemento que fica entre as duas, permitindo que se passe de um espaço para o outro. Da mesma forma, o sistema operacional não é o hardware nem é o aplicativo que o usuário está utilizando — ele é a camada que está entre os dois, viabilizando a comunicação.

Em termos de camadas, o hardware ocupa a base do sistema; sobre ele executa o sistema operacional, cujo núcleo é chamado de **kernel**; e acima do sistema operacional executam os demais programas — desde o próprio ambiente gráfico (o menu iniciar, os ícones, as janelas) até os aplicativos que o usuário abre, como um navegador ou um editor de texto.

[IMAGEM: diagrama em camadas — hardware na base, kernel do sistema operacional no meio, aplicativos e usuário no topo]

### 3.1.1 Abstração e plataforma

O sistema operacional cria uma **abstração** sobre o hardware: um desenvolvedor de software não precisa saber qual é o modelo da memória RAM instalada, a marca do disco ou a velocidade da placa de vídeo do computador em que seu programa vai rodar. Ele apenas chama funções do sistema operacional — por exemplo, para emitir um som ou desenhar uma janela — e é o sistema operacional quem trata da comunicação efetiva com aquele hardware específico.

Esse ambiente para o qual um software é desenvolvido é chamado de **plataforma**. Um programa feito para a plataforma Windows não roda nativamente em outra plataforma, a menos que exista uma versão da ferramenta usada (por exemplo, um banco de dados) disponível também para essa outra plataforma — o que caracteriza um software **multiplataforma**. No caso de uma aplicação web, a própria plataforma é o navegador, e não o sistema operacional subjacente.

Antes da existência do sistema operacional, um programa era escrito diretamente para o hardware que o executaria — de forma semelhante ao que ocorre hoje com uma placa Arduino, cujo programa precisa ser reescrito se a placa mudar. O sistema operacional resolveu esse problema criando uma camada intermediária estável, da qual decorre uma segunda propriedade fundamental: a possibilidade de executar **múltiplos programas ao mesmo tempo**, alternando (fazendo o chaveamento) entre eles os recursos de hardware disponíveis.

### 3.1.2 Da era monofunção à multitarefa

**Exemplo.** Antes dos smartphones modernos, cada função dependia de um dispositivo dedicado: um iPod para ouvir música, uma câmera para fotografar, um telefone para ligar, um bloco de papel para anotar. Esses aparelhos eram **monofunção**. O smartphone moderno reúne um hardware capaz de realizar todas essas tarefas e, sobre ele, instala um sistema operacional capaz de gerenciar múltiplos programas simultaneamente — permitindo, por exemplo, ouvir música no Spotify enquanto se recebe uma mensagem e um e-mail ao mesmo tempo. É o sistema operacional que faz a interface entre esses vários programas aplicativos, o usuário e o hardware do aparelho.

---

## 3.2 Sistemas de arquivo e a unidade mínima de alocação: o cluster

O **sistema de arquivo** é o protocolo — o conjunto de combinados — pelo qual o sistema operacional organiza e localiza dados dentro de uma unidade de armazenamento secundário. Sistemas operacionais diferentes utilizam, em geral, sistemas de arquivo diferentes: o Windows usa hoje o **NTFS** (e usou historicamente o FAT); distribuições Linux usam tipicamente **EXT4**; Android, iOS e macOS têm, cada um, seus próprios sistemas de arquivo.

A unidade mínima de alocação de espaço em disco para arquivos e diretórios é o **cluster**.

**Analogia.** O cluster pode ser entendido como uma gaveta: o sistema operacional não guarda dados em posições arbitrárias do disco, mas em unidades fixas — as gavetas —, cada uma com um tamanho definido no momento da formatação.

Ao formatar uma unidade de armazenamento, o sistema operacional solicita, entre outras informações, o **tamanho da unidade de alocação** (o tamanho do cluster). Valores típicos oferecidos pelo Windows incluem 8.192 bytes, 16 KB, 32 KB e 64 KB, além de um tamanho padrão sugerido para o dispositivo.

[IMAGEM: janela de formatação do Windows mostrando a escolha do sistema de arquivo (FAT32, NTFS, exFAT) e do tamanho da unidade de alocação]

### 3.2.1 File slack

Como cada arquivo ocupa um número inteiro de clusters, raramente o tamanho lógico de um arquivo coincide exatamente com o espaço físico que ele ocupa em disco. Essa diferença é chamada de **file slack**.

**Exemplo.** Nas propriedades de um arquivo de áudio real usado em demonstração, o tamanho do arquivo (tamanho lógico) era de 27.550.336 bytes (26,2 MB), enquanto o tamanho em disco (espaço físico ocupado) era de 27.553.792 bytes — uma diferença decorrente de o arquivo não preencher por completo o último cluster que lhe foi atribuído.

### 3.2.2 Fragmentação

A escolha do tamanho do cluster no momento da formatação gera compromissos entre quatro cenários possíveis, resumidos na tabela a seguir.

| Cenário | Cluster | Arquivo | Efeito |
|---|---|---|---|
| 1 | Pequeno | Pequeno | Cenário ideal, mas irreal em um computador de uso geral |
| 2 | Pequeno | Grande | Fragmentação: o arquivo é quebrado em muitos pedaços |
| 3 | Grande | Pequeno | File slack elevado: grande parte do disco é desperdiçada |
| 4 | Grande | Grande | Cenário aceitável, mas também irreal isoladamente |

Como um computador moderno lida simultaneamente com arquivos pequenos e grandes, a situação real está sempre mais próxima dos cenários 2 e 3, exigindo um meio-termo na escolha do tamanho do cluster. O cenário 3 — cluster grande com arquivo pequeno — é considerado o mais prejudicial, por gerar o maior desperdício proporcional de espaço em disco.

A **fragmentação** ocorre porque, à medida que arquivos são apagados e recriados de tamanhos distintos, os espaços livres deixados por exclusões (buracos) nem sempre comportam o próximo arquivo a ser gravado por inteiro, obrigando o sistema operacional a dividir um mesmo arquivo em blocos não contíguos no disco. A ferramenta de **desfragmentação** existe justamente para reorganizar esses blocos e reduzir esse efeito.

---

## 3.3 A operação de formatação

**Formatar** uma unidade de armazenamento significa atribuir a ela um sistema de arquivo — ou seja, "colocá-la em um formato", um combinado que o sistema operacional passa a reconhecer e utilizar. Antes da formatação, uma partição sem sistema de arquivo atribuído não pode ser usada pelo sistema operacional: nenhum programa consegue gravar ou ler dados nela.

Um efeito colateral direto da formatação é a perda de todos os arquivos e diretórios anteriormente existentes naquela unidade.

### 3.3.1 O que a formatação realmente faz: metadados, exclusão e recuperação de dados

Cada dado gravado em disco é acompanhado de **metadados**: informações sobre o próprio dado, como o nome do arquivo, o momento de criação, de modificação e de último acesso, atributos de somente leitura ou oculto, e assinatura digital, entre outros. Um mecanismo semelhante a uma tabela de referências indica onde cada arquivo começa e onde termina dentro do disco.

**Exemplo.** Suponha uma sequência de células de memória em que o valor 1001 foi gravado, seguido do valor 101. Sem uma marcação adicional, não é possível saber onde termina um número e começa o outro. A solução é registrar, para cada dado, uma referência com a posição inicial e o comprimento (por exemplo: "o dado A começa aqui e tem comprimento 4"). Apagar um arquivo consiste, nesse esquema, simplesmente em remover essa referência — não em reescrever os bits do dado propriamente dito.

Essa é a razão pela qual formatar ou apagar um arquivo não desgasta uma memória flash (como um pendrive ou SSD) na mesma proporção que reescrever cada bit: a operação normalmente descarta apenas a tabela de referências, preservando o conteúdo bruto até que aquele espaço seja reutilizado.

A **lixeira** do sistema operacional é uma lista de arquivos cuja referência está marcada como "pode ser removida no futuro", mas ainda não foi de fato eliminada — uma camada extra de segurança contra exclusões acidentais. Enquanto o dado permanecer fisicamente gravado, softwares de recuperação de dados podem restaurá-lo, mesmo após a formatação: eles percorrem o disco bit a bit em busca de cabeçalhos característicos de cada tipo de arquivo (por exemplo, os bytes iniciais que identificam um `.docx`) e, pelo princípio da localidade, reconstroem o conteúdo entre o início e o fim identificados.

**Aplicação prática.** Se um computador estiver infectado por um malware capturando dados do usuário, formatar o disco elimina o malware — mas também elimina, junto com ele, todos os demais dados do usuário, incluindo aqueles que se desejaria preservar. É, na expressão usada em aula, "matar uma mosca com uma bazuca": resolve o problema, mas com um custo desproporcional se não houver backup prévio (Seção 3.9).

[IMAGEM: esquema comparando a tabela de referências antes e depois da exclusão de um arquivo]

---

## 3.4 Partições: divisão lógica do disco

Uma **partição** é uma divisão lógica de um disco físico — não uma divisão física real.

**Analogia.** A fronteira entre Brasil e Paraguai não corresponde a nenhum traço físico no terreno; é uma convenção entre duas nações. Da mesma forma, um único disco pode ser "dividido" em duas ou mais partições sem que exista qualquer separação física real — apenas um combinado, registrado em metadados, de que até determinado ponto o espaço pertence a uma partição e, a partir dali, a outra.

**Analogia.** Um único armário pode ter suas gavetas divididas por convenção entre dois usuários — "estas gavetas são suas, estas são minhas" — sem que o armário seja fisicamente serrado ao meio. O mesmo raciocínio se aplica a um disco dividido em partições.

Todo disco precisa ter **ao menos uma partição** para que o sistema operacional possa atribuir a ele um sistema de arquivo e utilizá-lo — mesmo que essa única partição ocupe a totalidade do espaço físico disponível.

### 3.4.1 Sistemas de arquivo por partição e o conceito de dual boot

Cada partição pode ter atrelado a si um sistema de arquivo próprio, independente das demais partições do mesmo disco. Essa propriedade tem duas consequências práticas relevantes:

- **Modularização de uso.** É possível reservar cotas de espaço distintas para finalidades diferentes — por exemplo, dividir um mesmo disco entre dois usuários de uma mesma máquina.
- **Coexistência de sistemas operacionais.** Como sistemas operacionais diferentes exigem sistemas de arquivo diferentes (o Windows opera sobre NTFS; uma distribuição Linux como o Ubuntu opera sobre EXT4), um único disco físico pode conter partições distintas, cada uma com seu próprio sistema operacional instalado.

Quando um computador com múltiplos sistemas operacionais instalados é ligado e apresenta uma tela de escolha entre eles, esse mecanismo é chamado de **dual boot** (ou *multi boot*, se houver mais de dois sistemas). *Boot* é o termo em inglês para o procedimento de inicialização; dual boot significa, portanto, que há mais de uma forma possível de inicializar aquele computador, cada uma delas carregando um sistema operacional diferente, tratado em detalhe na Seção 3.11.

| Sistema operacional | Sistema de arquivo típico |
|---|---|
| Windows | NTFS (historicamente, FAT) |
| Linux (ex.: Ubuntu) | EXT4 (historicamente, EXT3) |
| Pendrives / mídias removíveis | FAT32 ou exFAT |

[IMAGEM: captura do gerenciador de disco do Windows mostrando um disco físico dividido em múltiplas partições]

---

## 3.5 Tabelas de partição: MBR e GPT

As informações sobre quantas partições um disco possui, onde cada uma começa e termina, e qual sistema de arquivo está atrelado a cada uma constituem, elas próprias, um conjunto de metadados que precisa ser gravado em algum lugar do disco. A estrutura responsável por essa organização é chamada de **tabela de partições**.

**Analogia.** A tabela de partições funciona como a capa e o sumário de um livro: reúne, num espaço fixo no início do disco, a informação de "para qual capítulo (partição) ir e onde ele começa".

Existem duas soluções de tabela de partição amplamente utilizadas: **MBR** (mais antiga) e **GPT** (mais recente).

**Analogia.** A relação entre MBR e GPT é comparável à relação entre um aparelho de ar-condicionado de janela, antigo e volumoso, e um aparelho split moderno: ambos cumprem a mesma função básica, mas o mais recente resolve limitações técnicas do mais antigo.

### 3.5.1 Master Boot Record (MBR)

O **MBR** (*Master Boot Record*) grava a tabela de partições em um setor específico no início do disco, usando endereçamento de **32 bits**. Dessa limitação de endereçamento decorrem duas restrições centrais:

- O tamanho máximo de uma partição é de **2 TB**.
- É possível criar no máximo **quatro partições primárias**.

Para superar o limite de quatro partições, uma das partições primárias pode ser convertida em **partição estendida**, dentro da qual é possível criar até **128 partições lógicas**. Uma consequência prática dessa regra é que múltiplas partições lógicas devem estar todas contidas dentro de uma única partição estendida — não é possível, por exemplo, dividir 64 partições lógicas entre duas partições primárias diferentes.

**Exemplo.** Um disco já dividido em quatro partições primárias atingiu o limite da tabela MBR. Para criar uma quinta divisão, uma das quatro partições primárias precisa ser apagada e recriada como partição estendida; somente dentro dela é possível abrir novas partições lógicas adicionais.

### 3.5.2 GUID Partition Table (GPT)

O **GPT** (*GUID Partition Table*) foi desenvolvido para superar as limitações do MBR, mantendo **retrocompatibilidade** com ele — isto é, softwares e firmwares mais antigos, mesmo sem reconhecer o GPT, ainda conseguem ler as informações essenciais gravadas no mesmo local histórico do disco.

**Analogia.** A retrocompatibilidade do GPT em relação ao MBR é equivalente à de um console de videogame mais recente que ainda executa jogos de gerações anteriores — como o PlayStation 5, capaz de rodar tanto jogos feitos para ele quanto jogos de PlayStation 1, ou o Nintendo Switch 2, compatível com os cartuchos do Switch original. O console mais antigo, por outro lado, não consegue executar jogos feitos exclusivamente para o mais novo.

Cada disco identificado em GPT recebe um **GUID** (*Globally Unique Identifier*), um identificador único análogo a um endereço IP em uma rede. Usando endereçamento de **64 bits**, o GPT permite partições na ordem de zettabytes, até **128 partições** sem a necessidade do artifício de partições estendidas, e inclui um mecanismo de **redundância**: como historicamente ataques que reescreviam apenas o setor da tabela de partições eram suficientes para inutilizar o acesso a um disco inteiro (sem apagar os dados propriamente ditos, mas destruindo a referência para encontrá-los), o GPT mantém cópias redundantes dessa informação.

| Característica | MBR | GPT |
|---|---|---|
| Época de criação | Mais antiga | Mais recente |
| Endereçamento | 32 bits | 64 bits |
| Tamanho máximo de partição | 2 TB | Na casa de zettabytes |
| Partições primárias | Até 4 | Até 128 (sem partição estendida) |
| Partições lógicas | Até 128, dentro de uma partição estendida | Não se aplica |
| Redundância da tabela | Não | Sim |
| Firmware associado historicamente | BIOS | UEFI |

[IMAGEM: diagrama do layout de um disco em MBR — código de inicialização, tabela de partições e partições de dados]

---

## 3.6 BIOS, UEFI e o procedimento de inicialização

O **BIOS** (*Basic Input/Output System*), introduzido no Capítulo 1 a propósito do IBM PC, é o conjunto de softwares gravado na placa-mãe responsável por inicializar o hardware e oferecer uma interface básica de entrada e saída antes de qualquer sistema operacional ser carregado. Ele é composto, entre outros elementos, por dois programas centrais: o **POST** e o **Setup**. O **UEFI** (*Unified Extensible Firmware Interface*) é a evolução moderna desse firmware, com interface gráfica navegável por mouse — em contraste com as telas de texto do BIOS tradicional.

### 3.6.1 POST

O **POST** (*Power On Self Test*, autoteste de inicialização) é o primeiro programa executado quando o computador é ligado. Sua função é varrer os componentes de hardware — processador, memória, teclado, entre outros — em busca de falhas, antes de liberar o controle da CPU para qualquer outro software.

**Analogia.** O POST equivale à triagem de um pronto-socorro: um exame rápido que determina se o paciente (o hardware) está em condições minimamente operacionais antes de qualquer procedimento seguinte.

Se algum componente essencial falhar no teste, o POST comunica o erro por meio de sinais sonoros (bips), já que, sem memória funcional, ele não tem como exibir uma mensagem na tela — mostrar algo na tela já é, em si, uma operação de software que depende de memória disponível. A quantidade e o padrão de bips indicam, conforme o manual da placa-mãe, qual componente falhou (por exemplo, ausência ou defeito de memória RAM).

Do ponto de vista do diagnóstico técnico, um POST bem-sucedido indica que processador, memória e placa-mãe estão minimamente funcionais — o que não exclui problemas de hardware que só se manifestem sob carga (como superaquecimento durante o uso), nem problemas de software, que só podem ocorrer depois que o POST é concluído com sucesso.

### 3.6.2 Setup

O **Setup** é o programa que permite alterar as configurações de hardware do computador — frequência do processador e da memória (overclock), habilitação ou desabilitação de funcionalidades, data e hora do sistema, e a **ordem de inicialização** (*boot order*), entre outras.

**Analogia.** Se o computador fosse comparado a um jogo, o Setup seria o menu de configurações desse jogo.

Essas configurações — incluindo a informação de qual dispositivo de armazenamento contém o sistema operacional a ser carregado — precisam ser preservadas mesmo com o computador desligado. Por isso, ficam gravadas em uma pequena memória flash não volátil na própria placa-mãe, dedicada a esse fim.

### 3.6.3 Boot: carregamento do sistema operacional

Concluído o POST com sucesso, o próximo passo padrão é o **boot** (inicialização) do sistema operacional: a cópia do sistema operacional da memória secundária, onde está instalado, para a memória primária (RAM), de onde ele passa a ser executado — retomando o conceito de hierarquia de memória apresentado no Capítulo 1 (Seção 1.10) e aprofundado no Capítulo 2.

Para saber onde procurar o sistema operacional entre as possivelmente várias partições e discos existentes, o computador consulta a variável de ordem de inicialização gravada na memória da placa-mãe (Seção 3.6.2). É possível interromper esse fluxo padrão e forçar a inicialização a partir de outro dispositivo — como um pendrive — de duas formas: alterando permanentemente a ordem de boot dentro do Setup, ou acionando, na tela do POST, um atalho de teclado que abre o chamado **boot menu**, uma lista de dispositivos disponíveis para inicialização imediata (nas máquinas descritas em aula, a tecla de atalho variava entre **F9**, **F11**/**F12** ou a sequência **10 → F12**, dependendo do fabricante).

[IMAGEM: tela de POST/BIOS de um computador real, mostrando o logotipo do fabricante e a instrução para acessar o boot menu]

[IMAGEM: tela de Setup/BIOS com a configuração de ordem de inicialização (boot order) destacada]

### 3.6.4 Segurança e ética do acesso físico

Um ponto central para a formação de um técnico de informática é a compreensão de que **o acesso físico a uma máquina muda todos os paradigmas de segurança**. Se é possível interromper o boot padrão e carregar, em vez do sistema operacional instalado, um programa alternativo a partir de um pendrive — por exemplo, um Live CD/USB (Seção 3.9) —, é possível se tornar administrador daquela máquina sem conhecer nenhuma senha, e a partir daí acessar, copiar ou apagar qualquer dado nela contido, independentemente das proteções de software configuradas pelo usuário original.

Essa mesma técnica que permite, de forma legítima, recuperar o acesso a uma máquina cujo usuário esqueceu a senha, pode ser usada de forma ilegítima para violar dados de terceiros sem autorização. Por essa razão, deixar um pendrive ou dispositivo USB como primeira opção na ordem de inicialização é considerado uma **falha de segurança grave**: qualquer pessoa com acesso físico breve à máquina pode assumir controle administrativo total sobre ela. O uso ético dessas técnicas — e a orientação de nunca acessar dados sensíveis de um cliente sem que ele esteja presente e ciente do procedimento — é parte inseparável da formação técnica apresentada neste capítulo.

---

## 3.7 Preparação da mídia de instalação

Para instalar um sistema operacional, é necessário preparar previamente uma mídia de instalação — tipicamente um pendrive — contendo o instalador em um formato reconhecível pelo firmware do computador de destino. Esse processo exige, ele próprio, criar uma tabela de partições e um sistema de arquivo válidos no pendrive, copiando e organizando os arquivos de instalação de acordo com esse esquema.

Uma ferramenta recomendada para essa tarefa é o **Rufus**, software gratuito, de código aberto e leve, com interface gráfica simples para essa finalidade. Ao gravar uma mídia de instalação com o Rufus, é preciso escolher dois parâmetros centrais:

- O **esquema de partição**: MBR ou GPT.
- O **sistema de destino**: BIOS (*legacy*) ou UEFI.

Como o UEFI é retrocompatível com o BIOS (Seção 3.5.2), um pendrive gravado em **MBR** funciona tanto em computadores com firmware BIOS quanto UEFI, enquanto um pendrive gravado em **GPT** funciona apenas em computadores com UEFI. Por essa razão, ao preparar uma única mídia de instalação para um parque de máquinas heterogêneo — com computadores antigos e recentes —, a opção mais segura é gravar em MBR, garantindo compatibilidade universal.

| Esquema gravado | Funciona em BIOS | Funciona em UEFI |
|---|---|---|
| MBR | Sim | Sim |
| GPT | Não | Sim |

**Aplicação prática.** Se um dado computador não reconhece o pendrive de instalação, ou apresenta uma mensagem de erro mencionando GPT e EFI (ou MBR), a causa mais provável é uma incompatibilidade entre o esquema de partição gravado na mídia e o tipo de firmware daquele computador.

[IMAGEM: captura de tela do Rufus com os campos de esquema de partição (MBR/GPT) e sistema de destino (BIOS/UEFI) destacados]

---

## 3.8 Instalação do sistema operacional

O processo de instalação de um sistema operacional pode ser descrito, de forma resumida, em três etapas:

1. Interromper o fluxo normal de boot (Seção 3.6.3) e direcioná-lo para a mídia de instalação (Seção 3.7), por meio do boot menu ou de uma alteração no Setup.
2. Executar o instalador: aceitar os termos de uso, escolher a partição de destino e, se necessário, formatá-la (Seção 3.3) para realizar uma **instalação limpa** — isto é, uma instalação que parte do zero, sem preservar dados anteriores daquela partição.
3. Aguardar a conclusão da cópia dos arquivos do sistema operacional para a partição de destino e a reinicialização automática da máquina, que volta a carregar normalmente a partir do disco — sem necessidade de nova intervenção no teclado.

Um ponto de atenção recorrente é que, ao chegar pela primeira vez à tela do instalador, costuma ser necessário pressionar qualquer tecla para confirmar a inicialização a partir da mídia externa; esse gesto não deve ser repetido após a primeira reinicialização automática do processo de instalação, sob pena de reiniciar a instalação do zero (Seção 3.8.2).

Também é preciso observar que, uma vez que o sistema operacional em execução está instalado em determinada partição, essa mesma partição não pode ser formatada enquanto está em uso — de forma análoga a tentar remover o alicerce sobre o qual se está de pé. Formatar a partição ativa do sistema em execução interrompe o próprio funcionamento do computador.

### 3.8.1 Backup antes de reinstalar

Como a formatação é uma etapa típica da instalação limpa, qualquer dado do usuário presente na partição de destino é perdido no processo, salvo se houver uma cópia prévia. Essa cópia de segurança é chamada de **backup**.

Antes de reinstalar um sistema operacional em uma máquina com dados relevantes do usuário, o procedimento recomendado é:

1. Criar (ou reaproveitar) uma partição separada, que não será formatada durante a instalação.
2. Copiar para essa partição os dados que precisam ser preservados.
3. Realizar a instalação limpa apenas na partição de destino do sistema operacional, deixando intacta a partição de backup.

**Aplicação prática — reparo de software.** Quando o hardware de uma máquina está íntegro e o problema diagnosticado está no sistema operacional (arquivos corrompidos, desempenho degradado, incompatibilidades), a instalação limpa — precedida de backup dos dados necessários — é um dos procedimentos de reparo mais comuns em manutenção de computadores, por "reiniciar o ciclo de vida" do software.

Um cuidado adicional é necessário quando a causa do problema é um software malicioso (**malware**): se o backup incluir arquivos infectados, o malware é copiado junto com os dados legítimos e pode se propagar para o próximo computador em que esse backup for restaurado. Por isso, um procedimento de backup responsável inclui a verificação e remoção de arquivos contaminados antes da restauração — tarefa aprofundada na disciplina de Manutenção de Computadores.

### 3.8.2 O loop de instalação infinito

Um problema comum na primeira experiência com instalação de sistemas operacionais ocorre quando o dispositivo USB de instalação permanece como primeira opção na ordem de boot (Seção 3.6.3). Nesse cenário, ao final da instalação, o computador reinicia, identifica novamente o pendrive como primeira opção de boot, e reinicia o processo de instalação do zero — repetindo esse ciclo indefinidamente, sem nunca chegar a carregar o sistema recém-instalado a partir do disco interno.

A correção consiste em, após concluída a instalação, remover a mídia USB ou reconfigurar a ordem de boot no Setup para priorizar o disco interno (HD ou SSD) sobre a mídia externa.

[IMAGEM: tela típica de instalador solicitando "pressione qualquer tecla para iniciar a partir do CD ou DVD"]

---

## 3.9 Live CD/USB como ferramenta de diagnóstico

Uma distribuição Linux como o Ubuntu, ao ser inicializada a partir de um pendrive, oferece tipicamente duas opções: **instalar** o sistema no disco, ou **experimentar/testar** (*Live CD* ou *Live USB*) o sistema operacional sem instalá-lo.

No modo Live CD/USB, o sistema operacional completo é executado diretamente a partir da memória RAM, carregado da mídia externa, sem necessidade de gravar nada no disco interno da máquina — nem sequer é necessário que a máquina possua um disco de armazenamento funcional. Nesse modo, o usuário tem privilégios de administrador daquela sessão, o que abre uma série de possibilidades diagnósticas.

**Aplicação prática — diagnóstico hardware versus software.** Se o som não funciona no Windows instalado em determinada máquina, inicializar um Live USB e testar o som nele permite isolar a causa: se o som funcionar no Live USB, o problema está no software (driver ou configuração do Windows); se não funcionar em nenhum dos dois ambientes, a causa mais provável é hardware. O mesmo raciocínio se aplica a problemas de conectividade de rede ou de qualquer outro subsistema.

Por oferecer privilégios administrativos completos sobre uma máquina sem exigir senha, o Live CD/USB é também a ferramenta central por trás do risco de segurança descrito na Seção 3.6.4: qualquer pessoa com acesso físico e um pendrive de instalação preparado pode acessar dados de um disco sem autenticação.

[IMAGEM: tela de boas-vindas de um instalador Linux com as opções "Experimentar" (Try) e "Instalar" (Install)]

---

## 3.10 Instalação do Linux: ponto de montagem raiz e partição swap

A instalação de uma distribuição Linux introduz um nível adicional de complexidade em relação à instalação do Windows, decorrente de sua organização de diretórios e do uso de uma partição de memória virtual.

No Linux, ao contrário do Windows — que atribui letras (C:\, D:\...) a cada unidade —, toda a estrutura de arquivos parte de uma única **raiz**, representada pela barra (`/`). Diretórios de sistema relevantes incluem `/dev` (arquivos que representam dispositivos conectados, como discos e pendrives), `/home` (pastas pessoais dos usuários) e `/tmp` e `/var` (arquivos temporários e variáveis do sistema), entre outros.

Discos conectados via SATA são identificados com o prefixo `sd` seguido de uma letra por disco (`sda` para o primeiro disco, `sdb` para o segundo, e assim por diante) e um número por partição dentro desse disco (`sda1`, `sda2`...).

Durante a instalação, é necessário indicar em qual partição o sistema deseja **montar** (*mount*) a raiz `/` — isto é, associar aquela partição ao ponto de entrada de toda a estrutura de diretórios do sistema. É essa exigência — decidir "onde vai a barra" — que costuma ser o ponto de maior dificuldade para quem instala Linux pela primeira vez.

Além da partição raiz, a instalação típica de uma distribuição Linux requer uma segunda partição, chamada **swap** (área de troca): um espaço reservado em disco para funcionar como extensão da memória RAM, retomando o conceito de memória virtual e a hierarquia de memória apresentados no Capítulo 2. Uma referência de dimensionamento usada em aula foi reservar entre 8 GB e 10 GB para a partição swap, destinando o restante do espaço disponível à partição raiz.

**Exemplo de particionamento típico para instalação do Ubuntu:** partição de swap de 8–10 GB e partição raiz (`/`) ocupando o espaço restante — por exemplo, em um espaço livre de 100 GB, aproximadamente 90 GB para `/` e 10 GB para swap.

[IMAGEM: tela do particionador avançado de um instalador Linux, mostrando a criação da partição swap e a seleção do ponto de montagem `/`]

---

## 3.11 Dual boot e o gerenciador de inicialização GRUB

Ao instalar uma distribuição Linux como o Ubuntu, é instalado também, por padrão, um **gerenciador de inicialização** chamado **GRUB**. O GRUB é o software responsável por, após o POST, apresentar ao usuário uma lista dos sistemas operacionais (ou das versões de kernel) disponíveis para carregamento, permitindo a escolha entre eles — o mecanismo de dual boot descrito na Seção 3.4.1.

Essa lista de opções inclui não apenas diferentes sistemas operacionais, mas também diferentes versões do **kernel** do Linux, o núcleo do sistema, atualizado periodicamente. Como programas podem depender de uma versão específica do kernel para funcionar corretamente, a possibilidade de escolher, no momento do boot, qual versão carregar é uma funcionalidade prática relevante do GRUB.

Para instalar Windows e Linux em dual boot no mesmo disco, a **ordem de instalação é determinante**: o Windows deve ser instalado **antes** do Linux. Isso ocorre porque o instalador do Windows sobrescreve o setor de inicialização do disco (a região do MBR descrita na Seção 3.5.1) sem preservar um gerenciador de boot alternativo ali presente. Se o GRUB for instalado primeiro (ao instalar o Linux) e o Windows for instalado depois, a instalação do Windows sobrescreve o GRUB, tornando o Linux inacessível na inicialização — embora os arquivos do sistema Linux continuem fisicamente intactos no disco, apenas inacessíveis por falta do menu de entrada. Recuperar o GRUB nessa situação é um procedimento de manutenção mais avançado.

**Sequência recomendada para dual boot:**

1. Instalar o Windows normalmente.
2. Reduzir (diminuir) a partição do Windows para liberar espaço não alocado.
3. Inicializar a mídia do Linux nesse espaço livre, criando a partição raiz (`/`) e a partição swap.
4. Ao final, o GRUB é instalado automaticamente e passa a apresentar, a cada boot, a opção de carregar Windows ou Linux.

[IMAGEM: tela do menu GRUB listando as opções de inicialização Windows e Ubuntu]

---

## 3.12 Drivers: a interface entre hardware e sistema operacional

Concluída a instalação do sistema operacional, um computador plenamente funcional ainda depende da instalação dos **drivers** apropriados. Um driver é um software, desenvolvido pelo fabricante de determinado componente de hardware, responsável por fazer a interface específica entre aquele hardware e o sistema operacional.

Sistemas operacionais diferentes exigem versões diferentes do mesmo driver — por exemplo, uma placa de vídeo tem uma versão de driver para Windows 10 e outra para Windows 11, desenvolvidas e distribuídas separadamente pelo fabricante da placa. Isso ocorre porque, embora o hardware seja o mesmo, o software que faz a comunicação com ele precisa ser compatível com a arquitetura interna de cada sistema operacional.

**Exemplo.** O procedimento padrão de instalação do Windows instala automaticamente **drivers genéricos** — versões simplificadas, capazes de operar minimamente qualquer hardware compatível, mas sem extrair seu desempenho pleno. Uma placa de vídeo de alto desempenho, adquirida separadamente do fabricante (por exemplo, uma GPU de gama alta), só entrega sua capacidade real de processamento gráfico depois que o driver **específico** fornecido pelo fabricante é instalado.

Um efeito visível e didático da instalação de um driver de vídeo específico é o aumento na **resolução** disponível para a tela — a contagem de pixels em largura e altura que a placa de vídeo consegue endereçar corretamente (por exemplo, o padrão Full HD, de 1920×1080 pixels, seguido pelos padrões 2K e 4K, múltiplos dessa resolução).

Historicamente, drivers eram distribuídos em mídias físicas (CD, disquete) que acompanhavam o hardware adquirido; com a popularização da internet, passaram a ser baixados diretamente do site do fabricante e, mais recentemente, os próprios sistemas operacionais passaram a identificar e instalar automaticamente o driver recomendado (por exemplo, via Windows Update), desde que haja conexão à internet disponível no momento.

**Aplicação prática.** Um computador sem driver de placa de rede Wi-Fi instalado enfrenta um problema de dependência circular: não é possível baixar o driver da internet, porque o driver necessário para acessar a internet é justamente o que está faltando. Nesse cenário, o procedimento é obter o driver em outro computador com acesso à internet, transferi-lo por mídia física (pendrive) e instalá-lo localmente.

Do ponto de vista de diagnóstico técnico, muitos sintomas atribuídos erroneamente a defeito de hardware — ausência de som, Wi-Fi ou Bluetooth não funcionando, touchpad sem responder a gestos — são, na realidade, causados pela ausência ou desatualização do driver correspondente, sendo corrigidos pela instalação ou reinstalação do software apropriado, sem qualquer intervenção física no componente.

[IMAGEM: gerenciador de dispositivos do Windows, mostrando a lista de hardware detectado e o status dos drivers instalados]

---

## Síntese do capítulo

Este capítulo apresentou o sistema operacional como a camada de interface entre hardware, software e usuário, detalhando como essa camada organiza o armazenamento secundário — introduzido no Capítulo 2 em termos de blocos, páginas e setores — por meio de clusters, sistemas de arquivo e partições. Foram estudadas as duas soluções de tabela de partição em uso, MBR e GPT, o procedimento completo de inicialização do computador (POST, Setup/BIOS e boot) e o processo integral de instalação de um sistema operacional, da preparação da mídia à instalação de drivers, passando por backup, dual boot e diagnóstico via Live CD/USB. Esses procedimentos dependem diretamente dos componentes físicos tratados no Capítulo 4 — a placa-mãe, seus barramentos e os próprios dispositivos de armazenamento — e do firmware gravado nesses componentes, cuja relação com a arquitetura de processadores será aprofundada no Capítulo 5.
