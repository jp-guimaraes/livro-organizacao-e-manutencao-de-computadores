# Capítulo 2 — Memória

Neste capítulo você vai aprofundar os diversos tipos de memória de um computador moderno — da memória RAM volátil, passando pela hierarquia de cache dentro do processador, até a memória secundária persistente em suas variantes magnética, de estado sólido (flash) e ótica — e a relação direta entre a natureza física da célula de memória e o desempenho do sistema. O Capítulo 1 já introduziu a distinção entre memória RAM e armazenamento secundário e apresentou, na Seção 1.10, a pirâmide de hierarquia de memória; este capítulo não repete essa introdução, mas aprofunda cada uma de suas camadas.

---

## 2.1 Da célula de memória às características da memória

Um princípio orienta toda a discussão deste capítulo: **as características de uma memória — velocidade, custo, volatilidade, durabilidade — não são arbitrárias; elas decorrem diretamente da natureza física da sua célula de memória**, isto é, do mecanismo usado para armazenar um único bit.

Uma célula de memória é, em essência, um combinado: um dispositivo físico ao qual se atribui o significado "0" ou "1". Esse combinado pode ser implementado de formas radicalmente diferentes — um circuito com transistores, um capacitor carregado, uma região magnetizada, um ponto que reflete ou não reflete luz —, e é exatamente essa diferença de implementação que separa memória primária de memória secundária, e que separa, dentro da própria memória secundária, um HD de um SSD ou de uma mídia ótica.

[IMAGEM: esquema comparativo das quatro células de memória estudadas no capítulo — flip-flop, capacitor, domínio magnético, floating gate]

## 2.2 Memória estática (SRAM)

Entre 1963 e 1995, a tecnologia dominante de memória primária era a memória **estática**. Numa célula estática, o bit é armazenado em um circuito chamado **flip-flop**, construído pela combinação de portas lógicas (AND, OR, NAND, NOT etc.), que por sua vez são construídas com transistores — chaves eletrônicas feitas de semicondutores dopados (tipo N e tipo P), cuja matéria-prima básica é o silício, um dos elementos mais abundantes do planeta.

Uma vez que um valor é escrito num flip-flop, ele permanece estável indefinidamente enquanto houver energia — daí o nome "estática". Essa estabilidade é o que torna a **SRAM** (*Static RAM*) extremamente rápida.

**Analogia.** A memória estática funciona como um objeto colocado sobre uma mesa: uma vez posicionado, ele permanece ali sem exigir nenhuma ação adicional para se manter no lugar.

A contrapartida da SRAM é o custo: por unidade de armazenamento, uma célula estática é significativamente mais cara e menos densa do que a alternativa dinâmica apresentada a seguir. Por isso, hoje a SRAM não é mais usada como memória primária de um computador — sua aplicação atual se restringe às memórias **cache** dentro do processador (Seção 2.8).

## 2.3 Memória dinâmica (DRAM) e a operação de *refresh*

A memória **dinâmica** (**DRAM**, *Dynamic RAM*) armazena cada bit em um capacitor — um componente que guarda carga elétrica, e não um valor lógico estável por natureza. Um capacitor perde carga ao longo do tempo, o que significa que a informação armazenada se degrada progressivamente.

**Analogia.** Guardar um bit num capacitor é como guardar um "1 lógico" na forma de água dentro de um copo: se o copo for deixado exposto, a água evapora lentamente e, depois de algum tempo, o "combinado" original (copo cheio = 1) deixa de valer. Para que o dado se mantenha, é preciso completar o copo periodicamente.

Esse "completar periodicamente" é a operação de ***refresh***: em intervalos regulares, o controlador de memória relê e regrava cada célula da DRAM para restaurar a carga elétrica antes que ela caia a ponto de tornar ambíguo se o bit é 0 ou 1. O termo é o mesmo usado para a atualização de uma página web (F5): uma releitura periódica que traz o conteúdo de volta ao estado esperado.

A necessidade de *refresh* torna a DRAM mais lenta do que a SRAM. Em compensação, sua célula é mais simples (um único capacitor, em vez de um circuito completo de portas lógicas), o que permite maior **densidade de memória** — mais bits armazenados no mesmo espaço físico — e, consequentemente, um custo por bit muito menor.

**Analogia.** A relação entre densidade de armazenamento e ocupação de espaço é comparável à densidade populacional: assim como o litoral brasileiro concentra mais pessoas por quilômetro quadrado do que o interior, uma tecnologia de memória mais densa concentra mais bits por milímetro quadrado de chip — reduzindo o custo de produção por unidade de dado armazenado.

É essa relação custo–densidade–velocidade que explica por que a DRAM, apesar de mais lenta que a SRAM, tornou-se a tecnologia usada como memória RAM principal de praticamente todos os computadores modernos.

## 2.4 Sincronismo e a família SDRAM/DDR

A geração seguinte de memória dinâmica introduziu o **sincronismo**: em vez de operar de forma assíncrona, a memória passou a coordenar suas operações com um sinal de **clock** — um sinal digital que alterna regularmente entre nível alto e nível baixo. As operações de leitura e escrita só são processadas quando o clock está em um determinado estado, o que evita instabilidades elétricas durante a transição de valores no circuito. Essa é a **SDRAM** (*Synchronous Dynamic RAM*): dinâmica (usa capacitores e precisa de *refresh*) e síncrona (usa clock).

A frequência desse clock, medida em megahertz (MHz) ou gigahertz (GHz), determina quantas operações de leitura/escrita a memória realiza por segundo — é o número de frequência de trabalho estampado na embalagem de qualquer memória RAM vendida no mercado.

A partir da SDRAM, o mercado consolidou a tecnologia **DDR** (*Double Data Rate*), cujas gerações sucessivas — DDR, DDR2, DDR3, DDR4, DDR5 — dobram, a cada geração, o número de operações realizadas por ciclo de clock, além de aumentar a densidade da célula e reduzir o consumo de energia. A tabela a seguir resume as principais características discutidas em aula:

| Geração | Taxa de transferência (aprox.) | Tensão de operação | Observação |
|---|---|---|---|
| DDR3 | ~1,6 Gb/s | 1,5 V | Tecnologia madura, hoje mais cara por menor oferta |
| DDR4 | ~3,2 Gb/s | 1,2 V | Tecnologia dominante no mercado atual |
| DDR5 | ~4,8–6,4 Gb/s | 1,1 V | Maior capacidade por módulo; ainda mais cara por menor adoção |

A tensão de operação cai a cada geração porque, segundo a relação P = U·I, uma tensão menor implica uma corrente menor para a mesma potência — e uma corrente menor produz menos perda de energia por efeito Joule. Como as trilhas de um circuito de memória percorrem distâncias muito curtas (ao contrário de uma linha de transmissão de energia de longa distância, onde se eleva a tensão para reduzir a corrente), reduzir a tensão é a estratégia mais eficiente para economizar energia num computador.

**Exemplo.** Em pesquisa de preços real feita em aula num site de varejo de hardware, uma memória DDR3 de 4 GB a 1600 MHz custava R$ 169,99, enquanto uma memória DDR4 de 8 GB — o dobro da capacidade e de uma tecnologia mais recente — custava R$ 129,49, um valor menor. A explicação não é técnica, mas de mercado: pela lei da oferta e da procura, uma tecnologia em fim de vida (DDR3) fica mais cara à medida que sua oferta diminui, mesmo sendo tecnologicamente inferior a uma tecnologia mais nova e mais barata (DDR4) que está no auge de sua adoção. O mesmo padrão se repetia com a DDR5: um kit de 2×16 GB custava R$ 1.139 — cerca do dobro do preço por gigabyte de um kit DDR4 equivalente —, mostrando que montar um computador de última geração tem um custo-benefício pior no curto prazo, embora garanta maior disponibilidade de peças de reposição no médio prazo.

**Nota prática.** Um computador cliente de servidor que roda sobre memória DDR3 é, em geral, mais barato de manter trocando apenas o módulo de memória (da ordem de R$ 100) do que substituindo toda a máquina por uma DDR4 (da ordem de R$ 10.000 a R$ 20.000) — uma decisão de manutenção baseada em custo-benefício, e não apenas em desempenho bruto.

Cada geração tecnológica também define um **limite de capacidade por módulo**: um slot de memória DDR4, por exemplo, comporta um módulo de até 128 GB. Numa placa-mãe com quatro slots, a capacidade total possível de memória primária é, portanto, de até 512 GB — mas apenas dentro da mesma geração tecnológica: não é possível combinar um módulo DDR4 com um DDR5 na mesma máquina, tanto por incompatibilidade elétrica quanto física (Seção 2.6).

[IMAGEM: linha do tempo DDR, DDR2, DDR3, DDR4, DDR5 com taxa de transferência e tensão]

## 2.5 Overclock, underclock e a tríade memória–placa-mãe–processador

Sobrecarregar a frequência de trabalho de um componente acima de sua especificação nominal é chamado de ***overclock***; o inverso — reduzir a frequência de trabalho abaixo do especificado — é o ***underclock***.

A frequência de trabalho de uma memória RAM não é uma propriedade isolada: ela precisa estar compatibilizada com a placa-mãe e com o processador. Se a memória suporta uma frequência mais alta do que a placa-mãe ou o processador conseguem sustentar, o sistema realiza um underclock automático de todo o conjunto para garantir estabilidade — em vez de operar na velocidade máxima anunciada da memória, o conjunto passa a operar na velocidade máxima que o elo mais fraco da cadeia suporta.

**Nota prática.** Um computador instável, travando com frequência, pode ter como causa uma memória configurada para trabalhar acima da frequência que a combinação placa-mãe/processador suporta de forma confiável. Reduzir manualmente essa frequência (um underclock deliberado) costuma resolver o travamento ao custo de uma perda de desempenho geralmente irrelevante na prática.

## 2.6 Compatibilidade física entre gerações: o chanfro

Módulos de memória de gerações DDR diferentes não são apenas eletricamente incompatíveis (cada geração opera numa tensão diferente); eles são também **fisicamente incompatíveis por projeto**. Cada módulo de memória possui um entalhe — o **chanfro** — posicionado em um ponto específico ao longo do conector de pinos; o slot correspondente na placa-mãe possui uma saliência física alinhada apenas com o chanfro daquela geração específica de memória.

O objetivo é puramente preventivo: como módulos de gerações diferentes têm a mesma pinagem física mas tensões de operação distintas, conectar um módulo incompatível poderia danificar tanto a memória quanto a placa-mãe. O chanfro torna essa conexão errada fisicamente impossível — não por os módulos terem tamanhos diferentes (todos os módulos DIMM de desktop têm dimensões físicas praticamente idênticas, para simplificar o projeto das placas-mãe), mas exclusivamente pela posição do chanfro, que muda a cada geração (DDR, DDR2, DDR3, DDR4, DDR5).

**Nota prática.** Se um técnico sentir que está fazendo força para encaixar um componente de hardware, isso é sinal de que algo está errado — nenhum procedimento de manuseio de memória, processador ou demais componentes eletrônicos deve exigir força. É necessário parar e reavaliar o encaixe.

Existe ainda uma diferença de tamanho físico entre memórias de notebook e de desktop — as memórias de notebook são fisicamente menores, para otimizar espaço —, o que significa que um desktop pode, em certos casos, usar memória de notebook, mas o inverso nunca é possível.

[IMAGEM: fotografia de dois módulos DDR de gerações diferentes lado a lado, com o chanfro em posições distintas destacado]

## 2.7 Dual Channel e Flex Mode

Uma mesma geração de memória tem um limite de velocidade determinado pela tecnologia da sua célula. O **Dual Channel** é uma estratégia para superar esse limite sem depender de uma nova geração tecnológica: em vez de escrever um dado inteiro sequencialmente em um único chip de memória, o sistema divide o dado (técnica chamada em inglês de *stripping*) e o escreve simultaneamente em dois ou mais módulos de memória idênticos, através de canais distintos.

**Exemplo.** Considere uma memória capaz de escrever a 10 MB por segundo e um arquivo de 100 MB a ser carregado da memória secundária para a memória primária. Usando um único módulo, a escrita levaria 10 segundos. Dividindo o arquivo ao meio e escrevendo 50 MB em cada um de dois módulos idênticos simultaneamente, cada metade leva 5 segundos — e, como as duas escritas ocorrem em paralelo, o tempo total cai de 10 para 5 segundos. O sistema operacional arca com um pequeno custo adicional de software para fragmentar e depois recompor o dado, mas o ganho de desempenho compensa amplamente esse custo.

Para o Dual Channel funcionar de forma ideal, o cenário recomendado é usar módulos **idênticos** — mesmo fabricante, mesma frequência de trabalho, mesma tensão de operação — e instalá-los nos slots corretos indicados no manual da placa-mãe. Quando não há dois módulos idênticos disponíveis, é possível usar o **Flex Mode**: módulos de capacidades ou frequências diferentes trabalham parcialmente em Dual Channel, mas a frequência de trabalho do conjunto fica limitada pelo módulo mais lento e a capacidade em Dual Channel, pelo módulo menor.

**Nota prática (quiz de mercado).** Existe diferença entre usar um único módulo de 8 GB ou dois módulos de 4 GB somando os mesmos 8 GB? Sim: se a placa-mãe suportar Dual Channel, dois módulos entregam desempenho sensivelmente melhor do que um único módulo da mesma capacidade total. Curiosamente, o mercado às vezes cobra mais caro por um kit de dois módulos idênticos (por exemplo, 2×16 GB) do que por um único módulo de capacidade equivalente (1×32 GB) — o que não invalida a vantagem técnica do Dual Channel, apenas reflete dinâmica de preços e demanda.

## 2.8 Cache e o princípio da localidade

O termo *cache* designa, ao mesmo tempo, um **conceito** e um **componente de hardware** específico — e é importante não confundir os dois.

Como conceito, *cache* é a estratégia de trazer, antecipadamente, dados de uma memória mais lenta para uma memória mais rápida, com base na expectativa de que esses dados serão necessários em breve. Essa estratégia se apoia no **princípio da localidade**: quando um programa acessa uma determinada posição de memória, há alta probabilidade de que ele também precise, em seguida, de posições adjacentes a ela.

**Exemplo.** Ao abrir um arquivo PDF, o sistema não lê apenas o byte solicitado no exato instante da requisição: como o disco tem acesso sequencial e o arquivo está fisicamente concentrado numa mesma região do disco (justamente por causa do princípio da localidade), o sistema aproveita que a cabeça de leitura já está posicionada ali e lê um bloco inteiro ao redor da posição pedida, guardando-o numa memória rápida — antecipando pedidos futuros em vez de repetir o processo de acesso sequencial, que é caro em tempo.

**Analogia.** A operação de cache é equivalente a um ajudante de obra que, ao perceber que o pedreiro está prestes a precisar de martelo e pregos, já traz os dois de uma vez e os deixa próximos, em vez de esperar cada pedido individual e ir buscar um item de cada vez.

Esse mesmo princípio é usado fora do hardware de um computador local: um serviço de streaming de vídeo, por exemplo, antecipa a demanda por um lançamento popular trazendo seus dados de um armazenamento mais lento para um armazenamento mais rápido antes mesmo de a maior parte dos usuários assistir.

Quando o dado antecipado é efetivamente solicitado em seguida, ocorre um ***cache hit***; quando o dado solicitado não está na memória cache e precisa ser buscado na memória mais lenta, ocorre um ***cache miss***.

Como **hardware**, a *cache da CPU* é a memória física, construída em tecnologia SRAM (Seção 2.2), localizada dentro do próprio processador. Ela é organizada em níveis:

- **Cache L1** — a menor e mais rápida, exclusiva de cada núcleo, geralmente subdividida em cache de instrução (o código do programa) e cache de dado.
- **Cache L2** — maior e um pouco mais lenta que a L1, também exclusiva de cada núcleo.
- **Cache L3** — a maior das três, compartilhada entre todos os núcleos do processador.

**Exemplo.** Ao solicitar um dado, o processador primeiro verifica a cache L1; se houver *cache miss*, verifica a L2; se houver novo *miss*, verifica a L3; e apenas se também não encontrar ali, vai buscar o bloco de dados na memória RAM (usando Dual Channel, se disponível), trazendo-o de volta para as camadas de cache. Um processador real anunciado no mercado, por exemplo, pode especificar 16 MB de cache L3 compartilhada e, para cada um de seus 8 núcleos, 512 KB de cache L2 e 48 KB de cache L1 — números que aparecem diretamente nas especificações técnicas vendidas ao consumidor.

**Cache versus Dual Channel.** Embora ambos aumentem o desempenho da memória, operam em níveis e por mecanismos diferentes: o Dual Channel atua ao nível da memória RAM, dividindo (*stripping*) e recompondo um mesmo dado entre módulos distintos para ganhar velocidade de escrita e leitura simultânea. O cache atua ao nível da CPU, antecipando e mantendo próximos dados que provavelmente serão requisitados, com base no princípio da localidade. Um não substitui o outro — ambos coexistem no mesmo sistema, otimizando pontos diferentes do caminho entre o processador e o armazenamento.

| Recurso | Nível de atuação | Mecanismo | Objetivo |
|---|---|---|---|
| Cache (L1/L2/L3) | CPU | Antecipa dados prováveis com base no princípio da localidade | Reduzir tempo de espera por dados já previstos |
| Dual Channel | Memória RAM | Divide e recompõe (*stripping*) um dado entre módulos simultâneos | Aumentar a taxa de leitura/escrita da RAM |

[IMAGEM: diagrama da hierarquia L1/L2/L3 dentro de um processador multi-núcleo, com fluxo de cache miss subindo até a RAM]

## 2.9 Memória virtual (*swap*)

Todo processo em execução precisa estar carregado, ao menos parcialmente, em memória RAM. Quando a soma da memória exigida pelos programas em execução excede a capacidade física de RAM instalada, o sistema operacional recorre a um recurso chamado **memória virtual**: ele reserva um espaço de armazenamento secundário e o trata como se fosse uma extensão da memória primária, "mentindo" para o sistema sobre a quantidade de RAM realmente disponível. No Linux, essa área reservada é chamada de **swap**.

O grande custo desse recurso é o desempenho: a memória secundária usada como swap é ordens de grandeza mais lenta do que a RAM, então o sistema como um todo fica visivelmente mais lento sempre que depende de memória virtual.

**Exemplo.** Ao processar um programa de linguagem natural que precisava tokenizar grandes volumes de texto, o professor precisou expandir sucessivamente a memória RAM disponível: começando com 16 GB, depois testando com 32 GB e 64 GB emprestados, até finalmente montar um computador dedicado com 128 GB de RAM. Mesmo assim, o sistema operacional precisou recorrer à memória virtual, chegando a usar cerca de 210 GB no pico da execução — 128 GB de RAM física somados a aproximadamente 82 GB de espaço em SSD alocados como swap — antes de estabilizar em torno de 30 GB de uso real após a conclusão da etapa mais pesada do processamento. Uma alternativa mais barata, sugerida posteriormente por um aluno em sala, seria configurar um SSD disponível inteiramente como área de swap: o programa rodaria de forma extremamente lenta, mas sem exigir a compra de um novo computador.

**Nota prática.** Computadores mais antigos, com pouca memória RAM, dependiam fortemente de memória virtual mesmo em tarefas cotidianas (como alternar entre poucos aplicativos abertos), o que explica boa parte da lentidão percebida nesses equipamentos. Um caso particularmente relevante é o de notebooks modernos com memória RAM reduzida e soldada à placa (não expansível): como recorrem a memória virtual com maior frequência, o uso constante de swap desgasta progressivamente as células da memória flash usada como área de troca — um problema discutido em detalhe na Seção 2.11.

## 2.10 Armazenamento magnético: o disco rígido (HD)

O **disco rígido** (HD, *hard disk*) é a memória secundária mais tradicional, e sua célula de memória é de natureza **magnética**. Fisicamente, um HD é composto por:

- Um ou mais **pratos** (*platters*) — discos rígidos girando em alta rotação, onde os dados são efetivamente gravados.
- Uma **cabeça de leitura e escrita** eletromagnética, posicionada na ponta de um **braço atuador**, que se movimenta sobre a superfície do prato.

A escrita ocorre porque uma corrente elétrica variável na cabeça de leitura/escrita gera um campo eletromagnético, que magnetiza uma região microscópica do prato numa polaridade norte-sul ou sul-norte — cada orientação corresponde a um bit 0 ou 1.

**Analogia.** O funcionamento é equivalente a uma fechadura eletromagnética de porta: enquanto há corrente, o eletroímã segura a porta fechada; ao cortar a energia, o campo desaparece e a porta libera. Da mesma forma, a cabeça do HD usa corrente elétrica para gerar (ou não) o campo magnético que orienta cada bit no prato.

Uma vez magnetizada, a região do disco mantém sua orientação **sem necessidade contínua de energia** — daí a não volatilidade do HD. O dado só é perdido se um novo campo magnético externo suficientemente forte for aplicado sobre a região gravada, o que reescreve (ou corrompe) a informação ali contida. Essa é, inclusive, uma técnica legítima de destruição segura de dados.

Como a cabeça de leitura/escrita precisa se posicionar fisicamente sobre a trilha correta e aguardar a rotação do prato até o setor desejado passar por baixo dela, o HD tem **acesso sequencial**: o tempo de acesso depende da posição física do dado no disco, ao contrário do acesso aleatório da memória RAM. Cada face de cada prato é organizada em **trilhas** (círculos concêntricos) subdivididas em **setores**; o endereço de um dado no disco é dado pela combinação face/trilha/setor.

Por depender de peças móveis — motor, prato girando, braço atuador —, o HD tem vulnerabilidades de nascença: desgaste mecânico ao longo do tempo (fadiga de peças em movimento), risco de dano por impacto físico enquanto o disco está girando, e um tempo de vida útil finito determinado pela durabilidade dos componentes mecânicos. Em compensação, sua carcaça é lacrada hermeticamente — sem entrada de poeira ou partículas —, e, ao contrário das mídias óticas (Seção 2.12), o prato interno não é exposto a arranhões no uso normal.

**Nota prática.** Reparar internamente um HD exige uma sala limpa com nível de partículas por metro cúbico comparável ao de uma sala de cirurgia; abrir a carcaça fora desse ambiente controlado inutiliza o disco de forma irreversível — qualquer poeira que entre compromete a leitura. Por isso, HDs trazem parafusos e adesivos de segurança que evidenciam violação.

[IMAGEM: HD aberto com prato, braço atuador e cabeça de leitura/escrita identificados]
[IMAGEM: esquema de endereçamento face/trilha/setor de um disco magnético]

## 2.11 Unidade de alocação: clusters e metadados

Todo sistema de armazenamento secundário organiza o espaço em disco numa unidade mínima de alocação chamada **cluster**. Um cluster funciona como uma gaveta de tamanho fixo: mesmo que um arquivo ocupe uma fração mínima dessa gaveta, o espaço inteiro do cluster fica reservado para aquele arquivo.

**Exemplo.** Um documento do Word contendo apenas a letra "J" — o equivalente, em ASCII, a 8 bits — pode ocupar 13 KB (13 × 1.024 × 8 bits) no disco. A diferença entre os 8 bits do caractere e os 13 KB efetivamente ocupados se explica pelo tamanho do cluster: o sistema de arquivos aloca, no mínimo, um cluster inteiro para qualquer arquivo, por menor que seja. Adicionar mais conteúdo ao mesmo documento (por exemplo, mais uma letra) continua ocupando o mesmo cluster, até que o conteúdo exceda sua capacidade — só então um segundo cluster é alocado.

O tamanho do cluster é uma escolha de engenharia com consequências em ambas as direções: clusters maiores reduzem o esforço de endereçamento (menos gavetas para gerenciar), mas desperdiçam mais espaço em arquivos pequenos; clusters menores reduzem o desperdício, mas aumentam o número de endereços que o sistema precisa gerenciar. Esse tema será retomado, junto com o processo de formatação, no Capítulo 3.

Associado a cada cluster alocado existe um conjunto de **metadados** — dados sobre o próprio dado: nome do arquivo, extensão, programa associado, e se aquele espaço está ou não disponível para uso. Os metadados ficam registrados no disco separadamente do conteúdo do arquivo propriamente dito, numa estrutura chamada **tabela de partição** (também aprofundada no Capítulo 3).

**Analogia.** Quando um arquivo é "apagado", ele geralmente não é sobrescrito de imediato — apenas seus clusters são marcados como disponíveis nos metadados, de forma equivalente a um hotel liberando um quarto após o check-out: o quarto está disponível para o próximo hóspede, mas um objeto esquecido pelo hóspede anterior (como um carregador de celular) ainda está fisicamente lá até que alguém o remova ou o quarto seja reocupado. É justamente por isso que existem técnicas de recuperação de arquivos apagados: enquanto os clusters correspondentes não forem sobrescritos por um novo dado, a informação original ainda pode ser resgatada.

**Nota técnica.** É comum haver confusão entre a capacidade anunciada de um dispositivo de armazenamento e a capacidade reconhecida pelo sistema operacional. Isso ocorre porque fabricantes costumam anunciar capacidade em múltiplos de 1.000 (o padrão do Sistema Internacional de Unidades — kilo, mega, giga como potências de dez), enquanto sistemas operacionais tradicionalmente calculam capacidade em múltiplos de 1.024 (potências de dois, já que o computador trabalha em base binária). Um dispositivo anunciado com "16 GB" aparece, portanto, com uma capacidade ligeiramente menor quando visualizado pelo sistema operacional.

## 2.12 Memória flash

A **memória flash** é a tecnologia por trás do SSD (*Solid State Disk* — disco de estado sólido), de pendrives e da memória de armazenamento da grande maioria dos smartphones atuais. Sua célula de memória é construída com um tipo específico de transistor de efeito de campo chamado **MOSFET**, dotado de uma estrutura adicional chamada **porta flutuante** (*floating gate*).

**Analogia.** A porta flutuante é isolada eletricamente por duas camadas finíssimas de óxido, formando uma espécie de sanduíche: assim como o recheio de um hambúrguer fica isolado entre dois pães, os elétrons armazenados na porta flutuante ficam retidos entre as duas camadas isolantes de óxido.

A presença ou ausência de elétrons retidos na porta flutuante altera a tensão necessária para que corrente passe entre os dois terminais do transistor (chamados de dreno e fonte) — esse comportamento é o que permite implementar, em hardware, o equivalente a um teste "se-então" (*if*) que determina se a célula representa um bit 0 ou 1. Escrever um bit consiste em aplicar uma tensão que empurra elétrons para dentro ou para fora da porta flutuante, atravessando a fina camada de óxido isolante.

É exatamente essa travessia repetida de elétrons que explica as duas principais fraquezas da memória flash:

1. **Número limitado de operações de leitura e escrita.** Cada vez que elétrons atravessam a camada de óxido, ela se desgasta um pouco — de forma análoga a uma borracha que, ao apagar repetidamente, vai afinando o papel até rasgá-lo. Depois de um número finito de ciclos de escrita (da ordem de milhares a dezenas de milhares, dependendo da tecnologia), a célula perde a capacidade de reter dados de forma confiável.
2. **Necessidade de reenergização periódica.** Mesmo sem novas escritas, a carga de elétrons retida na porta flutuante vaza lentamente ao longo do tempo, de forma análoga ao esvaziamento gradual de um capacitor. Um dado gravado numa memória flash e deixado sem uso por um período muito longo pode se tornar ilegível, porque a diferença de carga que originalmente distinguia um bit 0 de um bit 1 se dissipa.

**Nota prática.** Um pendrive guardado por décadas sem ser conectado a um computador não terá seus dados automaticamente preservados — a memória flash não é permanente da mesma forma que a magnetização de um HD; ela precisa ser periodicamente reenergizada para reter seu conteúdo.

Apesar dessas fraquezas, a memória flash apresenta vantagens decisivas para determinadas aplicações: ausência de partes móveis (logo, resistência a impactos e vibração), baixo consumo energético e volume físico reduzido — características que "casam" perfeitamente com dispositivos móveis. É por isso que praticamente 100% dos smartphones usam memória flash como armazenamento primário de dados, e por isso o iPhone, lançado já com memória flash, teve sucesso onde o iPod Video (baseado em HD, lançado alguns anos antes) enfrentou problemas de confiabilidade por causa da vibração durante o uso em movimento.

**Nota prática.** Computadores modernos com memória flash soldada à placa e pouca RAM disponível (como certos notebooks lançados a partir de 2020) dependem fortemente de memória virtual (Seção 2.9), usando a própria memória flash soldada como área de swap. Como a memória flash tem um número finito de ciclos de escrita, esse uso intensivo acelera o desgaste da célula ao longo dos anos — e, como a memória é soldada (não modular), não há como substituí-la isoladamente quando ela falha. Esse é um dos fatores que explica a desvalorização acentuada desses equipamentos à medida que envelhecem.

Do ponto de vista de organização interna, múltiplas células de memória flash formam **páginas**, e múltiplas páginas formam **blocos** — a unidade típica de apagamento na memória flash. Um SSD contém, além das próprias células flash, um chip controlador e, tipicamente, uma pequena quantidade de memória DRAM interna usada como cache: blocos de dados recentemente acessados são mantidos nessa DRAM interna (mais rápida que a própria flash) seguindo o mesmo princípio da localidade discutido na Seção 2.8.

A memória flash é historicamente descendente da família de memórias **ROM** (*Read Only Memory*): a ROM original era gravada uma única vez na fábrica; a **PROM** (*Programmable ROM*) podia ser gravada uma vez fora da fábrica; a **EPROM** (*Erasable PROM*) podia ser apagada por exposição à luz ultravioleta e regravada; e a **EEPROM** (*Electrically Erasable PROM*) podia ser apagada eletricamente, sem necessidade de luz ultravioleta — sendo essa a ancestral direta da memória flash moderna. É também por descender dessa linhagem que a memória flash substituiu a ROM em aplicações como o firmware da placa-mãe (BIOS/UEFI, estudado no Capítulo 4), que hoje pode ser atualizado justamente porque está gravado numa memória flash regravável.

[IMAGEM: corte esquemático de um MOSFET de porta flutuante, com as camadas de óxido isolante destacadas]
[IMAGEM: HD aberto ao lado de um SSD aberto, evidenciando ausência de partes móveis no SSD]

## 2.13 Mídias óticas

As mídias óticas — CD, DVD e Blu-ray — armazenam dados através de uma célula de memória completamente distinta das anteriores: um ponto da superfície do disco que **reflete ou não reflete** um feixe de laser. Um traço longo ou curto gravado na superfície corresponde a um bit 1 ou 0; um laser lê essa superfície e um fototransistor detecta se houve ou não reflexão, convertendo isso de volta em dados binários.

**Nota conceitual.** Um CD não deve ser confundido com um disco de vinil, apesar da semelhança física: o disco de vinil grava a informação de forma **analógica** — o sulco físico reproduz diretamente a forma de onda sonora, amplificada mecanicamente pela agulha. O CD grava informação de forma **digital**: cada ponto da superfície representa exclusivamente um 0 ou um 1.

Assim como o HD, a mídia ótica tem **acesso sequencial**: a leitura começa por uma posição combinada entre fabricante e leitor (próxima ao centro do disco) e prossegue radialmente para fora. Isso explica, por exemplo, por que gravar apenas metade da capacidade de um CD reduz visivelmente a área gravada (mais clara) em relação à área não utilizada.

A evolução de CD para DVD e para Blu-ray consistiu em reduzir o tamanho físico de cada célula de memória, permitindo mais dados no mesmo espaço — o que exige um laser de comprimento de onda menor (medido em nanômetros) e mais preciso tanto para gravar quanto para ler. O nome *Blu-ray* vem justamente do fato de seu laser operar no espectro azul, de comprimento de onda mais curto que o laser vermelho usado em CD e DVD.

Por não estar protegida por uma carcaça lacrada como o HD, a superfície de uma mídia ótica é vulnerável a arranhões, que interferem diretamente na reflexão do laser e corrompem a leitura — o "CD riscado" clássico. Técnicas informais de reparo (como aplicar verniz ou pasta de polimento para remover uma fina camada superficial e expor uma superfície de reflexão menos danificada) funcionam apenas de forma limitada, já que removem também parte da camada onde o próprio dado está gravado.

Por fim, distingue-se o **CD-ROM** (gravado uma única vez na fábrica, sem possibilidade de regravação), o **CD-R** (gravável uma única vez pelo usuário) e o **CD-RW** (regravável), com a mesma lógica de gravação valendo para DVD e Blu-ray.

## 2.14 Nuvem, backup e estratégias de segurança de dados

O armazenamento **em nuvem** não constitui um novo tipo de célula de memória: é, na prática, um computador remoto (ou um conjunto de servidores) conectado à internet, armazenando dados nas mesmas tecnologias já estudadas neste capítulo — predominantemente HD e SSD, organizados dentro de sua própria pirâmide de hierarquia de memória, como qualquer outro computador. Provedores como Google Drive, OneDrive e Dropbox mantêm réplicas dos dados em servidores fisicamente distribuídos em diferentes localizações, o que aumenta a confiabilidade ao custo, por vezes, de menor velocidade de acesso.

Uma pergunta recorrente em sala foi: qual mídia de armazenamento secundário é a mais segura? A resposta é uma provocação: **não existe uma mídia mais segura em termos absolutos**. Cada tecnologia estudada neste capítulo tem um ponto fraco de natureza distinta:

| Mídia | Ponto fraco característico |
|---|---|
| HD (magnético) | Vulnerável a campos magnéticos fortes próximos; peças móveis se desgastam |
| SSD / pendrive (flash) | Número limitado de operações de escrita; perda de carga ao longo do tempo |
| CD/DVD/Blu-ray (ótica) | Vulnerável a arranhões na superfície de leitura |
| Nuvem | Depende de senha/acesso; exposta a questões de privacidade e disponibilidade de rede |

A segurança real de um dado não vem de escolher a "melhor" mídia, mas de criar **redundância**: manter cópias em mídias de natureza física diferente e em **localizações físicas diferentes**, já que cada tecnologia falha por um motivo diferente e um único desastre local não deve comprometer todas as cópias simultaneamente.

**Exemplo.** Um estudante de pós-graduação mantinha backups de sua dissertação de mestrado no laptop, num HD externo e num pendrive — mas todos os três dispositivos estavam guardados dentro da mesma mochila, que foi roubada. Apesar de ter três cópias redundantes em três mídias diferentes, a ausência de separação geográfica entre elas fez com que todas fossem perdidas simultaneamente, obrigando-o a refazer o trabalho do zero. O princípio de backup exige não apenas diversidade de mídia, mas também diversidade de localização.

[IMAGEM: esquema de backup redundante em três mídias e duas localizações físicas diferentes]

---

## Síntese do capítulo

Este capítulo aprofundou a hierarquia de memória introduzida no Capítulo 1, mostrando que cada nível dessa pirâmide — registradores e cache, memória RAM, e as diferentes formas de armazenamento secundário — deriva suas características de desempenho, custo e volatilidade diretamente da natureza física de sua célula de memória. Foram estudadas a evolução da memória primária (da SRAM estática à família DDR síncrona e dinâmica), os recursos que ampliam seu desempenho (cache, Dual Channel, memória virtual), e as três grandes famílias de armazenamento secundário — magnética, flash e ótica —, cada uma com vantagens e fragilidades próprias, culminando na discussão de estratégias de backup e redundância. Esses conceitos formam a base necessária para o Capítulo 3, no qual o sistema operacional passa a ser estudado em detalhe: a formatação de um disco, a criação de sistemas de arquivos e o gerenciamento de clusters e metadados — apenas introduzidos aqui na Seção 2.11 — são, na prática, a camada de software que organiza e dá sentido à memória secundária estudada neste capítulo.
