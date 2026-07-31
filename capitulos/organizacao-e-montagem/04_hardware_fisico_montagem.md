# Capítulo 4 — Hardware físico e montagem

Neste capítulo você vai estudar os componentes físicos de um computador desktop e o procedimento de desmontagem e remontagem do gabinete, o funcionamento do POST sob a ótica dos componentes de hardware que ele verifica, o papel da bateria CMOS e do painel frontal, os critérios de compatibilidade entre processador e placa-mãe (fabricante, soquete e geração), e os sistemas de refrigeração a ar e a líquido, incluindo a função física da pasta térmica e o procedimento de troca de CPU.

---

## 4.1 Componentes de um computador desktop e modularidade aplicada

Conforme apresentado no Capítulo 1, o computador é um dispositivo **modular**: constituído por submódulos substituíveis que trabalham em conjunto. Um computador do tipo **desktop** — assim chamado por ter sido projetado para operar sobre uma mesa (*desk*) — reúne esses submódulos dentro de um gabinete.

A tabela a seguir relaciona os principais submódulos de um desktop e sua essencialidade para o funcionamento mínimo do sistema:

| Submódulo | Função | Essencial para ligar? |
|---|---|---|
| Gabinete | Estrutura metálica que abriga e organiza os demais componentes | Não |
| Fonte de alimentação | Converte corrente alternada (rede elétrica) em corrente contínua nas tensões exigidas pelos componentes internos | Sim |
| Placa-mãe | Interconecta todos os demais submódulos e os dispositivos de entrada e saída | Sim |
| Processador (CPU) | Executa as instruções dos programas | Sim |
| Memória primária (RAM) | Armazena, durante a execução, os dados e instruções em uso | Sim |
| Memória secundária (HD, SSD, unidade óptica) | Armazenamento não volátil de longo prazo | Não |
| Sistema de refrigeração (cooler) | Dissipa o calor gerado pelos componentes, em especial a CPU | Não (mas crítico à operação contínua) |
| GPU | Processamento gráfico — pode estar integrada ao próprio chip da CPU ou ser um componente externo | Depende (não essencial se houver GPU integrada) |

**Analogia.** O princípio de modularidade que rege essa tabela é o mesmo de um ônibus, cujos submódulos — motor, parte elétrica, pneus, suspensão, bancos — podem ser removidos e substituídos individualmente: a falha de um deles interrompe o funcionamento do todo, mas a substituição pelo módulo equivalente o restaura. O mesmo vale para um liquidificador doméstico: ele precisa de energia, do copo e da tampa para funcionar com segurança; a ausência da tampa não impede o funcionamento, mas é dispensável apenas nesse sentido restrito — o correto, ao perder um desses módulos, é substituí-lo, e não descartar o aparelho inteiro.

**Exemplo — a fonte de alimentação.** A rede elétrica residencial fornece corrente alternada (no Brasil, tipicamente 127 V ou 220 V). Todos os componentes internos do computador, no entanto, operam em corrente contínua, em diversas tensões específicas. A fonte de alimentação é o submódulo responsável por essa conversão. Sem ela, nenhum outro componente recebe energia, e o computador simplesmente não liga.

[IMAGEM: gabinete desktop aberto com fonte, placa-mãe, CPU, RAM e armazenamento secundário identificados por setas]

### 4.1.1 Interconexões internas

A fonte de alimentação entrega energia diretamente à placa-mãe por meio de conectores dedicados (um conector principal mais robusto e um conector adicional para a CPU). A própria placa-mãe, por sua vez, distribui energia à CPU e à memória RAM — ou seja, esses dois submódulos não recebem alimentação diretamente da fonte, mas sim através da placa-mãe.

A memória secundária (HD, SSD ou unidade óptica) recebe dois cabos distintos quando conectada via interface **SATA** (*Serial ATA*): um cabo de dados, que liga o dispositivo à placa-mãe, e um cabo de energia, que vem diretamente da fonte. Já os dispositivos de armazenamento no padrão **NVMe** (conectados em um slot M.2) dispensam o cabo de energia externo, pois recebem alimentação diretamente da própria placa-mãe.

## 4.2 Desmontagem e remontagem física de um desktop

O procedimento de desmontagem de um desktop segue uma ordem lógica que reflete as dependências elétricas descritas na Seção 4.1.1.

**Procedimento de segurança.** Antes de qualquer manuseio interno, o computador deve estar desligado e desconectado da tomada. Componentes eletrônicos devem ser manuseados pelas bordas, evitando o contato direto com pontos de contato elétrico, com atenção à descarga eletrostática acumulada pelo corpo humano.

**Ferramenta necessária.** A abertura do gabinete é feita com uma chave de fenda do tipo **Philips** — popularmente chamada de chave "estrela".

**Sequência de desmontagem:**

1. Desconectar a fonte de alimentação de qualquer unidade de armazenamento externo (leitor de CD/DVD, por exemplo) e o cabo de energia da fonte.
2. Desconectar os cabos de dados (SATA) e de energia da memória secundária, e removê-la.
3. Remover os módulos de memória RAM dos seus encaixes na placa-mãe.
4. Retirar os parafusos que fixam a placa-mãe ao gabinete e removê-la, mantendo o cooler acoplado à CPU (a remoção da CPU e do cooler é tratada separadamente, nas Seções 4.6 a 4.8).

A remontagem segue a **ordem inversa**: fixar a placa-mãe no gabinete, encaixar a memória RAM, conectar a fonte à placa-mãe, reconectar a memória secundária e, por fim, fechar o gabinete.

**Procedimento de manuseio.** Componentes como módulos de memória RAM possuem uma chave física (um entalhe no conector) que permite o encaixe em uma única orientação. Se for necessário aplicar força excessiva para encaixar um componente, isso indica, na maioria dos casos, que ele está sendo inserido de forma invertida — o procedimento correto é interromper, reavaliar a orientação da peça e não insistir com força.

[IMAGEM: sequência fotográfica da desmontagem — fonte, armazenamento secundário, RAM, placa-mãe]
[IMAGEM: detalhe do encaixe chaveado (entalhe) de um módulo de memória RAM no slot da placa-mãe]

### 4.2.4 Instalação de placas de expansão

Diferente da memória RAM e da CPU — que se conectam a um encaixe específico e único na placa-mãe (Seções 4.1 e 4.6) —, uma placa de expansão (GPU, placa de captura, placa de rede adicional) se conecta a um dos slots PCIe descritos na Seção 4.10.4, e o procedimento de instalação é o mesmo independentemente da função da placa:

1. Com o computador desligado e desconectado da tomada, remover a tampa metálica correspondente na parte traseira do gabinete (o local por onde os conectores da placa ficarão expostos).
2. Liberar a presilha de retenção do slot PCIe escolhido — normalmente uma pequena trava plástica na extremidade do slot, que impede a placa de se soltar por vibração.
3. Alinhar o conector dourado da placa ao slot e pressionar verticalmente e de forma uniforme, dos dois lados da placa, até sentir e (quando o slot tiver esse recurso) ouvir o encaixe da presilha.
4. Fixar a placa ao gabinete com o parafuso correspondente à tampa removida no passo 1, garantindo que ela não se desloque quando cabos forem conectados a ela.
5. Quando aplicável — como é o caso de GPUs de médio e alto desempenho —, conectar o(s) conector(es) de alimentação adicional vindos diretamente da fonte, que suprem uma placa cujo consumo excede o que o próprio slot PCIe é capaz de fornecer (o dimensionamento de fonte para acomodar esse consumo extra é tratado em profundidade no livro de Manutenção de Computadores, Capítulo 2, §2.10).

**Nota prática.** Os mesmos cuidados de manuseio já apresentados neste capítulo se aplicam aqui: nunca forçar o encaixe, manusear a placa pelas bordas, e observar a orientação correta indicada pelo próprio formato do conector — uma placa PCIe, assim como um módulo de memória (Seção 4.2), só se encaixa fisicamente numa única orientação.

## 4.3 O POST sob a ótica dos componentes de hardware

O Capítulo 3 apresentou o POST (*Power-On Self-Test*, autoteste de inicialização) do ponto de vista do software: o primeiro programa executado após a energização do sistema, responsável por verificar o hardware antes de transferir o controle do processador para o sistema operacional (ou para um instalador, no caso de uma instalação de sistema operacional). Este capítulo revisita o POST a partir dos componentes de hardware que ele avalia.

O POST é parte de um firmware maior, o **BIOS** (*Basic Input/Output System*), também referido pela designação mais atual **UEFI** (*Unified Extensible Firmware Interface*). Esse firmware reside fisicamente na placa-mãe, junto com o programa de *setup* — a interface usada para configurar parâmetros como a ordem de inicialização (*boot*) e a data e hora do sistema.

### 4.3.1 Componentes vitais ao POST

Para que o POST seja executado com sucesso, quatro submódulos precisam estar operacionais:

| Componente | Motivo |
|---|---|
| Fonte de alimentação | Sem energia, nenhum programa pode ser executado. |
| CPU | As instruções do POST precisam ser processadas por um processador funcional. |
| Memória RAM | Executar um programa exige carregar suas instruções na memória primária. |
| Placa-mãe (incluindo o BIOS) | Promove a interconexão entre fonte, CPU e RAM, e é onde o próprio programa POST reside. |

**Analogia.** O POST pode ser comparado a um exame de sangue: assim como um médico infere, a partir de indicadores como a contagem de glóbulos brancos, se há uma infecção em curso, o técnico infere, a partir do resultado do POST, se os componentes vitais do computador estão operacionais. É por isso que o ato de o computador exibir a tela inicial do POST é popularmente chamado de "**dar tela**" ou "*dar post*".

### 4.3.2 Componentes que não afetam o POST

Diversos componentes, apesar de relevantes ao uso pleno do computador, **não** interferem no resultado do POST:

- **Memória secundária** (HD, SSD, unidades ópticas): sua ausência não impede o POST, pois ela não é necessária à execução do próprio programa de autoteste.
- **Periféricos** (teclado, mouse, caixa de som, conexão de rede): são dispositivos de entrada e saída (E/S) auxiliares, sem relação causal com o POST — da mesma forma que um smartphone liga mesmo sem sinal de rede.
- **Painel frontal** (tratado em detalhe na Seção 4.5): dispensável ao POST, embora seja o meio usual de acionar a energização do sistema.
- **Bateria CMOS** (tratada na Seção 4.4): não impede o POST, mas afeta a retenção de configurações.

### 4.3.3 Sinalização sonora (beep codes)

Quando a falha ocorre antes que qualquer saída de vídeo seja possível — por exemplo, na ausência de memória RAM —, a placa-mãe não tem como exibir uma mensagem de erro na tela. Nesses casos, um **alto-falante** (*speaker*) interno à placa-mãe emite sinais sonoros (bipes) para comunicar o resultado do autoteste ao técnico: um padrão de bipes indica sucesso, e outros padrões indicam falhas específicas. Esse mecanismo permite diagnosticar um problema mesmo quando o monitor ainda não foi inicializado ou está ausente.

### 4.3.4 Metodologia de diagnóstico

A ausência de POST indica, necessariamente, uma falha em um dos quatro componentes vitais listados na Seção 4.3.1 — nunca em memória secundária, periféricos ou rede. O procedimento de diagnóstico sistemático (a ser aprofundado na disciplina de Manutenção de Computadores) parte sempre do ponto mais externo do sistema — a tomada elétrica — e avança progressivamente em direção aos componentes internos.

[IMAGEM: fluxo energização → POST → carregamento do sistema operacional (ou instalador), com a fronteira hardware/software destacada]

## 4.4 A bateria CMOS e a retenção de configurações

A placa-mãe mantém, em uma pequena memória volátil (a memória **CMOS**), as configurações do *setup*: data e hora do sistema, ordem de inicialização (*boot*) e demais parâmetros de firmware. Essa memória é alimentada por uma **bateria** dedicada, independente da fonte de alimentação principal, o que permite que as configurações persistam mesmo com o computador desligado da tomada.

A ausência ou descarga dessa bateria não impede o POST, mas faz com que as configurações do setup sejam perdidas a cada desligamento — por exemplo, a data e a hora voltam a um valor padrão, exigindo reconfiguração a cada inicialização.

**Exemplo.** Do ponto de vista de programação, o comportamento pode ser descrito por uma variável de controle (uma *flag*) que indica se a data e a hora já foram configuradas. Sem a bateria, essa flag não é preservada entre desligamentos: a cada nova inicialização, o sistema encontra a flag "não configurada" e sinaliza a ausência de data e hora válidas.

[IMAGEM: foto da bateria CMOS (formato moeda) instalada na placa-mãe, com o soquete de encaixe visível]

## 4.5 O painel frontal e o botão liga/desliga

Como decorrência do modelo de hardware aberto adotado desde o IBM PC (Capítulo 1), cada componente de um desktop é tipicamente fabricado por uma empresa diferente: o gabinete — e, portanto, o painel frontal nele embutido — não é necessariamente do mesmo fabricante da placa-mãe. Por essa razão, qualquer funcionalidade presente no painel frontal (botão de energia, botão de reset, indicadores luminosos, portas USB) só opera se estiver **fisicamente conectada** à placa-mãe por um cabo: não existe comunicação sem fio entre painel frontal e placa-mãe.

### 4.5.1 Funcionamento elétrico do botão

O botão de liga/desliga é, mecanicamente, um interruptor momentâneo com apenas dois terminais. Em repouso, uma mola mantém os dois terminais desconectados. Ao ser pressionado, o botão conecta momentaneamente os dois terminais, permitindo a passagem de corrente entre eles; ao ser solto, a mola desfaz essa conexão.

O sinal relevante para a placa-mãe é a **transição momentânea** de "desconectado" para "conectado" — não é necessário manter o botão pressionado. Uma pressão breve é interpretada como o comando padrão de ligar (ou desligar de forma controlada, se o sistema já estiver ligado); manter o botão pressionado por um período prolongado é interpretado como um comando distinto, tipicamente o desligamento forçado.

### 4.5.2 Diagnóstico por curto controlado

Como o botão de energia nada mais é do que um par de terminais que se conectam momentaneamente, é possível ligar o computador **sem o painel frontal**, encostando um objeto condutor (por exemplo, a ponta metálica de uma chave de fenda) diretamente nos dois pinos correspondentes ao botão de energia na placa-mãe — reproduzindo o mesmo efeito elétrico do acionamento do botão.

Esse procedimento é usado como técnica de diagnóstico para isolar o painel frontal como possível causa de falha ao ligar. Por envolver contato direto com a placa-mãe energizada, deve ser realizado com os seguintes cuidados:

- Uso de calçado fechado e de uma ferramenta com cabo isolado.
- Contato restrito exclusivamente aos dois pinos corretos do conector de energia (identificados no manual da placa-mãe) — o toque em pontos incorretos pode danificar o equipamento.

O painel frontal também disponibiliza, tipicamente, um segundo botão equivalente: o botão de **reset**.

[IMAGEM: detalhe do conector de pinos do painel frontal na placa-mãe, com o par correspondente ao botão de power identificado]

## 4.6 CPU: fabricantes, soquetes e gerações

O processador é, em geral, um dos componentes mais caros de um computador desktop. O mercado de CPUs para desktop é dominado por dois fabricantes: **Intel** e **AMD** — ao contrário do mercado de notebooks, no qual, cada vez mais, a CPU vem soldada diretamente à placa-mãe, eliminando a possibilidade de substituição. A imensa maioria dos computadores desktop disponíveis no mercado utiliza, em 2026, processadores da arquitetura **x64**, cujos detalhes de conjunto de instruções são tratados no Capítulo 5.

### 4.6.1 Compatibilidade entre CPU e placa-mãe: o soquete

O **soquete** é o conector físico da placa-mãe no qual o processador é encaixado. Diferentemente de um módulo de memória RAM — cujo soquete é padronizado e aceita módulos de fabricantes distintos (por exemplo, Kingston ou Samsung) —, o soquete de CPU é **específico do fabricante do processador**: uma placa-mãe projetada para processadores Intel não aceita processadores AMD, e vice-versa.

Além da compatibilidade entre fabricantes, é preciso observar a compatibilidade entre **gerações** de processador dentro de um mesmo fabricante:

- A **Intel**, historicamente, altera o soquete a cada uma ou duas gerações de processador. Em alguns casos, duas gerações consecutivas compartilham o mesmo soquete físico, mas ainda assim são incompatíveis entre si — a placa-mãe precisa ter sido projetada especificamente para aquela geração.
- A **AMD** tende a manter um mesmo soquete (por exemplo, o soquete AM4, mantido de 2016 a 2022) por várias gerações consecutivas de processadores, por vezes exigindo apenas uma atualização de BIOS para suportar uma geração mais recente `[1]`.

**Analogia.** A abordagem da Intel para soquetes pode ser comparada a um cenário hipotético em que cada geração de um smartphone tivesse seu próprio carregador, incompatível com o carregador da geração anterior.

**Exemplo real.** O soquete LGA1155, usado em algumas placas-mãe Intel, suporta processadores de 2ª geração (nome de código Sandy Bridge) e de 3ª geração (Ivy Bridge) `[2]`. Identificar qual geração uma determinada placa-mãe suporta é informação disponível no manual do fabricante — não é conhecimento a ser memorizado, mas sim consultado no momento da especificação ou do reparo. **Atenção:** o soquete compartilhado não garante, por si só, compatibilidade total — o chipset **H61**, por exemplo, é LGA1155 mas não suporta Ivy Bridge mesmo com atualização de BIOS.

### 4.6.2 Diferenças físicas entre os soquetes Intel e AMD

Um processador é conectado à placa-mãe por meio de um conjunto de contatos elétricos. Historicamente, os dois fabricantes adotam estratégias opostas quanto à localização física desses contatos:

- **Intel**: os pinos ficam alojados no **soquete da placa-mãe**; o processador possui apenas contatos planos (sem pinos salientes).
- **AMD** (na abordagem tradicional): os **pinos ficam no próprio processador**, e o soquete da placa-mãe possui os furos correspondentes.

**Atenção:** a AMD abandonou essa abordagem tradicional a partir do soquete **AM5** (lançado em 2022, usado pelos Ryzen 7000 em diante), que passou a ser LGA — os pinos ficaram na placa-mãe, como na Intel `[3]`. A descrição acima vale para os soquetes AMD anteriores ao AM5 (como o AM4).

Em ambos os casos, um pino entortado é um dano frequentemente irreparável: quando localizado na placa-mãe, compromete a placa inteira; quando localizado no processador, compromete o processador. Por isso, o manuseio de processadores e soquetes exige cuidado e nunca deve envolver força excessiva.

Todo processador possui uma marca de alinhamento (tipicamente um pequeno triângulo em um dos cantos) que corresponde a uma marca equivalente no soquete da placa-mãe. Esse par de marcas garante que o processador só possa ser encaixado em uma única orientação correta.

[IMAGEM: fotos comparativas de um soquete Intel (LGA, com pinos na placa) e um soquete AMD tradicional (PGA, com pinos no processador)]
[IMAGEM: detalhe da marca de alinhamento (triângulo) no canto do processador, alinhada à marca correspondente no soquete]

### 4.6.3 Critérios de especificação: não existe "o melhor"

Além do fabricante, geração e soquete, os processadores variam amplamente em preço e capacidade de processamento — de modelos de entrada a modelos de milhares de reais. Uma capacidade de processamento maior não se traduz automaticamente em melhor desempenho para toda e qualquer aplicação: o desempenho real depende também de como o software em uso foi projetado para tirar proveito do hardware disponível.

**Exemplo hipotético.** Imagine um usuário que investisse um valor elevado em um processador de alto número de núcleos, esperando desempenho superior em um jogo popular. O resultado, nesse cenário, ficaria aquém do esperado: se o jogo em questão foi desenvolvido para utilizar poucos núcleos simultaneamente, o excesso de núcleos disponíveis não poderia ser aproveitado — o gargalo estaria na interdependência entre hardware e software, não na capacidade bruta do processador.

Esse caso ilustra um princípio central da disciplina: **não existe "o melhor" componente em termos absolutos — existe o componente mais adequado a um orçamento e a uma finalidade específicos.** O mesmo raciocínio se aplica a outras decisões de hardware e rede: uma rede Wi-Fi em 2,4 GHz oferece maior alcance com menor velocidade, enquanto uma rede em 5 GHz oferece maior velocidade com menor alcance — trata-se de uma escolha de compromisso, não da existência de uma opção objetivamente superior. Da mesma forma, um processador de maior capacidade de processamento tende a consumir mais energia, o que é indesejável em um dispositivo móvel dependente de bateria. Essas relações de compromisso estão associadas à **arquitetura** do processador, tema aprofundado no Capítulo 5.

## 4.7 Sistemas de refrigeração: ar e líquido

Todo processador em operação gera calor, o que exige um sistema de refrigeração para manter sua temperatura dentro de limites seguros. Um sistema de refrigeração não **controla** a temperatura para um valor específico — ele apenas **remove** calor continuamente, independentemente da temperatura ambiente.

### 4.7.1 Componentes ativo e passivo do cooler a ar

O sistema de refrigeração a ar (*air cooler*) mais comum é composto por dois elementos:

- **Componente passivo** — o **dissipador**: uma peça metálica de alta condutividade térmica, fixada em contato direto com o processador, que aumenta a área de contato com o ar por meio de aletas.
- **Componente ativo** — a **ventoinha**: um ventilador alimentado eletricamente (conectado à placa-mãe ou à fonte por um conector de três pinos) que força a circulação de ar através das aletas do dissipador.

**Analogia.** O funcionamento do dissipador pode ser comparado ao ato de espalhar um alimento quente (como um brigadeiro) em um prato: ao aumentar a área de contato do alimento com o ar, a troca de calor é acelerada. O mesmo princípio — maior área de superfície, maior taxa de troca térmica — está por trás das aletas de um dissipador: a mesma massa de material metálico, com muito mais superfície exposta ao ar, dissipa calor de forma muito mais eficiente do que um bloco compacto.

### 4.7.2 Condutividade térmica dos materiais

A eficiência de um sistema de refrigeração depende diretamente da condutividade térmica do meio utilizado para transferir o calor. A tabela a seguir apresenta valores relativos de condutividade térmica para os materiais discutidos nesta seção `[4]`:

| Material | Condutividade térmica (ordem de grandeza relativa) |
|---|---|
| Prata | 428 |
| Cobre | 398 |
| Alumínio | 247 |
| Tungstênio | 178 |
| Ferro | 80 |
| Vidro | 0,8 |
| Água | 0,57 |
| Tijolo | 0,66 |
| Madeira | 0,11 |
| Fibra de vidro | 0,04 |
| Ar | 0,026 |

O ar é um condutor térmico deficiente — a água é aproximadamente **22 vezes mais condutiva termicamente do que o ar** `[4]`. É por essa razão que sistemas de refrigeração líquida conseguem remover calor de forma mais eficiente do que sistemas a ar, especialmente em processadores de alto consumo energético.

**Analogia.** A mesma lógica está presente na refrigeração de motores automotivos: o Fusca e seus derivados (como a Kombi e os buggies) utilizavam refrigeração a ar, o que explica seu som característico de motor; carros modernos, por gerarem mais calor e exigirem dissipação mais eficiente, utilizam refrigeração líquida com radiador.

### 4.7.3 Refrigeração líquida (water cooling)

Em um sistema de refrigeração líquida, um fluido (água destilada ou um líquido refrigerante específico) circula em um circuito fechado: passa por uma base em contato com o processador, absorve calor, segue por um tubo até um **radiador** — onde uma área de contato maior com o ar permite a dissipação do calor absorvido — e retorna, já resfriado, ao ponto de partida. Uma bomba e uma ou mais ventoinhas, ambas exigindo alimentação elétrica, mantêm esse ciclo em funcionamento contínuo.

**Observação de segurança.** O líquido refrigerante não entra em contato direto com o processador: ele circula por uma base metálica que, por sua vez, está em contato com a CPU. Essa separação é intencional, já que muitos líquidos conduzem eletricidade, o que tornaria o contato direto com os circuitos do processador um risco de curto-circuito.

[IMAGEM: esquema de um sistema de refrigeração a ar (dissipador + ventoinha) lado a lado com um sistema de water cooling (bloco, tubos, radiador, bomba)]

## 4.8 Pasta térmica: função física e procedimento de troca

Mesmo com um dissipador (a ar ou líquido) corretamente instalado, a superfície de contato entre o processador e a base do dissipador não é perfeitamente lisa em nível microscópico: pequenas imperfeições geram **microlacunas preenchidas por ar**. Como visto na Seção 4.7.2, o ar é um péssimo condutor térmico — nessas microlacunas, ele atua como um **isolante**, prejudicando a transferência de calor entre o processador e o dissipador.

A **pasta térmica** é um composto de alta condutividade térmica aplicado sobre a superfície do processador antes da instalação do dissipador, com a função específica de preencher essas microlacunas, substituindo o ar (isolante) por um material condutor.

### 4.8.1 Procedimento de troca de pasta térmica

1. **Remoção do dissipador.** Desconectar o cooler da placa-mãe (conector de alimentação da ventoinha) e liberar as presilhas ou parafusos mecânicos que o fixam.
2. **Remoção da pasta térmica antiga.** Limpar o excesso com papel; em caso de resíduo endurecido, utilizar **álcool isopropílico**, substância recomendada para limpeza de componentes internos por ser altamente volátil (evapora rapidamente, sem deixar resíduo). O uso de produtos como "limpa-contato" deve ser evitado nessa etapa: por serem mais abrasivos — formulados para remover oxidação —, não são a opção adequada para essa limpeza específica.
3. **Remoção e reinstalação da CPU** (quando aplicável). Identificar a marca de alinhamento do processador (Seção 4.6.2) e alinhá-la à marca correspondente do soquete antes de reencaixá-lo, sem aplicar força.
4. **Aplicação da nova pasta térmica.** A quantidade necessária é pequena — comparável à quantidade de pasta de dente usada em uma escovação (bem menos do que costuma ser mostrado em comerciais). Para pastas em bisnaga, o padrão usual é aplicar em forma de "X" ou cruz no centro do processador; a própria pressão do dissipador, ao ser instalado, espalha a pasta uniformemente pela superfície, preenchendo as microlacunas sem necessidade de espalhamento manual prévio.
5. **Reinstalação do dissipador**, com fixação firme e uniforme das presilhas ou parafusos, garantindo contato mecânico rígido entre processador e dissipador — uma fixação frouxa reintroduz os espaços de ar que a pasta térmica deveria eliminar.

**Nota sobre qualidade e custo.** Pastas térmicas variam amplamente em preço (por exemplo, entre R$ 19,99 e R$ 59,90, a depender da marca e da formulação), refletindo diferenças no grau de condutividade térmica. Como regra prática, qualquer pasta térmica aplicada corretamente supera, em desempenho, a ausência completa de pasta.

[IMAGEM: sequência fotográfica — remoção do dissipador, limpeza da pasta antiga, aplicação em "X" da nova pasta térmica, reinstalação do dissipador]
[IMAGEM: foto aproximada da marca de alinhamento (chanfro/triângulo) da CPU sendo posicionada no soquete]

---

## 4.9 Placa-mãe: fator de forma e organização interna

As seções anteriores deste capítulo trataram a placa-mãe do ponto de vista funcional — o que ela conecta (Seção 4.1), como ela se relaciona com o soquete do processador (Seção 4.6). Esta seção trata da placa-mãe como objeto físico: seu tamanho padronizado e os pequenos componentes de configuração manual que ela expõe.

### 4.9.1 Fator de forma (*form factor*)

O **fator de forma** de uma placa-mãe é o seu padrão de dimensões físicas e posicionamento de furos de fixação — um combinado (no mesmo sentido de "combinado" usado no Capítulo 2 a propósito da célula de memória) entre fabricantes de placa-mãe e fabricantes de gabinete, que garante que qualquer placa de um determinado fator de forma se encaixe em qualquer gabinete compatível com esse mesmo padrão.

| Fator de forma | Dimensões aproximadas `[5]` | Slots de expansão (observação de mercado, não parte da especificação) | Uso típico |
|---|---|---|---|
| **ATX** | 305 × 244 mm | Mais slots (tipicamente 4 a 7) | Desktop de uso geral, estações de trabalho |
| **microATX (mATX)** | 244 × 244 mm | Menos slots (tipicamente 2 a 4) | Desktop compacto, custo reduzido |
| **Mini-ITX** | 170 × 170 mm | Geralmente 1 slot | Computadores muito compactos, *home theater PC*, projetos de nicho |

O número de slots de expansão não é fixado pela especificação do fator de forma em si — depende do projeto de cada fabricante de placa-mãe; as faixas acima são uma observação de mercado, não uma regra normativa. Quanto menor o fator de forma, menor o gabinete que ele permite montar — mas menos espaço físico sobra para slots de expansão (Seção 4.10.4), conectores de alimentação e, com frequência, para soquetes adicionais de memória. A escolha do fator de forma é, portanto, um compromisso entre compacidade e capacidade de expansão futura, e deve ser decidida antes da compra do gabinete: um gabinete ATX aceita placas ATX, microATX e Mini-ITX (por retrocompatibilidade de posicionamento de furos), mas um gabinete Mini-ITX aceita **somente** placas Mini-ITX.

[IMAGEM: três placas-mãe (ATX, microATX, Mini-ITX) fotografadas lado a lado na mesma escala, evidenciando a diferença de tamanho]

### 4.9.2 Onboard versus offboard

Um recurso é dito **onboard** quando sua funcionalidade está integrada diretamente ao chipset ou à própria placa-mãe, sem exigir uma placa de expansão dedicada; é dito **offboard** quando depende de uma placa de expansão separada, conectada a um slot (Seção 4.10.4).

**Exemplo.** Toda placa-mãe moderna inclui vídeo onboard (herdado do processador, quando este tem GPU integrada — Seção 1.10.5), áudio onboard (um chip dedicado de áudio, presente na quase totalidade das placas atuais) e rede onboard (controlador Ethernet e, em muitos modelos, Wi-Fi). Um usuário com necessidades gráficas mais intensas (jogos, edição de vídeo) costuma instalar uma GPU offboard, conectada a um slot de expansão (Seção 4.10.4, adiante), mesmo já possuindo vídeo onboard — nesse caso, o sistema geralmente desabilita automaticamente a saída de vídeo onboard em favor da placa offboard, embora ambas continuem fisicamente presentes.

Historicamente, antes da integração em larga escala promovida pelo chipset moderno (Seção 4.10.2), até mesmo o controlador de rede e o de som eram tipicamente offboard — daí o nome "placa de som" e "placa de rede" ainda usados no vocabulário popular, mesmo quando o recurso em questão hoje é onboard na maioria dos computadores vendidos.

### 4.9.3 Jumpers

Um **jumper** é um pequeno conector plástico, revestido internamente por metal condutor, que une fisicamente dois pinos adjacentes de um conjunto de pinos expostos na placa-mãe — fechando um circuito simples e sinalizando, em hardware, uma escolha binária de configuração (ligado/desligado, modo A/modo B).

**Exemplo mais comum atualmente: o jumper Clear CMOS.** A Seção 4.4 apresentou a memória CMOS, que retém as configurações do *setup* graças à bateria da placa-mãe. Quando essas configurações ficam corrompidas — por exemplo, após uma tentativa de overclock malsucedida que impede o computador de sequer completar o POST — a correção mais confiável não é remover a bateria (o que, em muitas placas modernas, não é suficiente para descarregar completamente o capacitor de retenção), mas usar o jumper "Clear CMOS" (às vezes rotulado CLRTC ou similar): com o computador desligado e desconectado da tomada, move-se o conector plástico da posição padrão para a posição adjacente por alguns segundos, forçando a descarga da memória CMOS, e depois o devolve à posição original. O resultado é equivalente ao de uma placa nova de fábrica: todas as configurações de *setup* voltam ao padrão do fabricante.

**Nota prática.** A posição exata do jumper Clear CMOS — e de qualquer outro jumper presente numa placa específica — varia por fabricante e modelo, e deve ser sempre conferida no manual da placa-mãe antes de qualquer manuseio, seguindo a mesma recomendação já feita a propósito da pinagem do painel frontal (Seção 4.5) e dos conectores de alimentação do processador (livro de Manutenção de Computadores, Capítulo 2, §2.11).

Jumpers já foram mais comuns no passado — por exemplo, para selecionar manualmente a posição *master/slave* de um HD conectado por interface IDE, um padrão anterior ao SATA (Seção 4.10.5) — e hoje sobrevivem principalmente no Clear CMOS e em funções avançadas de diagnóstico em placas de servidor e de entusiasta.

[IMAGEM: foto aproximada de um bloco de pinos Clear CMOS na placa-mãe, com o jumper na posição padrão e, ao lado, na posição de reset]

---

## 4.10 Barramentos: do PCI ao PCIe

### 4.10.1 O que é um barramento

Um **barramento** (*bus*) é um conjunto de linhas condutoras compartilhadas por meio das quais múltiplos componentes de um computador trocam dados. Um barramento é fisicamente organizado em três grupos de linhas:

- **Linhas de dados** — transportam a informação propriamente dita.
- **Linhas de endereço** — indicam a origem ou o destino daquela informação (qual posição de memória, qual dispositivo).
- **Linhas de controle** — sincronizam a operação, indicando, por exemplo, se a operação em curso é de leitura ou de escrita.

Como diversos dispositivos compartilham o mesmo conjunto de linhas, é necessário um **controlador de barramento**, responsável por arbitrar o acesso: decidir, a cada instante, qual dispositivo tem permissão para transmitir. Esse compartilhamento tem um custo estrutural: quanto maior o número de dispositivos conectados a um mesmo barramento, maior tende a ser seu comprimento físico, maior o atraso de propagação do sinal ao longo dele, e maior o tempo médio que cada dispositivo espera até obter o controle do barramento. A solução histórica para esse gargalo foi organizar o computador numa **hierarquia de barramentos** — vários barramentos menores e especializados, em vez de um único barramento universal —, o assunto do restante desta seção.

**Nota conceitual.** Essa forma de comunicação, na qual várias linhas transportam bits simultaneamente em paralelo, é chamada de **comunicação paralela** e se opõe à **comunicação serial**, na qual os bits trafegam um após o outro por uma única linha (ou par de linhas), a uma frequência muito mais alta. Contra a intuição inicial, um link serial moderno normalmente transporta mais dados por segundo do que um barramento paralelo equivalente — a alta frequência de operação de uma única linha bem projetada compensa, e supera, a vantagem teórica de transmitir vários bits "ao mesmo tempo" em paralelo, que sofre mais com interferência entre linhas adjacentes (*crosstalk*) à medida que a frequência sobe. É por essa razão que a evolução dos barramentos de expansão, tratada na Seção 4.10.4, caminhou do paralelo (ISA, PCI) para o serial (PCI Express) — e a mesma lógica explica a evolução do armazenamento de IDE (paralelo) para SATA (serial), na Seção 4.10.5.

[IMAGEM: comparação esquemática entre um barramento paralelo (várias linhas lado a lado) e uma conexão serial (uma linha, alta frequência)]

### 4.10.2 Ponte norte e ponte sul: a arquitetura clássica do chipset

O **chipset** — já mencionado no livro de Manutenção de Computadores (Capítulo 2, §2.11) como o "conjunto de chips" que interliga os controladores da placa-mãe — foi, por muitos anos, fisicamente dividido em dois chips distintos, cada um responsável por uma metade da hierarquia de barramentos do computador.

- **Ponte norte** (*northbridge*, também chamada *IO hub*): conectada diretamente ao processador por um barramento de altíssima velocidade (chamado **QPI** — *QuickPath Interconnect* — pela Intel, e **HyperTransport** pela AMD, historicamente) `[6]`, a ponte norte intermediava o acesso à memória RAM e à placa de vídeo — os dois componentes que mais exigem largura de banda e menor latência possível em relação ao processador.
- **Ponte sul** (*southbridge*), hoje frequentemente chamada **PCH** (*Platform Controller Hub*, nomenclatura Intel) ou **FCH** (*Fusion Controller Hub*, nomenclatura AMD): conectada à ponte norte (nunca diretamente ao processador), reunia os controladores de dispositivos que toleram maior latência — portas USB, SATA (Seção 4.10.5), áudio, rede, o chip de BIOS/UEFI (Capítulo 3, §3.6) e os demais slots PCI/PCIe de expansão.

**Analogia.** A relação entre ponte norte e ponte sul é comparável à hierarquia de uma empresa de logística: a ponte norte é o centro de distribuição regional, conectado por uma rodovia expressa diretamente à fábrica (o processador) e capaz de atender rapidamente os poucos clientes de maior volume (memória RAM, vídeo); a ponte sul é o centro de distribuição local, que recebe carga do centro regional e a redistribui para o grande número de pequenos destinos (USB, SATA, áudio, rede) — cada um exigindo menos velocidade individual, mas em maior quantidade.

### 4.10.3 A migração para dentro do processador

A arquitetura de duas pontes começou a ser desmontada à medida que os processadores modernos passaram a incorporar, dentro do próprio encapsulamento da CPU, funções que antes pertenciam à ponte norte: o **controlador de memória** (Capítulo 2 trata a RAM em profundidade) e, em processadores mais recentes, um conjunto próprio de **pistas PCIe** (Seção 4.10.4, adiante) dedicadas à placa de vídeo e ao armazenamento NVMe (Seção 4.10.5).

O resultado é que a "ponte norte" propriamente dita desapareceu como chip separado na maioria dos desktops modernos: o processador se conecta diretamente à RAM e à GPU, e o que resta da comunicação com o restante da placa-mãe passa por um único link de alta velocidade até a ponte sul — chamado **DMI** (*Direct Media Interface*) pela Intel e **UMI** (*Unified Media Interface*) pela AMD `[7]`. Esse link concentra hoje o tráfego de tudo que ainda depende da ponte sul: USB, SATA, PCIe de menor prioridade, áudio, rede — e é, ele mesmo, um ponto de atenção em especificação de hardware, porque todo esse tráfego compartilha a largura de banda de um único link, ainda que cada dispositivo individual pareça ter sua própria conexão dedicada.

**Nota prática.** Essa reorganização explica por que a especificação de um processador (Capítulo 5) hoje frequentemente informa "quantas pistas PCIe" ele oferece diretamente — um dado que, antes da migração do controlador para dentro da CPU, seria uma característica do chipset, não do processador.

[IMAGEM: dois diagramas lado a lado — arquitetura clássica (CPU → ponte norte → ponte sul) e arquitetura atual (CPU com controlador de memória e PCIe integrados, ligada à ponte sul por DMI/UMI)]

### 4.10.4 Slots de expansão: de ISA a PCI Express

A tabela a seguir situa a evolução dos barramentos de expansão — as conexões da placa-mãe às quais placas adicionais (de vídeo, de som, de rede, entre outras) são fisicamente conectadas `[8]`:

| Padrão | Tipo de comunicação | Situação atual |
|---|---|---|
| **ISA** (*Industry Standard Architecture*) | Paralela | Obsoleto, presente apenas em computadores muito antigos |
| **AGP** (*Accelerated Graphics Port*) | Paralela, dedicada a vídeo | Obsoleto, substituído pelo PCIe |
| **PCI** (*Peripheral Component Interconnect*) | Paralela, barramento compartilhado | Praticamente obsoleto em placas novas |
| **PCI Express (PCIe)** | Serial, ponto a ponto | Padrão atual |

O **PCI Express** rompe com a lógica de barramento compartilhado das gerações anteriores: em vez de vários dispositivos disputando o mesmo conjunto de linhas (como discutido na Seção 4.10.1), cada slot PCIe estabelece uma conexão **ponto a ponto** exclusiva com o controlador — não é, tecnicamente, um "barramento" no sentido estrito da Seção 4.10.1, embora o uso corrente do mercado continue chamando-o assim.

Essa conexão é organizada em **pistas** (*lanes*), cada uma constituída por um par de linhas seriais full-duplex (transmitindo e recebendo simultaneamente). Um slot PCIe pode agrupar diferentes quantidades de pistas — identificadas como **x1**, **x4**, **x8** e **x16** —, e quanto mais pistas agrupadas, maior a largura de banda disponível para o dispositivo conectado. Uma placa de vídeo moderna, por exigir grande volume de dados, normalmente ocupa um slot x16; um SSD NVMe (Seção 4.10.5) costuma usar o equivalente a quatro pistas (x4).

**Compatibilidade física.** Um slot PCIe de maior tamanho físico (por exemplo, x16) aceita, por projeto, uma placa de tamanho físico menor (x1, x4, x8) encaixada nele — a placa menor simplesmente não utiliza todas as pistas disponíveis no slot. O inverso não é possível sem um slot aberto na extremidade (um recurso presente em algumas placas-mãe): uma placa fisicamente x16 não encaixa, por padrão, num slot x1.

Cada geração do padrão PCIe (identificada por um número de versão — PCIe 3.0, 4.0, 5.0 e assim sucessivamente) dobra, em relação à geração anterior, a largura de banda disponível por pista `[9]`, mantendo o mesmo princípio físico de conexão — um padrão de evolução comparável ao da família DDR de memória (Capítulo 2, §2.4).

[IMAGEM: foto de uma placa-mãe evidenciando slots PCIe de tamanhos diferentes (x16, x4, x1) lado a lado]

### 4.10.5 SATA e NVMe: interfaces de armazenamento

A Seção 4.1.1 já introduziu, brevemente, as interfaces **SATA** e **NVMe** ao tratar da conexão física da memória secundária. Esta seção aprofunda essa distinção agora que o conceito de PCIe foi apresentado.

**SATA** (*Serial ATA*) é o sucessor serial do antigo padrão **IDE** (*Integrated Drive Electronics*, também chamado **PATA**, *Parallel ATA*) — mais um caso, como discutido na Seção 4.10.1, da migração geral de interfaces paralelas para seriais. O SATA usa seu próprio controlador (parte da ponte sul, Seção 4.10.2) e seu próprio protocolo de comunicação, projetado nos anos 2000 `[10]` tendo o HD mecânico (Capítulo 2, §2.10) como dispositivo de referência — um dispositivo cujo gargalo real de desempenho está na mecânica do prato girante e do braço atuador, não na interface elétrica em si.

**NVMe** (*Non-Volatile Memory Express*) é um protocolo de comunicação desenvolvido especificamente para memória flash (Capítulo 2, §2.12), projetado para eliminar exatamente essa limitação histórica do SATA. Em vez de usar o controlador da ponte sul e um protocolo pensado para discos mecânicos, um dispositivo NVMe se conecta **diretamente às pistas PCIe** (Seção 4.10.3) — com frequência às pistas oferecidas diretamente pelo processador, e não pela ponte sul —, dispensando a camada de tradução SATA/AHCI e aproveitando a largura de banda muito maior do PCIe. Fisicamente, um dispositivo NVMe de consumo típico se conecta a um slot **M.2** na placa-mãe — um conector compacto que dispensa os cabos de dados e energia exigidos por um dispositivo SATA (Seção 4.1.1) — embora nem todo slot M.2 seja necessariamente NVMe: alguns slots M.2 mais antigos transportam o protocolo SATA sobre o mesmo conector físico, uma fonte comum de confusão na hora de especificar um SSD compatível.

**Nota de desempenho.** A diferença de velocidade entre SATA e NVMe não é sutil: um SSD SATA está limitado à taxa de transferência máxima da interface SATA (da ordem de 600 MB/s) `[11]`, enquanto um SSD NVMe, por usar múltiplas pistas PCIe diretamente, alcança taxas de vários gigabytes por segundo — uma ordem de grandeza acima. Essa diferença só se torna relevante, na prática, para cargas de trabalho que de fato saturam a interface (cópia de grandes volumes de arquivo, carregamento de jogos com texturas pesadas); para o uso cotidiano de um computador, a diferença perceptível entre os dois costuma ser pequena.

---

## 4.11 Entrada, saída e periféricos

### 4.11.1 Classificação e o problema da heterogeneidade

Um dispositivo de entrada e saída (E/S, ou *I/O*) é classificado, do ponto de vista do sistema, pelo sentido do fluxo de dados em relação ao computador:

- **Dispositivos de entrada** — enviam dados para o computador (teclado, mouse, *touchpad*, microfone, câmera, *scanner*).
- **Dispositivos de saída** — recebem dados do computador (monitor, caixas de som, impressora).
- **Dispositivos híbridos** — operam nos dois sentidos (tela sensível ao toque, impressora multifuncional com *scanner*, headset com microfone).

O desafio central de projetar a comunicação entre a CPU e esse universo de periféricos é a **heterogeneidade**: cada dispositivo tem conexão física própria, sentido de conexão próprio, velocidade própria, requisitos próprios (alguns toleram atraso, outros não) e é produzido por um fabricante diferente, sem garantia alguma de padronização espontânea entre eles. A solução estrutural para esse problema é a mesma adotada em outras camadas já estudadas neste livro: um **hardware controlador dedicado** para cada família de periférico, expondo à CPU uma **interface** simples e uniforme — poupando o processador de conhecer os detalhes elétricos específicos de cada fabricante, no mesmo espírito da abstração que o sistema operacional oferece ao software (Capítulo 3, §3.1.1).

### 4.11.2 Estudo de caso: CPU e memória secundária

A comunicação entre a CPU e um HD ou SSD (Capítulo 2) passa por uma controladora que desempenha quatro funções:

1. **Conexão física** — o conector elétrico propriamente dito (SATA ou NVMe, Seção 4.10.5).
2. **Conversão de protocolo de comunicação** — traduz entre o protocolo interno do computador e o protocolo específico daquele padrão de armazenamento.
3. **Conversão de tipos de dado** — organiza os dados na granularidade que o barramento espera (blocos, setores — Capítulo 2, §2.10).
4. **Buffer** — uma pequena área de armazenamento temporário que absorve diferenças momentâneas de velocidade entre a CPU (rápida) e o dispositivo de armazenamento (mais lento), evitando que a CPU precise esperar ociosa por cada byte individual.

### 4.11.3 Estudo de caso: CPU, teclado e mouse

A comunicação entre a CPU e dispositivos de entrada simples como teclado e mouse é resolvida majoritariamente em **software**, não em hardware dedicado de alta complexidade. Antigamente, essa comunicação básica de baixo nível era resolvida diretamente por rotinas do **BIOS** (Capítulo 3, §3.6); atualmente, a pilha é mais sofisticada e passa por três camadas, de baixo para cima: o **chipset** (Seção 4.10.2), que recebe o sinal elétrico bruto do dispositivo; o **driver** (Capítulo 3, §3.12), fornecido pelo sistema operacional ou pelo fabricante, que traduz esse sinal para um formato que o sistema entende; e o **gerenciador de dispositivos** do sistema operacional, que expõe esse dado já tratado aos programas em execução.

### 4.11.4 Modos de transferência de dados

Um requisito comum a qualquer transferência de E/S é comunicar três elementos: um **endereço** (para onde vai, ou de onde vem, o dado), **comandos** (o que fazer com ele) e os **dados** propriamente ditos. Existem três estratégias para a CPU realizar essa comunicação `[12]`:

- **Comunicação programada** — a própria CPU, executando uma rotina de software, é responsável por mover cada dado entre o periférico e a memória. Duas variantes existem: **espera ocupada** (a CPU fica presa num laço, checando repetidamente se o dispositivo está pronto, sem fazer mais nada nesse intervalo) e ***polling*** (a CPU verifica periodicamente, mas intercalando outras tarefas entre uma verificação e outra). Em ambas, a CPU desperdiça parte de sua capacidade de processamento apenas esperando ou verificando.
- **Comunicação por interrupção** — em vez de a CPU perguntar repetidamente "já terminou?", o próprio hardware do dispositivo **avisa** a CPU (por meio de um sinal elétrico chamado interrupção) no exato instante em que há um dado pronto para transferência. A CPU fica livre para executar outras tarefas entre um aviso e outro, interrompendo o que está fazendo apenas quando o periférico efetivamente precisa de atenção.
- **DMA** (*Direct Memory Access*, acesso direto à memória) — para transferências de grande volume (como copiar um arquivo inteiro do SSD para a RAM), mesmo a comunicação por interrupção geraria overhead excessivo se a CPU precisasse mediar byte a byte. O DMA delega essa cópia a um controlador dedicado, que move os dados diretamente entre o dispositivo e a memória RAM sem ocupar o processador durante a transferência — a CPU apenas inicia a operação e é avisada, por uma única interrupção, quando ela termina por completo.

**Analogia.** A diferença entre esses três modos é comparável a esperar uma encomenda em casa: a espera ocupada é ficar parado olhando pela janela sem fazer mais nada; o *polling* é ir até a janela a cada dez minutos, entre outras tarefas domésticas, para checar se a entrega chegou; a comunicação por interrupção é a campainha tocando exatamente quando o entregador chega, liberando a pessoa para fazer qualquer outra coisa no meio tempo; o DMA é contratar um porteiro para receber a encomenda inteira e só avisar quando ela já estiver guardada dentro de casa, sem exigir qualquer atenção da pessoa durante o processo de entrega em si.

### 4.11.5 Estudo de caso: USB

O **USB** (*Universal Serial Bus*, barramento serial universal) ilustra, num único padrão amplamente conhecido, como diferentes tipos de periférico exigem diferentes garantias de entrega de dados. A especificação USB define quatro tipos de transferência `[13]`:

| Tipo de transferência | Uso típico | Garantia |
|---|---|---|
| **Controle** | Inicialização do dispositivo ao ser conectado; comandos administrativos | Entrega garantida |
| **Em massa** (*bulk*) | Grandes volumes de dados sem urgência de tempo (impressoras, *scanners*, pendrives) | Entrega garantida, tempo não garantido |
| **Interrupção** | Pequenos volumes de dados sensíveis a tempo (teclado, mouse) | Entrega garantida, pequenos atrasos tolerados |
| **Isócrona** | Transmissão em tempo real (áudio, vídeo) | Ritmo de entrega garantido, mas dados individuais podem ser perdidos |

Note que essa tabela reflete diretamente o princípio de heterogeneidade apresentado na Seção 4.11.1: um teclado não pode tolerar que uma tecla pressionada demore segundos para ser reconhecida (por isso usa transferência de interrupção, com prioridade sobre atraso), enquanto um fluxo de áudio tolera perder uma amostra ocasional, mas não tolera que o ritmo de entrega varie (por isso usa transferência isócrona) — e uma impressora tolera esperar, desde que nenhum byte do documento se perca (por isso usa transferência em massa). O mesmo protocolo físico (USB) acomoda, portanto, contratos de entrega completamente diferentes, escolhidos pelo fabricante do periférico conforme a natureza do dado transmitido.

[IMAGEM: diagrama de um cabo USB com quatro balões apontando para exemplos de periférico — teclado (interrupção), pendrive (massa), headset (isócrona), dispositivo genérico sendo conectado (controle)]

### 4.11.6 Especificação de periféricos

Assim como processador, memória e armazenamento têm critérios objetivos de especificação (Capítulo 2 e Capítulo 4, §4.6.3), cada família de periférico tem seu próprio conjunto de critérios relevantes — geralmente ligados à natureza do dado que aquele dispositivo transmite (Seção 4.11.1):

| Periférico | Critério de especificação mais relevante |
|---|---|
| Monitor | Resolução e taxa de atualização (Hz) — quantos quadros por segundo o painel exibe |
| Teclado | Tipo de acionamento (membrana ou mecânico) e disposição de teclas |
| Mouse | Resolução do sensor (DPI) e taxa de resposta |
| Impressora | Tecnologia de impressão (jato de tinta ou laser) e custo por página impressa |
| Caixas de som / headset | Resposta de frequência e potência (Capítulo 2, do livro de Manutenção de Computadores, trata potência elétrica em profundidade) |

**Nota prática.** Como qualquer especificação de hardware (Capítulo 4, §4.6.3), não existe "o melhor" periférico em termos absolutos — um teclado mecânico de alto custo é desperdício de orçamento para um usuário de escritório, da mesma forma que uma impressora a laser monocromática não atende quem precisa imprimir fotos coloridas. O critério de especificação de periféricos segue o mesmo princípio de adequação à finalidade já estabelecido para os demais componentes.

---

## Síntese do capítulo

Este capítulo tratou dos componentes físicos de um computador desktop, do procedimento de desmontagem e remontagem do gabinete, e retomou o POST — apresentado no Capítulo 3 do ponto de vista do software — sob a ótica dos quatro componentes de hardware vitais à sua execução: fonte, CPU, RAM e placa-mãe. Foram tratados também o papel da bateria CMOS na retenção de configurações, o funcionamento elétrico do botão liga/desliga e do painel frontal, os critérios de compatibilidade entre processador e placa-mãe (fabricante, soquete e geração), e os sistemas de refrigeração a ar e a líquido, incluindo a função física da pasta térmica. O capítulo também situou a placa-mãe como objeto físico — seu fator de forma e seus jumpers — e como via de comunicação: a hierarquia de barramentos que liga processador, memória, armazenamento e periféricos, da arquitetura clássica de ponte norte/sul à integração progressiva dessas funções dentro do próprio processador, e os protocolos SATA, PCIe e NVMe que materializam essa comunicação hoje, além dos princípios de entrada e saída que regem a comunicação com teclado, mouse e demais periféricos. Os critérios de especificação de CPU introduzidos aqui — número de núcleos, desempenho por núcleo, consumo energético — dependem diretamente do conceito de **arquitetura de processadores**, aprofundado no Capítulo 5.

---

## Referências

1. TECHPOWERUP. "AMD Socket AM5 an LGA of 1,718 Pins with DDR5 and PCIe Gen 4." Disponível em: <https://www.techpowerup.com/282532/amd-socket-am5-an-lga-of-1-718-pins-with-ddr5-and-pcie-gen-4>.
2. WIKIPEDIA. "LGA 1155." Disponível em: <https://en.wikipedia.org/wiki/LGA_1155>; documentação Intel ARK para os chipsets específicos.
3. TECHPOWERUP. "AMD Socket AM5 an LGA of 1,718 Pins with DDR5 and PCIe Gen 4." Disponível em: <https://www.techpowerup.com/282532/amd-socket-am5-an-lga-of-1-718-pins-with-ddr5-and-pcie-gen-4>.
4. PRÄSS, Alberto Ricardo. "Condutividade Térmica — Constantes Físicas." fisica.net. Disponível em: <https://www.fisica.net/constantes/condutividade-termica-(k).php>.
5. WIKIPEDIA. "ATX." Disponível em: <https://en.wikipedia.org/wiki/ATX>; "MicroATX." Disponível em: <https://en.wikipedia.org/wiki/MicroATX>; "Mini-ITX." Disponível em: <https://en.wikipedia.org/wiki/Mini-ITX>.
6. STALLINGS, William. *Arquitetura e Organização de Computadores*. 10. ed. São Paulo: Pearson Education do Brasil, 2018 (seção sobre QPI); MONTEIRO, Mario A. *Introdução à Organização de Computadores*. 5. ed. Rio de Janeiro: LTC (seção D.3.4.2, Tecnologia HyperTransport).
7. WIKIPEDIA. "Direct Media Interface." Disponível em: <https://en.wikipedia.org/wiki/Direct_Media_Interface>; INTEL. "What Is the Direct Media Interface (DMI) of Intel® Processors?" Disponível em: <https://www.intel.com/content/www/us/en/support/articles/000094185/processors.html>; WIKIPEDIA. "Unified Media Interface." Disponível em: <https://en.wikipedia.org/wiki/Unified_Media_Interface>.
8. PCI-SIG. Especificações oficiais PCI/PCI Express. Disponível em: <https://pcisig.com>.
9. PCI-SIG. Especificações oficiais PCI Express (PCIe 3.0/4.0/5.0). Disponível em: <https://pcisig.com>.
10. SEAGATE. "Serial ATA: High Speed Serialized AT Attachment, Revision 1.0, 29-August-2001." Disponível em: <https://www.seagate.com/support/disc/manuals/sata/sata_im.pdf>.
11. SATA-IO. Especificação SATA. Disponível em: <https://www.sata-io.org>.
12. STALLINGS, William. *Arquitetura e Organização de Computadores*. 10. ed. São Paulo: Pearson Education do Brasil, 2018 (Capítulo 7, E/S programada, por interrupção e DMA).
13. USB IMPLEMENTERS FORUM. Especificação USB. Disponível em: <https://www.usb.org>; MONTEIRO, Mario A. *Introdução à Organização de Computadores*. 5. ed. Rio de Janeiro: LTC (seção D.3.4.1).
