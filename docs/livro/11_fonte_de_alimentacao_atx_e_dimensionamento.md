# Capítulo 11 — Fonte de Alimentação: ATX e Dimensionamento

Neste capítulo você vai estudar a diferença entre fontes lineares e fontes chaveadas, a arquitetura da fonte ATX e seus sinais de controle, os critérios de eficiência energética e fator de potência usados para classificar fontes comercialmente, e a metodologia de dimensionamento e diagnóstico de uma fonte de computador. As grandezas elétricas fundamentais e os princípios de aterramento sobre os quais este capítulo se apoia estão reunidos no Apêndice A.

---

## 11.1 Fontes chaveadas e modulação por largura de pulso (PWM)

A imensa maioria das fontes de alimentação usadas em computadores atuais — de smartphones a servidores — são **fontes chaveadas**. Em vez de reduzir a tensão de forma linear e contínua, esse tipo de fonte liga e desliga um circuito em altíssima frequência, controlando a fração do tempo em que o circuito permanece ligado. Essa técnica é chamada de **PWM** (*Pulse Width Modulation*, ou modulação por largura de pulso).

O princípio do PWM é simples: uma onda de tensão fixa (por exemplo, 10 V de amplitude) é ligada e desligada periodicamente. Se essa onda permanece "ligada" durante 50% de cada período, uma carga conectada a esse circuito "enxerga" uma tensão efetiva de 5 V — a metade da amplitude máxima. Se a onda permanece ligada apenas 23% do tempo, a carga enxerga aproximadamente 2,3 V.

**Exemplo.** Para gerar uma saída de 2,3 V a partir de uma onda de amplitude máxima de 10 V, basta manter o sinal em nível alto durante 23% de cada período (*duty cycle* de 23%) e em nível baixo nos 77% restantes. Circuitos com comportamento predominantemente passivo — como motores e LEDs — respondem a essa alternância rápida como se a tensão fosse, de fato, constante e igual à fração correspondente da amplitude máxima.

A vantagem central do chaveamento sobre outras formas de redução de tensão (como um simples divisor resistivo) é a **eficiência**: um divisor de tensão dissipa parte da energia em forma de calor através dos resistores, enquanto o chaveamento — ligando e desligando o circuito, em vez de dissipar energia continuamente — perde muito menos energia nessa conversão. É por isso que as fontes de computador atuais são chamadas de **fontes chaveadas**: internamente, elas empregam circuitos de chaveamento em alta frequência (controlados por PWM) para produzir as diversas tensões contínuas exigidas pelos componentes, de forma muito mais compacta e eficiente do que uma fonte linear equivalente (Apêndice A, §A.6).


!!! warning "Figura pendente"
    forma de onda PWM com diferentes duty cycles (10%, 50%, 90%) e a tensão média efetiva resultante em cada caso


---

## 11.2 A fonte ATX

### 11.2.1 Padrão ATX e o conector principal

A **fonte ATX** é o padrão universal de fonte de alimentação para computadores desktop. Diferentemente de fontes com uma chave seletora de tensão (110 V/220 V) — cuja posição incorreta pode queimar o equipamento se ligado na tensão errada —, boa parte das fontes modernas de melhor qualidade é do tipo **full range** (ou *auto switch*): elas aceitam qualquer tensão alternada de entrada dentro de uma faixa ampla, tipicamente de 100 V a 240 V, ajustando-se automaticamente sem necessidade de seleção manual.

**Atenção.** Em fontes com chave seletora de tensão, a posição da chave deve sempre ser conferida antes de conectar o equipamento à tomada. Ligar uma fonte selecionada para 115 V em uma tomada de 220 V resulta, tipicamente, em dano imediato e irreversível ao equipamento — o mesmo princípio descrito no Apêndice A, §A.1.1.

A fonte ATX se conecta à placa-mãe por meio de um conector principal de **20 ou 24 pinos** `[1]` (dependendo do modelo da placa-mãe), fornecendo simultaneamente diversas tensões contínuas distintas, identificadas por um padrão de cores nos fios `[2]`:

| Cor do fio | Tensão / sinal | Função |
|---|---|---|
| Laranja | +3,3 V | Alimentação de baixa tensão (memórias, lógica moderna) |
| Vermelho | +5 V | Alimentação de componentes diversos |
| Amarelo | +12 V | Alimentação de motores (ventoinhas, discos) e do processador |
| Roxo | +5 V (auxiliar/*standby*) | Alimentação permanente, mesmo com o computador desligado |
| Preto | COM (referência/terra) | Referência de potencial (0 V) para todas as demais tensões |
| Verde | PS_ON (*Power Supply On*) | Sinal de comando da placa-mãe para a fonte |
| Cinza | Power OK | Sinal de confirmação da fonte para a placa-mãe |

Além dos fios listados, a fonte também disponibiliza tensões negativas (-12 V e -5 V) para funções específicas de compatibilidade histórica. Um segundo conector, tipicamente de 4 ou 8 pinos, fornece alimentação dedicada ao processador — algumas placas-mãe mais recentes exigem inclusive **dois** conectores de 8 pinos para essa finalidade, tornando necessário verificar a compatibilidade entre placa-mãe e fonte antes da montagem.

O padrão ATX substituiu o padrão anterior, chamado **AT**, cuja principal limitação era a ausência de comunicação eletrônica entre a placa-mãe e a fonte para o desligamento: em computadores com fonte AT, o comando de desligar (pelo sistema operacional) apenas exibia uma mensagem informando que o computador já podia ser desligado com segurança, mas o desligamento físico ainda dependia de o usuário acionar uma chave mecânica. O padrão ATX introduziu o desligamento controlado por software, que se tornou padrão em todos os computadores modernos `[3]`.


!!! warning "Figura pendente"
    conector ATX de 24 pinos com o código de cores dos fios sobreposto


### 11.2.2 Sinais de controle: PS_ON e Power OK

O procedimento de inicialização de um desktop ilustra como a fonte, o botão de energia e a placa-mãe se comunicam eletricamente.

O botão de *power* do painel frontal do gabinete é, fisicamente, apenas um par de fios que, quando o botão é pressionado, se conectam momentaneamente — fechando um pequeno curto-circuito entre dois pinos específicos no conector do painel frontal da placa-mãe. Esse contato momentâneo é interpretado por um circuito da placa-mãe como um comando de ligar.

Ao reconhecer esse comando, a placa-mãe sinaliza à fonte que deve energizar seus circuitos de saída, unindo eletricamente o pino verde (**PS_ON**) ao pino preto (**COM**) — ou seja, colocando o pino de comando no mesmo nível de potencial que a referência de terra. Quando a fonte detecta essa condição, ela liga seus circuitos internos e passa a fornecer as tensões de saída (3,3 V, 5 V, 12 V etc.).

Esse acionamento não é instantâneo: existe um pequeno intervalo de tempo entre o comando de ligar e o momento em que todas as tensões de saída atingem seus valores nominais e estáveis. Ao final desse intervalo, a fonte sinaliza à placa-mãe, através do pino **Power OK**, que as tensões estão estabilizadas e prontas para uso. Somente após receber esse sinal a placa-mãe libera a energização dos demais componentes e inicia o procedimento de *boot*, chamando o primeiro programa executado pela placa-mãe — o POST.

**Exemplo (metodologia de diagnóstico).** Esse mecanismo fornece um procedimento sistemático para isolar problemas de energização em um computador que não liga:

1. Testar o botão físico do painel frontal, substituindo-o por um curto manual (por exemplo, com uma chave de fenda) diretamente nos pinos correspondentes da placa-mãe. Se o computador ligar dessa forma, o problema estava no botão ou em sua fiação — não na fonte nem na placa-mãe.
2. Se o curto manual no botão não resolver, desconectar a fonte da placa-mãe e testar a fonte isoladamente, unindo o pino verde (PS_ON) a qualquer pino preto (COM) no próprio conector da fonte. Se a fonte ligar (ventoinha gira, LEDs acendem), o problema está na placa-mãe. Se a fonte não ligar, o problema está na fonte.

Esse procedimento exemplifica, no contexto elétrico, a metodologia geral de diagnóstico por isolamento de módulos já apresentada no Capítulo 12 (§12.4): identificar o submódulo defeituoso testando cada elo da cadeia (botão → placa-mãe → fonte) separadamente.

**Atenção.** A fonte ligar durante esse teste — girando a ventoinha e produzindo as tensões nominais — indica apenas que ela consegue entregar tensão. Não garante que ela consegue entregar a **potência** total sob carga real: uma fonte deteriorada pode fornecer tensões corretas em vazio e ainda assim falhar ao alimentar componentes de alto consumo, como uma placa de vídeo. O teste do jumper é uma condição necessária, mas não suficiente, para validar uma fonte.


!!! warning "Figura pendente"
    fluxo botão → pinos do painel frontal → sinal PS_ON → fonte → sinal Power OK → placa-mãe, com indicação dos pontos de teste para diagnóstico


### 11.2.3 VRM: uma segunda fonte na placa-mãe

As tensões fornecidas pela fonte ATX (3,3 V, 5 V, 12 V) não correspondem, na maioria dos casos, às tensões efetivamente exigidas pelo processador e por outros componentes modernos, que frequentemente operam em tensões muito mais baixas e específicas. Por esse motivo, a própria placa-mãe contém uma "segunda fonte" interna: o **VRM** (*Voltage Regulator Module*), responsável por converter as tensões recebidas da fonte ATX nas tensões finais exigidas por cada componente. De forma equivalente, alguns processadores contam com um módulo de conversão próprio, às vezes chamado de PPM (*Processor Power Module*) `[4]`.

A razão histórica para manter essa conversão adicional na placa-mãe — e não na fonte — é a compatibilidade: o padrão de saída da fonte ATX permaneceu estável ao longo de gerações de processadores e memórias, permitindo que um usuário reaproveite a mesma fonte em upgrades de placa-mãe, processador ou memória, desde que as novas exigências específicas de tensão sejam resolvidas pela conversão adicional na própria placa-mãe.

---

## 11.3 Eficiência energética e fator de potência

### 11.3.1 Selos de eficiência (80 Plus e ETA-Lambda)

Toda conversão de energia envolve perdas: parte da energia retirada da tomada é dissipada em forma de calor durante as sucessivas transformações (AC–AC, AC–DC, DC–DC) realizadas dentro da fonte. A **eficiência** de uma fonte é definida como a razão entre a potência efetivamente entregue aos componentes do computador e a potência total consumida na tomada.

Órgãos de certificação independentes, como o **80 Plus**, realizam ensaios de bancada e atribuem selos de eficiência às fontes comerciais. Mais recentemente, a Cybenetics Labs passou a manter dois programas de certificação distintos: **ETA** (eficiência energética) e **LAMBDA** (ruído acústico produzido pela fonte sob diferentes cargas) — são dois selos separados, avaliados independentemente; uma fonte pode ter um sem o outro `[5]`. Esses ensaios avaliam a eficiência em três níveis de carga, expressos como percentual da potência nominal da fonte:

- **Carga leve** — cerca de 20% da potência nominal.
- **Carga típica** — cerca de 50% da potência nominal.
- **Carga máxima** — 100% da potência nominal.

O selo 80 Plus é concedido em diferentes categorias (Standard, Bronze, Silver, Gold, Platinum, Titanium, em ordem crescente de exigência), cada uma exigindo um patamar mínimo de eficiência nas três cargas. Por exemplo, o selo **Standard** exige 80% de eficiência nas três cargas (80/80/80); o selo **Platinum** exige patamares mais altos, como 90% em carga leve, 92% em carga típica e 89% em carga máxima `[6]`.

**Exemplo.** Uma fonte é tipicamente projetada para atingir sua eficiência máxima justamente na região de carga típica (em torno de 50% da potência nominal) — motivo pelo qual o dimensionamento recomendado de uma fonte para um computador (Seção 11.4) busca deixar o consumo real do sistema próximo dessa faixa.

Um fator adicional observado experimentalmente é que uma fonte tende a ser mais eficiente quando alimentada em 220 V do que em 110 V, para a mesma carga `[7]` — consequência direta do mesmo princípio de efeito Joule discutido no Apêndice A, §A.2: em uma tensão de entrada mais alta, a corrente de entrada correspondente é menor, reduzindo as perdas internas.

Selos de eficiência não devem ser confundidos com selos de potência: uma fonte de "650 W" descreve a potência que ela é capaz de fornecer, e sua eficiência (Standard, Bronze, Gold etc.) descreve a proporção dessa energia que é efetivamente aproveitada, e não perdida em calor, na conversão a partir da tomada.

### 11.3.2 Fator de potência e PFC

O **fator de potência** é uma segunda métrica de qualidade de uma fonte, distinta da eficiência. É definido como a razão entre a **potência ativa** (a potência que efetivamente realiza trabalho) e a **potência aparente** (a potência total que o circuito precisa "reservar" para operar, incluindo a energia armazenada temporariamente em componentes reativos, como capacitores e indutores, sem realizar trabalho útil):

$$\text{Fator de potência} = \frac{P_{\text{ativa}}}{S_{\text{aparente}}}$$

Fontes com correção de fator de potência (**PFC**, *Power Factor Correction*) empregam circuitos adicionais — passivos (bancos de capacitores e indutores) ou ativos (circuitos eletrônicos dedicados) — para reduzir essa parcela reativa e aproximar a potência aparente da potência ativa. No Brasil, consumidores residenciais não são cobrados por energia reativa (essa cobrança se aplica a consumidores do Grupo A — média/alta tensão, o que inclui grandes consumidores industriais e comerciais, não apenas industriais) `[8]`, de forma que a presença de PFC em uma fonte doméstica não reduz a conta de energia do usuário — mas é, ainda assim, um indicador de qualidade construtiva do circuito.

**Atenção.** O fator de potência e a eficiência de uma fonte são métricas independentes: uma fonte com PFC ativo não é, por esse motivo isolado, necessariamente mais eficiente — a eficiência é determinada pelo ensaio de conversão de energia (Seção 11.3.1), e não pelo fator de potência.

---

## 11.4 Dimensionamento e diagnóstico de fontes

### 11.4.1 Trilhos de potência (rails)

Ao especificar uma fonte, o fabricante não apenas informa a potência total nominal (por exemplo, 650 W), mas também detalha, em uma tabela de especificações, a corrente máxima que cada **trilho de tensão** (*rail*) — 3,3 V, 5 V, 12 V, além dos trilhos negativos e auxiliares — é capaz de fornecer individualmente.

**Exemplo.** Considere uma fonte nominal de 650 W com a seguinte especificação de trilhos:

| Trilho | Tensão | Corrente máxima | Potência do trilho |
|---|---|---|---|
| A | 3,3 V | 25 A | 82,5 W |
| B | 5 V | 25 A | 125 W |
| A + B (combinados) | — | — | 150 W (máximo compartilhado) |
| C | 12 V | 52 A | 624 W |
| D | 12 V (auxiliar) | 0,5 A | 6 W |
| E | 5 V (auxiliar) | 2,5 A | 12,5 W |

Somando a potência máxima teórica de todos os trilhos individualmente ($150 + 624 + 6 + 12{,}5 = 792{,}5$ W), o resultado ultrapassa os 650 W nominais da fonte. Isso não significa que o fabricante esteja anunciando uma especificação incorreta: significa que os 650 W nominais são **compartilhados** entre os trilhos, e que não é possível extrair a corrente máxima de todos os trilhos simultaneamente. Na prática, o trilho de 12 V (tipicamente o que alimenta processador e placa de vídeo, os dois maiores consumidores de um desktop) concentra a maior reserva de potência da fonte, e os demais trilhos (3,3 V e 5 V, tipicamente usados por memória, armazenamento e portas USB) compartilham uma parcela menor do total.


!!! warning "Figura pendente"
    tabela de trilhos de uma fonte real com tensões e correntes máximas por rail


### 11.4.2 Metodologia de dimensionamento

Ao dimensionar uma fonte para um computador desktop, os dois maiores consumidores de energia — e, portanto, os fatores decisivos no dimensionamento — são o **processador** e a **placa de vídeo**: uma GPU de alto desempenho pode consumir, sozinha, uma potência muito superior à soma de todos os demais componentes do sistema. Componentes adicionais (memórias, unidades de armazenamento, ventoinhas) contribuem com potências individuais menores, mas devem ser somados quando existem em grande quantidade — como em servidores com múltiplos discos.

Fabricantes de fontes disponibilizam calculadoras de dimensionamento *on-line* que, a partir da lista de componentes do sistema (processador, GPU, memória, armazenamento, ventoinhas), estimam o consumo total e recomendam uma potência de fonte adequada. Essas calculadoras tipicamente recomendam uma margem confortável acima do consumo estimado do sistema — não porque o sistema vá efetivamente consumir aquele valor, mas para que o consumo real do sistema recaia na faixa de carga típica (em torno de 50% da potência nominal), onde a fonte opera com eficiência máxima (Seção 11.3.1).

**Atenção.** Capacitores de grande capacitância no interior de uma fonte podem reter carga elétrica significativa por dias mesmo após o equipamento ser desconectado da tomada. Uma fonte nunca deve ser aberta sem os devidos cuidados de segurança, e o escopo deste curso não inclui a manutenção interna do circuito da fonte (troca de capacitores, indutores ou outros componentes) — apenas o diagnóstico que permite decidir pela substituição do módulo completo.

### 11.4.3 Roteiro prático de diagnóstico

Somando os conceitos apresentados neste capítulo, o diagnóstico de um computador que apresenta suspeita de falha na fonte segue, tipicamente, esta sequência:

1. **Inspeção visual** — verificar conexões soltas, a posição correta da chave seletora de tensão (em fontes não *full range*) e sinais evidentes de dano (capacitores estufados, vazamentos, queimaduras).
2. **Isolamento do ambiente de teste** — testar o computador com um monitor e uma tomada sabidamente funcionais, para que qualquer falha observada seja atribuída ao computador, e não ao ambiente de teste.
3. **Observação dos indicadores de energização** — ao ligar o computador, observar se a ventoinha da fonte gira, se a ventoinha do processador gira e se LEDs de atividade acendem.
4. **Verificação do POST** — a ausência do bipe característico do POST pode indicar um problema anterior ao teste do BIOS (fonte, botão, conexão) ou, simplesmente, um *speaker* (alto-falante interno de aviso) desconectado ou invertido em polaridade — o *speaker* é um componente polarizado (positivo e negativo) e deve ser conectado na orientação correta indicada na placa-mãe.
5. **Teste isolado da fonte**, conforme descrito na Seção 11.2.2, unindo o pino PS_ON (verde) a um pino COM (preto) diretamente no conector da fonte.
6. **Manutenção preventiva de contatos** — mau contato nos módulos de memória RAM é uma causa frequente de falha intermitente no POST (por exemplo, o computador não bipar em uma tentativa e bipar normalmente na tentativa seguinte). O procedimento de limpeza consiste em remover os módulos de memória, aplicar um produto de limpeza de contatos eletrônicos (álcool isopropílico ou produto similar, altamente volátil) sobre os pontos de contato dourados, aguardar a evaporação completa e reinserir o módulo, certificando-se de que o encaixe nas travas do slot esteja completo (indicado por um clique audível em ambos os lados do slot).

Esse roteiro exemplifica, de forma concreta, a metodologia de manutenção corretiva por formulação e teste de hipóteses apresentada no Capítulo 12 (§12.4): cada etapa isola uma parte do sistema, permitindo concluir, por eliminação, em qual submódulo está o problema.

---

## 11.5 Integração da placa-mãe: chipset, painel frontal e aterramento do gabinete

Como visto nas seções anteriores, a fonte se conecta à placa-mãe em dois pontos (o conector principal e o conector de alimentação do processador). A placa-mãe, por sua vez, é responsável por distribuir essa energia — e por integrar todos os demais componentes do computador — através de um conjunto de circuitos controladores conhecido como **chipset**.

O chipset é, como o nome sugere, um *conjunto de chips* que provê as funcionalidades de interconexão da placa-mãe: controladores de portas USB, de rede Ethernet, de Wi-Fi (quando presente), de linhas de memória, entre outros. Um mesmo chipset (identificado por um código de modelo, como "B860") pode ser implementado por diferentes fabricantes de placa-mãe, cada um oferecendo uma organização física e um conjunto de recursos adicionais diferentes — explicando por que placas-mãe de fabricantes distintos, baseadas no mesmo chipset, podem ter preços significativamente diferentes: a diferença normalmente está em funcionalidades extras (como Wi-Fi integrado) e não necessariamente em qualidade superior de um fabricante sobre o outro.

**Manual da placa-mãe.** O manual técnico fornecido pelo fabricante de cada placa-mãe é a fonte de referência definitiva para identificar a pinagem de conectores, os requisitos de alimentação do processador (por exemplo, se são necessários um ou dois conectores de 8 pinos) e os procedimentos específicos daquele modelo, como o Clear CMOS (Capítulo 8, §8.7.3). Um técnico deve sempre consultar o manual de cada placa-mãe individualmente, em vez de presumir que todos os modelos seguem exatamente o mesmo layout de pinos.

### 11.5.1 Painel frontal

O conector de **painel frontal** (*front panel* ou *system panel header*) da placa-mãe recebe os fios provenientes do gabinete: o botão de energia, o botão de reinicialização (*reset*), o LED de energia e o LED de atividade do disco. Como o gabinete e a placa-mãe são fabricados por empresas diferentes, a correspondência exata de pinos varia de modelo para modelo e deve ser conferida no manual da placa-mãe.

Uma distinção importante deve ser observada nesses conectores: **botões** (power e reset) não possuem polaridade — o fio pode ser conectado em qualquer uma das duas orientações possíveis, sem alterar o funcionamento. **LEDs**, por serem diodos emissores de luz, possuem polaridade definida (um terminal positivo e um negativo): conectados na orientação invertida, simplesmente não acendem, sem dano ao componente.

### 11.5.2 Aterramento do gabinete

O chassi metálico do gabinete deve manter continuidade elétrica com o condutor de aterramento da instalação — tanto através do cabo de alimentação da fonte quanto da fixação mecânica da própria fonte e da placa-mãe ao gabinete. Essa continuidade permite que eventuais excessos de carga acumulados no chassi (Apêndice A, §A.4.1) sejam escoados de forma segura para a terra, em vez de se acumularem e serem sentidos pelo usuário ao tocar o gabinete.

**Atenção.** A verificação de continuidade entre o terra da tomada e o chassi do gabinete deve sempre ser feita com um multímetro, nunca por contato direto. Uma instalação elétrica com fase e terra invertidos por erro de instalação pode energizar todo o chassi de um computador aterrado incorretamente — situação já registrada em ambientes reais, inclusive institucionais, e potencialmente fatal.

Pulseiras antiestáticas de aterramento, usadas para escoar cargas eletrostáticas do próprio corpo do técnico durante o manuseio de componentes sensíveis, dependem da confiabilidade da instalação elétrica ao qual são conectadas: um técnico deve avaliar, caso a caso, se confia o suficiente na instalação disponível antes de se conectar diretamente a ela por meio de uma pulseira — preferindo, em caso de dúvida, outras formas de controle eletrostático que não impliquem conexão direta a uma instalação de aterramento não verificada.


!!! warning "Figura pendente"
    diagrama do painel frontal de uma placa-mãe com os pinos de power switch, reset, HDD LED e power LED identificados, indicando polaridade dos LEDs


---

## Síntese do capítulo

Este capítulo apresentou a distinção entre fontes lineares e chaveadas, a arquitetura e os sinais de controle da fonte ATX, e os critérios de eficiência, fator de potência e dimensionamento que orientam a escolha e o diagnóstico de uma fonte real. Do ponto de vista metodológico, o capítulo reforça e aplica em contexto elétrico o princípio de diagnóstico por isolamento de módulos apresentado no Capítulo 12 (§12.4) — testar cada elo da cadeia tomada–fonte–placa-mãe isoladamente para localizar a origem de uma falha.

A energia entregue e regulada pela fonte, tratada aqui, é justamente o que torna possível o funcionamento do componente estudado no Capítulo 4: o processador. Os conceitos de tensão, corrente e dissipação de potência por efeito Joule (Apêndice A) retornarão, em outra escala, na discussão sobre consumo energético e dissipação térmica de processadores (Capítulo 4) — onde o mesmo compromisso entre potência entregue e eficiência de conversão, já estabelecido neste capítulo para a fonte, reaparece na análise de benchmark e desempenho da CPU (Capítulo 13).

---

## Referências

1. WIKIPEDIA. "ATX." Disponível em: <https://en.wikipedia.org/wiki/ATX>.
2. INTEL CORPORATION. *ATX12V Power Supply Design Guide*. (Versão a confirmar pelo autor.) Como fonte secundária: eTechnophiles. "ATX Power Supply Connector Pinout (20 & 24 pins)." Disponível em: <https://www.etechnophiles.com/atx-power-supply-connector-pinout/>.
3. WIKIPEDIA. "ATX." Disponível em: <https://en.wikipedia.org/wiki/ATX>; COMPUTER HOPE. "What Is ATX?" Disponível em: <https://www.computerhope.com/jargon/a/atx.htm>.
4. WIKIPEDIA. "Voltage regulator module." Disponível em: <https://en.wikipedia.org/wiki/Voltage_regulator_module>.
5. CYBENETICS LABS. "ETA — PSU Efficiency Certification." Disponível em: <https://www.cybenetics.com/index.php?option=eta>; "LAMBDA — PSU Noise Level Certification." Disponível em: <https://www.cybenetics.com/index.php?option=lambda-%28power-supplies%29>.
6. WIKIPEDIA. "80 Plus." Disponível em: <https://en.wikipedia.org/wiki/80_Plus>.
7. ANANDTECH. "The Seasonic Focus Plus Gold 750FX 750W PSU Review." Disponível em: <https://www.anandtech.com/show/14338/the-seasonic-focus-plus-gold-750fx-750w-psu-review/3>.
8. AGÊNCIA NACIONAL DE ENERGIA ELÉTRICA (ANEEL). Resolução Normativa nº 414, de 9 de setembro de 2010. (Edição/atualizações a confirmar pelo autor.)
