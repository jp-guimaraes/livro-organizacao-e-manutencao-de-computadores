# Capítulo 1 — Fundamentos: o que é um computador

Neste capítulo você vai estudar a definição técnica de computador, sua evolução histórica desde os primeiros instrumentos de cálculo até o computador pessoal moderno, o conceito de modularidade que sustenta toda a disciplina de manutenção, e uma primeira introdução à hierarquia de memória.

---

## 1.1 Definição de computador

O termo *computador* deriva do verbo *computar*, originado do latim *calculus* ("pedrinha"), em referência ao uso histórico de pedrinhas para realizar contagens. Essa origem revela o sentido amplo do termo: em sua acepção mais larga, um computador é qualquer instrumento que auxilia a realizar cálculos — o que inclui dispositivos como o ábaco ou uma calculadora simples.

Essa definição ampla, no entanto, é insuficiente para descrever o computador digital moderno. Este livro adota a definição proposta pelo pesquisador Andrew Tanenbaum:

> "O computador digital é uma máquina que pode resolver problemas para as pessoas executando instruções que lhes são dadas."

Essa definição contém três elementos essenciais:

- **Máquina** — o computador é, antes de tudo, um dispositivo físico (hardware).
- **Resolve problemas de forma genérica** — diferentemente de uma calculadora, que executa um conjunto fixo de operações, o computador recebe um programa e pode, em princípio, resolver qualquer problema computável.
- **Executa instruções que lhe são dadas** — o software é ele próprio um dado de entrada, e não uma característica fixa do hardware.

**Aplicação da definição.** Uma calculadora de padaria realiza operações de soma, subtração, multiplicação e divisão, mas não pode receber um programa genérico — não é possível, por exemplo, instalar nela um aplicativo de mensagens. Por essa razão, ela se enquadra na definição ampla de computação, mas não na definição de computador digital de uso geral. Essa distinção entre "dispositivo que computa" e "computador de uso geral" é usada ao longo de todo o capítulo.


!!! warning "Figura pendente"
    linha do tempo dos dispositivos de cálculo — ábaco, ossos de Napier, régua de cálculo, calculadora mecânica Curta


## 1.2 Evolução histórica: dos instrumentos mecânicos ao transistor

A tabela a seguir situa os principais marcos na evolução dos instrumentos de cálculo:

| Período | Dispositivo | Característica |
|---|---|---|
| ~2.500 a.C. | Ábaco | Contagem manual com contas móveis |
| 1617 | Ossos de Napier | Auxílio a multiplicações |
| Até anos 1970 | Régua de cálculo | Cálculo analógico por escalas logarítmicas |
| Anos 1940 | Calculadora Curta | Mecanismo de engrenagens |
| — | Dispositivos eletromecânicos | Baseados em relés |
| — | Válvulas | Eletrônicos, porém volumosos e de alto consumo energético |
| — | Transistor | Chave eletrônica miniaturizada e de baixo custo |

O **transistor** é o componente que viabilizou a computação moderna. Fisicamente, é constituído por um arranjo de material semicondutor dopado (uma junção N-P-N ou P-N-P), que funciona como uma chave eletrônica capaz de ligar e desligar em altíssima velocidade, ocupar espaço microscópico e ser fabricado em larga escala a baixo custo. A substituição progressiva de válvulas por transistores, ao longo da segunda metade do século XX, é o que permitiu a redução de tamanho e custo que tornou o computador pessoal viável.


!!! warning "Figura pendente"
    foto comparativa — ábaco / régua de cálculo / calculadora Curta / transistor em corte esquemático


## 1.3 Alan Turing e o conceito de máquina de propósito geral

Durante a Segunda Guerra Mundial, as forças alemãs utilizavam a máquina Enigma para criptografar comunicações militares. O matemático britânico Alan Turing foi recrutado para desenvolver métodos de decifração dessas mensagens.

A contribuição central de Turing para a computação não foi construir uma máquina especializada apenas em quebrar aquele código específico, mas conceber uma **máquina de propósito geral**: um dispositivo capaz de receber diferentes programas e, a partir deles, resolver diferentes classes de problemas. O primeiro problema resolvido por essa máquina foi, historicamente, a quebra do código Enigma.

Essa distinção — entre uma máquina que executa uma operação fixa e uma máquina que recebe o próprio algoritmo como entrada — é o critério que separa uma calculadora de um computador de uso geral, conforme apresentado na Seção 1.1.


!!! warning "Figura pendente"
    ilustração/foto da máquina Bombe de Turing


## 1.4 John von Neumann e o programa armazenado

De forma paralela e complementar ao trabalho de Turing, o matemático John von Neumann formalizou o conceito de **programa armazenado**: a ideia de que as instruções de um programa — e não apenas os dados que ele manipula — devem residir na mesma memória do computador.

Antes dessa formalização, o algoritmo existia apenas como um procedimento mental ou registrado em papel, executado passo a passo por um operador humano. Com o programa armazenado, o computador passa a executar a sequência completa de instruções de forma autônoma, sem intervenção humana a cada etapa.

**Analogia.** A diferença entre uma calculadora comum e um computador com programa armazenado pode ser ilustrada pela comparação entre uma calculadora de bolso e uma planilha eletrônica: na calculadora, cada operação deve ser inserida manualmente pelo usuário; na planilha, uma fórmula é armazenada uma única vez e reaplicada automaticamente sempre que os dados de entrada mudam.

O conceito de programa armazenado é a base da **arquitetura de von Neumann**, tratada em profundidade no Capítulo 5.

## 1.5 O modelo entrada–processamento–saída

Todo computador, para operar, requer três elementos: **entrada** de dados, **processamento** sobre esses dados e **saída** do resultado.

**Exemplo.** No cálculo da média entre duas notas (N1 e N2), a entrada consiste nos valores de N1 e N2; o processamento consiste na soma dos dois valores seguida da divisão por dois; a saída é o valor da média resultante.

Uma distinção relevante deve ser observada: ao realizar esse cálculo numa calculadora convencional, é o usuário humano quem executa o algoritmo, decidindo a sequência de operações. Num computador de uso geral, o próprio algoritmo é tratado como um dado de entrada e é a máquina que o executa de forma autônoma — reforçando a definição apresentada na Seção 1.1.


!!! warning "Figura pendente"
    diagrama entrada → processamento → saída, com o exemplo da média


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

**Analogia.** Esse procedimento é equivalente a testar o pneu de um carro com defeito trocando-o pelo pneu de um carro em pleno funcionamento: se o carro com defeito continuar apresentando o mesmo problema, conclui-se que a peça testada não era a causa, e outro componente deve ser investigado.

Esse princípio de modularidade é o fundamento metodológico da disciplina de Manutenção de Computadores (2026.1).


!!! warning "Figura pendente"
    esquema "sistema computacional = hardware + software + pessoas"


## 1.7 Da computação corporativa ao computador pessoal

Até meados da década de 1970, a computação era predominantemente corporativa e institucional, realizada por grandes **mainframes** utilizados por bancos, governos, universidades e agências como a NASA.

A tabela a seguir reúne declarações históricas frequentemente citadas para ilustrar a dificuldade de prever a trajetória da computação pessoal:

| Ano | Declaração | Autor/fonte |
|---|---|---|
| 1943 | "Há talvez um mercado mundial para cinco computadores." | Thomas Watson, presidente da IBM |
| 1949 | "No futuro os computadores não pesarão mais do que uma tonelada e meia." | Revista Popular Mechanics |
| 1977 | "Não há razão para alguém querer um computador em casa." | Presidente da Digital Equipment Corporation |
| 1981 | "640 KB é mais do que suficiente para qualquer um." | Bill Gates |

### 1.7.1 Os primeiros computadores pessoais

- **Altair 8800** (1975): programado por meio de chaves binárias (posição alta = 1, posição baixa = 0), sem monitor, com saída representada por luzes indicadoras.
- **Apple I** (1976): placa de circuito artesanal, sem gabinete próprio, dependente de um televisor externo como monitor.
- **Apple II**, **Commodore** e **TRS-80** (1977): computadores já equipados com teclado integrado e gabinete, marcando o início da popularização comercial da computação pessoal.

**Nota terminológica.** O termo *bug*, usado para designar um defeito de software, tem origem num inseto encontrado literalmente causando um curto-circuito em um relé de um computador mainframe antigo.


!!! warning "Figura pendente"
    Altair 8800, Apple I e Apple II lado a lado, mesma escala


## 1.8 O IBM PC e a padronização da arquitetura pessoal

Em 1981, a IBM lançou o IBM PC, com o objetivo de atingir um preço de venda próximo a US$ 1.500. Para viabilizar esse custo, a equipe de desenvolvimento utilizou componentes já disponíveis no mercado, incluindo um processador (Intel 8088) originalmente destinado a calculadoras.

A IBM adotou um modelo de **hardware aberto**, publicando as especificações completas do computador e permitindo que terceiros fabricassem componentes e sistemas compatíveis. A exceção foi o chip de **BIOS** (*Basic Input/Output System*) — firmware responsável por inicializar o hardware e fornecer funções básicas de entrada e saída antes do carregamento de qualquer sistema operacional —, mantido como propriedade fechada da IBM.

Um terceiro realizou a engenharia reversa do BIOS da IBM e distribuiu uma versão funcionalmente equivalente e livre de restrições de licenciamento, o que reduziu significativamente o custo de produção de computadores compatíveis com o padrão IBM PC. A combinação entre hardware aberto e BIOS livre resultou na entrada de novos fabricantes no mercado — entre eles Compaq, Dell e HP —, consolidando o padrão IBM PC como referência da indústria.

Esse processo ilustra um efeito de mercado relevante para a área de tecnologia: plataformas com maior base de usuários tendem a atrair mais desenvolvimento de software, o que por sua vez amplia ainda mais sua base de usuários — um mecanismo análogo ao que hoje explica a predominância do desenvolvimento de aplicativos para a plataforma Android em relação a plataformas minoritárias.


!!! warning "Figura pendente"
    foto do IBM PC original de 1981


## 1.9 Componentes mínimos de um computador desktop

São necessários quatro componentes para que um computador do tipo desktop seja capaz de ligar e operar minimamente:

1. **Fonte de alimentação** — fornece energia ao sistema (tratada em detalhe no Capítulo 4 e na disciplina de Manutenção de Computadores).
2. **Processador (CPU)** — unidade responsável pelo processamento.
3. **Memória principal (RAM)** — tratada na Seção 1.10.
4. **Placa-mãe** — promove a interconexão entre os demais componentes e a ligação com dispositivos de entrada e saída.

Componentes como placa de rede, impressora ou webcam não são necessários para o funcionamento mínimo do sistema, sendo classificados como módulos adicionais.

**Procedimento de manuseio.** Componentes eletrônicos devem ser manuseados pelas bordas, evitando o contato direto com os pontos de contato elétrico, e com atenção à descarga eletrostática acumulada pelo corpo humano.


!!! warning "Figura pendente"
    foto de placa-mãe com CPU, pente de RAM e conector de fonte identificados por setas


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

**Analogia.** O funcionamento dessa hierarquia pode ser comparado ao trabalho de um padeiro: o armazenamento secundário corresponde à despensa, onde os ingredientes ficam guardados por longos períodos; a memória RAM corresponde à mesa de trabalho, onde os ingredientes necessários no momento são reunidos; os registradores e a memória cache correspondem às próprias mãos do padeiro, mantendo o essencial em acesso imediato.

### 1.10.4 Aplicações práticas

- O tempo de inicialização (*boot*) de um dispositivo corresponde à cópia de dados da memória secundária (lenta) para a memória RAM (rápida); por isso, destravar um dispositivo já ligado é mais rápido do que ligá-lo do zero.
- A substituição de um HD por um SSD reduz o tempo de inicialização por aumentar a velocidade da memória secundária.
- O conceito de *cache* é aplicado também fora do hardware local — por exemplo, em serviços de streaming de vídeo, que priorizam conteúdo popular em memória de acesso mais rápido.

### 1.10.5 Processadores especializados: CPU, GPU e NPU

Um computador moderno tipicamente integra mais de um tipo de processador:

- **CPU** (*Central Processing Unit*) — processamento de propósito geral.
- **GPU** (*Graphical Processing Unit*) — processador dedicado a tarefas gráficas, com memória de alta velocidade própria (VRAM).
- **NPU** (*Neural Processing Unit*) — processador dedicado a cargas de trabalho de inteligência artificial, cada vez mais comum em dispositivos móveis e notebooks.


!!! warning "Figura pendente"
    pirâmide da hierarquia de memória com registradores, cache, RAM e armazenamento secundário


!!! warning "Figura pendente"
    anúncio comentado de um processador e de uma placa de vídeo, com cache/núcleos/memória destacados


---

## Síntese do capítulo

Este capítulo apresentou a definição técnica de computador, sua origem histórica e evolução até o computador pessoal moderno, o princípio de modularidade que fundamenta a manutenção de computadores, e uma primeira introdução à hierarquia de memória. Esses conceitos serão retomados e aprofundados nos capítulos seguintes: memória (Capítulo 2), sistema operacional e instalação (Capítulo 3), hardware físico e montagem (Capítulo 4) e arquitetura de processadores (Capítulo 5).
