# Capítulo 4 — Suporte e Gestão de Serviços

Neste capítulo você vai estudar a organização do atendimento técnico ao usuário: a central de serviços (*service desk*) como ponto único de entrada das demandas, a categorização de chamados em evento, incidente e solicitação, os critérios de priorização por impacto e urgência, os níveis de suporte e o custo crescente de cada escalonamento, e as ferramentas e princípios éticos que regem o acesso remoto a máquinas de terceiros.

---

## 4.1 Central de serviços (*service desk*)

Quando um problema técnico surge — por exemplo, a internet de um laboratório para de funcionar —, o primeiro passo do diagnóstico é distinguir se a causa é **local** (a máquina específica) ou de **infraestrutura** (algo fora do alcance daquele posto de trabalho, que depende do setor de Tecnologia da Informação). Uma vez identificado que o problema é de infraestrutura, a demanda deve ser encaminhada a um ponto único de contato.

Esse ponto único é a **central de serviços**, também chamada de *service desk*. Trata-se de um hub para onde convergem todas as demandas de um setor ou organização, e a partir do qual elas recebem tratamento e encaminhamento adequados. Em vez de o usuário procurar diretamente um técnico específico, toda solicitação passa por esse canal centralizado, que a registra, categoriza e distribui.

**Exemplo.** Um caso amplamente divulgado na imprensa e em redes sociais brasileiras ilustra o que ocorre quando uma central de serviços é sobrecarregada ou mal gerida: uma operadora de internet teve sua central de atendimento completamente saturada por um volume de chamados muito acima de sua capacidade, a ponto de clientes não conseguirem contato nem para suporte técnico nem para cancelamento de serviço — configurando, inclusive, violação de direitos do consumidor e motivando fiscalização de órgãos de defesa do consumidor. O episódio mostra que a central de serviços não é um detalhe administrativo: é a peça que determina se a organização consegue, de fato, responder às demandas de seus usuários.

No âmbito do IFRN, a central de serviços é operada pelo sistema **SUAP** (Sistema Unificado de Administração Pública), tratado em detalhe na Seção 4.6.


!!! warning "Figura pendente"
    fluxograma — usuário identifica problema → local ou infraestrutura? → abertura de chamado na central de serviços → triagem


## 4.2 Categorização das demandas: evento, incidente e solicitação

Nem toda demanda que chega a uma central de serviços tem a mesma natureza. A prática de gestão de serviços de TI — estudada em profundidade em cursos de Administração e Engenharia de Produção, sob frameworks como o ITIL (*Information Technology Infrastructure Library*, hoje em sua versão 4) — classifica as demandas em três categorias.

### 4.2.1 Evento

Um **evento** é uma ocorrência detectável que **não interrompe** o trabalho do usuário, mas gera um sinal de atenção. Está fortemente associado à manutenção preventiva: o evento é o alerta que permite agir antes que um problema real se manifeste.

**Exemplo.** O uso de CPU de um servidor atinge 80% de ocupação; o nível de tinta ou toner de uma impressora cai abaixo de determinado percentual e o equipamento emite uma notificação; uma rotina de backup semanal projeta que o disco de armazenamento ficará sem espaço disponível dali a três semanas. Em nenhum desses casos o usuário deixou de trabalhar — mas em todos eles existe um sinal que, se ignorado, tende a se converter em um problema real.

### 4.2.2 Incidente

Um **incidente** é uma interrupção não planejada ou uma redução da qualidade de um serviço de TI. Ao contrário do evento, o incidente **interrompe** o fluxo de trabalho do usuário e está associado à manutenção corretiva: exige uma ação de resposta, geralmente com maior urgência.

**Exemplo.** O computador não liga; a impressora trava; o usuário perde a conexão com a internet. Em todos esses casos, alguém que precisa de um recurso computacional está impedido de usá-lo.

### 4.2.3 Solicitação

Uma **solicitação de serviço** é um pedido previsível, que não decorre de uma falha. Pode ser periódica ou não, mas segue o fluxo padrão de atendimento, sem a urgência associada a um incidente.

**Exemplo.** Recuperar uma senha esquecida; solicitar a instalação de uma impressora nova; pedir a expansão do sinal de Wi-Fi em um setor; solicitar a troca da conexão de um computador de rede sem fio para rede cabeada; os procedimentos de matrícula e criação de e-mail institucional de um aluno recém-ingresso.

### 4.2.4 Quando uma solicitação vira incidente

A fronteira entre as três categorias depende do critério de **interrupção do fluxo do usuário**, e não apenas da natureza superficial do pedido. Um exemplo recorrente: solicitar a substituição de um mouse com defeito é, em princípio, uma solicitação de serviço. Mas se aquele mouse é a ferramenta de trabalho de um funcionário que, sem ele, não consegue produzir, a demanda deixa de ser uma solicitação comum e passa a ser tratada como **incidente** — porque há um custo real (o salário daquela pessoa, parada) sendo desperdiçado a cada minuto sem solução.

A tabela a seguir resume os três critérios de categorização:

| Categoria | Interrompe o trabalho do usuário? | Tipo de manutenção associada | Exemplos |
|---|---|---|---|
| Evento | Não | Preventiva | CPU do servidor em 80%; toner baixo; projeção de disco cheio |
| Incidente | Sim | Corretiva | Computador não liga; impressora travada; sem internet |
| Solicitação | Não (em geral) | Preventiva ou corretiva, conforme o caso | Redefinição de senha; instalação de software; expansão de Wi-Fi |

## 4.3 Priorização: impacto, urgência e prioridade

Como as demandas de uma central de serviços não chegam de forma organizada nem podem ser todas atendidas simultaneamente, é preciso um critério para decidir a ordem de atendimento. Esse critério não é a ordem de chegada — nem todo incidente é atendido na sequência em que foi registrado. O que determina a ordem de atendimento é a **prioridade**, calculada a partir de dois fatores:

- **Impacto**: quantas pessoas são afetadas pelo problema e quão crítico é o serviço afetado.
- **Urgência**: quão rapidamente a situação precisa ser resolvida antes de gerar prejuízo maior.

A combinação desses dois fatores define a prioridade de atendimento:

| Impacto \ Urgência | Urgência baixa | Urgência alta |
|---|---|---|
| **Impacto baixo** | Prioridade baixa — ex.: substituir teclados antigos, sujos, mas ainda funcionais | Prioridade moderada |
| **Impacto alto** | Prioridade alta — ex.: trocar cadeiras que causam problema de postura para toda uma equipe | Prioridade crítica — ex.: internet caiu; monitor quebrou; servidor da secretaria parou no dia da matrícula |

**Exemplo.** Um servidor da secretaria escolar cair justamente no dia de matrícula tem impacto alto (afeta um processo crítico e um grande volume de pessoas) e urgência alta (o processo tem prazo), resultando em prioridade crítica: todo o trabalho em andamento é interrompido para atender essa demanda primeiro. Já a ausência do papel de parede padrão em um computador é um problema de impacto e urgência baixos, que pode aguardar.

Quando não existe um sistema formal de chamados — como ocorre em equipes pequenas de suporte —, a definição de prioridade cabe ao critério do supervisor responsável, que aplica a política da organização mesmo sem registrá-la formalmente em um sistema. Um técnico que ingressa em uma empresa recebe, na fase de treinamento, a orientação sobre qual política de priorização deve seguir.


!!! warning "Figura pendente"
    matriz impacto x urgência com quadrantes de prioridade destacados


## 4.4 Níveis de suporte e o custo do atendimento

Uma vez aberto, o chamado (também chamado de **ticket** — o nome remete à ideia de "etiquetar" a demanda, para que ela possa ser acompanhada enquanto passa pelas etapas de tratamento) segue por níveis de suporte sucessivos, até ser resolvido. A cada nível não resolvido, o problema é **escalado** para o nível seguinte.

| Nível | Descrição | Modo típico de atendimento |
|---|---|---|
| **Nível 0** | Autoatendimento: o próprio usuário resolve o problema com apoio de um guia ou tutorial fornecido pelo sistema, sem necessidade de abrir chamado | Tutoriais, guias de configuração, e cada vez mais chatbots baseados em IA generativa como camada intermediária |
| **Nível 1** | Triagem e suporte básico | Telefone, WhatsApp, acesso remoto |
| **Nível 2** | Suporte técnico local | Visita física ao local, diagnóstico dedicado |
| **Nível 3** | Especialistas ou fabricantes do equipamento | Escalonamento para equipes especializadas externas |

A escalada de um nível para outro não é gratuita: cada nível tem um custo mais alto do que o anterior. O custo de um técnico que se desloca fisicamente é maior do que o de um atendente de central telefônica; a esse custo de mão de obra somam-se custos de equipamento, transporte e logística. Por isso, o técnico de informática deve buscar, sempre que possível, resolver o problema no nível mais baixo em que a solução for viável — o que reforça a importância do acesso remoto como ferramenta de contenção de custo (Seção 4.5).

**Exemplo real de escalonamento.** Uma operadora de internet que enfrentou uma queda prolongada e generalizada em sua qualidade de serviço (o mesmo caso citado na Seção 4.1) precisou recorrer ao Nível 3 — especialistas e fabricantes de equipamento de infraestrutura — porque o problema não se resolveu em um dia, nem em uma semana, evidenciando uma falha estrutural que os níveis anteriores de suporte não tinham capacidade de resolver sozinhos.


!!! warning "Figura pendente"
    diagrama de escalonamento nível 0 → nível 1 → nível 2 → nível 3, com custo crescente indicado


## 4.5 Acesso remoto: ferramentas e uso ético

Grande parte dos problemas resolvidos nos níveis 1 e 2 de suporte envolve apenas configuração de software, e não troca física de peças. Nesses casos, o **acesso remoto** permite ao técnico operar o computador do usuário a distância, evitando o custo de deslocamento. Entre as ferramentas mais usadas estão o SSH (acesso remoto via terminal, tipicamente para servidores e equipamentos de rede), o TeamViewer, o AnyDesk e o RustDesk, além da própria funcionalidade de Área de Trabalho Remota do Windows.

O acesso físico à máquina continua sendo necessário apenas quando o problema exige a substituição de um componente de hardware — tudo o que envolve exclusivamente configuração de software pode, em princípio, ser resolvido remotamente.

**Exemplo.** Um problema doméstico comum — um arquivo PDF que passou a abrir automaticamente no Word em vez do leitor de PDF, por associação de tipo de arquivo alterada — foi resolvido a distância por meio do AnyDesk: o técnico recebeu um código de acesso gerado no computador remoto e, a partir dele, assumiu o controle de teclado e mouse da máquina até corrigir a associação de arquivo.

Por envolver o controle total do computador de outra pessoa — muitas vezes com acesso a e-mails, mensagens, fotos e documentos pessoais —, o acesso remoto exige a observância de princípios éticos claros:

- **Consentimento explícito.** O acesso remoto só deve começar depois que o usuário autoriza expressamente o início da sessão.
- **Transparência durante a operação.** O técnico deve narrar o que está fazendo a cada passo (por exemplo, "vou abrir a configuração de rede"), para que o usuário se sinta seguro de que nada além do necessário está sendo acessado.
- **Não acessar dados pessoais.** Arquivos e mensagens pessoais não devem ser abertos, exceto quando estritamente necessários à resolução do problema relatado.
- **Encerramento comunicado e registrado.** Ao final, o técnico deve informar explicitamente que a sessão está sendo encerrada, e registrar o que foi feito, por quem, quando e onde. Esse registro protege tanto o usuário quanto o técnico: sem ele, um uso indevido do computador feito pelo próprio usuário depois do atendimento poderia ser injustamente atribuído ao técnico que teve acesso remoto anteriormente.

Esses princípios se relacionam diretamente com a **Lei Geral de Proteção de Dados (LGPD)**: dados pessoais de terceiros não podem ser tratados sem o devido consentimento, o que se aplica tanto ao conteúdo acessado durante uma sessão remota quanto aos registros gerados por ela.


!!! warning "Figura pendente"
    tela de autenticação de uma ferramenta de acesso remoto, com destaque para o código de sessão e o aviso de consentimento


## 4.6 Sistemas de chamados na prática

O registro e o acompanhamento de chamados são feitos por sistemas de *ticketing*. O **GLPI**, por exemplo, é um software livre amplamente usado para essa finalidade, que organiza os chamados pendentes e os já designados a um responsável, funcionando como um painel supervisório do trabalho da equipe de suporte.

### 4.6.1 O SUAP como central de serviços do IFRN

No IFRN, a abertura de chamados é feita pelo módulo de serviços do SUAP. O usuário escolhe primeiro a **área** do serviço (Administração, Comunicação, EAD, Ensino, Gestão de Pessoas, Manutenção Predial, Pesquisa ou Tecnologia da Informação) e, dentro dela, uma **subcategoria** cada vez mais específica — por exemplo, dentro de Tecnologia da Informação: Redes e Internet, Data Center, Equipamentos, Segurança da Informação, Sistemas e Aplicativos, entre outras.

**Exemplo de simulação de abertura de chamado.** Para um problema de sinal de Wi-Fi instável em um laboratório, o caminho na árvore de categorias é: Tecnologia da Informação → Redes e Internet → Rede sem fio, onde o sistema oferece três opções específicas: informar problema de acesso à rede sem fio, solicitar acesso à rede corporativa, ou solicitar expansão de rede sem fio. Ao abrir o chamado, o usuário preenche uma descrição do problema (por exemplo, "verificar viabilidade de expansão da rede sem fio nos laboratórios de manutenção"), pode adicionar outros interessados (como o coordenador do setor afetado, que passa a acompanhar as atualizações do chamado), anexar evidências (como um print do sinal fraco) e, dependendo da categoria, escolher entre atendimento pela equipe de TI local ou pela equipe de TI remota — alguns serviços, como VPN, só são resolvidos por esta última. Uma vez aberto, o chamado entra na fila de atendimento com um prazo de resposta esperado, tipicamente entre 48 e 120 horas conforme a categoria.

Um mesmo caso é útil para revisar a categorização apresentada na Seção 4.2: um sinal de Wi-Fi instável (mas não totalmente indisponível) não interrompe o uso, então não é um incidente; também não é um evento, porque não se trata de um sinal detectado por infraestrutura de monitoramento; é uma **solicitação**, e por não interromper o fluxo de ninguém, recebe prioridade baixa.

Antes de permitir a abertura de um chamado, o próprio SUAP oferece, quando disponível, um guia de solução (por exemplo, um tutorial de configuração de rede) — uma tentativa de resolver o problema em Nível 0, sem necessidade de acionar a equipe de TI.


!!! warning "Figura pendente"
    captura de tela do SUAP — árvore de categorias de serviço até "Rede sem fio"


!!! warning "Figura pendente"
    captura de tela do SUAP — formulário de abertura de chamado preenchido, com campos de descrição, interessados e anexo


### 4.6.2 O mesmo modelo no desenvolvimento de software

A lógica de chamados categorizados, priorizados e distribuídos entre responsáveis não é exclusiva da manutenção de hardware. No desenvolvimento de software, o equivalente ao chamado é a **issue**, registrada em plataformas de controle de versão (como o Git). Em equipes que seguem a metodologia Scrum, um responsável (o *Scrum Master*) distribui essas tarefas entre a equipe dentro de um intervalo de tempo fixo (*sprint*). Outra abordagem comum é o método **Kanban**, no qual cada tarefa avança por colunas visuais — do *backlog* (tarefas pendentes) para "em resolução", depois "teste", "avaliação" e, por fim, "finalizado" — dando visibilidade ao estado de trabalho de toda a equipe simultaneamente.

Vale registrar uma ressalva prática sobre sistemas de chamados em geral: a exigência de registrar formalmente cada atendimento pode gerar uma burocracia que, paradoxalmente, reduz a produtividade — por exemplo, quando um técnico já resolveu informalmente um problema simples e precisa, ainda assim, abrir um chamado só para que a solução conste no sistema. Esse é um custo real da formalização do atendimento, que deve ser equilibrado com os benefícios de rastreabilidade e priorização que o sistema oferece.

---

## Síntese do capítulo

Este capítulo apresentou a organização do suporte técnico: a central de serviços como ponto único de entrada das demandas, a categorização em evento, incidente e solicitação, a priorização por impacto e urgência, o escalonamento por níveis de suporte com custo crescente, o uso ético do acesso remoto e o funcionamento prático de um sistema de chamados institucional, o SUAP.

Com isso se encerra a formação teórica do curso de Manutenção de Computadores. O percurso começou pela definição do computador e pelo princípio de modularidade que estrutura todo diagnóstico técnico (Capítulo 1); avançou para a base elétrica do funcionamento de um computador, com a fonte de alimentação como ponto de partida de qualquer diagnóstico de hardware (Capítulo 2); tratou do processador e dos critérios objetivos de avaliação de desempenho por meio de benchmarks (Capítulo 3); e fecha, neste capítulo, com a dimensão de atendimento da manutenção — como organizar, priorizar e conduzir eticamente o suporte ao usuário. Resta ao curso a etapa final, prática: a apresentação dos trabalhos de dimensionamento de computadores para perfis de uso específicos, na qual os conceitos estudados ao longo dos quatro capítulos são aplicados a um caso concreto de especificação de hardware.
