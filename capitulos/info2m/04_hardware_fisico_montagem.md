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

O processador é, em geral, um dos componentes mais caros de um computador desktop. O mercado de CPUs para desktop é dominado por dois fabricantes: **Intel** e **AMD** — ao contrário do mercado de notebooks, no qual, cada vez mais, a CPU vem soldada diretamente à placa-mãe, eliminando a possibilidade de substituição. A imensa maioria dos computadores desktop disponíveis no mercado utiliza processadores da arquitetura **x64**, cujos detalhes de conjunto de instruções são tratados no Capítulo 5.

### 4.6.1 Compatibilidade entre CPU e placa-mãe: o soquete

O **soquete** é o conector físico da placa-mãe no qual o processador é encaixado. Diferentemente de um módulo de memória RAM — cujo soquete é padronizado e aceita módulos de fabricantes distintos (por exemplo, Kingston ou Samsung) —, o soquete de CPU é **específico do fabricante do processador**: uma placa-mãe projetada para processadores Intel não aceita processadores AMD, e vice-versa.

Além da compatibilidade entre fabricantes, é preciso observar a compatibilidade entre **gerações** de processador dentro de um mesmo fabricante:

- A **Intel**, historicamente, altera o soquete a cada uma ou duas gerações de processador. Em alguns casos, duas gerações consecutivas compartilham o mesmo soquete físico, mas ainda assim são incompatíveis entre si — a placa-mãe precisa ter sido projetada especificamente para aquela geração.
- A **AMD** tende a manter um mesmo soquete (por exemplo, o soquete AM4) por várias gerações consecutivas de processadores, por vezes exigindo apenas uma atualização de BIOS para suportar uma geração mais recente.

**Analogia.** A abordagem da Intel para soquetes pode ser comparada a um cenário hipotético em que cada geração de um smartphone tivesse seu próprio carregador, incompatível com o carregador da geração anterior.

**Exemplo real.** O soquete LGA1155, usado em algumas placas-mãe Intel, suporta processadores de 2ª geração (nome de código Sandy Bridge) e de 3ª geração (Ivy Bridge). Identificar qual geração uma determinada placa-mãe suporta é informação disponível no manual do fabricante — não é conhecimento a ser memorizado, mas sim consultado no momento da especificação ou do reparo.

### 4.6.2 Diferenças físicas entre os soquetes Intel e AMD

Um processador é conectado à placa-mãe por meio de um conjunto de contatos elétricos. Historicamente, os dois fabricantes adotam estratégias opostas quanto à localização física desses contatos:

- **Intel**: os pinos ficam alojados no **soquete da placa-mãe**; o processador possui apenas contatos planos (sem pinos salientes).
- **AMD** (na abordagem tradicional): os **pinos ficam no próprio processador**, e o soquete da placa-mãe possui os furos correspondentes.

Em ambos os casos, um pino entortado é um dano frequentemente irreparável: quando localizado na placa-mãe, compromete a placa inteira; quando localizado no processador, compromete o processador. Por isso, o manuseio de processadores e soquetes exige cuidado e nunca deve envolver força excessiva.

Todo processador possui uma marca de alinhamento (tipicamente um pequeno triângulo em um dos cantos) que corresponde a uma marca equivalente no soquete da placa-mãe. Esse par de marcas garante que o processador só possa ser encaixado em uma única orientação correta.

[IMAGEM: fotos comparativas de um soquete Intel (LGA, com pinos na placa) e um soquete AMD tradicional (PGA, com pinos no processador)]
[IMAGEM: detalhe da marca de alinhamento (triângulo) no canto do processador, alinhada à marca correspondente no soquete]

### 4.6.3 Critérios de especificação: não existe "o melhor"

Além do fabricante, geração e soquete, os processadores variam amplamente em preço e capacidade de processamento — de modelos de entrada a modelos de milhares de reais. Uma capacidade de processamento maior não se traduz automaticamente em melhor desempenho para toda e qualquer aplicação: o desempenho real depende também de como o software em uso foi projetado para tirar proveito do hardware disponível.

**Exemplo.** Um caso amplamente comentado envolveu um usuário que investiu um valor elevado (equivalente ao preço de um carro) em um processador de alto número de núcleos, esperando desempenho superior em um jogo popular. O resultado, entretanto, ficou aquém do esperado: o jogo em questão foi desenvolvido para utilizar poucos núcleos simultaneamente, de modo que o excesso de núcleos disponíveis não pôde ser aproveitado — o gargalo estava na interdependência entre hardware e software, não na capacidade bruta do processador.

Esse caso ilustra um princípio central da disciplina: **não existe "o melhor" componente em termos absolutos — existe o componente mais adequado a um orçamento e a uma finalidade específicos.** O mesmo raciocínio se aplica a outras decisões de hardware e rede: uma rede Wi-Fi em 2,4 GHz oferece maior alcance com menor velocidade, enquanto uma rede em 5 GHz oferece maior velocidade com menor alcance — trata-se de uma escolha de compromisso, não da existência de uma opção objetivamente superior. Da mesma forma, um processador de maior capacidade de processamento tende a consumir mais energia, o que é indesejável em um dispositivo móvel dependente de bateria. Essas relações de compromisso estão associadas à **arquitetura** do processador, tema aprofundado no Capítulo 5.

## 4.7 Sistemas de refrigeração: ar e líquido

Todo processador em operação gera calor, o que exige um sistema de refrigeração para manter sua temperatura dentro de limites seguros. Um sistema de refrigeração não **controla** a temperatura para um valor específico — ele apenas **remove** calor continuamente, independentemente da temperatura ambiente.

### 4.7.1 Componentes ativo e passivo do cooler a ar

O sistema de refrigeração a ar (*air cooler*) mais comum é composto por dois elementos:

- **Componente passivo** — o **dissipador**: uma peça metálica de alta condutividade térmica, fixada em contato direto com o processador, que aumenta a área de contato com o ar por meio de aletas.
- **Componente ativo** — a **ventoinha**: um ventilador alimentado eletricamente (conectado à placa-mãe ou à fonte por um conector de três pinos) que força a circulação de ar através das aletas do dissipador.

**Analogia.** O funcionamento do dissipador pode ser comparado ao ato de espalhar um alimento quente (como um brigadeiro) em um prato: ao aumentar a área de contato do alimento com o ar, a troca de calor é acelerada. O mesmo princípio — maior área de superfície, maior taxa de troca térmica — está por trás das aletas de um dissipador: a mesma massa de material metálico, com muito mais superfície exposta ao ar, dissipa calor de forma muito mais eficiente do que um bloco compacto.

### 4.7.2 Condutividade térmica dos materiais

A eficiência de um sistema de refrigeração depende diretamente da condutividade térmica do meio utilizado para transferir o calor. A tabela a seguir apresenta valores relativos de condutividade térmica para materiais mencionados em aula:

| Material | Condutividade térmica (ordem de grandeza relativa) |
|---|---|
| Prata | 426 |
| Cobre | 398 |
| Alumínio | 237 |
| Tungstênio | 178 |
| Ferro | 80 |
| Vidro | 0,72 |
| Água | 0,61 |
| Tijolo | 0,4 |
| Madeira | 0,11 |
| Fibra de vidro | 0,04 |
| Ar | 0,026 |

O ar é um condutor térmico deficiente — a água é aproximadamente **24 vezes mais condutiva termicamente do que o ar**. É por essa razão que sistemas de refrigeração líquida conseguem remover calor de forma mais eficiente do que sistemas a ar, especialmente em processadores de alto consumo energético.

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

## Síntese do capítulo

Este capítulo tratou dos componentes físicos de um computador desktop, do procedimento de desmontagem e remontagem do gabinete, e retomou o POST — apresentado no Capítulo 3 do ponto de vista do software — sob a ótica dos quatro componentes de hardware vitais à sua execução: fonte, CPU, RAM e placa-mãe. Foram tratados também o papel da bateria CMOS na retenção de configurações, o funcionamento elétrico do botão liga/desliga e do painel frontal, os critérios de compatibilidade entre processador e placa-mãe (fabricante, soquete e geração), e os sistemas de refrigeração a ar e a líquido, incluindo a função física da pasta térmica. Os critérios de especificação de CPU introduzidos aqui — número de núcleos, desempenho por núcleo, consumo energético — dependem diretamente do conceito de **arquitetura de processadores**, aprofundado no Capítulo 5.
