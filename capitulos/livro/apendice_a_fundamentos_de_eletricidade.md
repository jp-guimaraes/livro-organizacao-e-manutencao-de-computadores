# Apêndice A — Fundamentos de Eletricidade

Este apêndice reúne as grandezas elétricas fundamentais (tensão, corrente, resistência e potência), os princípios de proteção e aterramento de uma instalação elétrica residencial, e o funcionamento de transformadores — a base física sobre a qual se apoia o Capítulo 11, que trata da fonte de alimentação do computador propriamente dita.

---

## A.1 Grandezas elétricas fundamentais

### A.1.1 Diferença de potencial (tensão)

Toda análise elétrica de um computador começa na tomada, e toda tomada é, fisicamente, uma **diferença de potencial elétrico** (DDP). O conceito de potencial elétrico pode ser compreendido por analogia com o potencial gravitacional.

O mesmo raciocínio se aplica à eletricidade: a diferença de potencial elétrico só existe entre dois pontos. É por essa razão que toda tomada elétrica possui, no mínimo, dois furos — um representando cada um dos dois pontos entre os quais existe a diferença de potencial. A grandeza que quantifica essa diferença de potencial é chamada de **tensão** ou **voltagem**, medida em **volts** (V).

[IMAGEM: diagrama dos pontos A, B e C em mesas empilhadas, com setas indicando as diferenças de potencial gravitacional entre cada par]

Quando um caminho condutor é fornecido entre dois pontos de potenciais elétricos diferentes, os elétrons se deslocam da região de maior potencial para a de menor potencial — exatamente como o lápis cai da mesa para o chão, transformando energia potencial gravitacional em energia cinética. Esse movimento de elétrons pode ser aproveitado para realizar trabalho: aquecer uma resistência, acender um LED, ou acionar os transistores que formam os circuitos lógicos de um computador.

**Exemplo.** Um dispositivo eletrônico é projetado para operar dentro de uma faixa de tensão específica — assim como uma roda-d'água é projetada para funcionar sob uma queda d'água de determinada altura. Uma roda-d'água dimensionada para uma queda de 2 metros não resiste a uma queda de 20 metros: a estrutura se rompe porque não foi projetada para aquela energia. Da mesma forma, um equipamento projetado para operar em 110 V, ao ser ligado em 220 V, recebe o dobro da tensão para a qual foi dimensionado — o que, pela Lei de Ohm (Seção A.1.3), provoca uma corrente elétrica também maior do que a suportada pelos seus componentes, danificando-os.

### A.1.2 Corrente elétrica

**Corrente elétrica** é o fluxo ordenado de elétrons através de um condutor, medido em **ampere** (A). Historicamente, antes de se compreender que a carga móvel era o elétron (de carga negativa), adotou-se a convenção de que a corrente flui do polo positivo para o polo negativo — o chamado **sentido convencional** da corrente. O **sentido real** do movimento dos elétrons é o oposto: do polo negativo (região com excesso de elétrons) para o polo positivo (região com falta de elétrons). Essa convenção histórica permanece em uso na análise de circuitos até hoje.

### A.1.3 Lei de Ohm e resistência elétrica

A relação entre tensão, corrente e resistência é dada pela **primeira Lei de Ohm**:

$$V = R \times I$$

onde V é a tensão (volts), R é a **resistência elétrica** (ohms, Ω) e I é a corrente (amperes). A resistência mede a oposição de um material à passagem de corrente: materiais condutores (como cobre) têm resistência muito baixa; materiais isolantes (como borracha ou ar) têm resistência muito alta.

**Exemplo.** Em um circuito simples formado por uma fonte de tensão, um resistor e um LED em série, aumentar a tensão da fonte, mantendo a mesma resistência, provoca um aumento proporcional na corrente — e um LED submetido a maior corrente brilha com maior intensidade. Tensão e corrente são, nesse circuito, grandezas diretamente proporcionais: quando uma sobe, a outra sobe na mesma proporção.

Essa relação também explica por que um **curto-circuito** é perigoso. Um curto-circuito ocorre quando um caminho de resistência próxima de zero é criado entre dois pontos de potenciais diferentes — por exemplo, um pequeno objeto condutor (um clipe de papel, um grampo metálico) tocando acidentalmente os dois pinos de uma tomada. Como a corrente é inversamente proporcional à resistência, uma resistência próxima de zero produz uma corrente extremamente alta — teoricamente, o máximo que a fonte for capaz de fornecer. Esse pico de corrente é o que provoca aquecimento excessivo dos condutores, podendo causar incêndio se não houver um dispositivo de proteção interrompendo o circuito (ver Seção A.3.1).

[IMAGEM: circuito simples fonte–resistor–LED com seta indicando corrente e legenda "V = R × I"]

### A.1.4 Corrente contínua e corrente alternada

A corrente elétrica pode ser **contínua** (CC ou, do inglês, DC) ou **alternada** (CA ou AC).

Na **corrente contínua**, os elétrons se deslocam sempre no mesmo sentido, produzida por uma fonte de tensão fixa ao longo do tempo — como uma pilha, cuja diferença de potencial entre os polos permanece constante em, por exemplo, 1,5 V. Representando essa tensão em um gráfico ao longo do tempo, obtém-se uma linha reta e constante.

Na **corrente alternada**, a tensão da fonte varia periodicamente entre valores positivos e negativos, seguindo um comportamento **senoidal**: a tensão sobe até um valor máximo, desce até um valor mínimo (negativo) e repete esse ciclo indefinidamente. Como consequência, os elétrons não se deslocam sempre no mesmo sentido — eles oscilam, ora em uma direção, ora na direção oposta, tantas vezes por segundo quanto for a **frequência** da onda. A tomada residencial no Rio Grande do Norte fornece uma tensão alternada de 220 V (valor eficaz, ou RMS) a 60 Hz `[1]` — ou seja, o ciclo de oscilação se repete 60 vezes por segundo.

**Exemplo.** O funcionamento de um chuveiro elétrico não depende do sentido em que os elétrons se movem: o simples ir e vir do elétron, induzido pela tensão alternada, já é suficiente para aquecer a resistência do chuveiro e, consequentemente, a água. O trabalho realizado (aquecimento) não exige que a corrente seja contínua.

A razão pela qual a energia elétrica é gerada, transportada e distribuída na forma alternada — e não contínua — está diretamente ligada à minimização de perdas no transporte, tratada em detalhe na Seção A.2.

---

## A.2 Potência elétrica e efeito Joule

**Potência elétrica** é a capacidade de um dispositivo realizar trabalho por unidade de tempo, medida em **watts** (W). É calculada como o produto entre tensão e corrente:

$$P = V \times I$$

Combinando essa equação com a Lei de Ohm ($V = R \times I$), obtém-se uma segunda forma equivalente:

$$P = R \times I^2$$

Essa segunda forma é especialmente importante porque descreve a **potência dissipada por efeito Joule** — o calor gerado pela passagem de corrente através de um condutor com resistência. Quanto maior a corrente que passa por um condutor, maior é a potência perdida em forma de calor, e essa perda cresce com o **quadrado** da corrente.

**Exemplo.** Um chuveiro elétrico ligado em 220 V, puxando uma corrente da ordem de 5 A, tem potência de $220 \times 5 = 1100$ W. Um carregador de celular, ligado na mesma tomada de 220 V mas puxando apenas cerca de 0,01 A, tem potência de $220 \times 0{,}01 = 2{,}2$ W. Ambos os dispositivos estão sujeitos à mesma tensão da tomada; o que os diferencia é a corrente que cada um demanda — e essa diferença de corrente é o que torna o chuveiro elétrico centenas de vezes mais potente que o carregador.

### Por que a energia é transportada em alta tensão

A rede elétrica gera energia em uma determinada tensão e, antes de transportá-la por longas distâncias até os centros consumidores, eleva essa tensão para valores muito mais altos (por meio de transformadores, tratados na Seção A.5), reduzindo-a de volta a 220 V apenas próximo ao ponto de consumo. Essa escolha de projeto decorre diretamente da equação $P = R \times I^2$: para transportar uma mesma potência, é possível usar uma tensão alta com corrente baixa, ou uma tensão baixa com corrente alta. Como a perda por efeito Joule cresce com o quadrado da corrente, transportar a energia com uma corrente menor (elevando a tensão) reduz drasticamente as perdas ao longo dos cabos de transmissão — o que explica também o zumbido característico dos transformadores de poste, resultado da conversão eletromagnética de tensão em andamento.

[IMAGEM: diagrama simplificado da rede elétrica — geração, elevação de tensão para transporte, redução de tensão em subestações e no poste, chegada em 220 V à residência]

---

## A.3 Proteção da instalação elétrica

**Normas aplicáveis.** O conteúdo desta seção e da Seção A.4 (disjuntores, dimensionamento de condutores, aterramento) segue as prescrições das normas técnicas brasileiras de instalações elétricas de baixa tensão e de segurança em instalações elétricas `[2]`.

### A.3.1 Disjuntores

Um **disjuntor** é um dispositivo eletromecânico que interrompe automaticamente a passagem de corrente elétrica quando ela ultrapassa um determinado limite. Seu funcionamento se baseia no fato de que toda corrente elétrica alternada produz um campo magnético proporcional à sua intensidade: dentro do disjuntor existe um sensor sensível a esse campo magnético; quando a corrente excede o limite para o qual o disjuntor foi dimensionado (por exemplo, 10 A), o campo magnético resultante aciona um mecanismo de mola que desarma o disjuntor, desconectando mecanicamente o circuito — produzindo o característico estalo audível.

Uma instalação elétrica é organizada hierarquicamente: da rede pública, a energia chega a um **quadro geral**, de onde é distribuída para um ou mais **quadros de distribuição**, cada um atendendo a um setor específico da edificação (um andar, uma sala). Cada circuito de um quadro de distribuição — iluminação, tomadas, ar-condicionado — é protegido por seu próprio disjuntor, de forma que uma falha em um circuito não derrube os demais. Esse isolamento por circuito é análogo ao encapsulamento em programação orientada a objetos: cada objeto (aqui, cada sala ou circuito) mantém seus próprios atributos e falhas isoladas do restante do sistema.

A instalação pode ser **monofásica** (uma única fase de 220 V mais um neutro de referência) ou **trifásica** (três fases de 220 V, cada uma referenciada ao mesmo neutro, usadas para distribuir cargas maiores entre três circuitos independentes).

[IMAGEM: hierarquia poste → quadro geral → quadros de distribuição → disjuntores individuais por circuito]

### A.3.2 Dimensionamento de condutores

Cada condutor (fio) elétrico suporta uma corrente máxima, determinada pela sua **bitola** (área de seção transversal). Quanto maior a bitola do fio, maior a corrente que ele pode conduzir sem aquecer excessivamente.

O disjuntor de um circuito deve ser dimensionado de acordo com a capacidade do fio que ele protege: se um fio suporta no máximo 10 A, o disjuntor daquele circuito deve desarmar antes que essa corrente seja ultrapassada. Uma causa comum de disjuntores desarmando repetidamente é a **sobrecarga**: ligar, em um mesmo circuito, equipamentos cuja soma de potências excede a capacidade projetada para aquele fio e aquele disjuntor — por exemplo, uma impressora de alto consumo e uma pistola de cola quente compartilhando a mesma tomada. Quando essa sobrecarga não é interrompida por um disjuntor subdimensionado (ou por um disjuntor trocado por um de corrente nominal mais alta sem trocar o fio correspondente), o próprio condutor pode superaquecer e provocar um curto-circuito ou incêndio.

---

## A.4 Aterramento e segurança elétrica

### A.4.1 O planeta Terra como referência de potencial

O terceiro pino presente na maioria das tomadas modernas corresponde ao **aterramento** (terra). O planeta Terra, por sua imensa massa e extensão, funciona como uma fonte praticamente infinita de cargas elétricas: ele pode absorver um excesso de cargas de qualquer ponto conectado a ele, ou fornecer cargas a um ponto que esteja com déficit, sempre tendendo ao equilíbrio elétrico.

O **ar** é naturalmente isolante — seus átomos mantêm os elétrons presos com energia suficiente para impedir a condução em condições normais — o que explica por que é seguro aproximar a mão de um fio energizado sem tocá-lo diretamente. Quando, porém, a diferença de potencial entre dois pontos se torna extrema (como entre uma nuvem carregada e o solo), a rigidez elétrica do ar é rompida, e ele passa a conduzir: esse fenômeno é o **raio**. O trajeto irregular de um raio decorre do fato de que a descarga segue o caminho de menor resistência entre as moléculas de ar naquele instante. Estruturas pontiagudas, como para-raios, favorecem a descarga por um efeito conhecido como **poder das pontas**: a geometria fina concentra o campo elétrico, oferecendo um caminho de menor resistência para a corrente até o fio terra.

[IMAGEM: ilustração do trajeto irregular de um raio e de um para-raios conduzindo a descarga até o fio terra]

**Exemplo.** Um carregador ou notebook com gabinete metálico, ligado a um cabo de alimentação de apenas dois pinos (sem aterramento), pode transmitir ao usuário uma leve sensação de formigamento ao ser tocado enquanto carrega. Essa sensação ocorre porque um pequeno vazamento de corrente se acumula no chassi metálico e, na ausência de um caminho de aterramento de baixa resistência, o próprio corpo do usuário se torna o caminho disponível para o escoamento dessas cargas até a terra.

### A.4.2 Instalação de aterramento e o papel da concessionária

Em uma instalação elétrica residencial, os condutores de **fase** e **neutro** são fornecidos pela concessionária de energia (no Rio Grande do Norte, a Cosern): problemas nesses dois condutores são de responsabilidade dela. O condutor de **terra**, por outro lado, é de responsabilidade da instalação elétrica local — tipicamente executado com hastes metálicas cravadas no solo, muitas vezes aproveitando o próprio ferro da fundação da edificação, conectadas por fio a uma resistência de aterramento baixa o suficiente para escoar cargas com eficiência.

Como a tomada é uma diferença de potencial alternada, não existe, tecnicamente, um lado "certo" e um lado "errado" entre fase e neutro do ponto de vista da física básica — mas, na prática, muitos equipamentos e normas de instalação definem um lado correto para cada função, e essa correspondência deve ser verificada com instrumentos apropriados, nunca presumida.

**Atenção.** Um erro de instalação — por exemplo, o condutor de fase sendo conectado, por engano, ao ponto que deveria ser o terra — pode fazer com que toda a fiação de aterramento de uma edificação fique energizada em 220 V. Nessa condição, qualquer equipamento aterrado (como uma geladeira) torna-se, ele próprio, uma fonte de choque ao ser tocado. Por essa razão, um técnico nunca deve presumir que uma instalação elétrica está correta: a tomada deve ser testada com um multímetro antes de qualquer intervenção, identificando corretamente fase, neutro e terra.

### A.4.3 Choque elétrico e o chuveiro elétrico

O choque elétrico é perigoso porque a corrente elétrica que atravessa o corpo humano pode interferir nos impulsos nervosos que controlam a musculatura — inclusive o músculo cardíaco. Uma corrente elétrica no momento errado pode desorganizar o ritmo cardíaco, causando uma disfunção potencialmente fatal.

**Atenção.** Antes de qualquer manuseio de fiação elétrica, energia deve ser desligada na fonte (disjuntor) e, sempre que possível, confirmada como desligada com um instrumento de medição. Nunca se deve presumir que um circuito está desenergizado apenas porque um interruptor foi acionado.

O **chuveiro elétrico** — uma invenção brasileira `[3]` — costuma causar estranhamento em visitantes de países onde o aquecimento de água é feito por gás ou por reservatórios térmicos (*boilers*), a ponto de gerar receio em relação ao seu uso. Esse receio é, tecnicamente, infundado: o chuveiro elétrico não estabelece contato elétrico com a água. A corrente elétrica atravessa apenas a resistência interna do aparelho, que se aquece por efeito Joule; a água, ao passar por essa resistência já aquecida, absorve o calor por condução térmica, sem que corrente elétrica normalmente flua através dela. Um choque em um chuveiro elétrico só ocorre diante de uma falha grave de isolamento ou de instalação — não é uma característica intrínseca do funcionamento do equipamento.

---

## A.5 Transformadores e transporte de energia

Um **transformador** é o dispositivo responsável por elevar ou reduzir uma tensão alternada, sendo o elemento central tanto no transporte de energia em alta tensão (Seção A.2) quanto no primeiro estágio de uma fonte de alimentação linear (Seção A.6).

Seu princípio de funcionamento se baseia na **Lei de Faraday**: uma corrente elétrica variável produz um campo magnético; um campo magnético variável, por sua vez, induz uma corrente elétrica em um condutor próximo. Um transformador é fisicamente constituído por dois enrolamentos de fio (bobinas) — o primário e o secundário — em torno de um núcleo ferromagnético comum, sem contato elétrico direto entre eles. A corrente alternada que circula pela bobina primária gera um campo magnético variável no núcleo, que induz uma corrente na bobina secundária.

A relação entre a tensão de entrada e a tensão de saída é determinada pela razão entre o **número de espiras** (voltas do fio) em cada bobina: se o secundário possui mais espiras do que o primário, a tensão é elevada e a corrente correspondentemente reduzida (para conservar a potência); se possui menos espiras, a tensão é reduzida e a corrente aumentada.

Como a energia não se perde nessa conversão (idealmente), o produto tensão × corrente se mantém aproximadamente constante entre primário e secundário: elevar a tensão implica reduzir a corrente na mesma proporção, e vice-versa. É exatamente essa propriedade que permite elevar a tensão da rede elétrica para transporte de longa distância (reduzindo a corrente e, com ela, as perdas por efeito Joule) e depois reduzi-la de volta a 220 V para uso residencial — passando antes por transformadores de subestação e, por fim, pelos transformadores de poste que abaixam a tensão para o nível final entregue às residências.

Como o funcionamento do transformador depende de variação de campo magnético, ele **exige corrente alternada** para operar: não é possível usar um transformador diretamente sobre uma tensão contínua constante, pois esta não gera a variação de campo magnético necessária à indução.

[IMAGEM: diagrama de um transformador com bobina primária e secundária em torno de um núcleo ferromagnético, indicando número de espiras e tensões de entrada/saída]

---

## A.6 Da corrente alternada à contínua: fontes lineares

Todos os componentes internos de um computador — processador, memória, circuitos lógicos — operam com **corrente contínua**. A função central de qualquer fonte de alimentação é, portanto, converter a corrente alternada da tomada em corrente contínua nos níveis de tensão exigidos por cada componente.

O modelo mais simples de conversão é a **fonte linear**, construída por meio de quatro estágios em sequência:

1. **Transformador** — reduz a tensão alternada de entrada (por exemplo, 220 V) para uma tensão alternada de menor amplitude (por exemplo, 10 V), conforme descrito na Seção A.5.
2. **Retificador** (ponte de diodos) — inverte a parcela negativa da onda alternada para o lado positivo, já que um diodo permite a passagem de corrente em apenas um sentido. Um único diodo eliminaria completamente a metade negativa da onda; uma ponte de diodos "rebate" essa metade negativa para cima, produzindo uma onda inteiramente positiva, ainda que pulsante.
3. **Filtro capacitivo** — um capacitor de grande capacitância, ligado em paralelo com a carga, suaviza as oscilações (o chamado *ripple*) da onda retificada, aproximando-a de uma tensão contínua estável.
4. **Regulador de tensão** — ajusta e estabiliza a tensão final na saída.

Fontes lineares são robustas e relativamente simples de projetar, mas apresentam uma desvantagem física significativa: para uma mesma potência, seus componentes (especialmente o transformador) são consideravelmente maiores e mais pesados do que os de uma fonte chaveada equivalente. Por essa razão, fontes lineares praticamente não são mais utilizadas em computadores modernos, restringindo-se a aplicações específicas, como equipamentos de áudio de alta fidelidade, em que a característica do circuito linear é tecnicamente desejável.

[IMAGEM: diagrama de blocos de uma fonte linear — transformador → ponte de diodos → filtro capacitivo → regulador — com a forma de onda em cada estágio]

---

## Síntese do apêndice

Este apêndice apresentou as grandezas elétricas fundamentais — tensão, corrente, resistência e potência —, os princípios de proteção por disjuntores e dimensionamento de condutores, o aterramento e a segurança contra choque elétrico, e o funcionamento de transformadores e circuitos retificadores até a fonte linear. Esses fundamentos sustentam diretamente o Capítulo 11, que trata da fonte chaveada moderna — a fonte ATX — e de sua arquitetura, seus sinais de controle e sua metodologia de dimensionamento e diagnóstico.

---

## Referências

1. NEOENERGIA COSERN. "Normas Técnicas — Padrão de Entrada de Energia." Disponível em: <https://www.neoenergia.com/web/rn/normas-tecnicas>.
2. ASSOCIAÇÃO BRASILEIRA DE NORMAS TÉCNICAS. *NBR 5410: Instalações elétricas de baixa tensão*. ABNT. (Edição a confirmar pelo autor.) BRASIL. Ministério do Trabalho e Emprego. *NR-10: Segurança em Instalações e Serviços em Eletricidade*. (Edição a confirmar pelo autor.)
3. Engenharia 360. "O inventor brasileiro do chuveiro elétrico." Disponível em: <https://engenharia360.com/o-inventor-brasileiro-do-chuveiro-eletrico/>; WIKIPÉDIA. "Chuveiro elétrico." Disponível em: <https://pt.wikipedia.org/wiki/Chuveiro_el%C3%A9trico>.
