# Capítulo 3 — Processador, Benchmark e Dimensionamento

Neste capítulo você vai estudar a evolução histórica e os limites físicos do processador moderno — da lei de Moore ao problema do calor —, a distinção entre arquiteturas RISC e CISC, a organização interna de um processador multicore (núcleos, threads, cache e pipeline), a relação entre resolução de vídeo e demanda de processamento, e a metodologia de benchmark que permite comparar hardware de fabricantes e gerações diferentes para realizar o dimensionamento de um computador dentro de um orçamento.

---

## 3.1 O processador como peça central da especificação

Dentro da tarefa de especificar uma máquina para uma determinada demanda — um dos objetivos centrais desta disciplina —, o processador (CPU, *Central Processing Unit*) ocupa posição crítica. A escolha da CPU não é uma decisão isolada: ela impõe restrições sobre a placa-mãe (via soquete e chipset) e sobre a fonte de alimentação (via potência exigida, tema do Capítulo 2), e é frequentemente o fator que define o desempenho final da máquina — o chamado **gargalo** (*bottleneck*) da especificação.

Se o processador fosse tratado como uma classe de programação, seus atributos característicos seriam:

- **Arquitetura** (RISC ou CISC, tratada na Seção 3.2)
- **Litografia** (o processo de fabricação, tratado na Seção 3.3)
- **Fabricante**
- **Soquete** (o encaixe físico na placa-mãe, tratado na Seção 3.7)
- **Geração**
- **Número de núcleos** (*cores*)
- **Número de threads**
- **Potência** (em watts)
- **Clock** (frequência de trabalho)

Esses atributos formam a "ficha técnica" completa de um processador, tal como aparece nos anúncios comerciais. O restante deste capítulo desenvolve cada um desses atributos e apresenta a metodologia — baseada em *benchmark* — que permite comparar processadores diferentes de forma objetiva.


!!! warning "Figura pendente"
    anúncio real de processador com os atributos arquitetura, litografia, soquete, núcleos, threads, potência e clock destacados


## 3.2 Arquiteturas RISC e CISC

No nível do *Instruction Set Architecture* (ISA — o conjunto de instruções que uma CPU é capaz de executar), o mercado de processadores se organiza historicamente em dois grandes paradigmas:

- **CISC** (*Complex Instruction Set Computer*) — conjunto de instruções complexo. Seu grande diferencial é a **retrocompatibilidade**: um processador CISC lançado hoje ainda é capaz de executar instruções presentes em processadores lançados décadas atrás. Essa característica gera discussões reais na engenharia de software — por exemplo, entre os desenvolvedores do núcleo (*kernel*) do sistema operacional Linux há debates recorrentes sobre manter, ou não, suporte a instruções herdadas de arquiteturas de computadores como o 386 e o 486, da década de 1990 `[1]`.
- **RISC** (*Reduced Instruction Set Computer*) — conjunto de instruções reduzido e simplificado. Instruções mais simples exigem hardware mais simples, o que resulta em maior eficiência energética (mais desempenho por watt consumido) em comparação a um processador CISC equivalente.

**Exemplo.** Processadores da família Pentium 2, Pentium 3, Atom, e as diversas gerações da linha Ryzen são exemplos de processadores CISC (arquitetura x86), demonstrando décadas de retrocompatibilidade dentro dessa família.

Por muito tempo, essa escolha de arquitetura era irrelevante para o técnico de manutenção de desktops e notebooks: processadores RISC ficavam restritos a smartphones, onde a eficiência energética é decisiva para a autonomia de bateria. Esse cenário mudou. Hoje, processadores RISC (como os chips Apple Silicon e os processadores Snapdragon) também competem no mercado de desktops e laptops. Consequentemente, ao especificar computadores portáteis — por exemplo, para uma equipe de professores que leva o equipamento para dar aula fora do laboratório —, a arquitetura passa a ser uma escolha técnica relevante: um computador de arquitetura CISC de alto desempenho pode exigir tantos acessórios de suporte (fonte robusta, ventilação adicional) que se torna impraticável para uso móvel, enquanto um equivalente RISC entrega autonomia de bateria muito superior.

> **Atualidade de mercado — o chip RISC da NVIDIA para computação de IA local**
>
> Em 1º de junho de 2026, durante a feira Computex em Taipei, a NVIDIA — historicamente fabricante de placas de vídeo GeForce — anunciou o **RTX Spark**, seu primeiro chip de arquitetura RISC (especificamente Arm) voltado a computadores pessoais, com memória unificada (nos moldes do que a Apple já pratica em seus chips Apple Silicon) e capacidade de até 128 GB de memória compartilhada entre CPU, GPU e NPU `[2]`. A NVIDIA e a Microsoft, em conjunto, descreveram o lançamento como parte de uma "reinvenção do computador".
>
> A novidade central não é apenas a arquitetura RISC em si, mas o fato de que o chip foi projetado com instruções voltadas ao chamado *loop agêntico*: da mesma forma que o ciclo clássico de busca–decodificação–execução (Seção 3.6) fundamenta o funcionamento de qualquer CPU, o RTX Spark inclui, em nível de processador, suporte a um ciclo de raciocínio–execução–validação voltado à execução local de agentes de inteligência artificial (assistentes de programação e automação que operam diretamente na máquina do usuário, sem depender inteiramente de processamento em nuvem).
>
> O chip já nasce com parcerias fechadas com fabricantes de notebooks como Lenovo, HP, Dell (Microsoft Surface), Asus e MSI, colocando pressão competitiva simultânea sobre Intel, AMD e Apple. Trata-se de uma notícia de mercado recente — o leitor deste livro deve tratá-la como indicativo de tendência, não como fato estático: a configuração exata de produtos comerciais baseados nesse chip deve ser verificada em fontes atualizadas no momento da leitura.

## 3.3 A Lei de Moore e os limites físicos da litografia

Historicamente, observou-se que os processadores lançados pela Intel dobravam a quantidade de transistores em relação ao modelo anterior a cada aproximadamente dois anos. Essa observação empírica foi formalizada como meta de desenvolvimento da indústria e ficou conhecida como **lei de Moore**.

Como o transistor é a unidade fundamental de construção de portas lógicas, circuitos aritméticos, circuitos de controle e circuitos de memória, um processador com o dobro de transistores tende a oferecer maior poder computacional. O gráfico histórico de contagem de transistores por chip, de 1970 a meados da década de 2010, mostra crescimento de milhares para dezenas de bilhões de transistores por chip.

| Fabricante/arquitetura | Litografia aproximada |
|---|---|
| Intel, 12ª geração | 10 nm |
| AMD Zen 3 (Ryzen série 5000) | 7 nm |
| AMD Zen 4 (Ryzen série 7000) | 5 nm |
| Apple Silicon (M1) | 5 nm |
| Qualcomm Snapdragon (gerações recentes) | ~3 nm |

*Dados de litografia levantados em 2026; a litografia real muda a cada nova geração de produto `[4]`.*

Reduzir a litografia traz dois benefícios simultâneos e vinculados por física básica: como a velocidade de deslocamento do elétron é aproximadamente constante, diminuir a distância física que o elétron percorre entre terminais do transistor reduz o tempo de processamento (maior velocidade) e reduz a perda de energia por efeito Joule (maior eficiência energética). Um processador fabricado numa litografia menor é, por concepção de projeto, mais rápido e mais eficiente do que um equivalente fabricado numa litografia maior.

**O processo de fabricação.** O silício, elemento com quatro elétrons na camada de valência, é abundante — extraído da areia, não de jazidas raras — e forma cristais estáveis por ligação covalente entre átomos vizinhos. Após purificado e cristalizado, o silício é fatiado em discos finos chamados *wafers*. Sobre o *wafer*, um processo óptico de precisão chamado **litografia** projeta, com o auxílio de lasers e lentes especiais, a imagem do circuito do processador, "queimando" no silício o desenho dos transistores já interligados em portas lógicas. O processo de **dopagem** (introdução controlada de impurezas, como boro, na estrutura cristalina) cria as regiões de tipo N e tipo P que formam diodos e transistores. Concluída a gravação, o *wafer* é fatiado em unidades individuais (os *dies*), que recebem encapsulamento protetor e se tornam o chip vendido no mercado, no formato que se conecta ao soquete da placa-mãe.

Historicamente, a Intel controlava tanto o projeto quanto a fabricação (fundição) de seus próprios chips. Outros fabricantes — AMD, Apple, Qualcomm — projetam seus chips mas terceirizam a fabricação para fundições especializadas, principalmente a TSMC (*Taiwan Semiconductor Manufacturing Company*), sediada em Taiwan. A dificuldade da Intel em reduzir sua própria litografia abaixo de 10 nm é um fator relevante da perda de competitividade da empresa nos últimos anos, a ponto de ela também ter passado a recorrer a fundições terceirizadas para parte de sua produção. A concentração geográfica dessa capacidade de fabricação de semicondutores de ponta em Taiwan é, adicionalmente, um fator de tensão geopolítica relevante, dado o contexto de disputa territorial entre Taiwan e a China — um ponto que tem desdobramentos diretos sobre preço e disponibilidade de chips no mercado global.


!!! warning "Figura pendente"
    fotografia de um wafer de silício antes e depois do processo de litografia


!!! warning "Figura pendente"
    gráfico da contagem de transistores por chip ao longo do tempo, 1970–2016 — se adaptado de fonte de terceiros (ex.: Our World in Data), creditar a fonte e confirmar a licença antes de publicar; alternativa: construir com dados brutos próprios/públicos para evitar qualquer dúvida de direito autoral


## 3.4 Calor, thermal throttling e o fim do núcleo único

Alocar mais transistores no mesmo espaço físico tem uma consequência inevitável: mais calor gerado na mesma área. Processadores das gerações mais antigas (até o início dos anos 2000) nem sempre possuíam proteção térmica — e a diferença entre ter ou não essa proteção podia ser dramática: um vídeo de demonstração histórico e amplamente citado (Tom's Hardware, ~2000–2001) comparou um Intel Pentium III e um AMD Athlon "Thunderbird", ambos sem *cooler*, sob carga. O Pentium III, equipado com um monitor térmico que desligava o processador ao atingir a temperatura crítica, travou o sistema mas sobreviveu; o Athlon, sem qualquer proteção térmica, literalmente queimou e soltou fumaça em menos de um segundo, chegando a 370 °C no núcleo `[5]`.

Os processadores modernos resolvem esse risco com o mecanismo de **thermal throttling** (acelerador térmico): ao detectar que a temperatura se aproxima de um limite pré-definido, o processador reduz automaticamente sua frequência de processamento; ao esfriar, ele volta a acelerar. O resultado é um ciclo contínuo de aceleração e desaceleração, governado pela temperatura.

O *thermal throttling* deixou de ser apenas uma medida de emergência e passa a ser usado como característica de projeto: um MacBook sem ventoinha reduz o clock progressivamente conforme aquece, enquanto um MacBook Pro com ventoinha ativa consegue sustentar clocks mais altos por mais tempo, adiando o momento do *throttling*.

**O limite que originou o multicore.** No início dos anos 2000, a Intel chegou a planejar um Pentium 4 de 4 GHz, mas cancelou o lançamento em outubro de 2004: a dissipação de calor necessária tornava o produto inviável para os computadores da época `[6]`. A solução encontrada pela indústria não foi continuar aumentando a densidade de transistores num único núcleo, mas **duplicar o número de núcleos de processamento** dentro do mesmo encapsulamento — cada um mais simples e mais frio do que seria um único núcleo hipertrofiado. Nasceu assim a era **multicore** no mercado de desktop, por volta de 2005, com o lançamento do Pentium D pela Intel e do Athlon X2 pela AMD `[7]`. Essa mudança de direção arquitetural se mantém até hoje: não houve retorno ao paradigma de núcleo único, apenas a adição de novas unidades de processamento especializadas (GPU, NPU), tratadas ao final deste capítulo.


!!! warning "Figura pendente"
    gráfico comparando temperatura e FPS de um processador com e sem cooler durante um jogo


## 3.5 A era multicore: núcleos, cache e hyper-threading

Um **core** (núcleo) é uma unidade de processamento física — hardware. Um processador multicore contém, dentro de um único encapsulamento, múltiplas cópias completas da estrutura de processamento (unidade lógico-aritmética, registradores, unidades de controle de fluxo), cada uma com sua própria memória cache de nível 1 (L1) e nível 2 (L2). Externamente aos núcleos, mas ainda dentro do chip, fica a cache de nível 3 (L3), compartilhada entre todos os núcleos — funcionando como uma mesa de trabalho comum para a troca de dados entre eles quando uma tarefa é dividida entre múltiplos núcleos.

**Nota sobre controle de qualidade.** Nem todo processador de uma mesma linha de produção nasce igual: após a fabricação, cada chip passa por uma bancada de testes. Esse processo, chamado *binning*, é real e bem documentado na indústria `[8]`: às vezes, um chip com todos os núcleos aprovados no controle de qualidade é vendido como a linha superior (por exemplo, um "i7"), enquanto um chip do mesmo *die*, com núcleos defeituosos desabilitados, é vendido como um produto de linha inferior ("i5" ou "i3"). Essa não é, porém, a explicação universal da diferenciação entre linhas: em boa parte dos casos — especialmente em gerações mais recentes — i5 e i3 são fabricados a partir de *dies* fisicamente menores e diferentes do i7, não do mesmo chip com núcleos desabilitados.

Uma **thread**, por sua vez, é uma unidade lógica — uma simulação em software da existência de mais processadores do que os fisicamente presentes. A tecnologia responsável por essa simulação é chamada de **hyper-threading** (nomenclatura da Intel) ou **SMT**, *simultaneous multi-threading* (nomenclatura da AMD). Um núcleo físico com hyper-threading de grau 2 é enxergado pelo sistema operacional como dois processadores lógicos.

**Exemplo.** Um anúncio real de processador Intel Core i5-12400F (12ª geração) especifica 6 núcleos físicos (*cores*) com hyper-threading, totalizando 12 threads `[9]` — ou seja, o sistema operacional identifica 12 processadores lógicos disponíveis, embora fisicamente existam apenas 6.

Essa complexidade, no entanto, tem um custo que sobe para as camadas de software: programação paralela (a técnica de dividir um algoritmo para ser executado simultaneamente em múltiplos núcleos) é uma disciplina distinta e mais difícil do que a programação sequencial convencional, e a maioria dos programas aplicativos comuns não é otimizada para tirar proveito de mais do que quatro a seis núcleos simultâneos. A consequência prática desse descompasso — poder computacional disponível, mas ocioso — é discutida na Seção 3.11.


!!! warning "Figura pendente"
    fotografia (die shot) de um processador com quatro núcleos, cache L1/L2 por núcleo e cache L3 compartilhada identificados


## 3.6 Pipeline: sobreposição de estágios de execução

O ciclo básico de funcionamento de uma CPU consiste em três etapas repetidas continuamente: **busca** da instrução na memória, **decodificação** dessa instrução e **execução** da instrução decodificada. A técnica de **pipeline** consiste em sobrepor essas etapas para diferentes instruções simultaneamente, em vez de executar o ciclo completo de uma instrução antes de iniciar a próxima.

**Analogia (adaptada da clássica analogia da lavanderia de Patterson & Hennessy `[10]`).** Considere uma lavanderia com quatro estações — lavar, secar, dobrar e guardar —, em que cada etapa leva uma hora. Numa execução sem pipeline, o ciclo completo (lavar → secar → dobrar → guardar) leva 4 horas, e o próximo ciclo só começa depois que o anterior termina inteiramente: quatro ciclos completos consumiriam 16 horas (4 etapas × 1 hora × 4 ciclos), com cada máquina ficando ociosa na maior parte do tempo. Com pipeline, assim que a máquina de lavar termina uma carga e a transfere para a secadora, ela já recebe uma nova carga de roupa suja — nenhum equipamento fica parado. Nesse esquema, em sete horas obtêm-se quatro ciclos completos de saída, contra as dezesseis horas necessárias sem sobreposição — um ganho de mais do que o dobro de produtividade utilizando exatamente o mesmo hardware, apenas evitando ociosidade.

É essa mesma lógica de aproveitamento de estágios ociosos do circuito de busca–decodificação–execução que permite ao hyper-threading (Seção 3.5) fazer um único núcleo físico atender a duas instruções em estágios diferentes do pipeline ao mesmo tempo, simulando dois processadores lógicos. O termo *pipeline* não é exclusivo da arquitetura de computadores — é usado de forma equivalente em engenharia de produção industrial para descrever qualquer processo organizado em estágios reaproveitáveis e encadeados.


!!! warning "Figura pendente"
    diagrama de linha do tempo mostrando quatro estágios de pipeline sobrepostos ao longo de sete unidades de tempo


## 3.7 Soquete, geração e compatibilidade de mercado

O **soquete** é o conector físico da placa-mãe onde o processador é encaixado. Cada geração de processador é compatível apenas com um conjunto específico de soquetes: uma placa-mãe fabricada para processadores Intel não aceita processadores AMD, e vice-versa — e mesmo dentro de um mesmo fabricante, gerações diferentes de processador frequentemente exigem soquetes diferentes.

Esse detalhe tem consequência direta para o trabalho de manutenção. Historicamente, a AMD tem mantido o mesmo soquete por múltiplas gerações de processador — o soquete AM4 atendeu várias gerações consecutivas de Ryzen, e o soquete AM5, lançado mais recentemente, teve seu suporte estendido pela AMD até o ano de 2029 `[11]`. Isso significa que uma placa-mãe AM5 fabricada hoje continuará aceitando processadores lançados anos depois. A Intel, por sua vez, tende a alterar o soquete a cada uma ou duas gerações.

**Consequência prática para o técnico.** Diante de uma placa-mãe com defeito comprovado, cujo processador continua funcional, a estratégia de diagnóstico modular (transferir o processador para outra placa-mãe compatível) é significativamente mais viável em um ecossistema AMD — em que placas-mãe compatíveis com processadores mais antigos continuam disponíveis no mercado — do que em um ecossistema Intel, no qual encontrar uma placa-mãe compatível com um processador de poucos anos atrás pode ser difícil e caro o suficiente para tornar mais econômico descartar o processador funcional e comprar um conjunto novo (processador e placa-mãe).

Esse tipo de escolha de projeto — que reduz a vida útil economicamente viável de um componente ainda funcional — se aproxima do fenômeno mais amplo de **obsolescência programada**, observável em outras indústrias. Do ponto de vista puramente técnico, isso reforça por que a análise de soquete e longevidade de plataforma deve fazer parte da recomendação de compra ao cliente, e não apenas a comparação de desempenho bruto — que é tratada, com apoio de benchmark, na Seção 3.9. Cabe notar, entretanto, que a Intel frequentemente compensa essa desvantagem de longevidade praticando preços mais agressivos, de modo que a escolha entre os dois fabricantes é sempre uma decisão de custo-benefício, não uma resposta única.


!!! warning "Figura pendente"
    foto comparativa de soquete AMD (AM4/AM5) e soquete Intel (LGA) com os pinos/contatos visíveis


## 3.8 Resolução, taxa de quadros e demanda gráfica

Um monitor é, fisicamente, uma matriz de milhões de **pixels**, cada um capaz de assumir uma cor por meio da combinação aditiva das cores primárias de luz — vermelho, verde e azul (RGB, *Red-Green-Blue*). A síntese aditiva parte do preto (monitor desligado) e soma luz até formar as demais cores; o processo é diferente da impressão em papel, que parte do branco e usa síntese subtrativa de tinta (ciano, magenta, amarelo).

A **resolução** de um monitor descreve a quantidade estática de pixels — largura por altura:

| Nome comercial | Resolução (pixels) |
|---|---|
| HD | 1280 × 720 (também chamado 720p) |
| Full HD | 1920 × 1080 (também chamado 1080p) |
| 2K / QHD | 2560 × 1440 |
| 4K | 3840 × 2160 |

Quanto maior a resolução, maior o número de pixels que o hardware precisa calcular, transportar e copiar continuamente — trabalho que recai, em última instância, sobre o processador (e sobre a GPU, tratada na Seção 3.9).

A segunda variável relevante é a **taxa de quadros por segundo** (FPS, *frames per second*): quantas vezes por segundo a imagem inteira é atualizada. O olho humano percebe movimento contínuo a partir de aproximadamente 24 atualizações por segundo — o mesmo princípio de um desenho animado feito quadro a quadro num caderno.

**Exemplo.** Para estimar o volume de dados de vídeo que o hardware precisa processar por segundo, multiplica-se a quantidade de pixels de um quadro pela taxa de quadros por segundo:

- 720p a 30 FPS: 1.280 × 720 × 30 ≈ 27,6 milhões de pixels processados por segundo.
- Full HD (1080p) a 60 FPS: 1.920 × 1.080 × 60 ≈ 124,4 milhões de pixels processados por segundo.

A diferença entre os dois cenários é de aproximadamente 4,5 vezes — um salto de resolução de 720p para Full HD, combinado com o dobro da taxa de quadros, quase quintuplica a demanda computacional. Esse cálculo explica por que jogos e aplicações gráficas listam requisitos mínimos e recomendados atrelados tanto a uma resolução quanto a uma taxa de FPS específicas.

Vale registrar que nem toda queda de desempenho percebida em jogos multijogador tem origem no processamento local: quando o computador atua como cliente de um servidor remoto (típico de jogos *online*), atrasos de rede (Wi-Fi, latência do provedor, disponibilidade do servidor) também produzem sensação de travamento, independentemente da capacidade da CPU e da GPU locais.


!!! warning "Figura pendente"
    comparação lado a lado da mesma imagem renderizada em diferentes resoluções, evidenciando o tamanho dos pixels


## 3.9 Benchmark: metodologia de comparação e dimensionamento

Ao especificar um computador para uma finalidade concreta — por exemplo, atender aos requisitos mínimos de um jogo —, o técnico se depara com um problema: os requisitos publicados pelo fabricante do software costumam ser descritivos (sistema operacional, um modelo específico de CPU, quantidade de memória RAM, um modelo específico de GPU, espaço de armazenamento), e não numéricos. Memória RAM e armazenamento são diretamente comparáveis em gigabytes — qualquer módulo de 8 GB atende a um requisito de 8 GB. CPU e GPU não: não existe uma unidade simples que permita comparar diretamente um processador de um fabricante, arquitetura e geração com outro processador de fabricante, arquitetura e geração diferentes.

A solução adotada pela indústria é o **benchmark** — literalmente, "bancada de testes". Todo processador ou placa de vídeo submetido ao mesmo teste padronizado recebe uma nota (*score*) comparável.

**As duas notas de CPU.** Ferramentas de benchmark para processador (a mais usada em sala é o PassMark, cujo software CPU-Z é abordado na Seção 3.10) produzem duas notas distintas:

- **Single-thread rating** — desempenho de um único núcleo trabalhando sozinho.
- **Multi-thread rating** — desempenho de todos os núcleos e threads trabalhando simultaneamente.

Essa distinção é decisiva na prática: a maioria dos softwares de uso comum (planilhas, navegadores) e a maioria dos jogos não são otimizados para dezenas de núcleos simultâneos — eles dependem, sobretudo, do desempenho *single-thread*. Cargas de trabalho de servidor, renderização e simulação, por outro lado, se beneficiam diretamente do desempenho *multi-thread*.

**Exemplo.** Uma comparação real conduzida em sala, entre um processador Intel (lançado em 2015) e um processador AMD Ryzen (lançado em 2017), ilustra o ponto: o processador Intel obteve nota *single-thread* de aproximadamente 2.315 pontos contra aproximadamente 2.000 pontos do AMD (uma diferença de cerca de 10% a favor da Intel); já na nota *multi-thread*, o AMD obteve cerca de 12.000 pontos contra 6.305 pontos da Intel — quase o dobro. *(Nota: dado autoral de demonstração em sala; os modelos exatos de CPU não são nomeados aqui — vale documentá-los, ou anexar a captura de tela do PassMark usada na aula, para que o exemplo seja reproduzível.)* A conclusão prática: para um computador cuja finalidade é jogar (dependente de desempenho *single-thread*), o processador Intel seria a escolha mais adequada, apesar de mais antigo; para um servidor cuja carga se distribui por múltiplas threads simultâneas, o AMD seria a escolha correta. O benchmark permite essa comparação mesmo entre processadores de fabricantes, arquiteturas, gerações, caches e potências diferentes, porque ambos foram submetidos exatamente à mesma prova.

**Ganho geracional.** Comparações de longo prazo dentro de uma mesma linha de produto evidenciam o efeito acumulado da miniaturização (Seção 3.3) e de melhorias de arquitetura. Um exemplo apresentado em aula, de uma mesma família de processador ao longo de gerações sucessivas: em 2017, um modelo de 65 W entregava cerca de 2.000 pontos *single-thread*; em 2018, a geração seguinte, operando a 105 W, chegou a cerca de 2.400 pontos; já em 2024, uma geração mais recente voltou a operar a 65 W (a mesma potência de 2017) e alcançou aproximadamente 4.500 pontos *single-thread* e cerca de 30.000 pontos *multi-thread* — mais do que o dobro do desempenho *single-thread* de sete anos antes, com potência igual à do ponto de partida. *(Nota: família de processador específica a documentar pelo autor, para que a série seja rastreável.)* Esse é o retrato numérico do que a Seção 3.3 descreve de forma qualitativa: litografias menores entregam, ao mesmo tempo, mais desempenho e mais eficiência energética.

**Benchmark de GPU e custo-benefício.** O mesmo tipo de ferramenta existe para placas de vídeo. Ao comparar duas GPUs reais de gerações próximas, por exemplo, uma custando cerca de R$ 2.890 com nota de aproximadamente 22.000 pontos, contra outra custando cerca de R$ 4.600 com nota de aproximadamente 28.000 pontos, *(GPUs específicas e data de consulta de preço a documentar pelo autor, já que preços em reais mudam rapidamente)* o técnico consegue avaliar objetivamente se o ganho de desempenho (cerca de 27%) justifica o acréscimo de custo (cerca de 60%) para aquele cliente específico — e ainda precisa verificar se a fonte de alimentação do computador suporta a potência adicional exigida pela placa mais cara, sob risco de o upgrade da GPU obrigar também um upgrade da fonte.

Uma forma particularmente útil de visualizar essas comparações é o gráfico de dispersão (*scatter plot*), com a nota de benchmark no eixo horizontal e o preço no eixo vertical: quanto mais à direita e mais abaixo estiver um produto nesse gráfico, melhor o seu custo-benefício. O cálculo de custo-benefício em si é simples — nota de benchmark dividida pelo preço do componente.

**Exemplo — RISC contra CISC, lado a lado.** A comparação mais didática de eficiência energética entre arquiteturas usa um processador RISC de origem móvel (o Apple A18 Pro, originalmente projetado para iPhone e reaproveitado num MacBook) contra um processador CISC de laptop equivalente: o A18 Pro obteve cerca de 4.000 pontos *single-thread* e quase 12.000 pontos *multi-thread*, consumindo entre 4 W e 10 W `[12]`; o processador CISC equivalente consumiu cerca de dez vezes mais potência para entregar uma nota inferior *(modelo CISC específico a documentar pelo autor)*. É esse tipo de comparação, quantificada por benchmark, que explica por que a autonomia de bateria de dispositivos com chips RISC é tão superior — e por que a indústria de desktops e laptops caminha na direção descrita no quadro da Seção 3.2.


!!! warning "Figura pendente"
    captura de tela do PassMark comparando dois processadores lado a lado, com notas single-thread e multi-thread destacadas


!!! warning "Figura pendente"
    gráfico de dispersão (scatter plot) de nota de benchmark por preço, com pontos coloridos por fabricante


## 3.10 Diagnóstico em campo: CPU-Z e HWMonitor

Duas ferramentas de software, de uso corrente entre técnicos, permitem levantar as características de um processador e monitorar seu comportamento sob carga sem a necessidade de desmontar o computador.

**CPU-Z** lê e apresenta, a partir do sistema operacional em execução, informações detalhadas de hardware: nome comercial e codinome do processador, litografia, potência máxima, família de instruções, faixa de clock em operação, tamanho das caches L1/L2/L3, contagem de núcleos e threads, fabricante e versão de BIOS da placa-mãe, configuração de canais de memória (single ou dual channel) e as GPUs disponíveis no sistema. Uma aba específica, chamada *bench*, aplica o teste de benchmark descrito na Seção 3.9 diretamente no computador em uso.

**HWMonitor** é um painel de sensores em tempo real — o equivalente a um monitor cardíaco preso a um atleta correndo em uma esteira. Ele reporta, para cada componente monitorado, os valores atual, mínimo e máximo registrados de temperatura, potência (watts) e outras grandezas.

**Exemplo (demonstração em sala).** Em um notebook equipado com processador Intel i7 de 13ª geração e 32 GB de RAM, em repouso a temperatura do pacote de processamento ficava próxima de 50–59 °C. Ao aplicar um teste de estresse (o mesmo tipo de ferramenta de benchmark da Seção 3.9, usada aqui para forçar a carga máxima), a potência consumida saltou para a faixa de 45–51 W e a temperatura chegou a 96–97 °C — no limite de segurança do fabricante. Nesse ponto, o *thermal throttling* (Seção 3.4) reduziu a potência entregue para cerca de 19 W, e o ciclo de aceleração e desaceleração térmica ficou visível em tempo real no HWMonitor, com a potência oscilando repetidamente entre esses dois extremos. Ao conectar o notebook a um carregador de 100 W, o sistema operacional liberou automaticamente o "modo de alto desempenho" — deixando de gerenciar a bateria — e o processador passou a sustentar potências mais altas por mais tempo antes de sofrer *throttling* novamente. Esse comportamento — desempenho diferente conforme o notebook está ou não conectado à tomada — é característico de notebooks Windows; processadores Apple Silicon, por comparação, mantêm o mesmo desempenho ligados ou desligados da tomada, justamente por serem RISC e demandarem uma fração da potência.

Esse teste de estresse cumpre dupla função de diagnóstico: verifica, simultaneamente, se a **fonte de alimentação** (ou a bateria, no caso de notebooks) é capaz de entregar a potência de pico exigida pelo hardware sob carga máxima — tema do Capítulo 2 —, e se a **refrigeração** é adequada para sustentar essa carga sem superaquecimento. É o procedimento indicado, por exemplo, para validar se a troca de pasta térmica resolveu um quadro de reinicializações intermitentes atribuídas a superaquecimento.


!!! warning "Figura pendente"
    captura de tela do CPU-Z mostrando núcleos, threads, caches e clock de um processador real


!!! warning "Figura pendente"
    captura de tela do HWMonitor durante um teste de estresse, evidenciando o ciclo de thermal throttling


## 3.11 Gargalo e dimensionamento orientado à aplicação

O **gargalo** de um sistema computacional é o componente que, em um dado momento, limita o desempenho do conjunto — e ele não é fixo: ao melhorar um componente, o gargalo simplesmente se desloca para outro ponto do sistema (processador, GPU, armazenamento, memória RAM ou rede).

**Exemplo.** Um usuário que investiu uma quantia elevada em um processador de altíssimo desempenho, mas obteve resultado pior do que o esperado em um jogo específico, ilustra bem o problema: o jogo em questão não estava otimizado para tirar proveito de dezenas de núcleos de processamento, de modo que apenas uma pequena fração dos núcleos disponíveis era efetivamente utilizada, e o restante do investimento em poder computacional ficou ocioso.

**Exemplo.** Em um cenário de download de arquivos em uma rede universitária extremamente rápida, o gargalo real não estava na velocidade da internet, nem na memória RAM, nem no processador, mas na velocidade de escrita do disco rígido (HD) mecânico, incapaz de gravar os dados recebidos na mesma velocidade em que chegavam pela rede. Substituir esse HD por um SSD, de escrita muito mais rápida, não elimina o conceito de gargalo — apenas desloca o ponto de estrangulamento para outro componente do sistema, tipicamente a rede ou o servidor remoto.

**Método de dimensionamento.** A metodologia apresentada ao longo deste capítulo pode ser resumida em cinco passos:

1. Definir a **aplicação** do computador (jogo, estação de trabalho, servidor, uso de escritório etc.), pois é ela que determina quais notas de benchmark (single-thread, multi-thread, GPU) são relevantes.
2. Levantar os requisitos mínimos e recomendados publicados pelo fabricante do software-alvo.
3. Converter esses requisitos descritivos em notas de benchmark comparáveis, usando ferramentas como o PassMark.
4. Pesquisar, dentro do orçamento disponível, componentes cuja nota de benchmark atenda ou supere a meta, comparando custo-benefício entre alternativas de fabricantes e gerações diferentes.
5. Verificar se a escolha de um componente mais potente não desloca o gargalo, ou a exigência de potência, para outro ponto do sistema — tipicamente a fonte de alimentação.

**Exemplo — orçamento de potência de um servidor.** Considere um servidor local com processador de 150 W de consumo máximo, duas GPUs idênticas de 250 W cada, oito discos de armazenamento de 15 W cada, e um consumo combinado de placa-mãe, memória RAM e ventoinhas de 80 W:

| Componente | Consumo máximo |
|---|---|
| Processador | 150 W |
| GPUs (2 × 250 W) | 500 W |
| Discos (8 × 15 W) | 120 W |
| Placa-mãe, RAM e ventoinhas | 80 W |
| **Total de pico** | **850 W** |

Esse valor de 850 W representa o **pico teórico**, isto é, a soma dos consumos máximos individuais — um cenário raro na prática, já que dificilmente todos os componentes operam simultaneamente no limite. Em uso típico, um servidor como esse opera perto de 40% da carga de pico (cerca de 340 W neste exemplo). Retomando o Capítulo 2: a eficiência elétrica de uma fonte ATX é máxima justamente perto de 50% de sua carga nominal. Escolher uma fonte de exatos 850 W deixaria a operação típica numa faixa de baixa eficiência (cerca de 40% de 850 W) e sem margem alguma para upgrades futuros. A escolha tecnicamente correta é uma fonte de capacidade nominal maior — por exemplo, entre 1.000 W e 1.500 W —, de modo que a operação típica do servidor caia próxima da faixa de melhor eficiência da fonte, com folga de segurança para os momentos de pico.

Esse raciocínio fecha o ciclo entre o dimensionamento do processador (e dos demais componentes de processamento) e o dimensionamento da fonte de alimentação: nenhuma escolha de hardware de processamento pode ser tomada de forma isolada da capacidade de entrega de energia do sistema.


!!! warning "Figura pendente"
    tabela de orçamento de potência de um servidor, com a soma dos componentes e a faixa de operação típica marcada sobre a curva de eficiência de uma fonte ATX


---

## 3.12 Manutenção preventiva e corretiva em notebooks

As seções anteriores deste capítulo trataram o processador de forma geral, aplicável tanto a desktops quanto a notebooks. Esta seção fecha o capítulo tratando especificamente do que muda quando o computador em questão é portátil — um recorte que soma, mas não substitui, tudo o que já foi visto sobre refrigeração (livro de Organização e Montagem, Capítulo 4), fonte de alimentação (Capítulo 2) e thermal throttling (Seção 3.4).

### 3.12.1 Bateria: o componente que só o notebook tem

A bateria de um notebook é uma célula de íon de lítio (ou polímero de lítio), sujeita a um processo de degradação química irreversível — diferente de qualquer componente puramente eletrônico já estudado neste livro, que falha por defeito, não por desgaste químico natural. Duas práticas de manutenção preventiva reduzem essa degradação:

- **Evitar ciclos completos de descarga.** Descarregar a bateria até 0% com frequência acelera sua degradação química, de forma análoga (guardadas as proporções) ao desgaste por ciclo de escrita da memória flash (livro de Organização e Montagem, Capítulo 2, §2.12): a bateria de íon de lítio se degrada menos quando mantida, na maior parte do tempo, numa faixa intermediária de carga (por exemplo, entre 20% e 80%) do que quando ciclada repetidamente entre 0% e 100%.
- **Evitar calor prolongado.** A degradação química da bateria acelera com a temperatura — manter o notebook conectado à energia e sob carga de processamento pesada por longos períodos, numa superfície que restrinja a ventilação (uma cama, um sofá), combina justamente os dois fatores que mais aceleram esse desgaste: calor e carga elétrica sustentada.

**Diagnóstico corretivo.** Uma bateria degradada não perde a capacidade de operação instantaneamente — ela perde **capacidade total** (a autonomia cai progressivamente) e pode passar a apresentar inchaço físico, visível como uma leve deformação do chassi ou do touchpad. Um notebook com a bateria fisicamente inchada não deve continuar em uso: o inchaço indica acúmulo de gases internos por decomposição química da célula, um risco real de incêndio caso a célula seja perfurada ou continue sendo carregada.

### 3.12.2 Refrigeração: o desafio do espaço reduzido

A Seção 4.7 do livro de Organização e Montagem apresentou dissipador e ventoinha como os dois componentes do resfriamento a ar. Num notebook, o mesmo princípio se aplica, mas dentro de um volume drasticamente menor — o que tem duas consequências práticas diretas:

- **Acúmulo de poeira em menos espaço, com efeito proporcionalmente maior.** As aletas do dissipador de um notebook são mais finas e mais próximas entre si do que as de um cooler de desktop, para caber no chassi fino. Uma mesma quantidade de poeira acumulada obstrui, proporcionalmente, uma fração muito maior da área de passagem de ar — o que explica por que notebooks tendem a apresentar thermal throttling (Seção 3.4) por acúmulo de poeira num intervalo de tempo menor do que um desktop equivalente. A limpeza preventiva do dissipador e da ventoinha (normalmente com ar comprimido, sem desmontar o notebook por completo) é, por essa razão, mais frequente em notebooks do que em desktops.
- **Repasse de pasta térmica mais delicado.** O procedimento de troca de pasta térmica (livro de Organização e Montagem, Capítulo 4, §4.8) segue o mesmo princípio físico num notebook, mas a desmontagem para acessar o processador é, em geral, mais invasiva: exige remover a placa inteira do chassi em muitos modelos, em vez de apenas liberar um dissipador preso por presilhas externas como num desktop. Por isso, esse é um procedimento tipicamente reservado a um técnico com experiência prévia em desmontagem daquele modelo específico — um manual de serviço (*service manual*) do fabricante, quando disponível, é a referência mais confiável para essa etapa.

### 3.12.3 Componentes soldados: o que muda no diagnóstico por substituição

O Capítulo 1 do livro de Organização e Montagem (§1.11.2) já apresentou o compromisso entre modularidade e portabilidade: memória RAM e, cada vez mais, o próprio processador vêm soldados à placa num notebook. Isso tem uma consequência direta sobre o método de diagnóstico por substituição de módulo (livro de Organização e Montagem, Capítulo 1, §1.6.2): quando o componente suspeito está soldado, não é possível simplesmente trocá-lo por um equivalente para testar a hipótese. As alternativas de diagnóstico corretivo, nesse cenário, são:

- Testar o mesmo sintoma num live USB (Capítulo 3 do livro de Organização e Montagem, §3.9) para isolar hardware de software, já que essa técnica não depende de trocar peça alguma.
- Testar o componente suspeito em outro notebook do mesmo modelo, quando disponível (por exemplo, numa bancada com máquinas de reposição), como forma indireta de aplicar o mesmo princípio de substituição sem precisar desoldar nada.
- Quando a suspeita se confirma e o componente é de fato o defeituoso, a correção deixa de ser uma troca de módulo e passa a ser retrabalho de solda em nível de placa — fora do escopo de manutenção de bancada convencional na maioria dos casos, e que costuma justificar, financeiramente, a comparação entre o custo do reparo e o custo de um equipamento novo (a mesma lógica de obsolescência econômica já discutida a propósito de soquetes de CPU, Seção 3.7).

### 3.12.4 Reparos mais comuns: tela e teclado

Diferente do processador e da memória, tela e teclado são, na prática de bancada, os componentes de notebook mais frequentemente substituídos — não por serem tecnologicamente mais frágeis, mas por estarem fisicamente mais expostos a dano por impacto, derramamento de líquido e desgaste de uso repetitivo. Em praticamente todo modelo de notebook, ambos são módulos destacáveis (presos por parafusos e conectores do tipo *ribbon cable*, uma fita plana de contatos), o que os torna reparáveis por substituição direta mesmo em modelos que soldam processador e RAM — uma peça de reposição compatível, comprada do fabricante ou de um fornecedor terceirizado, restaura o equipamento sem exigir retrabalho de solda.


!!! warning "Figura pendente"
    notebook com a tampa inferior removida, evidenciando bateria, dissipador miniaturizado e conectores tipo *ribbon cable* da tela e do teclado


---

## Síntese do capítulo

Este capítulo apresentou o processador como peça central da tarefa de especificação de um computador: a distinção entre arquiteturas RISC e CISC, os limites físicos impostos pela litografia e pelo calor, a organização interna de um processador multicore (núcleos, threads, cache e pipeline), a relação entre resolução de vídeo e demanda computacional, e a metodologia de benchmark que transforma requisitos descritivos de software em notas numéricas comparáveis entre fabricantes, arquiteturas e gerações diferentes. O exemplo de orçamento de potência da Seção 3.11 retoma diretamente o dimensionamento de fonte de alimentação estudado no Capítulo 2, evidenciando que a escolha de processador, GPU e armazenamento nunca é independente da capacidade de entrega de energia do sistema. O capítulo fechou aplicando esses mesmos princípios — refrigeração, energia, diagnóstico por substituição — ao caso específico do notebook, cujo espaço reduzido e componentes soldados exigem adaptações do método geral. Os conceitos de diagnóstico por eliminação de módulos, teste de estresse e identificação de gargalo, exercitados aqui com CPU-Z e HWMonitor, serão retomados e sistematizados no Capítulo 4, dedicado ao atendimento e suporte técnico.

---

## Referências

1. PHORONIX. "The Linux Kernel May Finally Phase Out Intel i486 CPU Support." Disponível em: <https://www.phoronix.com/news/Intel-i486-Linux-Possible-Drop>; THE REGISTER. Cobertura relacionada. Disponível em: <https://forums.theregister.com/forum/all/2025/05/07/linux_kernel_drops_486/>.
2. NVIDIA NEWSROOM/GEFORCE NEWS. "NVIDIA at COMPUTEX 2026: NVIDIA RTX Spark..." Disponível em: <https://www.nvidia.com/en-us/geforce/news/computex-2026-nvidia-geforce-rtx-announcements/>; TOM'S HARDWARE. "Nvidia unveils RTX Spark Superchip for laptops and desktop PCs at Computex 2026." Disponível em: <https://www.tomshardware.com/laptops/nvidia-unveils-rtx-spark-superchip-at-computex-2026-new-platform-promises-to-turn-windows-into-an-agentic-ai-os-with-arm-cpu-blackwell-gpu-and-128gb-unified-memory>.
3. Dados de litografia por fabricante/arquitetura conferidos via TechInsights/TrendForce/roteiro de nós de processo TSMC; cobertura em notebookcheck.net e techpowerup.com.
4. NATIONAL INSTITUTE OF STANDARDS AND TECHNOLOGY (NIST). "A sheet of paper is about 100,000 nanometers thick." Disponível em: <https://x.com/NIST/status/1792590000179064919>; NATIONAL NANOTECHNOLOGY INITIATIVE. "Just How Small Is Nano?" Disponível em: <https://www.nano.gov/about-nanotechnology/just-how-small-is-nano/>.
5. TOM'S HARDWARE. "Hot Spot: How Modern Processors Cope With Heat Emergencies." Disponível em: <https://www.tomshardware.com/reviews/hot-spot,365-4.html>.
6. CHANNEL INSIDER. "Intel Cancels 4-GHz Pentium 4." Disponível em: <https://www.channelinsider.com/news-and-trends/intel-cancels-4-ghz-pentium-4/>; PC PERSPECTIVE. "Intel Cancels the 4GHz Prescott." Disponível em: <https://pcper.com/2004/10/intel-cancels-the-4ghz-prescott/>.
7. INTEL NEWSROOM. "Dual Core Era Begins, PC Makers Start Selling Intel-Based PCs." 18 abr. 2005. Disponível em: <https://www.intel.com/pressroom/archive/releases/2005/20050418comp.htm>.
8. Documentação técnica geral sobre segmentação de produto e *binning* de CPUs (Intel/AMD); artigos técnicos sobre *yield* de semicondutores — fonte específica a confirmar pelo autor.
9. INTEL. Especificações oficiais, "Intel® Core™ i5-12400F Processor (18M Cache, up to 4.40 GHz)." Disponível em: <https://www.intel.com/content/www/us/en/products/sku/134587/intel-core-i512400f-processor-18m-cache-up-to-4-40-ghz/specifications.html>.
10. PATTERSON, David A.; HENNESSY, John L. *Computer Organization and Design: The Hardware/Software Interface* — RISC-V Edition. Cambridge, MA: Morgan Kaufmann, 2017. ISBN 978-0-12-812275-4.
11. TECHPOWERUP. "AMD Announces Socket AM5 Longevity till 2029." Disponível em: <https://www.techpowerup.com/349541/amd-announces-socket-am5-longevity-till-2029>; VIDEOCARDZ. Disponível em: <https://videocardz.com/newz/amd-extends-am5-socket-support-through-2029-with-future-ryzen-cpus>.
12. PASSMARK/CPU BENCHMARK. "Apple A18 Pro (MacBook Neo) Benchmark." Disponível em: <https://www.cpubenchmark.net/cpu.php?cpu=Apple+A18+Pro+%28MacBook+Neo%29&id=7232>.
