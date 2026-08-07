# Capítulo 1 — Fundamentos: o que é um computador

Neste capítulo você vai estudar a definição técnica de computador, sua evolução histórica desde os primeiros instrumentos de cálculo até o computador pessoal moderno, o conceito de modularidade que sustenta toda a disciplina de manutenção, e uma primeira introdução à hierarquia de memória.

---

## 1.1 Definição de computador

O termo *computador* deriva do verbo *computar*, originado do latim *calculus* ("pedrinha"), em referência ao uso histórico de pedrinhas para realizar contagens. Essa origem revela o sentido amplo do termo: em sua acepção mais larga, um computador é qualquer instrumento que auxilia a realizar cálculos — o que inclui dispositivos como o ábaco ou uma calculadora simples.

Essa definição ampla, no entanto, é insuficiente para descrever o computador digital moderno. Este livro adota a definição proposta pelo pesquisador Andrew Tanenbaum:

> "O computador digital é uma máquina que pode resolver problemas para as pessoas executando instruções que lhes são dadas." `[1]`

Essa definição contém três elementos essenciais:

- **Máquina** — o computador é, antes de tudo, um dispositivo físico (hardware).
- **Resolve problemas de forma genérica** — diferentemente de uma calculadora, que executa um conjunto fixo de operações, o computador recebe um programa e pode, em princípio, resolver qualquer problema computável.
- **Executa instruções que lhe são dadas** — o software é ele próprio um dado de entrada, e não uma característica fixa do hardware.

**Aplicação da definição.** Uma calculadora de padaria realiza operações de soma, subtração, multiplicação e divisão, mas não pode receber um programa genérico — não é possível, por exemplo, instalar nela um aplicativo de mensagens. Por essa razão, ela se enquadra na definição ampla de computação, mas não na definição de computador digital de uso geral. Essa distinção entre "dispositivo que computa" e "computador de uso geral" é usada ao longo de todo o capítulo.

[IMAGEM: linha do tempo dos dispositivos de cálculo — ábaco, ossos de Napier, régua de cálculo, calculadora mecânica Curta]

## 1.2 Evolução histórica: dos instrumentos mecânicos ao transistor

A tabela a seguir situa os principais marcos na evolução dos instrumentos de cálculo:

| Período | Dispositivo | Característica |
|---|---|---|
| ~2.500 a.C. | Ábaco | Contagem manual com contas móveis |
| 1617 | Ossos de Napier `[2]` | Auxílio a multiplicações |
| Até anos 1970 | Régua de cálculo | Cálculo analógico por escalas logarítmicas |
| Anos 1940 | Calculadora Curta | Mecanismo de engrenagens |
| — | Dispositivos eletromecânicos | Baseados em relés |
| — | Válvulas | Eletrônicos, porém volumosos e de alto consumo energético |
| — | Transistor | Chave eletrônica miniaturizada e de baixo custo |

O **transistor** é o componente que viabilizou a computação moderna. Fisicamente, é constituído por um arranjo de material semicondutor dopado (uma junção N-P-N ou P-N-P), que funciona como uma chave eletrônica capaz de ligar e desligar em altíssima velocidade, ocupar espaço microscópico e ser fabricado em larga escala a baixo custo. A substituição progressiva de válvulas por transistores, ao longo da segunda metade do século XX, é o que permitiu a redução de tamanho e custo que tornou o computador pessoal viável.

[IMAGEM: foto comparativa — ábaco / régua de cálculo / calculadora Curta / transistor em corte esquemático]

## 1.3 Alan Turing e o conceito de máquina de propósito geral

Durante a Segunda Guerra Mundial, as forças alemãs utilizavam a máquina Enigma para criptografar comunicações militares. O matemático britânico Alan Turing foi recrutado para desenvolver métodos de decifração dessas mensagens `[3]`.

A contribuição central de Turing para a computação não foi construir uma máquina especializada apenas em quebrar aquele código específico, mas conceber uma **máquina de propósito geral**: um dispositivo capaz de receber diferentes programas e, a partir deles, resolver diferentes classes de problemas. O primeiro problema resolvido por essa máquina foi, historicamente, a quebra do código Enigma.

Essa distinção — entre uma máquina que executa uma operação fixa e uma máquina que recebe o próprio algoritmo como entrada — é o critério que separa uma calculadora de um computador de uso geral, conforme apresentado na Seção 1.1.

[IMAGEM: ilustração/foto da máquina Bombe de Turing]

## 1.4 John von Neumann e o programa armazenado

De forma paralela e complementar ao trabalho de Turing, o conceito de **programa armazenado** foi formalizado por escrito no relatório *Preliminary Discussion of the Logical Design of an Electronic Computing Instrument* (1946), assinado por Arthur Burks, Herman Goldstine e John von Neumann `[4]`: a ideia de que as instruções de um programa — e não apenas os dados que ele manipula — devem residir na mesma memória do computador. O nome consagrado do conceito, "arquitetura de von Neumann", é o que este livro adota, mas a formalização foi, de fato, um trabalho conjunto dos três autores.

Antes dessa formalização, o algoritmo existia apenas como um procedimento mental ou registrado em papel, executado passo a passo por um operador humano. Com o programa armazenado, o computador passa a executar a sequência completa de instruções de forma autônoma, sem intervenção humana a cada etapa.

O conceito de programa armazenado é a base da **arquitetura de von Neumann**, tratada em profundidade no Capítulo 5.

## 1.5 O modelo entrada–processamento–saída

Todo computador, para operar, requer três elementos: **entrada** de dados, **processamento** sobre esses dados e **saída** do resultado.

**Exemplo.** No cálculo da média entre duas notas (N1 e N2), a entrada consiste nos valores de N1 e N2; o processamento consiste na soma dos dois valores seguida da divisão por dois; a saída é o valor da média resultante.

Uma distinção relevante deve ser observada: ao realizar esse cálculo numa calculadora convencional, é o usuário humano quem executa o algoritmo, decidindo a sequência de operações. Num computador de uso geral, o próprio algoritmo é tratado como um dado de entrada e é a máquina que o executa de forma autônoma — reforçando a definição apresentada na Seção 1.1.

[IMAGEM: diagrama entrada → processamento → saída, com o exemplo da média]

## 1.6 O sistema computacional: hardware, software e pessoas

Um sistema computacional não é composto apenas por hardware e software; inclui também as **pessoas** responsáveis por sua operação. Essa tríade está implícita na definição de Tanenbaum, que qualifica o computador como uma máquina que resolve problemas *para as pessoas*.

Em contextos de suporte técnico, é comum que um problema relatado como falha de hardware ou software seja, na verdade, decorrente de erro de operação — por exemplo, um cabo de alimentação desconectado. A identificação correta da origem do problema (hardware, software ou operação humana) é o primeiro passo de qualquer diagnóstico técnico.

### 1.6.1 Manutenção corretiva e preventiva

- **Manutenção corretiva**: intervenção realizada após a ocorrência de uma falha (por exemplo, substituir a pilha de um controle remoto somente depois que ele para de responder).
- **Manutenção preventiva**: intervenção realizada antes da ocorrência da falha, com base no ciclo de vida esperado do componente (por exemplo, substituir a pilha antes do fim de sua vida útil média).

### 1.6.2 Modularidade

O computador é um dispositivo **modular**, constituído por submódulos substituíveis (fonte, processador, memória, placa-mãe, entre outros). O procedimento padrão de diagnóstico consiste em:

1. Formular a hipótese de que um módulo específico está danificado.
2. Substituir esse módulo por um equivalente sabidamente funcional.
3. Observar se o sistema volta a operar corretamente.

Esse princípio de modularidade é o fundamento metodológico da disciplina de Manutenção de Computadores (2026.1).

[IMAGEM: esquema "sistema computacional = hardware + software + pessoas"]

## 1.7 Da computação corporativa ao computador pessoal

Até meados da década de 1970, a computação era predominantemente corporativa e institucional, realizada por grandes **mainframes** utilizados por bancos, governos, universidades e agências como a NASA.

A tabela a seguir reúne declarações históricas frequentemente citadas para ilustrar a dificuldade de prever a trajetória da computação pessoal:

| Ano | Declaração | Autor/fonte |
|---|---|---|
| 1949 | "No futuro os computadores não pesarão mais do que uma tonelada e meia." `[6]` | Revista Popular Mechanics |
| 1977 | "Não há razão para alguém querer um computador em casa." `[5]` | Presidente da Digital Equipment Corporation |

**Nota sobre a citação de 1977.** A declaração é real — foi feita por Ken Olsen, presidente e fundador da Digital Equipment Corporation, na World Future Society, em 1977 — mas costuma circular fora de contexto: Olsen se referia a um computador central controlando toda a casa (um único sistema automatizando iluminação, eletrodomésticos etc.), não ao PC pessoal como se tornaria comum. Ele próprio já possuía um computador doméstico na época `[5]`.

### 1.7.1 Os primeiros computadores pessoais

- **Altair 8800** (1975): programado por meio de chaves binárias (posição alta = 1, posição baixa = 0), sem monitor, com saída representada por luzes indicadoras.
- **Apple I** (1976): placa de circuito artesanal, sem gabinete próprio, dependente de um televisor externo como monitor.
- **Apple II**, **Commodore** e **TRS-80** (1977): computadores já equipados com teclado integrado e gabinete, marcando o início da popularização comercial da computação pessoal.

**Nota terminológica.** O termo *bug*, usado para designar um defeito de software, tem origem num inseto encontrado literalmente causando um curto-circuito em um relé de um computador mainframe antigo.

[IMAGEM: Altair 8800, Apple I e Apple II lado a lado, mesma escala]

## 1.8 O IBM PC e a padronização da arquitetura pessoal

Em 1981, a IBM lançou o IBM PC, com o objetivo de atingir um preço de venda próximo a US$ 1.500. Para viabilizar esse custo, a equipe de desenvolvimento utilizou componentes já disponíveis no mercado, incluindo um processador (Intel 8088), uma variante de custo reduzido do Intel 8086 — com barramento de dados externo de 8 bits em vez de 16, o que barateava a memória (RAM/ROM) e a lógica de suporte necessárias na placa-mãe.

A IBM adotou um modelo de **hardware aberto**, publicando as especificações completas do computador e permitindo que terceiros fabricassem componentes e sistemas compatíveis. A exceção foi o chip de **BIOS** (*Basic Input/Output System*) — firmware responsável por inicializar o hardware e fornecer funções básicas de entrada e saída antes do carregamento de qualquer sistema operacional —, mantido como propriedade fechada da IBM.

Um terceiro realizou a engenharia reversa do BIOS da IBM e distribuiu uma versão funcionalmente equivalente e livre de restrições de licenciamento, o que reduziu significativamente o custo de produção de computadores compatíveis com o padrão IBM PC. A combinação entre hardware aberto e BIOS livre resultou na entrada de novos fabricantes no mercado — entre eles Compaq, Dell e HP —, consolidando o padrão IBM PC como referência da indústria.

Esse processo ilustra um efeito de mercado relevante para a área de tecnologia: plataformas com maior base de usuários tendem a atrair mais desenvolvimento de software, o que por sua vez amplia ainda mais sua base de usuários — um mecanismo análogo ao que hoje explica a predominância do desenvolvimento de aplicativos para a plataforma Android em relação a plataformas minoritárias.

![IBM PC 5150 (1981), modelo original. Fonte: Wikimedia Commons `[9]`](imagens/ibm-pc-5150.jpg)

## 1.9 Componentes mínimos de um computador desktop

São necessários quatro componentes para que um computador do tipo desktop seja capaz de ligar e operar minimamente:

1. **Fonte de alimentação** — fornece energia ao sistema (tratada em detalhe no Capítulo 4 e na disciplina de Manutenção de Computadores).
2. **Processador (CPU)** — unidade responsável pelo processamento.
3. **Memória principal (RAM)** — tratada na Seção 1.10.
4. **Placa-mãe** — promove a interconexão entre os demais componentes e a ligação com dispositivos de entrada e saída.

Componentes como placa de rede, impressora ou webcam não são necessários para o funcionamento mínimo do sistema, sendo classificados como módulos adicionais.

**Procedimento de manuseio.** Componentes eletrônicos devem ser manuseados pelas bordas, evitando o contato direto com os pontos de contato elétrico, e com atenção à descarga eletrostática acumulada pelo corpo humano.

[IMAGEM: foto de placa-mãe com CPU, pente de RAM e conector de fonte identificados por setas]

## 1.10 Introdução à hierarquia de memória

O computador utiliza dois tipos de memória de natureza distinta: **memória principal** (RAM) e **memória secundária** (armazenamento).

### 1.10.1 Memória RAM

RAM é a sigla para *Random Access Memory* (memória de acesso aleatório): o tempo necessário para ler ou escrever um dado independe da posição de memória acessada. Esse comportamento se opõe ao **acesso sequencial**, no qual o tempo de acesso depende da posição — como ocorre em dispositivos de armazenamento mecânico.

A célula de memória da RAM é construída com transistores e capacitores, otimizada para alta velocidade de acesso. Como consequência direta dessa construção, a RAM é uma memória **volátil**: seu conteúdo é perdido na ausência de energia elétrica.

### 1.10.2 Memória secundária

A memória secundária (armazenamento) é **não volátil** — mantém seus dados sem necessidade de energia contínua —, porém apresenta velocidade de acesso significativamente inferior à da memória RAM.

### 1.10.3 Pirâmide de hierarquia de memória

Da camada mais rápida (e mais cara) para a mais lenta (e mais barata):

1. **Registradores** — internos ao processador, capacidade da ordem de kilobytes.
2. **Memória cache (L1, L2, L3)** — associada ao processador; a cache L3 é tipicamente compartilhada entre múltiplos núcleos.
3. **Memória RAM** — capacidade da ordem de gigabytes.
4. **Armazenamento secundário** — capacidade da ordem de terabytes.

### 1.10.4 Aplicações práticas

- O tempo de inicialização (*boot*) de um dispositivo corresponde à cópia de dados da memória secundária (lenta) para a memória RAM (rápida); por isso, destravar um dispositivo já ligado é mais rápido do que ligá-lo do zero.
- A substituição de um HD por um SSD reduz o tempo de inicialização por aumentar a velocidade da memória secundária.
- O conceito de *cache* é aplicado também fora do hardware local — por exemplo, em serviços de streaming de vídeo, que priorizam conteúdo popular em memória de acesso mais rápido.

### 1.10.5 Processadores especializados: CPU, GPU e NPU

Um computador moderno tipicamente integra mais de um tipo de processador — a Seção 1.11 aprofunda essa taxonomia e a estende a outros tipos de processador e a outros perfis de máquina além do desktop.

- **CPU** (*Central Processing Unit*) — processamento de propósito geral.
- **GPU** (*Graphical Processing Unit*) — processador dedicado a tarefas gráficas, com memória de alta velocidade própria (VRAM).
- **NPU** (*Neural Processing Unit*) — processador dedicado a cargas de trabalho de inteligência artificial, cada vez mais comum em dispositivos móveis e notebooks.

[IMAGEM: pirâmide da hierarquia de memória com registradores, cache, RAM e armazenamento secundário]
[IMAGEM: anúncio comentado de um processador e de uma placa de vídeo, com cache/núcleos/memória destacados]

---

## 1.11 Processadores especializados e perfis de máquina

A Seção 1.9 apresentou os quatro componentes mínimos de um desktop, e a Seção 1.10 introduziu a hierarquia de memória e uma primeira taxonomia de processadores (CPU, GPU, NPU). Esta seção fecha o Capítulo 1 respondendo a uma pergunta que fica em aberto até aqui: um computador moderno raramente tem *um* processador — ele tem vários, cada um especializado numa tarefa —, e a combinação desses processadores muda radicalmente conforme o tipo de máquina considerado (um desktop, um notebook, um smartphone ou um servidor).

### 1.11.1 Taxonomia de processadores

- **CPU** (*Central Processing Unit*) — processamento de propósito geral; já apresentado na Seção 1.10.5.
- **GPU** (*Graphics Processing Unit*) — processador dedicado a tarefas gráficas, com memória de alta velocidade própria (VRAM); já apresentado na Seção 1.10.5.
- **NPU** (*Neural Processing Unit*) — processador dedicado a cargas de trabalho de inteligência artificial, cada vez mais comum em dispositivos móveis e notebooks; já apresentado na Seção 1.10.5.
- **APU** (*Accelerated Processing Unit*) — termo usado para designar um chip que combina, no mesmo encapsulamento, uma CPU e uma GPU integrada. Hoje praticamente todo processador de desktop e notebook tem vídeo integrado (Capítulo 4, §4.1), então "APU" deixou de ser uma categoria à parte e passou a descrever quase qualquer CPU moderna — o termo sobrevive principalmente como nome comercial de determinadas linhas de produto.
- **DSP** (*Digital Signal Processor*) — processador especializado em processar sinais contínuos (áudio, imagem, rádio) por meio de operações matemáticas repetitivas (somas e multiplicações em sequência) sobre grandes volumes de amostras. Diferente da CPU, que precisa lidar com qualquer tipo de instrução, o DSP é otimizado apenas para esse tipo de cálculo — e por isso executa essas operações com muito mais eficiência energética. Está presente, por exemplo, no microfone e na câmera de um smartphone, processando o sinal bruto antes que ele chegue à CPU ou à NPU.
- **SoC** (*System on a Chip*, sistema em um único chip) — não é um tipo de processador, mas uma **estratégia de integração**: reunir, num único encapsulamento, CPU, GPU, controlador de memória, modem de rede e demais controladores que, num desktop, estariam espalhados entre processador, chipset e placa-mãe (Capítulo 4, §4.10, trata do chipset e da interconexão desses componentes). Praticamente todo smartphone, tablet e Raspberry Pi é organizado em torno de um SoC.

[IMAGEM: diagrama de um SoC de smartphone mostrando CPU, GPU, NPU, DSP e modem integrados no mesmo chip, ao lado de um diagrama de desktop com CPU, GPU discreta e chipset como blocos separados]

### 1.11.2 Hardware para diferentes perfis de uso

O mesmo conjunto de conceitos — CPU, memória, armazenamento, interconexão — se organiza de formas muito diferentes conforme o perfil de uso da máquina. Quatro perfis cobrem a maior parte do mercado: **desktop**, **notebook**, **dispositivo móvel** e **servidor**.

| Característica | Desktop | Notebook | Dispositivo móvel | Servidor |
|---|---|---|---|---|
| Processador | CPU substituível, soquete próprio (Capítulo 4, §4.6) | CPU frequentemente soldada à placa | SoC (CPU+GPU+modem integrados) | Um ou mais soquetes de CPU na mesma placa-mãe |
| Memória RAM | Módulos substituíveis, geralmente Dual Channel (Capítulo 2, §2.7) | Módulos substituíveis ou soldados, conforme o modelo | Soldada/empacotada junto ao SoC | Módulos ECC (ver adiante), muitos slots, capacidade na casa de centenas de GB a TB |
| Alimentação | Fonte ATX interna (Capítulo 4, §4.1) | Bateria + fonte externa | Bateria interna | Uma ou mais fontes redundantes |
| Prioridade de projeto | Custo-benefício e desempenho bruto | Portabilidade e autonomia de bateria | Autonomia de bateria acima de tudo | Disponibilidade contínua (*uptime*) e capacidade de processar muitas requisições simultâneas |
| Forma física | Gabinete de mesa (torre, *desk*) | Chassi único e fino | Chassi único, sem abertura para manutenção | Chassi em formato *rack*, dimensionado em unidades **U** (1U, 2U, 4U) para empilhamento em um armário de rede |

**Servidores: redundância como princípio de projeto.** Um servidor difere de um desktop não por processar "mais rápido" — muitas vezes o processador de um servidor tem clock por núcleo *menor* que o de um desktop, priorizando número de núcleos e eficiência energética sob operação contínua —, mas por ser projetado para **nunca parar**. Essa exigência se traduz em componentes redundantes: duas ou mais fontes de alimentação (se uma falha, a outra assume sem interrupção), discos organizados em arranjos com redundância de dados (de forma que a falha de um disco não cause perda de dados, tema aprofundado na disciplina de Manutenção de Computadores), e placas-mãe capazes de hospedar mais de um processador físico simultaneamente.

**Bit flip: causa física.** Um ***bit flip*** (também chamado ***soft error*** ou *single-event upset*, SEU) é a inversão espontânea do valor armazenado numa célula de memória — um 0 que passa a 1, ou vice-versa —, sem que a célula tenha sofrido qualquer dano físico permanente: se regravada com o valor correto, ela volta a funcionar normalmente. A literatura técnica — a partir de um estudo seminal da Intel, em 1978, que primeiro identificou o fenômeno em DRAM `[7]` — aponta **duas** causas físicas bem estabelecidas, ambas formas de radiação ionizante, hoje normatizadas por um padrão da indústria de testes de memória `[8]`:

1. **Raios cósmicos secundários.** Partículas de altíssima energia vindas do espaço colidem com a atmosfera terrestre e produzem um chuveiro de partículas secundárias — na superfície da Terra, majoritariamente **nêutrons**. Um nêutron não tem carga elétrica e não perturba um circuito diretamente, mas, ao colidir com o núcleo de um átomo de silício do chip, pode gerar partículas carregadas secundárias, que então depositam carga suficiente para inverter o estado de um capacitor de DRAM (Capítulo 2, §2.3) ou de um flip-flop de SRAM (Capítulo 2, §2.2).
2. **Partículas alfa de contaminantes radioativos no encapsulamento.** Os próprios materiais usados para embalar e soldar o chip (a "casca" plástica ou cerâmica do processador ou do módulo de memória) contêm, em quantidade mínima, traços de elementos radioativos residuais dos processos de mineração e refino usados para produzi-los. Esses traços emitem, de forma constante e previsível, partículas alfa — e, por estarem fisicamente muito próximos da própria célula de memória, essas partículas depositam carga da mesma forma que um nêutron secundário.

**Bit flip não é o mesmo fenômeno que a vulnerabilidade do HD a campos magnéticos (Capítulo 2, §2.10 e §2.14).** Um HD armazena dados por meio da orientação magnética de uma região do prato — por isso um ímã suficientemente forte de fato ameaça um HD, ao reescrever essa orientação. Uma célula de RAM, em contraste, armazena dado como **carga elétrica** (DRAM) ou como **estado lógico de um circuito** (SRAM) — não existe, na literatura sobre soft errors, um mecanismo estabelecido de bit flip por campo magnético externo; um ímã comum, mesmo forte, não tem como induzir diretamente a carga necessária para inverter um bit de RAM da forma como raios cósmicos e partículas alfa fazem. As duas ameaças — magnética para o HD, radiação ionizante para a RAM — têm mecanismos físicos distintos e não devem ser confundidas.

**Memória ECC.** Servidores costumam usar módulos de memória **ECC** (*Error-Correcting Code*), um tipo de RAM capaz de detectar e corrigir automaticamente um erro de bit flip de um único bit por palavra de memória, usando bits extras de paridade/verificação gravados junto com o dado. Quanto menor a litografia do chip de memória (o livro de Manutenção de Computadores trata da litografia em profundidade) e quanto maior a quantidade total de memória instalada, maior a probabilidade estatística de que um bit flip ocorra em algum lugar do sistema. Num desktop doméstico, um bit flip ocasional é, na pior hipótese, uma tela azul isolada; num servidor operando 24 horas por dia com centenas de gigabytes de RAM, o mesmo tipo de erro, acumulado ao longo de meses, pode corromper silenciosamente um banco de dados inteiro — daí o uso de ECC ser padrão nesse perfil de máquina, e praticamente inexistente em desktops e notebooks comuns.

**Notebooks: compromisso entre modularidade e portabilidade.** O princípio de modularidade apresentado na Seção 1.6.2 — trocar um módulo suspeito para diagnosticar uma falha — se aplica com menos liberdade a um notebook do que a um desktop. Para reduzir espessura, peso e consumo de energia, fabricantes de notebook soldam diretamente à placa componentes que, num desktop, seriam módulos substituíveis: a memória RAM e, cada vez mais, também o processador. Um técnico ainda consegue substituir bateria, SSD (quando não soldado) e tela na maioria dos modelos, mas a possibilidade de "testar trocando o módulo" (Seção 1.6.2) fica mais restrita — e, quando o componente soldado falha, a reparação deixa de ser uma troca simples e passa a exigir retrabalho de solda em nível de placa, ou a substituição da placa-mãe inteira.

**Dispositivos móveis: o extremo da integração.** Um smartphone leva a lógica do notebook ao limite: por trás de um SoC único não há sequer um soquete de processador — CPU, GPU, NPU, modem e, com frequência, a própria memória, estão fisicamente empilhados no mesmo encapsulamento (uma técnica chamada *package-on-package*). Não existe, na prática, "abrir o aparelho e trocar a CPU" nesse perfil de máquina — a modularidade da Seção 1.6.2 se desloca inteiramente para fora do hardware, para o nível de aplicativos e serviços.

[IMAGEM: fotos comparativas lado a lado — placa-mãe de desktop com CPU socketed e RAM em slots, placa de notebook com RAM soldada, e um SoC de smartphone isolado]

---

## Síntese do capítulo

Este capítulo apresentou a definição técnica de computador, sua origem histórica e evolução até o computador pessoal moderno, o princípio de modularidade que fundamenta a manutenção de computadores, uma primeira introdução à hierarquia de memória, e como esses mesmos componentes se recombinam em diferentes perfis de máquina — do desktop ao servidor. Esses conceitos serão retomados e aprofundados nos capítulos seguintes: memória (Capítulo 2), sistema operacional e instalação (Capítulo 3), hardware físico e montagem (Capítulo 4) e arquitetura de processadores (Capítulo 5).

---

## Referências

1. TANENBAUM, Andrew S.; AUSTIN, Todd. *Organização Estruturada de Computadores*. 6. ed. São Paulo: Pearson Education do Brasil, 2013.
2. Data de 1617 para os "Ossos de Napier" (publicação de *Rabdologiae*, Edimburgo) confirmada em: MACTUTOR HISTORY OF MATHEMATICS ARCHIVE, University of St Andrews, verbete "John Napier"; SCIENCE MUSEUM GROUP, coleção de instrumentos de cálculo. Note-se que o livro-texto local de Tangon & Santos atribui erroneamente 1614 a este marco — essa é a data de outra obra de Napier (*Mirifici Logarithmorum Canonis Descriptio*, sobre logaritmos), não dos ossos.
3. HODGES, Andrew. *Alan Turing: The Enigma*. Londres: Burnett Books, 1983; Nova York: Simon & Schuster, 1983.
4. BURKS, A. W.; GOLDSTINE, H. H.; VON NEUMANN, J. *Preliminary Discussion of the Logical Design of an Electronic Computing Instrument*. Princeton: Institute for Advanced Study, 1946.
5. Sobre o contexto da declaração de Ken Olsen (1977, World Future Society): QUOTE INVESTIGATOR. "There Is No Reason for Any Individual to Have a Computer in Their Home"; TECHRADAR, reportagens sobre a origem e o contexto da citação.
6. POPULAR MECHANICS. "Brains That Click." mar. 1949.
7. MAY, T. C.; WOODS, M. H. A new physical mechanism for soft errors in dynamic memories. In: *Proceedings of the 16th Annual Reliability Physics Symposium*. IEEE, 1978. p. 33–40. Publicado também como: MAY, T. C.; WOODS, M. H. Alpha-particle-induced soft errors in dynamic memories. *IEEE Transactions on Electron Devices*, v. 26, n. 1, p. 2–9, jan. 1979.
8. JEDEC SOLID STATE TECHNOLOGY ASSOCIATION. *JESD89B: Measurement and Reporting of Alpha Particle and Terrestrial Cosmic Ray Induced Soft Errors in Semiconductor Devices*. Arlington, VA: JEDEC, 2021.
9. Fotografia do IBM PC 5150. Autor: Reseletti. Wikimedia Commons, 2022. Licença CC BY-SA 3.0. Disponível em: https://commons.wikimedia.org/wiki/File:IBM_PC_5150.jpg.
