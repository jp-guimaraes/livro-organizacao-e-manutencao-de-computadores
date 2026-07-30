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

- **CISC** (*Complex Instruction Set Computer*) — conjunto de instruções complexo. Seu grande diferencial é a **retrocompatibilidade**: um processador CISC lançado hoje ainda é capaz de executar instruções presentes em processadores lançados décadas atrás. Essa característica gera discussões reais na engenharia de software — por exemplo, entre os desenvolvedores do núcleo (*kernel*) do sistema operacional Linux há debates recorrentes sobre manter, ou não, suporte a instruções herdadas de arquiteturas de computadores como o 386 e o 486, da década de 1990.
- **RISC** (*Reduced Instruction Set Computer*) — conjunto de instruções reduzido e simplificado. Instruções mais simples exigem hardware mais simples, o que resulta em maior eficiência energética (mais desempenho por watt consumido) em comparação a um processador CISC equivalente.

**Exemplo.** Processadores da família Pentium 2, Pentium 3, Atom, e as diversas gerações da linha Ryzen são exemplos de processadores CISC (arquitetura x86), demonstrando décadas de retrocompatibilidade dentro dessa família.

Por muito tempo, essa escolha de arquitetura era irrelevante para o técnico de manutenção de desktops e notebooks: processadores RISC ficavam restritos a smartphones, onde a eficiência energética é decisiva para a autonomia de bateria. Esse cenário mudou. Hoje, processadores RISC (como os chips Apple Silicon e os processadores Snapdragon) também competem no mercado de desktops e laptops. Consequentemente, ao especificar computadores portáteis — por exemplo, para uma equipe de professores que leva o equipamento para dar aula fora do laboratório —, a arquitetura passa a ser uma escolha técnica relevante: um computador de arquitetura CISC de alto desempenho pode exigir tantos acessórios de suporte (fonte robusta, ventilação adicional) que se torna impraticável para uso móvel, enquanto um equivalente RISC entrega autonomia de bateria muito superior.

> **Atualidade de mercado — o chip RISC da NVIDIA para computação de IA local**
>
> Em 1º de junho de 2026, durante a feira Computex em Taipei, a NVIDIA — historicamente fabricante de placas de vídeo GeForce — anunciou o **RTX Spark**, seu primeiro chip de arquitetura RISC voltado a computadores pessoais, com memória unificada (nos moldes do que a Apple já pratica em seus chips Apple Silicon) e capacidade de até 128 GB de memória compartilhada entre CPU, GPU e NPU. O CEO da empresa, Jensen Huang, chamou o lançamento de "reinvenção do computador".
>
> A novidade central não é apenas a arquitetura RISC em si, mas o fato de que o chip foi projetado com instruções voltadas ao chamado *loop agêntico*: da mesma forma que o ciclo clássico de busca–decodificação–execução (Seção 3.6) fundamenta o funcionamento de qualquer CPU, o RTX Spark inclui, em nível de processador, suporte a um ciclo de raciocínio–execução–validação voltado à execução local de agentes de inteligência artificial (assistentes de programação e automação que operam diretamente na máquina do usuário, sem depender inteiramente de processamento em nuvem).
>
> O chip já nasce com parcerias fechadas com fabricantes de notebooks como Lenovo, HP, Dell (Microsoft Surface), Asus e MSI, colocando pressão competitiva simultânea sobre Intel, AMD e Apple. Trata-se de uma notícia de mercado recente — o leitor deste livro deve tratá-la como indicativo de tendência, não como fato estático: a configuração exata de produtos comerciais baseados nesse chip deve ser verificada em fontes atualizadas no momento da leitura.

## 3.3 A Lei de Moore e os limites físicos da litografia

Historicamente, observou-se que os processadores lançados pela Intel dobravam a quantidade de transistores em relação ao modelo anterior a cada aproximadamente dois anos. Essa observação empírica foi formalizada como meta de desenvolvimento da indústria e ficou conhecida como **lei de Moore**.

Como o transistor é a unidade fundamental de construção de portas lógicas, circuitos aritméticos, circuitos de controle e circuitos de memória, um processador com o dobro de transistores tende a oferecer maior poder computacional. O gráfico histórico de contagem de transistores por chip, de 1970 a meados da década de 2010, mostra crescimento de milhares para dezenas de bilhões de transistores por chip.

**Analogia.** Se um saco comporta dez bolas de um determinado tamanho e a meta passa a ser encaixar vinte bolas no mesmo saco, a única solução é diminuir o tamanho das bolas. Da mesma forma, para dobrar a contagem de transistores mantendo o tamanho físico do chip aproximadamente constante, a indústria precisou miniaturizar continuamente os transistores — processo que trouxe a fabricação de semicondutores à escala dos **nanômetros** (1 nm = 10⁻⁹ m, um bilionésimo de metro; a título de comparação, uma folha de papel comum tem cerca de 100 nm de espessura).

| Fabricante/arquitetura | Litografia aproximada |
|---|---|
| Intel, 12ª geração | 10 nm |
| AMD Zen 3 (Ryzen série 5000) | 7 nm |
| AMD Zen 4 (Ryzen série 7000) | 5–6 nm |
| Apple Silicon (M1) | 5 nm |
| Qualcomm Snapdragon (gerações recentes) | ~3 nm |

Reduzir a litografia traz dois benefícios simultâneos e vinculados por física básica: como a velocidade de deslocamento do elétron é aproximadamente constante, diminuir a distância física que o elétron percorre entre terminais do transistor reduz o tempo de processamento (maior velocidade) e reduz a perda de energia por efeito Joule (maior eficiência energética). Um processador fabricado numa litografia menor é, por concepção de projeto, mais rápido e mais eficiente do que um equivalente fabricado numa litografia maior.

**O processo de fabricação.** O silício, elemento com quatro elétrons na camada de valência, é abundante — extraído da areia, não de jazidas raras — e forma cristais estáveis por ligação covalente entre átomos vizinhos. Após purificado e cristalizado, o silício é fatiado em discos finos chamados *wafers*. Sobre o *wafer*, um processo óptico de precisão chamado **litografia** projeta, com o auxílio de lasers e lentes especiais, a imagem do circuito do processador, "queimando" no silício o desenho dos transistores já interligados em portas lógicas. O processo de **dopagem** (introdução controlada de impurezas, como boro, na estrutura cristalina) cria as regiões de tipo N e tipo P que formam diodos e transistores. Concluída a gravação, o *wafer* é fatiado em unidades individuais (os *dies*), que recebem encapsulamento protetor e se tornam o chip vendido no mercado, no formato que se conecta ao soquete da placa-mãe.

Historicamente, a Intel controlava tanto o projeto quanto a fabricação (fundição) de seus próprios chips. Outros fabricantes — AMD, Apple, Qualcomm — projetam seus chips mas terceirizam a fabricação para fundições especializadas, principalmente a TSMC (*Taiwan Semiconductor Manufacturing Company*), sediada em Taiwan. A dificuldade da Intel em reduzir sua própria litografia abaixo de 10 nm é um fator relevante da perda de competitividade da empresa nos últimos anos, a ponto de ela também ter passado a recorrer a fundições terceirizadas para parte de sua produção. A concentração geográfica dessa capacidade de fabricação de semicondutores de ponta em Taiwan é, adicionalmente, um fator de tensão geopolítica relevante, dado o contexto de disputa territorial entre Taiwan e a China — um ponto que tem desdobramentos diretos sobre preço e disponibilidade de chips no mercado global.


!!! warning "Figura pendente"
    fotografia de um wafer de silício antes e depois do processo de litografia


!!! warning "Figura pendente"
    gráfico da contagem de transistores por chip ao longo do tempo, 1970–2016


## 3.4 Calor, thermal throttling e o fim do núcleo único

Alocar mais transistores no mesmo espaço físico tem uma consequência inevitável: mais calor gerado na mesma área. Processadores das gerações mais antigas (até o início dos anos 2000) não possuíam qualquer proteção térmica: sem um dissipador de calor (*cooler*) adequado, o chip aquecia progressivamente até literalmente derreter, soltar fumaça ou pegar fogo — comportamento registrado em vídeos de demonstração da época com processadores Pentium 4 e AMD.

Os processadores modernos resolvem esse risco com o mecanismo de **thermal throttling** (acelerador térmico): ao detectar que a temperatura se aproxima de um limite pré-definido, o processador reduz automaticamente sua frequência de processamento; ao esfriar, ele volta a acelerar. O resultado é um ciclo contínuo de aceleração e desaceleração, governado pela temperatura.

**Exemplo (demonstração em sala).** Um vídeo popular mostra um processador sem *cooler*, com pasta térmica substituída por um ovo, sendo estressado por um software de *benchmark*: a temperatura da CPU sobe de aproximadamente 65 °C para 100 °C, e o ovo é efetivamente cozinhado pelo calor do encapsulamento — evidência de que a temperatura da superfície do processador atinge valores próximos aos de uma frigideira. Outro vídeo, de um Pentium 4 executando um jogo, mostra a taxa de quadros por segundo (FPS) caindo de 60 para 15 assim que o *cooler* é removido — o jogo trava progressivamente à medida que o *thermal throttling* reduz o processamento disponível — e volta a subir assim que o *cooler* é reconectado.

O *thermal throttling* deixou de ser apenas uma medida de emergência e passa a ser usado como característica de projeto: um MacBook sem ventoinha reduz o clock progressivamente conforme aquece, enquanto um MacBook Pro com ventoinha ativa consegue sustentar clocks mais altos por mais tempo, adiando o momento do *throttling*.

**O limite que originou o multicore.** No início dos anos 2000, a Intel chegou a planejar um Pentium 4 de 4 GHz, mas cancelou o lançamento: a dissipação de calor necessária tornava o produto inviável para os computadores da época. A solução encontrada pela indústria não foi continuar aumentando a densidade de transistores num único núcleo, mas **duplicar o número de núcleos de processamento** dentro do mesmo encapsulamento — cada um mais simples e mais frio do que seria um único núcleo hipertrofiado. Nasceu assim a era **multicore**, por volta de 2005 (marco documentado, entre outras fontes, em artigo publicado naquele ano pela revista da IEEE — *Institute of Electrical and Electronic Engineers*). Essa mudança de direção arquitetural se mantém até hoje: não houve retorno ao paradigma de núcleo único, apenas a adição de novas unidades de processamento especializadas (GPU, NPU), tratadas ao final deste capítulo.


!!! warning "Figura pendente"
    gráfico comparando temperatura e FPS de um processador com e sem cooler durante um jogo


## 3.5 A era multicore: núcleos, cache e hyper-threading

Um **core** (núcleo) é uma unidade de processamento física — hardware. Um processador multicore contém, dentro de um único encapsulamento, múltiplas cópias completas da estrutura de processamento (unidade lógico-aritmética, registradores, unidades de controle de fluxo), cada uma com sua própria memória cache de nível 1 (L1) e nível 2 (L2). Externamente aos núcleos, mas ainda dentro do chip, fica a cache de nível 3 (L3), compartilhada entre todos os núcleos — funcionando como uma mesa de trabalho comum para a troca de dados entre eles quando uma tarefa é dividida entre múltiplos núcleos.

**Nota sobre controle de qualidade.** Nem todo processador de uma mesma linha de produção nasce igual: após a fabricação, cada chip passa por uma bancada de testes. Se todos os núcleos de um chip projetado com quatro núcleos passam no controle de qualidade, ele é vendido como a linha superior (por exemplo, um "i7"); se apenas parte dos núcleos passa, os núcleos defeituosos são desabilitados e o mesmo chip é vendido como um produto de linha inferior (um "i5" ou "i3"). Não se trata de um projeto diferente, mas do aproveitamento comercial de chips que não atingiram a especificação máxima.

Uma **thread**, por sua vez, é uma unidade lógica — uma simulação em software da existência de mais processadores do que os fisicamente presentes. A tecnologia responsável por essa simulação é chamada de **hyper-threading** (nomenclatura da Intel) ou **SMT**, *simultaneous multi-threading* (nomenclatura da AMD). Um núcleo físico com hyper-threading de grau 2 é enxergado pelo sistema operacional como dois processadores lógicos.

**Analogia.** Um único atendente de balcão que tanto cobra quanto embala a compra do cliente está, na prática, desempenhando duas tarefas — mas continua sendo uma única pessoa fazendo alternadamente uma coisa e outra, aproveitando os intervalos ociosos de uma tarefa para avançar a outra. É exatamente esse aproveitamento de tempo ocioso do hardware, viabilizado pela técnica de pipeline (Seção 3.6), que permite a um núcleo físico simular o comportamento de dois núcleos lógicos.

**Exemplo.** Um anúncio real de processador Intel Core 5 (12ª geração), modelo 12400F, especifica 6 núcleos físicos (*cores*) com hyper-threading, totalizando 12 threads — ou seja, o sistema operacional identifica 12 processadores lógicos disponíveis, embora fisicamente existam apenas 6.

Essa complexidade, no entanto, tem um custo que sobe para as camadas de software: programação paralela (a técnica de dividir um algoritmo para ser executado simultaneamente em múltiplos núcleos) é uma disciplina distinta e mais difícil do que a programação sequencial convencional, e a maioria dos programas aplicativos comuns não é otimizada para tirar proveito de mais do que quatro a seis núcleos simultâneos. A consequência prática desse descompasso — poder computacional disponível, mas ocioso — é discutida na Seção 3.11.


!!! warning "Figura pendente"
    fotografia (die shot) de um processador com quatro núcleos, cache L1/L2 por núcleo e cache L3 compartilhada identificados


## 3.6 Pipeline: sobreposição de estágios de execução

O ciclo básico de funcionamento de uma CPU consiste em três etapas repetidas continuamente: **busca** da instrução na memória, **decodificação** dessa instrução e **execução** da instrução decodificada. A técnica de **pipeline** consiste em sobrepor essas etapas para diferentes instruções simultaneamente, em vez de executar o ciclo completo de uma instrução antes de iniciar a próxima.

**Analogia.** Considere uma lavanderia com quatro estações — lavar, secar, dobrar e guardar —, em que cada etapa leva quatro horas. Numa execução sem pipeline, o ciclo completo (lavar → secar → dobrar → guardar) leva 4 horas, e o próximo ciclo só começa depois que o anterior termina inteiramente: dois ciclos completos consumiriam 16 horas (4 etapas × 4 horas × 2 ciclos), com cada máquina ficando ociosa na maior parte do tempo. Com pipeline, assim que a máquina de lavar termina uma carga e a transfere para a secadora, ela já recebe uma nova carga de roupa suja — nenhum equipamento fica parado. Nesse esquema, em sete horas obtêm-se quatro ciclos completos de saída, contra os dezesseis necessários sem sobreposição — um ganho de mais do que o dobro de produtividade utilizando exatamente o mesmo hardware, apenas evitando ociosidade.

É essa mesma lógica de aproveitamento de estágios ociosos do circuito de busca–decodificação–execução que permite ao hyper-threading (Seção 3.5) fazer um único núcleo físico atender a duas instruções em estágios diferentes do pipeline ao mesmo tempo, simulando dois processadores lógicos. O termo *pipeline* não é exclusivo da arquitetura de computadores — é usado de forma equivalente em engenharia de produção industrial para descrever qualquer processo organizado em estágios reaproveitáveis e encadeados.


!!! warning "Figura pendente"
    diagrama de linha do tempo mostrando quatro estágios de pipeline sobrepostos ao longo de sete unidades de tempo


## 3.7 Soquete, geração e compatibilidade de mercado

O **soquete** é o conector físico da placa-mãe onde o processador é encaixado. Cada geração de processador é compatível apenas com um conjunto específico de soquetes: uma placa-mãe fabricada para processadores Intel não aceita processadores AMD, e vice-versa — e mesmo dentro de um mesmo fabricante, gerações diferentes de processador frequentemente exigem soquetes diferentes.

Esse detalhe tem consequência direta para o trabalho de manutenção. Historicamente, a AMD tem mantido o mesmo soquete por múltiplas gerações de processador — o soquete AM4 atendeu várias gerações consecutivas de Ryzen, e o soquete AM5, lançado mais recentemente, teve seu suporte estendido pela AMD até o ano de 2029. Isso significa que uma placa-mãe AM5 fabricada hoje continuará aceitando processadores lançados anos depois. A Intel, por sua vez, tende a alterar o soquete a cada uma ou duas gerações.

**Consequência prática para o técnico.** Diante de uma placa-mãe com defeito comprovado, cujo processador continua funcional, a estratégia de diagnóstico modular (transferir o processador para outra placa-mãe compatível) é significativamente mais viável em um ecossistema AMD — em que placas-mãe compatíveis com processadores mais antigos continuam disponíveis no mercado — do que em um ecossistema Intel, no qual encontrar uma placa-mãe compatível com um processador de poucos anos atrás pode ser difícil e caro o suficiente para tornar mais econômico descartar o processador funcional e comprar um conjunto novo (processador e placa-mãe).

Esse tipo de escolha de projeto — que reduz a vida útil economicamente viável de um componente ainda funcional — se aproxima do fenômeno mais amplo de **obsolescência programada**, observável em outras indústrias (por exemplo, cartuchos de impressora com contadores de página que interrompem o funcionamento após um número predefinido de impressões, mesmo com tinta disponível). Do ponto de vista puramente técnico, isso reforça por que a análise de soquete e longevidade de plataforma deve fazer parte da recomendação de compra ao cliente, e não apenas a comparação de desempenho bruto — que é tratada, com apoio de benchmark, na Seção 3.9. Cabe notar, entretanto, que a Intel frequentemente compensa essa desvantagem de longevidade praticando preços mais agressivos, de modo que a escolha entre os dois fabricantes é sempre uma decisão de custo-benefício, não uma resposta única.


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

**Analogia.** Um dinamômetro automotivo submete motores diferentes ao mesmo teste padronizado, produzindo uma medida comparável (cavalos de potência, torque). Da mesma forma, o Enem submete candidatos de escolas e contextos diferentes à mesma prova, nas mesmas condições de tempo e sem consulta, produzindo uma nota comparável entre eles. O benchmark de hardware cumpre exatamente esse papel para CPUs e GPUs.

**As duas notas de CPU.** Ferramentas de benchmark para processador (a mais usada em sala é o PassMark, cujo software CPU-Z é abordado na Seção 3.10) produzem duas notas distintas:

- **Single-thread rating** — desempenho de um único núcleo trabalhando sozinho.
- **Multi-thread rating** — desempenho de todos os núcleos e threads trabalhando simultaneamente.

Essa distinção é decisiva na prática: a maioria dos softwares de uso comum (planilhas, navegadores) e a maioria dos jogos não são otimizados para dezenas de núcleos simultâneos — eles dependem, sobretudo, do desempenho *single-thread*. Cargas de trabalho de servidor, renderização e simulação, por outro lado, se beneficiam diretamente do desempenho *multi-thread*.

**Exemplo.** Uma comparação real conduzida em sala, entre um processador Intel (lançado em 2015) e um processador AMD Ryzen (lançado em 2017), ilustra o ponto: o processador Intel obteve nota *single-thread* de aproximadamente 2.315 pontos contra aproximadamente 2.000 pontos do AMD (uma diferença de cerca de 10% a favor da Intel); já na nota *multi-thread*, o AMD obteve cerca de 12.000 pontos contra 6.305 pontos da Intel — quase o dobro. A conclusão prática: para um computador cuja finalidade é jogar (dependente de desempenho *single-thread*), o processador Intel seria a escolha mais adequada, apesar de mais antigo; para um servidor cuja carga se distribui por múltiplas threads simultâneas, o AMD seria a escolha correta. O benchmark permite essa comparação mesmo entre processadores de fabricantes, arquiteturas, gerações, caches e potências diferentes, porque ambos foram submetidos exatamente à mesma prova.

**Ganho geracional.** Comparações de longo prazo dentro de uma mesma linha de produto evidenciam o efeito acumulado da miniaturização (Seção 3.3) e de melhorias de arquitetura. Um exemplo apresentado em aula, de uma mesma família de processador ao longo de gerações sucessivas: em 2017, um modelo de 65 W entregava cerca de 2.000 pontos *single-thread*; em 2018, a geração seguinte, operando a 105 W, chegou a cerca de 2.400 pontos; já em 2024, uma geração mais recente voltou a operar a 65 W (a mesma potência de 2017) e alcançou aproximadamente 4.500 pontos *single-thread* e cerca de 30.000 pontos *multi-thread* — mais do que o dobro do desempenho *single-thread* de sete anos antes, com potência igual à do ponto de partida. Esse é o retrato numérico do que a Seção 3.3 descreve de forma qualitativa: litografias menores entregam, ao mesmo tempo, mais desempenho e mais eficiência energética.

**Benchmark de GPU e custo-benefício.** O mesmo tipo de ferramenta existe para placas de vídeo. Ao comparar duas GPUs reais de gerações próximas, por exemplo, uma custando cerca de R$ 2.890 com nota de aproximadamente 22.000 pontos, contra outra custando cerca de R$ 4.600 com nota de aproximadamente 28.000 pontos, o técnico consegue avaliar objetivamente se o ganho de desempenho (cerca de 27%) justifica o acréscimo de custo (cerca de 60%) para aquele cliente específico — e ainda precisa verificar se a fonte de alimentação do computador suporta a potência adicional exigida pela placa mais cara, sob risco de o upgrade da GPU obrigar também um upgrade da fonte.

Uma forma particularmente útil de visualizar essas comparações é o gráfico de dispersão (*scatter plot*), com a nota de benchmark no eixo horizontal e o preço no eixo vertical: quanto mais à direita e mais abaixo estiver um produto nesse gráfico, melhor o seu custo-benefício. O cálculo de custo-benefício em si é simples — nota de benchmark dividida pelo preço do componente.

**Exemplo — RISC contra CISC, lado a lado.** A comparação mais didática de eficiência energética entre arquiteturas usa um processador RISC de origem móvel (o Apple A18 Pro, originalmente projetado para iPhone e reaproveitado num MacBook) contra um processador CISC de laptop equivalente: o A18 Pro obteve cerca de 4.000 pontos *single-thread* e quase 12.000 pontos *multi-thread*, consumindo entre 4 W e 10 W; o processador CISC equivalente consumiu cerca de dez vezes mais potência para entregar uma nota inferior. É esse tipo de comparação, quantificada por benchmark, que explica por que a autonomia de bateria de dispositivos com chips RISC é tão superior — e por que a indústria de desktops e laptops caminha na direção descrita no quadro da Seção 3.2.


!!! warning "Figura pendente"
    captura de tela do PassMark comparando dois processadores lado a lado, com notas single-thread e multi-thread destacadas


!!! warning "Figura pendente"
    gráfico de dispersão (scatter plot) de nota de benchmark por preço, com pontos coloridos por fabricante


## 3.10 Diagnóstico em campo: CPU-Z e HWMonitor

Duas ferramentas de software, de uso corrente entre técnicos, permitem levantar as características de um processador e monitorar seu comportamento sob carga sem a necessidade de desmontar o computador.

**CPU-Z** lê e apresenta, a partir do sistema operacional em execução, informações detalhadas de hardware: nome comercial e codinome do processador, litografia, potência máxima, família de instruções, faixa de clock em operação, tamanho das caches L1/L2/L3, contagem de núcleos e threads, fabricante e versão de BIOS da placa-mãe, configuração de canais de memória (single ou dual channel) e as GPUs disponíveis no sistema. Uma aba específica, chamada *bench*, aplica o teste de benchmark descrito na Seção 3.9 diretamente no computador em uso.

**Analogia.** Processadores híbridos modernos combinam núcleos de desempenho (*performance cores*, ou P-cores) e núcleos econômicos (*efficient cores*, ou E-cores) — uma arquitetura adotada pela Intel, entre outros, em resposta à eficiência energética típica de processadores RISC. A diferença entre os dois tipos de núcleo é comparável à diferença entre um carro 1.0 (mais econômico, menos potente) e um carro 2.0 (mais potente, mais consumo): o sistema operacional aloca tarefas leves (como notificações e aplicativos em segundo plano) aos núcleos econômicos, reservando os núcleos de desempenho para tarefas que realmente demandam potência, como jogos.

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

## Síntese do capítulo

Este capítulo apresentou o processador como peça central da tarefa de especificação de um computador: a distinção entre arquiteturas RISC e CISC, os limites físicos impostos pela litografia e pelo calor, a organização interna de um processador multicore (núcleos, threads, cache e pipeline), a relação entre resolução de vídeo e demanda computacional, e a metodologia de benchmark que transforma requisitos descritivos de software em notas numéricas comparáveis entre fabricantes, arquiteturas e gerações diferentes. O exemplo de orçamento de potência da Seção 3.11 retoma diretamente o dimensionamento de fonte de alimentação estudado no Capítulo 2, evidenciando que a escolha de processador, GPU e armazenamento nunca é independente da capacidade de entrega de energia do sistema. Os conceitos de diagnóstico por eliminação de módulos, teste de estresse e identificação de gargalo, exercitados aqui com CPU-Z e HWMonitor, serão retomados e sistematizados no Capítulo 4, dedicado ao atendimento e suporte técnico.
