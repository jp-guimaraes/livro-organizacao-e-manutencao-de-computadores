# Capítulo 3 — Arquitetura e Organização de Processadores

Neste capítulo você vai estudar a distinção entre arquitetura e organização de computadores, o aprofundamento da arquitetura de von Neumann formalizada no Capítulo 2, os dois grandes paradigmas de projeto de processadores — CISC e RISC —, a evolução da família x86/x64 e as famílias ARM e AVR como exemplos de RISC.

---

## 3.1 Arquitetura versus organização de computadores

O Capítulo 2 (§2.5) separou dois níveis da máquina multinível: o do conjunto de instruções (L2) e o da microarquitetura que o implementa (L1). Esta seção dá nome a essa separação.

Os termos *arquitetura de computadores* e *organização de computadores* são, com frequência, usados como sinônimos — inclusive na literatura técnica e no vocabulário do mercado de tecnologia. Este livro, seguindo a distinção adotada por autores como Stallings `[1]`, trata os dois termos como conceitos tecnicamente distintos.

**Arquitetura** é o conjunto de instruções que um processador disponibiliza para quem programa nesse processador. Esse conjunto de instruções é chamado, em inglês, de *Instruction Set Architecture* (ISA) — arquitetura do conjunto de instruções. A arquitetura define o que um processador é capaz de executar: quais operações existem, como os dados são endereçados, quais registradores estão disponíveis.

**Organização** é a implementação em hardware de uma dada arquitetura: as escolhas de projeto que determinam quantos núcleos um processador tem, qual a quantidade de memória cache, qual a frequência de operação, quanto de memória RAM ou de armazenamento um computador possui. Duas máquinas podem compartilhar a mesma arquitetura — o mesmo conjunto de instruções — e, ainda assim, ter organizações completamente diferentes.

**Exemplo.** Um processador Intel Core i3, um Core i5 e um Core i7 de uma mesma geração compartilham a mesma arquitetura x86/x64: executam essencialmente o mesmo conjunto de instruções e, portanto, os mesmos programas. O que os diferencia — quantidade de núcleos, tamanho de cache, frequência de clock, consumo energético — são decisões de organização. O mesmo raciocínio se aplica a um smartphone vendido em versões 4G e 5G, ou a um mesmo modelo de notebook oferecido com capacidades diferentes de SSD: a arquitetura do processador permanece idêntica; o que muda é a organização do hardware ao redor dele.

Essa distinção também delimita o foco deste livro: processador, memória, placa-mãe e demais componentes, estudados nos capítulos seguintes, são, tecnicamente, decisões de organização, e não de arquitetura. Arquitetura é assunto do programador de baixo nível e do fabricante do processador; organização é assunto de quem monta, especifica e mantém computadores. É também por isso que, como visto no Capítulo 2 (§2.5), o vocabulário de mercado costuma chamar de "nova arquitetura" o que, tecnicamente, é uma mudança de organização.


!!! warning "Figura pendente"
    comparativo de anúncios de processadores i3/i5/i7 de mesma geração, com núcleos e cache destacados


## 3.2 A arquitetura de von Neumann: instrução e dado são a mesma coisa

O Capítulo 2 (§2.6) formalizou a arquitetura de von Neumann e suas quatro unidades funcionais. Esta seção não repete essa formalização — explora, em vez disso, uma consequência dela que é central para entender a distinção entre arquitetura e organização apresentada na Seção 3.1.

Essa consequência raramente é percebida por quem está começando a estudar computação: o processador não distingue, por natureza, uma instrução de um dado, nem atribui significado ao que está processando. O processador é uma máquina que executa instruções mecanicamente, manipulando padrões binários e produzindo uma saída — sem qualquer noção do propósito daquela operação.

**Exemplo.** Do ponto de vista do processador, é absolutamente indiferente se a sequência de instruções que ele executa está calculando a nota final de um aluno ou controlando a fervura de um doce: ele apenas manipula dados e gera uma saída. Quem atribui sentido a essa saída — quem decide se o resultado representa uma média escolar ou uma receita culinária — é o software, não o hardware. O processador, isoladamente, "não sabe o que está fazendo": ele apenas executa.

Essa característica é o que torna a arquitetura de von Neumann ao mesmo tempo poderosa e genérica: como instruções são armazenadas e tratadas como qualquer outro dado na memória, o mesmo hardware pode executar qualquer programa que respeite o seu conjunto de instruções (a arquitetura, na definição da Seção 3.1) — sem que o hardware precise ser fisicamente alterado a cada novo problema. Esse é o mesmo critério que, no Capítulo 1 (Seção 1.3), distinguiu a máquina de Turing de propósito geral de uma calculadora de operação fixa.

A [Figura 2.5](02_do_transistor_a_arquitetura_von_neumann.md#fig-von-neumann), no Capítulo 2, mostra essa organização: as instruções do programa e os dados ocupam a mesma memória e chegam ao processador pelo mesmo barramento.

## 3.3 CISC: retrocompatibilidade e a família x86/x64

A Seção 1.8 contou como a IBM lançou, em 1981, o IBM PC com o processador Intel 8088, variante de custo reduzido do 8086 — um chip de 16 bits (o tamanho da palavra da Seção 2.3), sucessor do 8080 da linhagem apresentada na Seção 1.7.1 e projetado para competir com os processadores da Zilog e da Motorola `[2]`. Aqui interessa a consequência daquela escolha para a arquitetura: o sucesso comercial desse computador consolidou o conjunto de instruções do 8086 como padrão de mercado, e toda a evolução subsequente da família de processadores da Intel — e, mais tarde, da AMD — preservou esse conjunto de instruções original, apenas adicionando novas instruções a cada geração.

Esse comportamento decorre de uma exigência implícita do mercado de software: um fabricante que investiu no desenvolvimento de um programa para um determinado processador espera que esse programa continue funcionando — de preferência com desempenho melhor — nos processadores lançados posteriormente. A esse requisito dá-se o nome de **retrocompatibilidade**: a capacidade de um sistema mais novo executar, sem modificação, programas feitos para um sistema mais antigo da mesma família.

A tabela a seguir situa os principais marcos da evolução da família x86:

| Processador | Observação |
|---|---|
| 8086 | 16 bits; sucessor do 8080, projetado para competir com Zilog Z8000 e Motorola 68000; base do computador que a IBM adotou |
| 8088 | Versão de barramento externo simplificado do 8086, usada no IBM PC original (1981) |
| 80286 | Segunda geração da família; retrocompatível com o 8086 |
| 80386 | Lançado em 1985 `[3]`; primeira geração de 32 bits da família, retrocompatível até o 8086 |
| 80486 | Evolução do 386 com memória cache integrada ao processador |
| Pentium | Sucessor do 486; a Intel abandonou a numeração "586" e passou a usar um nome comercial `[4]` |
| Pentium II / III | Gerações seguintes da linha Pentium |
| Core 2 Duo | Geração seguinte, já multinúcleo |
| Core i3 / i5 / i7 | Segmentação por faixa de desempenho, mantendo a mesma arquitetura x86/x64 |
| Core Ultra / Core 5, 7, 9 | Nomenclatura adotada a partir de 2023 (geração Meteor Lake), substituindo i3/i5/i7 após décadas de uso `[5]` |

Cada geração dessa família mantém, como subconjunto, o conjunto de instruções de todas as gerações anteriores. A [Figura 3.1](#fig-x86-conjuntos-concentricos) representa essa acumulação como um diagrama de Venn de círculos concêntricos: as instruções do 8086 estão contidas nas do 286, que estão contidas nas do 386, e assim sucessivamente — cada círculo contém todos os de dentro.

Ao conjunto de processadores que evoluem dessa forma — acumulando instruções ao longo do tempo, sem nunca descartar as anteriores — dá-se o nome de arquitetura **CISC** (*Complex Instruction Set Computer*, computador com conjunto de instruções complexo). O ponto forte dessa filosofia é justamente a retrocompatibilidade; o custo é o acúmulo constante de complexidade no hardware — mais lógica de decodificação e microcódigo a cada geração. Se esse custo se traduz em maior consumo de energia é discussão retomada na Seção 3.5.

<figure id="fig-x86-conjuntos-concentricos" markdown="1">
![Seis círculos concêntricos, do centro para fora: 8086, 80286, 80386, 80486, Pentium e Core, com cores do azul (centro) ao vermelho (borda). Uma seta aponta para o 8086, com a nota: cada geração acrescenta instruções e mantém todas as anteriores — um programa feito para o 8086 ainda roda num Core.](imagens/x86-conjuntos-concentricos.png)
<figcaption markdown="span"><strong>Figura 3.1</strong> — Gerações x86 como conjuntos concêntricos: cada uma contém as instruções de todas as anteriores.</figcaption>
</figure>

## 3.4 Endereçamento e a barreira dos 32 bits

A retrocompatibilidade da família x86 enfrentou seu maior teste na passagem de 32 para 64 bits. A quantidade de bits que um processador utiliza para endereçar a memória determina diretamente a quantidade máxima de memória RAM que esse processador é capaz de acessar.

Um processador de arquitetura de 32 bits consegue endereçar, no máximo, cerca de 4 GB de memória RAM: com 32 bits há $2^{32}$ endereços distintos e, como $2^{30}$ bytes formam um gigabyte (Seção 1.10.3), isso dá $2^{2} \times 2^{30}$ bytes = 4 GB. Essa é uma limitação estrutural da arquitetura, não da quantidade de memória fisicamente instalada na placa-mãe.

**Exemplo.** É possível instalar 8 GB de memória RAM em um computador equipado com um sistema operacional de 32 bits; entretanto, esse sistema só conseguirá endereçar e utilizar até 4 GB — o restante permanece inacessível, por ausência de endereços suficientes para representá-lo. Esse foi historicamente um problema real de suporte técnico: computadores com memória fisicamente instalada, mas parcialmente inutilizável, porque o processador já era de 64 bits, mas o sistema operacional instalado era de 32 bits — e é a arquitetura em uso pelo sistema que limita o endereçamento.

A superação dessa barreira veio da AMD: em vez de propor uma arquitetura inteiramente nova, ela estendeu a x86 de 32 bits, preservando toda a retrocompatibilidade e acrescentando um modo de operação de 64 bits. O resultado, a arquitetura **AMD64**, acabou adotado por toda a indústria e é conhecido genericamente como **x64** `[7]`. A Intel, que à época apostava numa arquitetura de 64 bits própria e incompatível — a Itanium (IA-64) —, adotou a extensão da AMD em 2004, sob o nome Intel 64. É a retrocompatibilidade da Seção 3.3 decidindo, mais uma vez, o rumo do mercado.

Uma consequência prática dessa relação de subconjunto (x86 ⊂ x64) diz respeito à compatibilidade de software: um sistema operacional de 64 bits é capaz de executar tanto programas de 64 bits quanto programas de 32 bits, por manter a retrocompatibilidade; já um sistema operacional de 32 bits não é capaz de executar programas de 64 bits, por não reconhecer as instruções e os endereços estendidos dessa arquitetura mais recente.

A mesma lógica — um campo de tamanho fixo que limita o que se pode endereçar — reaparece no Capítulo 6 (§6.5), no limite de 2 TB das partições MBR.


!!! warning "Figura pendente"
    comparação de páginas de download de um mesmo programa, mostrando as versões disponíveis para x86, x64 e ARM


## 3.5 RISC: o paradigma da simplicidade

Em contraposição à filosofia CISC, existe uma segunda abordagem de projeto de processadores, baseada na premissa oposta: construir um processador cujo conjunto de instruções seja o mais simples e reduzido possível. A essa família dá-se o nome de **RISC** (*Reduced Instruction Set Computer*, computador com conjunto de instruções reduzido).

O ponto forte do RISC, em comparação ao CISC, é a simplicidade do hardware de decodificação. É comum associar essa simplicidade a um menor consumo energético — e, na prática, processadores RISC (como os da família ARM) costumam ser mais eficientes energeticamente do que processadores CISC (x86/x64) — mas a pesquisa específica sobre o tema mostra que essa diferença vem majoritariamente de escolhas de microarquitetura e do mercado-alvo de cada família (ARM historicamente otimizada para dispositivos móveis; x86/x64 para desempenho bruto), não de uma propriedade intrínseca do conjunto de instruções em si `[6]`. A contrapartida real e direta da simplicidade do conjunto de instruções é que instruções complexas, que num processador CISC seriam executadas diretamente em hardware, precisam ser decompostas em uma sequência de instruções mais simples — transferindo parte da complexidade do hardware para o software (compiladores e demais camadas de programação).

**Exemplo.** Considere a tarefa de somar 5 a um valor guardado na memória. Num processador CISC (x86), uma única instrução faz tudo: lê o valor da memória, soma 5 e grava o resultado de volta. Num processador RISC (ARM), as instruções aritméticas só operam sobre registradores, e a mesma tarefa vira três instruções simples, geradas pelo compilador: carregar o valor da memória para um registrador (*load*), somar 5 e gravar o resultado de volta na memória (*store*). O resultado final é idêntico; o caminho até ele é que muda — e é essa diferença de caminho que distingue, na prática, um processador CISC de um processador RISC.

A principal família comercial de processadores RISC de propósito geral é a **ARM**, presente em smartphones, no Raspberry Pi e, com mais força desde 2020, também em notebooks (como os MacBooks equipados com chips da série M — M1, M2, M3, M4, M5, lançados a partir de novembro de 2020) e em processadores da linha Snapdragon `[8]`.

Uma segunda família RISC, voltada não para computação de propósito geral, mas para **microcontroladores** embarcados, é a **AVR**, presente em chips como o ATmega328 (usado nas placas Arduino Uno). Outra família de microcontroladores muito difundida, a **PIC**, também é RISC, mas tem arquitetura própria, incompatível com a AVR.

Diferentemente da relação entre x86 e x64 (em que uma arquitetura está contida na outra), ARM e AVR não compartilham conjuntos de instruções entre si: são duas famílias RISC distintas, sem relação de subconjunto uma com a outra, cada uma otimizada para um tipo de aplicação diferente.

**Exemplo.** Um semáforo de trânsito exige um hardware de controle que permaneça ligado ininterruptamente, com baixíssimo consumo energético e alta confiabilidade, mas sem necessidade de grande poder de processamento — um cenário típico de aplicação para microcontroladores AVR. Um notebook usado para tarefas de escritório e navegação em rede, por outro lado, demanda maior poder computacional e tipicamente adota arquiteturas x86/x64 ou ARM, conforme o caso de uso.


!!! warning "Figura pendente"
    fotos comparativas de um chip Cortex-A (Raspberry Pi), um Snapdragon (smartphone) e um ATmega328 (Arduino Uno)


## 3.6 Comparação entre paradigmas de arquitetura

A tabela a seguir resume as principais diferenças entre os paradigmas CISC e RISC:

| Característica | CISC | RISC |
|---|---|---|
| Conjunto de instruções | Extenso e complexo, acumulado ao longo de décadas | Reduzido e simplificado, por projeto |
| Consumo energético | Historicamente mais alto (efeito majoritariamente de microarquitetura, não da ISA em si `[6]`) | Historicamente mais baixo (idem) |
| Retrocompatibilidade | Ponto forte histórico (ex.: x86/x64) | Não é o foco de projeto |
| Onde reside a complexidade | No hardware | Transferida para o software/compilador |
| Exemplos de arquitetura | x86, x64 | ARM, AVR |
| Aplicações típicas | Desktops, notebooks, servidores tradicionais | Smartphones, computação móvel, automação embarcada |

Paradigma e família não devem ser confundidos: CISC e RISC são paradigmas; x86/x64, ARM e AVR são famílias que seguem um deles. Nem todo processador CISC é x86 — o Motorola 68000, citado na Seção 3.3, também é CISC —, e nem todo RISC é ARM, como mostra o próprio AVR. A relação correta é de classe e subclasse.

CISC e RISC são, portanto, **paradigmas** — formas distintas de resolver o mesmo problema geral (processar instruções), da mesma maneira que bicicleta, carro e ônibus são meios de transporte que resolvem o mesmo problema (deslocamento) seguindo lógicas de projeto totalmente diferentes, cada uma adequada a um conjunto de circunstâncias.

## 3.7 Tendências de mercado: computação de borda e migração para ARM

A distinção entre arquitetura e organização (Seção 3.1) também explica decisões recentes de mercado. Um exemplo é a diferenciação entre versões "Pro" e "não Pro" de um mesmo smartphone: ambas podem compartilhar a mesma arquitetura de processador, mas a versão "Pro" pode incluir uma NPU (ver Capítulo 1, Seção 1.11.1) mais capaz, permitindo que tarefas de inteligência artificial — como transcrição e tradução simultânea de voz — sejam processadas localmente no aparelho, sem depender de um servidor remoto. Essa diferenciação é uma decisão de **organização**, não de arquitetura: o processamento no dispositivo (computação de borda, ou *edge computing*) versus o processamento na nuvem é uma escolha de hardware e de projeto de produto, não uma mudança no conjunto de instruções do processador.

A adoção da arquitetura ARM tem se expandido para além de dispositivos móveis. O projeto **Asahi Linux**, em desenvolvimento desde o início da década de 2020, busca portar o sistema operacional Linux para funcionar de forma plena nos chips ARM da série M da Apple, originalmente destinados exclusivamente ao macOS `[9]`. Portar um sistema operacional para outra família significa recompilá-lo para outro conjunto de instruções — exatamente o custo que a retrocompatibilidade x86 sempre evitou (Seção 3.3).

Nos servidores, a migração já é comercial: provedores de nuvem oferecem instâncias com processadores ARM próprios, como os AWS Graviton (desde 2018), ao lado das opções x86/x64 `[10]`.


!!! warning "Figura pendente"
    captura de tela de um site de hospedagem em nuvem mostrando opções de servidor com processador ARM ao lado de opções x86/x64


## Síntese do capítulo

Este capítulo formalizou a distinção entre arquitetura (o conjunto de instruções de um processador) e organização (sua implementação em hardware), aprofundou a arquitetura de von Neumann formalizada no Capítulo 2, e apresentou os dois grandes paradigmas de projeto de processadores — CISC, representado pela família x86/x64, e RISC, representado pelas famílias ARM e AVR — situando-os no contexto de tendências atuais de mercado, como a computação de borda e a possível migração de servidores para arquitetura ARM.

Esses conceitos são retomados adiante: o Capítulo 4 parte do paradigma (CISC × RISC, §4.2) para a organização interna de um processador real — Lei de Moore, calor, multicore, pipeline e soquete —, fechando o bloco "processador" (Capítulos 2–4); o limite de endereçamento reaparece no Capítulo 6 (§6.5), nas tabelas de partição MBR e GPT; e o Capítulo 13 retoma a organização do processador sob a metodologia de benchmark.

---

## Referências

1. STALLINGS, William. *Arquitetura e Organização de Computadores*. 10. ed. São Paulo: Pearson Education do Brasil, 2018, seção 1.1 "Organização e Arquitetura".
2. WIKIPEDIA. "Intel 8086." Disponível em: <https://en.wikipedia.org/wiki/Intel_8086>; "Intel 4004." Disponível em: <https://en.wikipedia.org/wiki/Intel_4004>; "Intel 8008." Disponível em: <https://en.wikipedia.org/wiki/Intel_8008>.
3. STALLINGS, William. *Arquitetura e Organização de Computadores*. 10. ed. São Paulo: Pearson Education do Brasil, 2018.
4. TEDIUM. "Why Intel Couldn't Trademark Numbers Anymore." Disponível em: <https://tedium.co/2017/05/18/intel-386-486-trademark-battles/>.
5. TECHPOWERUP. "Intel Confirms 'Core i-' Getting Replaced by 'Core Ultra' For Upcoming Meteor Lake Processors." Disponível em: <https://www.techpowerup.com/308061/>; ENGADGET. "Intel drops 'i' processor branding after 15 years, introduces 'Ultra' for higher-end chips." Disponível em: <https://www.engadget.com/intel-drops-i-processor-branding-after-15-years-introduces-ultra-for-higher-end-chips-130100277.html>.
6. BLEM, Emily; MENON, Jaikrishnan; SANKARALINGAM, Karthikeyan. "Power Struggles: Revisiting the RISC vs. CISC Debate on Contemporary ARM and x86 Architectures." *HPCA 2013*. Disponível em: <https://research.cs.wisc.edu/vertical/papers/2013/hpca13-isa-power-struggles.pdf>.
7. WIKIPEDIA. "x86-64." Disponível em: <https://en.wikipedia.org/wiki/X86-64>.
8. APPLE. "Apple unleashes M1." Apple Newsroom, 10 nov. 2020. Disponível em: <https://www.apple.com/newsroom/2020/11/apple-unleashes-m1/>.
9. ASAHI LINUX. Página "About" do projeto. Disponível em: <https://asahilinux.org/about/>.
10. AMAZON WEB SERVICES. "AWS Graviton Processor." Disponível em: <https://aws.amazon.com/ec2/graviton/>.
