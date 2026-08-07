# Capítulo 1 — Fundamentos e Abstração

Neste capítulo você vai estudar a manutenção de computadores como disciplina técnica — sua definição, sua divisão em manutenção corretiva e preventiva, e o raciocínio de diagnóstico que sustenta o trabalho do técnico de informática — e vai reconstruir, camada por camada, a ponte entre o software que se escreve e o hardware que efetivamente o executa, do transistor até a arquitetura de von Neumann. Este livro dá continuidade à disciplina de Organização e Montagem de Computadores, mas não pressupõe que ela tenha sido cursada: os conceitos de hardware, software e sistema computacional necessários são retomados aqui.

---

## 1.1 Manutenção de computadores: definição e escopo

Este livro adota a seguinte definição, comum na literatura técnica de manutenção industrial e plenamente aplicável à informática:

> "Manutenção é a combinação de todas as ações técnicas e administrativas, incluindo supervisão, destinadas a manter ou recolocar um item em estado no qual possa desempenhar uma função requerida." `[1]`

Essa definição contém uma implicação frequentemente ignorada por quem está começando na área: manutenção não é sinônimo de conserto. Todo computador precisa de manutenção — não apenas os que já apresentam defeito. Essa distinção é o que separa a **manutenção corretiva** (agir depois que a falha ocorreu) da **manutenção preventiva** (agir antes que ela ocorra), tratadas em detalhe na Seção 1.3.

## 1.2 O sistema computacional: hardware, software e pessoas

Como já visto no estudo introdutório de computadores, um sistema computacional não é formado apenas por hardware e software: ele inclui também as **pessoas** responsáveis por sua operação. Para a manutenção, essa tríade — hardware, software, pessoas — é o primeiro filtro de qualquer diagnóstico: diante de um chamado técnico, a primeira pergunta não é "qual é o defeito?", mas "em qual dessas três frentes está o problema?".

**Exemplo.** Um chamado técnico relata que "o mouse não está funcionando". Existem, ao menos, três hipóteses plausíveis, uma em cada frente do sistema computacional:

| Frente | Hipótese | Diagnóstico |
|---|---|---|
| Software | O driver do *trackpad* do notebook não está instalado | O sistema operacional não reconhece o dispositivo apontador |
| Hardware | O mouse físico está com defeito ou sem pilha | O componente em si não opera |
| Pessoa (usuário) | O mouse é sem fio e não está pareado com o computador | O hardware e o software estão corretos; falta uma ação do usuário |

Repare que, no terceiro caso, não há defeito de hardware nem de software: o problema está inteiramente na operação. É comum que problemas relatados como falha técnica sejam, na prática, erro de uso — por isso o técnico precisa investigar as três frentes antes de concluir qualquer diagnóstico.

[IMAGEM: diagrama "sistema computacional = hardware + software + pessoas" com o exemplo do mouse ramificando nas três hipóteses]

## 1.3 Manutenção corretiva e manutenção preventiva

- **Manutenção corretiva**: conjunto de ações tomadas para sanar um problema já identificado. O computador chega com sintomas de um comportamento indevido, e a tarefa do técnico é, a partir desses sintomas, identificar o defeito e realizar a substituição ou correção — seja em hardware (troca de um módulo), seja em software (reinstalação ou reconfiguração de um programa).
- **Manutenção preventiva**: conjunto de ações tomadas para reduzir a probabilidade de que um problema venha a ocorrer, executadas antes de qualquer falha se manifestar.

Não existe uma periodicidade única para a manutenção preventiva — ela depende do tipo de ação e das condições de uso do equipamento.

**Exemplo.** No ambiente de laboratório de um campus, os computadores costumam ser reinstalados uma vez por ano letivo, prática que reduz o índice de problemas ao longo do semestre; sob uso muito mais intenso, esse intervalo poderia cair para seis meses. Já a cópia de segurança (*backup*) de dados de uso profissional é uma ação de manutenção preventiva que deve ser executada diariamente: um computador sem rotina de backup que sofre uma falha grave perde integralmente os dados que não foram copiados.

Manutenção corretiva e preventiva se aplicam às três frentes do sistema computacional (Seção 1.2): existem ações preventivas relacionadas a hardware (limpeza, inspeção), a software (backup, atualização) e também a pessoas — treinamento e orientação do usuário para reduzir erros de operação recorrentes.

### 1.3.1 Condições reais e ideais de trabalho

A qualidade de uma manutenção não depende só do diagnóstico correto (Seção 1.4): depende também das condições físicas em que o reparo é executado. Três fatores concentram a maior parte do risco evitável numa bancada de manutenção.

**Controle eletrostático (ESD).** O corpo humano acumula, por atrito simples (caminhar sobre um carpete, por exemplo), uma carga eletrostática que pode chegar a milhares de volts — imperceptível ao toque, mas suficiente para danificar permanentemente um circuito integrado sensível, cuja tolerância a descargas é medida em dezenas ou centenas de volts `[2]`. A condição ideal de bancada inclui uma superfície de trabalho **antiestática** (um tapete condutor aterrado) e, quando disponível uma instalação de aterramento confiável (Capítulo 2, §2.4), uma pulseira antiestática conectando o técnico a essa mesma referência de terra — a mesma ressalva já feita no Capítulo 2 (§2.11.2) se aplica aqui: só vale a pena se conectar a um aterramento em que se confia.

**Umidade e risco de condensação.** Um componente eletrônico transportado de um ambiente frio (por exemplo, um veículo com ar-condicionado) para um ambiente quente e úmido pode sofrer condensação de água em sua superfície — o mesmo fenômeno que embaça um copo gelado num dia quente. Água condensada sobre um circuito energizado é um risco direto de curto-circuito. A prática recomendada é deixar o equipamento estabilizar à temperatura ambiente, ainda desligado, antes de energizá-lo.

**Organização como parte do método, não só do ambiente.** Ao desmontar um equipamento com múltiplos parafusos e cabos semelhantes entre si (Capítulo 4, do livro de Organização e Montagem de Computadores, trata o procedimento de desmontagem em detalhe), separar e identificar cada peça na ordem de remoção evita o erro mais comum de reparo malsucedido: a remontagem incorreta. Essa organização não é uma questão de estética de bancada — é uma extensão direta do método de diagnóstico por hipóteses (Seção 1.4): um técnico que não sabe de onde veio cada parafuso não consegue isolar, com confiança, se um problema após a remontagem foi causado pelo reparo em si ou por uma montagem incorreta.

## 1.4 O raciocínio diagnóstico: hipóteses e método científico

A habilidade central desenvolvida ao longo desta disciplina é a de **isolar um problema** dentro do sistema computacional. Essa habilidade, como programar ou nadar, não se aprende apenas lendo — desenvolve-se pela prática repetida.

O procedimento subjacente ao diagnóstico técnico reproduz o método científico: a partir de uma observação (o sintoma relatado), formula-se uma **hipótese** que explique aquele comportamento, testa-se essa hipótese e verifica-se se ela é válida ou deve ser descartada em favor de outra.

**Exemplo.** Um computador entra em ciclo de reinicialização (POST bem-sucedido, tela de instalação do sistema operacional trava e reinicia). As hipóteses possíveis incluem: defeito na memória secundária, imagem de instalação corrompida, problema de configuração da máquina, ou defeito de hardware específico daquele computador. Um teste direcionado — por exemplo, conectar o disco em outra máquina e rodar um software de diagnóstico de saúde do disco (percentual de blocos defeituosos) — permite confirmar ou descartar a hipótese do disco sem precisar investigar as demais.

Um princípio prático orienta a ordem em que as hipóteses devem ser testadas: **teste primeiro a hipótese mais barata de verificar**, não necessariamente a mais provável. Tempo é um recurso escasso no trabalho técnico; investigar uma hipótese complexa (por exemplo, desmontar o computador para testar um componente em outra máquina) antes de descartar uma hipótese simples (por exemplo, trocar a imagem de instalação e tentar de novo) desperdiça tempo caso a causa fosse, de fato, a mais simples.

Esse tipo de raciocínio — geração de hipóteses, priorização por custo de verificação, teste e confirmação ou descarte — não é adquirido de uma vez; desenvolve-se ao longo da prática cotidiana como técnico, à medida que se acumula repertório de problemas já vistos e resolvidos.

## 1.5 Malware, vírus e cavalos de troia

Um problema de software identificado durante o diagnóstico pode ter origem em **software malicioso** (*malware*) instalado no computador sem o conhecimento ou consentimento do usuário.

- **Vírus**: software malicioso cuja característica definidora é a **replicação** — a capacidade de se propagar de um computador para outro, contaminando novas máquinas.
- **Trojan** (cavalo de troia): software que se apresenta como um programa legítimo, mas que traz embutido um código malicioso oculto, executado em segundo plano após a instalação.

**Exemplo.** Em 2023, o maior canal de tecnologia do YouTube, o Linus Tech Tips, teve seus canais sequestrados após um funcionário da área de publicidade abrir um PDF contaminado recebido como proposta comercial. O software malicioso obteve acesso ao navegador da máquina infectada e, através das permissões já concedidas àquele computador, passou a publicar em todos os subcanais do grupo vídeos promovendo um golpe de criptomoeda associado à imagem de uma figura pública. Levou cerca de 24 horas para a equipe recuperar o controle dos canais `[3]` — todo o alcance da rede havia sido redirecionado para o conteúdo malicioso antes que o acesso fosse restabelecido.

Esse caso ilustra por que a origem de um software instalado importa: um malware pode chegar embutido em qualquer instalador, mesmo em arquivos aparentemente inofensivos como um documento PDF.

## 1.6 Reinstalação do sistema operacional como manutenção corretiva

Diante de um problema de software cuja causa exata não foi identificada, uma prática comum — ainda que nem sempre a mais eficiente — é reinstalar o sistema operacional por completo, apagando o disco e recomeçando do zero.

Ainda assim, a reinstalação continua sendo uma ferramenta legítima de manutenção corretiva, sobretudo quando o tempo de diagnóstico pontual excederia o tempo do próprio procedimento de reinstalação. Duas implicações são obrigatórias sempre que esse caminho é adotado:

1. **Perda de dados**: a reinstalação apaga o disco. É dever do técnico alertar o usuário e obter confirmação de que uma cópia de segurança (backup) dos dados relevantes foi realizada antes de iniciar o procedimento.
2. **A reinstalação só resolve problemas de software**: se o sintoma reaparecer após uma reinstalação bem-sucedida, a hipótese de defeito de hardware sobe de prioridade.

[IMAGEM: fluxograma de decisão — sintoma relatado → hipótese hardware/software/usuário → teste da hipótese mais barata → correção pontual ou reinstalação]

## 1.7 Criação de mídia de instalação: Rufus, MBR/GPT e UEFI

A instalação de um sistema operacional requer uma mídia de inicialização (pendrive ou disco físico) contendo a imagem do sistema, a partir da qual o computador é inicializado antes de o sistema instalado normalmente ser carregado.

**Procedimento de segurança.** A imagem de instalação (arquivo ISO) deve ser obtida diretamente do fabricante — no caso do Windows, do site oficial da Microsoft. Imagens obtidas de fontes intermediárias não confiáveis podem vir acompanhadas de software malicioso embutido no próprio instalador.

O procedimento de criação de mídia envolve duas etapas conceitualmente distintas: baixar a imagem do sistema operacional (arquivo `.iso`) e, em seguida, gravar essa imagem em um pendrive de forma que ele se torne inicializável.

### 1.7.1 BIOS/MBR e UEFI/GPT

Computadores mais antigos utilizam firmware **BIOS** com tabela de partição **MBR**; computadores mais recentes utilizam firmware **UEFI** com tabela de partição **GPT**. Uma mídia de instalação criada para um padrão não inicializa corretamente uma máquina que utiliza o outro.

**Procedimento de identificação.** Ao inicializar o computador e entrar no *setup* (menu de configuração do firmware, acessado durante o POST): se o menu responde ao mouse, o firmware é UEFI/GPT; se o menu só é navegável pelo teclado, o firmware é BIOS/MBR legado.

### 1.7.2 Ferramentas de criação de mídia

| Ferramenta | Uso recomendado |
|---|---|
| Assistente de instalação da Microsoft (*Media Creation Tool*) | Gera diretamente um pendrive UEFI/GPT (acerta para a maioria dos computadores novos) ou permite apenas baixar o arquivo ISO para uso posterior com outra ferramenta |
| **Rufus** | Ferramenta leve (poucos megabytes) que permite escolher explicitamente o tipo de sistema-alvo (BIOS/MBR ou UEFI/GPT); recomendada para gravar uma única imagem por vez com controle preciso do padrão de destino |
| **YUMI** | Permite reunir múltiplos instaladores (por exemplo, várias distribuições Linux e versões do Windows) em um único pendrive, funcionando como um "GRUB de instaladores"; menos direta de configurar que o Rufus |
| **Ventoy** | Alternativa multi-imagem semelhante ao YUMI |

*Especificações e comportamento de cada ferramenta conforme suas páginas oficiais `[4]`.*

O Assistente de instalação da Microsoft, quando usado no modo "unidade flash USB", automaticamente grava a mídia como UEFI/GPT — o que funciona para a grande maioria dos computadores novos, mas falha em máquinas antigas com BIOS/MBR. Para instalar em uma máquina legada, é necessário baixar apenas o arquivo ISO e utilizar o Rufus, selecionando manualmente o esquema de partição BIOS/MBR compatível com aquele hardware.

## 1.8 Plataforma e abstração em camadas

Todo software é desenvolvido para ser executado em um determinado local — o que este livro chama de **plataforma**. A plataforma de um software pode ser um programa (por exemplo, um navegador específico), um sistema operacional, ou, em última instância, uma arquitetura de hardware.

**Exemplo.** Um bloqueador de anúncios desenvolvido para o navegador Firefox tem como plataforma o próprio Firefox: o software não funciona no Chrome nem no Safari. Por sua vez, o Firefox tem como plataforma diversos sistemas operacionais (Windows, macOS, Linux, Android, iOS). E cada um desses sistemas operacionais tem como plataforma hardwares fisicamente distintos — um processador Snapdragon num smartphone Android, um chip Apple M1 num MacBook, um processador Intel ou AMD num desktop Windows.

Essa organização em camadas — software sobre navegador, navegador sobre sistema operacional, sistema operacional sobre hardware — é chamada **abstração em camadas**. Ela é o motivo pelo qual um desenvolvedor de software para navegador não precisa se preocupar com qual câmera, qual placa de rede ou qual processador está instalado no dispositivo do usuário final: cada camada delega à camada abaixo dela a responsabilidade por lidar com a complexidade que está fora do seu escopo.

A estratégia de camadas não é exclusiva da relação hardware-software: a mesma lógica organiza, por exemplo, os protocolos de rede em camadas (física, enlace, transporte, aplicação). Este capítulo adota uma abordagem **top-down** (do software visível ao usuário até o hardware que o executa) para, nas seções seguintes, reconstruir a mesma pilha de forma **bottom-up** (do transistor até a linguagem de programação).

[IMAGEM: pilha de camadas — software aplicativo → navegador → sistema operacional → hardware, com setas de dependência apontando para baixo]

## 1.9 Do transistor às portas lógicas

Para entender como um software é efetivamente executado por um hardware, é necessário responder a uma pergunta simples em aparência: como um circuito eletrônico realiza uma operação lógica ou aritmética?

### 1.9.1 O combinado entre bit e tensão

Um programa como `x = 2` instrui o computador a reservar um espaço de memória, nomeá-lo `x` e armazenar ali o valor 2. Esse número, em base decimal, é convertido para binário antes de ser armazenado, porque a eletrônica digital opera sobre um **combinado** (convenção) entre os símbolos binários (0 e 1) e grandezas elétricas mensuráveis. Na lógica TTL, por exemplo, o combinado usual é: 5 volts representa o bit 1, e 0 volts representa o bit 0 `[5]`. Esse combinado é arbitrário — poderia ser outro par de tensões — mas precisa ser fixado entre fabricante e desenvolvedor para que a informação seja interpretada de forma consistente. **Nota técnica:** na prática, os níveis TTL reais são faixas, não valores exatos — um nível alto válido é qualquer tensão a partir de aproximadamente 2,4 V, e um nível baixo válido vai até aproximadamente 0,4–0,5 V; "5 V e 0 V" é a simplificação didática usual para os valores nominais de saída.

### 1.9.2 O semicondutor e o transistor

Um **semicondutor** é um material que, dependendo das condições (como a temperatura), pode se comportar como isolante ou como condutor — o silício é o exemplo mais usado na indústria. Ao dopar o silício com impurezas específicas, obtêm-se dois tipos de material: o tipo **N** (com excesso de elétrons) e o tipo **P** (com déficit de elétrons, ou "buracos"). A junção entre um material tipo P e um tipo N forma um **diodo**, que conduz corrente em apenas um sentido quando polarizado corretamente.

Empilhando três camadas alternadas (P-N-P ou N-P-N), obtém-se o **transistor**: um dispositivo de três terminais — coletor, base e emissor — que se comporta como uma chave eletromecânica. Quando há nível lógico alto (1) na base, o transistor fecha o contato entre coletor e emissor, permitindo a passagem de corrente; quando há nível lógico baixo (0) na base, o contato permanece aberto.

### 1.9.3 Construindo portas lógicas com transistores

A partir dessa chave elementar, é possível construir as portas lógicas estudadas em eletrônica digital:

- **Porta AND**: dois transistores ligados em série. A saída só apresenta nível lógico 1 se ambas as entradas estiverem em 1 — cada transistor precisa estar "fechado" para que a tensão chegue até a saída.
- **Porta OR**: dois transistores ligados em paralelo. A saída apresenta nível lógico 1 se qualquer uma das entradas estiver em 1 — basta que um dos dois caminhos esteja fechado.
- **Porta NOT (inversora)**: um único transistor usado como chave que inverte o sinal de entrada — 1 na entrada produz 0 na saída, e vice-versa.

**Nota técnica.** Esse modelo (série = AND, paralelo = OR) é uma simplificação pedagógica — um "modelo de chave" coerente com a lógica CMOS moderna — e não corresponde exatamente à topologia de circuitos comerciais TTL/DTL, que tradicionalmente implementam AND/OR com lógica a diodo e usam um transistor inversor separado `[6]`. O modelo aqui é útil para a intuição, mas não deve ser confundido com a topologia exata de um circuito integrado comercial.

[IMAGEM: três circuitos lado a lado — porta AND (transistores em série), porta OR (transistores em paralelo) e porta NOT (transistor inversor), com tabela-verdade de cada uma]

## 1.10 Circuitos aritméticos: o meio-somador

Se é possível construir portas lógicas com transistores, também é possível construir um circuito capaz de somar dois números binários.

A adição em binário segue a mesma lógica da adição em decimal, mas com apenas dois símbolos disponíveis:

| A | B | Soma | Vai-um (*carry*) |
|---|---|---|---|
| 0 | 0 | 0 | 0 |
| 0 | 1 | 1 | 0 |
| 1 | 0 | 1 | 0 |
| 1 | 1 | 0 | 1 |

Observando essa tabela, nota-se que a coluna "Soma" corresponde exatamente à tabela-verdade da porta **OU exclusivo** (XOR), e a coluna "Vai-um" corresponde exatamente à tabela-verdade da porta **AND**.

O circuito que combina uma porta XOR (para o bit de soma) e uma porta AND (para o bit de vai-um), ambas recebendo as mesmas duas entradas A e B, é chamado **meio-somador** (*half adder*). Ele soma dois bits e produz dois resultados: o bit de soma e o bit de transporte para a próxima posição. Encadeando vários meios-somadores (com o acréscimo da entrada de vai-um recebido da posição anterior, o que dá origem ao **somador completo**, ou *full adder*), constrói-se um circuito capaz de somar números de qualquer quantidade de bits — o tamanho da palavra binária que um processador consegue somar de uma vez (32 bits, 64 bits) é justamente definido por quantos desses circuitos estão encadeados no hardware.

[IMAGEM: circuito do meio-somador — porta XOR e porta AND recebendo as entradas A e B, produzindo Soma e Carry]

## 1.11 Memória: o flip-flop e os sinais de controle

Se as portas lógicas resolvem o problema das operações lógicas e aritméticas, resta um terceiro problema: como armazenar um valor de forma persistente, para além do instante em que ele é calculado.

A célula de memória mais básica é o **flip-flop**: um circuito construído a partir da combinação de portas lógicas (e, portanto, em última instância, de transistores) capaz de armazenar um bit e responder a duas operações — leitura ("qual valor você tem?") e escrita ("guarde este valor").

A tabela-verdade do flip-flop tipo JK, um dos modelos mais estudados, resume seu comportamento:

| J | K | Comportamento |
|---|---|---|
| 0 | 0 | Mantém o valor atual (memória não é alterada) |
| 0 | 1 | Escreve 0 |
| 1 | 0 | Escreve 1 |
| 1 | 1 | Inverte o valor atual |

O flip-flop só responde a essas entradas no instante em que recebe um sinal de **clock** — um pulso periódico que sincroniza a operação. É esse sinal de clock, gerado em alta frequência, que corresponde à frequência de operação anunciada para um processador (em megahertz ou gigahertz).

### 1.11.1 Sinais de controle

A operação de leitura e escrita não esgota o funcionamento de um chip de memória real. Um registrador construído com flip-flops — como o circuito integrado 74HC173, um registrador de 4 bits disponível comercialmente `[7]` — expõe também:

- **Reset**: zera o valor armazenado, independentemente do estado do clock.
- **Habilitação de saída** (*output enable*): liga ou desliga a conexão entre o valor armazenado e a saída do chip — relevante, por exemplo, quando a saída está ligada a um motor que precisa estar energizado antes de receber o sinal.
- **Habilitação de escrita** (*write enable*): determina se o chip está em modo de leitura ou de escrita naquele instante, mesmo que o sinal de clock continue chegando.

**Exemplo.** Um simulador de eletrônica digital utilizado em aula demonstra por que os sinais de controle são indispensáveis: ao conectar um circuito somador simples diretamente a um decodificador binário e um display de sete segmentos, o resultado exibido fica incorreto se o segundo operando for alterado antes de o primeiro ter sido efetivamente processado. Os sinais de controle são o que permite dizer ao circuito "carregue este valor agora" e "leia o resultado agora" em momentos distintos e bem definidos — sem eles, não há garantia de que a operação foi concluída antes da leitura.

Esses sinais — de ligar/desligar, de habilitar saída, de selecionar entre operações possíveis de um chip — reaparecem em praticamente todo circuito digital: um somador, um circuito de memória, um controlador de barramento. Entender que eles existem é o que permite compreender a camada seguinte da abstração, tratada na próxima seção.

[IMAGEM: registrador de 4 bits com entradas de dados, clock, reset e habilitação de saída identificadas]

## 1.12 A hierarquia de linguagens: de L0 a L5

A hierarquia de níveis apresentada nesta seção segue o modelo de máquinas multiníveis proposto por Tanenbaum `[8]`. A lógica digital descrita nas seções anteriores é poderosa, mas impraticável de programar diretamente: escrever um programa inteiro em sequências de 0 e 1 é uma tarefa inviável para qualquer problema não trivial. A solução histórica para esse problema foi a criação de sucessivas camadas de linguagem, cada uma mais próxima do raciocínio humano do que a anterior, e cada uma traduzida (por um interpretador, compilador ou circuito de controle) para a camada imediatamente abaixo.

| Nível | Nome | Função |
|---|---|---|
| **L0** | Lógica digital | Portas lógicas, somadores, memórias (Seções 1.9–1.11) |
| **L1** | Microarquitetura (microprograma) | Controla o fluxo de dados: o que é carregado, de onde, para onde, acionando a camada L0 |
| **L2** | Arquitetura do conjunto de instruções (ISA) | Define se o processador é RISC ou CISC, e qual conjunto de instruções ele reconhece (x86, ARM, etc.) |
| **L3** | Sistema operacional | Permite a execução de múltiplos programas e o gerenciamento do hardware por eles |
| **L4** | Tradução (compiladores/montadores) | Converte código de alto nível em código de máquina executável pelo sistema operacional |
| **L5** | Linguagem orientada a problema | Python, C++, JavaScript — nível em que a maioria dos desenvolvedores trabalha |

**Nota terminológica.** É comum que a imprensa especializada em hardware anuncie uma "nova arquitetura" ao descrever um novo processador quando, tecnicamente, o que mudou foi a **microarquitetura** (nível L1) — a forma como aquele conjunto de instruções é implementado internamente —, enquanto a arquitetura do conjunto de instruções (nível L2, por exemplo x86-64) permanece a mesma.

### 1.12.1 Exemplo: de Python ao circuito

Retomando o programa `x = 2; y = x + 1`: em L5 (Python), a atribuição e a soma são expressas em sintaxe legível por humanos. O interpretador ou compilador (L4) traduz essas instruções para código de máquina. O sistema operacional (L3) aloca memória e agenda a execução do processo. O processador consulta seu conjunto de instruções (L2) para decodificar cada instrução recebida. O microprograma (L1) aciona os circuitos específicos — leitura de memória, soma, escrita de memória — que fisicamente existem no nível de lógica digital (L0), executando a operação por meio de tensões elétricas.

Antes da existência de linguagens de alto nível, a única alternativa a programar diretamente em código de máquina (sequências binárias) era a **linguagem Assembly**: um conjunto de mnemônicos (como `ADD`, `MOV`) que correspondem quase diretamente às instruções do processador, mas ainda exigem gerenciamento manual explícito de registradores e endereços de memória — por isso, extremamente trabalhosa para programas complexos.

### 1.12.2 O nível além de L5

Um nível ainda não formalizado na literatura clássica de arquitetura de computadores, mas cada vez mais concreto na prática, é o de **linguagem natural**: comandos dados a um modelo de linguagem (LLM) que gera código executável em Python, C++ ou outra linguagem de nível L5 a partir de um pedido descrito em português ou inglês comum. Ferramentas como assistentes de voz (Alexa, Google Assistant) representaram uma primeira aproximação limitada desse nível; modelos de linguagem contemporâneos ampliam significativamente essa capacidade, embora ainda não exista uma camada intermediária formal, treinada especificamente para maximizar a taxa de acerto entre o pedido em linguagem natural e o código gerado.

**Nota sobre o uso de ferramentas de IA.** Um modelo de linguagem gera texto com alta probabilidade estatística de ser relevante — não é um interlocutor consciente, ainda que a fluência de suas respostas possa sugerir o contrário. Isso reforça um ponto prático para o técnico de informática: modelos de linguagem e agentes de IA são ferramentas, e a responsabilidade por uma tarefa delegada a eles continua sendo de quem concedeu essa liberdade — da mesma forma que dizer "o macaco trocou o pneu do carro" ignora que foi a pessoa quem usou o macaco.

## 1.13 A arquitetura de von Neumann

O conceito de **programa armazenado** — a ideia de que as instruções de um programa, e não apenas os dados que ele manipula, residem na mesma memória do computador — já apresentado como fundamento histórico da computação de uso geral, foi formalizado por escrito no relatório "First Draft of a Report on the EDVAC" (jun. 1945), de John von Neumann, e detalhado em 1946 em coautoria com Arthur Burks e Herman Goldstine `[9]`. A disputa de crédito mais discutida na literatura histórica não é com Alan Turing, mas com **Eckert e Mauchly**, engenheiros do grupo ENIAC/EDVAC que consideravam a ideia um resultado coletivo e ficaram descontentes por o relatório circular só com o nome de von Neumann. Turing, por sua vez, produziu um relatório equivalente sobre programa armazenado (o projeto ACE, apresentado ao National Physical Laboratory em fevereiro de 1946, já em tempos de paz) — o sigilo que de fato cercou o trabalho de Turing durante a guerra foi o da criptoanálise em Bletchley Park, não o do próprio projeto ACE `[10]`. Ainda assim, "arquitetura de von Neumann" é o nome consagrado que este livro adota para a formalização.

Essa arquitetura organiza o computador em quatro unidades funcionais:

- **Unidade de entrada** — capta dados do mundo externo (teclado, mouse, câmera).
- **Unidade de saída** — expõe dados processados ao mundo externo (monitor, alto-falante).
- **Unidade de processamento (CPU)** — subdividida em **unidade de controle** (coordena a sequência de operações) e **unidade lógica e aritmética — ULA** (executa as operações lógicas e aritméticas propriamente ditas).
- **Unidade de memória** — armazena tanto os dados quanto o próprio programa em execução.

No computador desktop moderno, a via de dados que interliga processador, memória e dispositivos de entrada e saída — o **barramento** — é fisicamente provida pela placa-mãe.

[IMAGEM: diagrama da arquitetura de von Neumann — CPU (unidade de controle + ULA), memória, entrada e saída interligados por um barramento central]

## 1.14 O gargalo de von Neumann

A separação física entre processador e memória — necessária, já que nenhum dispositivo conhecido realiza simultaneamente as funções de processamento e de armazenamento — traz uma limitação estrutural conhecida como **gargalo de von Neumann**.

Abordagens modernas de arquitetura, como o **System-on-Chip (SoC)**, aproximam fisicamente processador e memória dentro de um único encapsulamento, reduzindo a latência de comunicação entre eles. Essa aproximação mitiga o problema, mas não o elimina: processamento e memória continuam sendo entidades fisicamente distintas, e o gargalo de von Neumann permanece um problema em aberto na arquitetura de computadores.

## 1.15 Computação além do silício

A abstração em camadas construída ao longo deste capítulo — da tensão elétrica à porta lógica, da porta lógica ao circuito aritmético, do circuito à linguagem de programação — revela algo importante sobre a natureza da computação: o que importa é a estrutura lógica das operações, não o material físico que as implementa.

**Exemplo.** Utilizando o sistema de circuitos do jogo *Minecraft* (o mecanismo de *redstone*), é possível reproduzir portas lógicas, meios-somadores e células de memória, e a partir deles construir um computador funcional dentro do próprio jogo — capaz, por exemplo, de executar um programa que calcula a sequência de Fibonacci. Um projeto ainda mais extremo levou essa ideia ao limite: como o computador construído em *redstone* é, em si, capaz de executar qualquer programa, um desenvolvedor conseguiu rodar uma cópia do próprio *Minecraft* dentro do computador que havia construído dentro do *Minecraft* — a um custo de desempenho da ordem de milhões de vezes mais lento, mas funcionalmente completo `[11]`.

Outros projetos substituem o transistor por outros meios físicos para implementar as mesmas portas lógicas — por exemplo, circuitos hidráulicos que implementam portas AND, OR e NOT utilizando água e tubulações `[12]`. O romance de ficção científica *O Problema dos Três Corpos*, do autor chinês Liu Cixin, descreve um exército de seres humanos treinados para atuar, cada um, como uma porta lógica — formando coletivamente um computador funcional operado inteiramente por pessoas `[13]`.

Esses exemplos, por mais lúdicos que pareçam, sustentam um ponto central deste capítulo: a computação é uma estrutura lógica de camadas de abstração, e o silício é apenas o meio físico mais eficiente conhecido atualmente para implementá-la — não o único possível.

---

## Síntese do capítulo

Este capítulo apresentou a manutenção de computadores como disciplina fundamentada na distinção entre manutenção corretiva e preventiva, no raciocínio de diagnóstico por hipóteses e no reconhecimento do sistema computacional como uma tríade de hardware, software e pessoas — incluindo casos concretos de manutenção corretiva de software, como a identificação de malware e a reinstalação de sistemas operacionais. Em seguida, reconstruiu a ponte entre software e hardware por meio da abstração em camadas: da plataforma de execução ao transistor, do transistor às portas lógicas, das portas lógicas aos circuitos aritméticos e de memória, e destes à hierarquia de linguagens que culmina na arquitetura de von Neumann e em sua limitação estrutural, o gargalo de von Neumann. Esses fundamentos — sobretudo a noção de que todo problema pode ser localizado numa camada específica dessa pilha — sustentam o capítulo seguinte, que trata da camada mais concreta de todas: a eletricidade e a fonte de alimentação que energizam fisicamente cada uma dessas camadas.

---

## Referências

1. ASSOCIAÇÃO BRASILEIRA DE NORMAS TÉCNICAS. *NBR 5462: Confiabilidade e mantenabilidade — Terminologia*. Rio de Janeiro: ABNT, 1994.
2. ESD ASSOCIATION. *Fundamentals of Electrostatic Discharge*. Disponível em: <https://www.esda.org>; ou ABNT NBR IEC 61340-5-1 (controle eletrostático em ambientes que manuseiam dispositivos sensíveis).
3. TECHSPOT. "YouTube channel Linus Tech Tips terminated after it was hacked to show crypto-scam videos." 2023. Disponível em: <https://www.techspot.com/news/98047->; DIGITAL TRENDS. "Linus Tech Tips restored after crypto scam hack." Disponível em: <https://www.digitaltrends.com/computing/linus-tech-tips-offline-after-cryptoscam/>.
4. Páginas oficiais: RUFUS, <https://rufus.ie>; VENTOY, <https://www.ventoy.net>; YUMI, <https://www.pendrivelinux.com>.
5. MALVINO, Albert Paul; BROWN, Jerald A. *Digital Computer Electronics*. 3. ed. Nova York: Glencoe/McGraw-Hill, 1993, Cap. 4 "TTL Circuits".
6. MALVINO, Albert Paul; BROWN, Jerald A. *Digital Computer Electronics*. 3. ed. Nova York: Glencoe/McGraw-Hill, 1993, Cap. 2 ("2-1 Inverters", "Diode OR Gate", "2-3 AND Gates", "Diode AND Gate").
7. NEXPERIA. "74HC173; 74HCT173 — Quad D-type flip-flop; positive-edge trigger; 3-state." Datasheet. Disponível em: <https://assets.nexperia.com/documents/data-sheet/74HC_HCT173.pdf>.
8. TANENBAUM, Andrew S.; AUSTIN, Todd. *Organização Estruturada de Computadores*. 6. ed. São Paulo: Pearson Education do Brasil, 2013, Seção 1.1.
9. BURKS, A. W.; GOLDSTINE, H. H.; VON NEUMANN, J. *Preliminary Discussion of the Logical Design of an Electronic Computing Instrument*. Princeton: Institute for Advanced Study, 1946.
10. COPELAND, B. Jack (org.). *Alan Turing's Automatic Computing Engine*. Oxford: Oxford University Press, 2005.
11. MOJANG. "Minecraftception." Minecraft.net. Disponível em: <https://www.minecraft.net/en-us/article/-minecraftception>.
12. "Hydraulic logic gates: building a digital water computer." *European Journal of Physics*, v. 39, 2018. IOP Publishing. Disponível em: <https://iopscience.iop.org/article/10.1088/1361-6404/aa97fc>.
13. LIU, Cixin. *O Problema dos Três Corpos*. São Paulo: Aleph. (Tradutor e ano da edição a confirmar pelo autor.)
