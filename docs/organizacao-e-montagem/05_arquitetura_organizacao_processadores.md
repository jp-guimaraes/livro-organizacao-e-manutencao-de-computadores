# Capítulo 5 — Arquitetura e Organização de Processadores

Neste capítulo você vai estudar a distinção entre arquitetura e organização de computadores, o aprofundamento da arquitetura de von Neumann introduzida no Capítulo 1, os dois grandes paradigmas de projeto de processadores — CISC e RISC —, a evolução da família x86/x64, as famílias ARM e AVR como exemplos de RISC, e uma revisão integrada de conceitos de firmware e diagnóstico que perpassam todo o livro.

---

## 5.1 Arquitetura versus organização de computadores

Os termos *arquitetura de computadores* e *organização de computadores* são, com frequência, usados como sinônimos — inclusive na literatura técnica e no vocabulário do mercado de tecnologia. Este livro, seguindo a distinção adotada por autores como Stallings `[1]`, trata os dois termos como conceitos tecnicamente distintos.

**Arquitetura** é o conjunto de instruções que um processador disponibiliza para quem programa nesse processador. Esse conjunto de instruções é chamado, em inglês, de *Instruction Set Architecture* (ISA) — arquitetura do conjunto de instruções. A arquitetura define o que um processador é capaz de executar: quais operações existem, como os dados são endereçados, quais registradores estão disponíveis.

**Organização** é a implementação em hardware de uma dada arquitetura: as escolhas de projeto que determinam quantos núcleos um processador tem, qual a quantidade de memória cache, qual a frequência de operação, quanto de memória RAM ou de armazenamento um computador possui. Duas máquinas podem compartilhar a mesma arquitetura — o mesmo conjunto de instruções — e, ainda assim, ter organizações completamente diferentes.

**Exemplo.** Um processador Intel Core i3, um Core i5 e um Core i7 de uma mesma geração compartilham a mesma arquitetura x86/x64: executam exatamente o mesmo conjunto de instruções e, portanto, os mesmos programas. O que os diferencia — quantidade de núcleos, tamanho de cache, frequência de clock, consumo energético — são decisões de organização. O mesmo raciocínio se aplica a um smartphone vendido em versões 4G e 5G, ou a um mesmo modelo de notebook oferecido com capacidades diferentes de SSD: a arquitetura do processador permanece idêntica; o que muda é a organização do hardware ao redor dele.

Essa distinção também explica por que o nome da disciplina que dá origem a este livro é *organização e montagem de computadores*: ao longo dos capítulos anteriores, o que foi estudado — processador, memória principal, memória secundária, placa-mãe e demais componentes — são, tecnicamente falando, decisões de organização, e não de arquitetura. Arquitetura é assunto do programador de baixo nível e do fabricante do processador; organização é assunto de quem monta, especifica e mantém computadores.

**Nota de uso.** No vocabulário de mercado — sites de notícias de tecnologia, materiais de fabricantes, embalagens de produto —, o termo "arquitetura" costuma ser aplicado de forma ampla, cobrindo também mudanças que, tecnicamente, são de organização (por exemplo, uma nova geração de processador com mais núcleos e cache é frequentemente anunciada como "nova arquitetura"). O leitor deve estar preparado para essa imprecisão terminológica ao consultar fontes não acadêmicas.


!!! warning "Figura pendente"
    comparativo de anúncios de processadores i3/i5/i7 de mesma geração, com núcleos e cache destacados


## 5.2 A arquitetura de von Neumann formalizada

O Capítulo 1 introduziu o conceito de **programa armazenado**, formalizado por escrito no relatório de 1946 assinado por Arthur Burks, Herman Goldstine e John von Neumann `[2]`: a ideia de que instruções e dados residem na mesma memória do computador, permitindo que o programa seja executado de forma autônoma, sem intervenção humana a cada etapa. O nome consagrado do conceito — "arquitetura de von Neumann" — é o adotado neste livro, mas, como já observado no Capítulo 1, a formalização foi um trabalho conjunto dos três autores.

Esse princípio tem uma consequência que raramente é percebida por quem está começando a estudar computação: o processador não distingue, por natureza, uma instrução de um dado, nem atribui significado ao que está processando. O processador é uma máquina que executa instruções mecanicamente, manipulando padrões binários e produzindo uma saída — sem qualquer noção do propósito daquela operação.

**Exemplo.** Do ponto de vista do processador, é absolutamente indiferente se a sequência de instruções que ele executa está calculando a nota final de um aluno ou controlando a fervura de um doce: ele apenas manipula dados e gera uma saída. Quem atribui sentido a essa saída — quem decide se o resultado representa uma média escolar ou uma receita culinária — é o software, não o hardware. O processador, isoladamente, "não sabe o que está fazendo": ele apenas executa.

Essa característica é o que torna a arquitetura de von Neumann ao mesmo tempo poderosa e genérica: como instruções são armazenadas e tratadas como qualquer outro dado na memória, o mesmo hardware pode executar qualquer programa que respeite o seu conjunto de instruções (a arquitetura, na definição da Seção 5.1) — sem que o hardware precise ser fisicamente alterado a cada novo problema. Esse é o mesmo critério que, no Capítulo 1, distinguiu a máquina de Turing de propósito geral de uma calculadora de operação fixa.


!!! warning "Figura pendente"
    diagrama simplificado da arquitetura de von Neumann — processador, memória (instruções e dados), barramento, entrada/saída


## 5.3 CISC: retrocompatibilidade e a família x86/x64

Em 1981, a IBM lançou o IBM PC utilizando o processador Intel 8088, derivado do 8086 — um chip de 16 bits projetado como sucessor do 8080 para competir com os processadores de 16/32 bits da Zilog e da Motorola, escolhido pela IBM por seu baixo custo `[3]` (o Capítulo 1 apresenta o 8088 como variante de custo reduzido do 8086; a origem em calculadoras mencionada naquele capítulo se refere a chips anteriores da família Intel — o 4004 e o 8008 —, não ao 8086/8088). O sucesso comercial desse computador consolidou o conjunto de instruções do 8086 como padrão de mercado, e toda a evolução subsequente da família de processadores da Intel — e, mais tarde, da AMD — preservou esse conjunto de instruções original, apenas adicionando novas instruções a cada geração.

Esse comportamento decorre de uma exigência implícita do mercado de software: um fabricante que investiu no desenvolvimento de um programa para um determinado processador espera que esse programa continue funcionando — de preferência com desempenho melhor — nos processadores lançados posteriormente. A esse requisito dá-se o nome de **retrocompatibilidade**: a capacidade de um sistema mais novo executar, sem modificação, programas feitos para um sistema mais antigo da mesma família.

A tabela a seguir situa os principais marcos da evolução da família x86:

| Processador | Observação |
|---|---|
| 8086 | 16 bits; sucessor do 8080, projetado para competir com Zilog Z8000 e Motorola 68000; base do computador que a IBM adotou |
| 8088 | Versão de barramento externo simplificado do 8086, usada no IBM PC original (1981) |
| 80286 | Segunda geração da família; retrocompatível com o 8086 |
| 80386 | Lançado em 1985 `[4]`; primeira geração de 32 bits da família, retrocompatível até o 8086 |
| 80486 | Evolução do 386 com memória cache integrada ao processador |
| Pentium | Sucessor do 486; a Intel abandonou a numeração "586" e passou a usar um nome comercial `[5]` |
| Pentium II / III | Gerações seguintes da linha Pentium |
| Core 2 Duo | Geração seguinte, já multinúcleo |
| Core i3 / i5 / i7 | Segmentação por faixa de desempenho, mantendo a mesma arquitetura x86/x64 |
| Core Ultra / Core 5, 7, 9 | Nomenclatura adotada a partir de 2023 (geração Meteor Lake), substituindo i3/i5/i7 após décadas de uso `[6]` |

Cada geração dessa família mantém, como subconjunto, o conjunto de instruções de todas as gerações anteriores — o que pode ser representado como um diagrama de Venn de círculos concêntricos, em que as instruções do 8086 estão contidas nas do 286, que estão contidas nas do 386, e assim sucessivamente.

Ao conjunto de processadores que evoluem dessa forma — acumulando instruções ao longo do tempo, sem nunca descartar as anteriores — dá-se o nome de arquitetura **CISC** (*Complex Instruction Set Computer*, computador com conjunto de instruções complexo). O ponto forte dessa filosofia é justamente a retrocompatibilidade. Quanto ao consumo energético, um estudo de referência que mediu processadores ARM e x86 reais concluiu que as diferenças de consumo observadas na prática vêm principalmente de escolhas de microarquitetura e do ponto de projeto desempenho/eficiência (processadores ARM historicamente otimizados para baixo consumo; x86 para alto desempenho) — não do fato de o conjunto de instruções ser CISC ou RISC em si `[7]`. O que de fato é uma consequência direta do paradigma CISC é o acúmulo constante de complexidade no hardware ao longo de décadas de evolução — o que exige mais lógica de decodificação e microcódigo, ainda que o efeito disso sobre o consumo energético seja mais modesto do que costuma ser popularmente descrito.


!!! warning "Figura pendente"
    diagrama de Venn com círculos concêntricos representando 8086 ⊂ 286 ⊂ 386 ⊂ 486 ⊂ Pentium ⊂ Core


## 5.4 Endereçamento e a barreira dos 32 bits

A quantidade de bits que um processador utiliza para endereçar a memória determina diretamente a quantidade máxima de memória RAM que esse processador é capaz de acessar.

Um processador de arquitetura de 32 bits consegue endereçar, no máximo, cerca de 4 GB de memória RAM. Essa é uma limitação estrutural da arquitetura, não da quantidade de memória fisicamente instalada na placa-mãe.

**Exemplo.** É possível instalar 8 GB de memória RAM em um computador equipado com um sistema operacional de 32 bits; entretanto, esse sistema só conseguirá endereçar e utilizar até 4 GB — o restante permanece inacessível, por ausência de endereços suficientes para representá-lo. Esse foi historicamente um problema real de suporte técnico: computadores com memória fisicamente instalada, mas parcialmente inutilizável, por limitação da arquitetura do sistema operacional instalado, não do processador.

A superação dessa barreira motivou a extensão da arquitetura x86 para 64 bits. Em vez de propor uma arquitetura inteiramente nova, a AMD estendeu a arquitetura x86 de 32 bits existente, preservando toda a sua retrocompatibilidade e adicionando um modo de operação de 64 bits — resultando na arquitetura **AMD64**, posteriormente adotada por toda a indústria (incluindo a Intel, que tinha à época uma arquitetura de 64 bits concorrente e incompatível, a Itanium/IA-64, e só adotou a extensão da AMD em 2004, sob o nome "Intel 64") sob a denominação genérica **x64** `[8]`.

Uma consequência prática dessa relação de subconjunto (x86 ⊂ x64) diz respeito à compatibilidade de software: um sistema operacional de 64 bits é capaz de executar tanto programas de 64 bits quanto programas de 32 bits, por manter a retrocompatibilidade; já um sistema operacional de 32 bits não é capaz de executar programas de 64 bits, por não reconhecer as instruções e os endereços estendidos dessa arquitetura mais recente.


!!! warning "Figura pendente"
    comparação de páginas de download de um mesmo programa, mostrando as versões disponíveis para x86, x64 e ARM


## 5.5 RISC: o paradigma da simplicidade

Em contraposição à filosofia CISC, existe uma segunda abordagem de projeto de processadores, baseada na premissa oposta: construir um processador cujo conjunto de instruções seja o mais simples e reduzido possível. A essa família dá-se o nome de **RISC** (*Reduced Instruction Set Computer*, computador com conjunto de instruções reduzido).

O ponto forte do RISC, em comparação ao CISC, é a simplicidade do hardware de decodificação. É comum associar essa simplicidade a um menor consumo energético — e, na prática, processadores RISC (como os da família ARM) costumam ser mais eficientes energeticamente do que processadores CISC (x86/x64) — mas a pesquisa específica sobre o tema mostra que essa diferença vem majoritariamente de escolhas de microarquitetura e do mercado-alvo de cada família (ARM historicamente otimizada para dispositivos móveis; x86/x64 para desempenho bruto), não de uma propriedade intrínseca do conjunto de instruções em si `[7]`. A contrapartida real e direta da simplicidade do conjunto de instruções é que instruções complexas, que num processador CISC seriam executadas diretamente em hardware, precisam ser decompostas em uma sequência de instruções mais simples — transferindo parte da complexidade do hardware para o software (compiladores e demais camadas de programação).

**Exemplo.** A instrução "5 × 3" pode ser implementada de duas formas distintas. Em um processador com uma instrução de multiplicação dedicada em hardware, essa operação é resolvida diretamente. Em um processador cujo conjunto de instruções contém apenas soma, a mesma operação é obtida por meio de somas sucessivas (5 + 5 + 5), decompostas pelo compilador antes da execução. O resultado final é idêntico; o caminho até ele é que muda — e é essa diferença de caminho que distingue, na prática, um processador CISC de um processador RISC.

A principal família comercial de processadores RISC de propósito geral é a **ARM**, presente em smartphones, no Raspberry Pi e, desde 2020, também em notebooks (como os MacBooks equipados com chips da série M — M1, M2, M3, M4, M5, lançados a partir de novembro de 2020) e em processadores da linha Snapdragon `[9]`.

Uma segunda família RISC, voltada não para computação de propósito geral, mas para **microcontroladores** embarcados, é a **AVR**, presente em chips como o ATmega328 (usado nas placas Arduino Uno) e nos microcontroladores PIC.

Diferentemente da relação entre x86 e x64 (em que uma arquitetura está contida na outra), ARM e AVR não compartilham conjuntos de instruções entre si: são duas famílias RISC distintas, sem relação de subconjunto uma com a outra, cada uma otimizada para um tipo de aplicação diferente.

**Exemplo.** Um semáforo de trânsito exige um hardware de controle que permaneça ligado ininterruptamente, com baixíssimo consumo energético e alta confiabilidade, mas sem necessidade de grande poder de processamento — um cenário típico de aplicação para microcontroladores AVR. Um notebook usado para tarefas de escritório e navegação em rede, por outro lado, demanda maior poder computacional e tipicamente adota arquiteturas x86/x64 ou ARM, conforme o caso de uso.


!!! warning "Figura pendente"
    fotos comparativas de um chip Cortex-A (Raspberry Pi), um Snapdragon (smartphone) e um ATmega328 (Arduino Uno)


## 5.6 Comparação entre paradigmas de arquitetura

A tabela a seguir resume as principais diferenças entre os paradigmas CISC e RISC:

| Característica | CISC | RISC |
|---|---|---|
| Conjunto de instruções | Extenso e complexo, acumulado ao longo de décadas | Reduzido e simplificado, por projeto |
| Consumo energético | Historicamente mais alto (efeito majoritariamente de microarquitetura, não da ISA em si `[7]`) | Historicamente mais baixo (idem) |
| Retrocompatibilidade | Ponto forte histórico (ex.: x86/x64) | Não é o foco de projeto |
| Onde reside a complexidade | No hardware | Transferida para o software/compilador |
| Exemplos de arquitetura | x86, x64 | ARM, AVR |
| Aplicações típicas | Desktops, notebooks, servidores tradicionais | Smartphones, computação móvel, automação embarcada |

Arquitetura (o paradigma de projeto) e implementação específica não devem ser confundidas: nem todo processador CISC pertence à família x86/x64, e nem todo processador RISC pertence à família ARM. A relação correta é de classe e subclasse.

CISC e RISC são, portanto, **paradigmas** — formas distintas de resolver o mesmo problema geral (processar instruções), da mesma maneira que bicicleta, carro e ônibus são meios de transporte que resolvem o mesmo problema (deslocamento) seguindo lógicas de projeto totalmente diferentes, cada uma adequada a um conjunto de circunstâncias.

## 5.7 Tendências de mercado: computação de borda e migração para ARM

A distinção entre arquitetura e organização (Seção 5.1) também explica decisões recentes de mercado. Um exemplo é a diferenciação entre versões "Pro" e "não Pro" de um mesmo smartphone: ambas podem compartilhar a mesma arquitetura de processador, mas a versão "Pro" pode incluir uma NPU (ver Capítulo 1, Seção 1.10.5) mais capaz, permitindo que tarefas de inteligência artificial — como transcrição e tradução simultânea de voz — sejam processadas localmente no aparelho, sem depender de um servidor remoto. Essa diferenciação é uma decisão de **organização**, não de arquitetura: o processamento no dispositivo (computação de borda, ou *edge computing*) versus o processamento na nuvem é uma escolha de hardware e de projeto de produto, não uma mudança no conjunto de instruções do processador.

A adoção da arquitetura ARM tem se expandido para além de dispositivos móveis. O projeto **Asahi Linux**, em desenvolvimento desde o início da década de 2020, busca portar o sistema operacional Linux para funcionar de forma plena nos chips ARM da série M da Apple, originalmente destinados exclusivamente ao macOS `[10]`.


!!! warning "Figura pendente"
    captura de tela de um site de hospedagem em nuvem mostrando opções de servidor com processador ARM ao lado de opções x86/x64


## 5.8 Revisão integrada: firmware, particionamento e diagnóstico

Esta seção consolida, de forma breve, conceitos tratados em capítulos anteriores deste livro, retomados aqui como revisão integrada antes do fechamento do curso.

**Bateria da placa-mãe (CMOS).** A placa-mãe possui uma pequena memória volátil dedicada a armazenar as configurações do firmware — data e hora do sistema, parâmetros de inicialização e demais configurações definidas pelo *setup* da BIOS/UEFI (ver Capítulo 4). Por ser uma memória volátil, essa informação depende de energia contínua para não ser perdida; a bateria da placa-mãe existe justamente para manter essa memória energizada mesmo com o computador desligado da tomada.

**Tabelas de partição: MBR e GPT.** MBR (*Master Boot Record*) é o esquema de particionamento mais antigo, limitado a quatro partições primárias (contornável por meio de uma partição estendida contendo partições lógicas) e a discos de até aproximadamente 2 TB `[11]`. GPT (*GUID Partition Table*) é o esquema mais recente, sem essa limitação prática de tamanho de disco, com suporte a um número muito maior de partições, rótulos (*labels*) nomeáveis e uma cópia de segurança da própria tabela de partição em outra região do disco. O uso de GPT depende de suporte do firmware da placa-mãe: computadores com BIOS tradicional (não UEFI) não têm suporte a GPT; computadores com UEFI podem trabalhar tanto com GPT quanto, por retrocompatibilidade, com MBR.

| Característica | MBR | GPT |
|---|---|---|
| Idade | Mais antigo | Mais recente |
| Partições primárias | Até 4 (ou partição estendida com lógicas) | Muito superior a 4 |
| Tamanho máximo de disco | ~2 TB | Sem essa limitação prática |
| Backup da tabela de partição | Não | Sim |
| Requisito de firmware | BIOS ou UEFI | Exclusivamente UEFI |

**BIOS, UEFI e Setup.** BIOS (*Basic Input/Output System*, ver Capítulo 1) designa, em sentido amplo, o conjunto de softwares de firmware presentes na placa-mãe — entre eles o programa de *setup* (interface de configuração), o POST (rotina de autoteste na inicialização) e utilitários de diagnóstico de memória. UEFI (*Unified Extensible Firmware Interface*) é a evolução moderna dessa camada de firmware, sucedendo a BIOS tradicional `[12]`; a relação entre BIOS e UEFI é análoga à relação entre MBR e GPT — a mais nova sucede a mais antiga, mantendo retrocompatibilidade.

**GRUB e inicialização com múltiplos sistemas operacionais.** Um *bootloader* é o software responsável por indicar ao processador qual região do disco deve ser carregada para dar início à execução de um sistema operacional — necessário porque o processador, conforme discutido na Seção 5.2, apenas executa instruções, sem qualquer capacidade de decidir autonomamente o que carregar. O GRUB é um bootloader típico de sistemas Linux, usado em configurações de inicialização dupla (*dual boot*). Recomenda-se instalar o Windows antes do Linux num mesmo disco porque o instalador do Windows, por padrão, sobrescreve a região de inicialização do disco sem considerar a coexistência com outro sistema operacional; o Linux, por filosofia de projeto, já assume a possibilidade de múltiplos sistemas operacionais e instala um bootloader capaz de gerenciar essa escolha.

**Live CD / Live USB.** Denomina-se *live CD* (ou *live USB*, por extensão histórica do termo) um sistema operacional capaz de ser executado inteiramente a partir da memória secundária removível, sem necessidade de instalação. Esse recurso é uma ferramenta de diagnóstico relevante para a disciplina de manutenção: ao inicializar um computador a partir de um live USB e testar componentes (por exemplo, conectividade Wi-Fi) fora do sistema operacional instalado, é possível isolar se um problema relatado é de hardware ou de software — aplicando o mesmo princípio de substituição de módulo apresentado no Capítulo 1 (Seção 1.6.2), mas por meio de software.

**Funcionamento mínimo sem memória secundária.** Retomando o modelo de hierarquia de memória do Capítulo 1: um computador do tipo desktop necessita de memória RAM presente e operacional para executar qualquer programa; sem memória primária, nenhuma instrução pode ser processada. A memória secundária (HD/SSD), por outro lado, não é estritamente necessária para que o computador ligue e opere — é possível, por exemplo, executar um sistema por meio de um live USB, sem qualquer armazenamento interno.

## Síntese do capítulo

Este capítulo formalizou a distinção entre arquitetura (o conjunto de instruções de um processador) e organização (sua implementação em hardware), aprofundou a arquitetura de von Neumann introduzida no Capítulo 1, e apresentou os dois grandes paradigmas de projeto de processadores — CISC, representado pela família x86/x64, e RISC, representado pelas famílias ARM e AVR — situando-os no contexto de tendências atuais de mercado, como a computação de borda e a possível migração de servidores para arquitetura ARM.

Com este capítulo encerra-se a jornada proposta por este livro: partindo da definição técnica de computador e de sua evolução histórica (Capítulo 1), passando pela hierarquia de memória (Capítulo 2), pela instalação e configuração de sistemas operacionais (Capítulo 3) e pela montagem e manutenção do hardware físico (Capítulo 4), até chegar aos fundamentos teóricos de arquitetura de processadores que sustentam tudo o que foi estudado nos capítulos anteriores.

O princípio de modularidade apresentado no Capítulo 1 — a ideia de que um computador é um conjunto de módulos substituíveis, e de que o diagnóstico técnico consiste em isolar qual módulo é responsável por uma falha — permanece como o fio condutor de toda a disciplina. No semestre seguinte, o curso de Manutenção de Computadores (2026.1), com a mesma turma, dará continuidade a este conteúdo com foco em diagnóstico e reparo: aplicando, na prática cotidiana da bancada técnica, os fundamentos teóricos de hardware, memória, sistema operacional e arquitetura consolidados ao longo deste livro.

---

## Referências

1. STALLINGS, William. *Arquitetura e Organização de Computadores*. 10. ed. São Paulo: Pearson Education do Brasil, 2018, seção 1.1 "Organização e Arquitetura".
2. BURKS, A. W.; GOLDSTINE, H. H.; VON NEUMANN, J. *Preliminary Discussion of the Logical Design of an Electronic Computing Instrument*. Princeton: Institute for Advanced Study, 1946; sobre a disputa de crédito com Eckert e Mauchly: COMPUTER HISTORY MUSEUM. "The Neverending Quest for 'Firsts'." Disponível em: <https://computerhistory.org/blog/the-neverending-quest-for-firsts/>.
3. WIKIPEDIA. "Intel 8086." Disponível em: <https://en.wikipedia.org/wiki/Intel_8086>; "Intel 4004." Disponível em: <https://en.wikipedia.org/wiki/Intel_4004>; "Intel 8008." Disponível em: <https://en.wikipedia.org/wiki/Intel_8008>.
4. STALLINGS, William. *Arquitetura e Organização de Computadores*. 10. ed. São Paulo: Pearson Education do Brasil, 2018.
5. TEDIUM. "Why Intel Couldn't Trademark Numbers Anymore." Disponível em: <https://tedium.co/2017/05/18/intel-386-486-trademark-battles/>.
6. TECHPOWERUP. "Intel Confirms 'Core i-' Getting Replaced by 'Core Ultra' For Upcoming Meteor Lake Processors." Disponível em: <https://www.techpowerup.com/308061/>; ENGADGET. "Intel drops 'i' processor branding after 15 years, introduces 'Ultra' for higher-end chips." Disponível em: <https://www.engadget.com/intel-drops-i-processor-branding-after-15-years-introduces-ultra-for-higher-end-chips-130100277.html>.
7. BLEM, Emily; MENON, Jaikrishnan; SANKARALINGAM, Karthikeyan. "Power Struggles: Revisiting the RISC vs. CISC Debate on Contemporary ARM and x86 Architectures." *HPCA 2013*. Disponível em: <https://research.cs.wisc.edu/vertical/papers/2013/hpca13-isa-power-struggles.pdf>.
8. WIKIPEDIA. "x86-64." Disponível em: <https://en.wikipedia.org/wiki/X86-64>.
9. Data de lançamento dos MacBooks com chip Apple M1 (novembro de 2020): Apple Newsroom (anúncio oficial); para o histórico mais amplo de tentativas anteriores de notebooks ARM, ver retrospectivas de imprensa especializada (Windows Central, How-To Geek) — link exato a confirmar pelo autor.
10. ASAHI LINUX. Página "About" do projeto. Disponível em: <https://asahilinux.org/about/>.
11. MICROSOFT. "Windows and GPT FAQ." Disponível em: <https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/windows-and-gpt-faq> (edição/data exata a confirmar pelo autor).
12. UEFI FORUM. Especificação oficial. Disponível em: <https://uefi.org/specifications> (edição específica a confirmar pelo autor).
