# Capítulo 12 — Manutenção de Computadores: Definição e Método

Neste capítulo você vai estudar a manutenção de computadores como disciplina técnica — sua definição, sua divisão em manutenção corretiva e preventiva, as condições físicas de trabalho que afetam a qualidade de um reparo, e o raciocínio de diagnóstico que sustenta o trabalho do técnico de informática. Os capítulos anteriores construíram o conhecimento técnico necessário — do transistor à arquitetura de von Neumann, passando por processador, memória, sistema operacional, hardware físico e eletricidade; este capítulo dá nome e método ao ofício que aplica esse conhecimento na prática, servindo de ponte para o Capítulo 14, que trata da gestão desse trabalho em escala.

---

## 12.1 Manutenção de computadores: definição e escopo

Este livro adota a seguinte definição, comum na literatura técnica de manutenção industrial e plenamente aplicável à informática:

> "Manutenção é a combinação de todas as ações técnicas e administrativas, incluindo supervisão, destinadas a manter ou recolocar um item em estado no qual possa desempenhar uma função requerida." `[1]`

Essa definição contém uma implicação frequentemente ignorada por quem está começando na área: manutenção não é sinônimo de conserto. Todo computador precisa de manutenção — não apenas os que já apresentam defeito. Essa distinção é o que separa a **manutenção corretiva** (agir depois que a falha ocorreu) da **manutenção preventiva** (agir antes que ela ocorra), tratadas em detalhe na Seção 12.3.

## 12.2 O sistema computacional como filtro de diagnóstico

A tríade hardware, software e pessoas — apresentada no Capítulo 1 (§1.6) — é, para a manutenção, o primeiro filtro de qualquer diagnóstico: diante de um chamado técnico, a primeira pergunta não é "qual é o defeito?", mas "em qual dessas três frentes está o problema?".

**Exemplo.** Um chamado técnico relata que "o mouse não está funcionando". Existem, ao menos, três hipóteses plausíveis, uma em cada frente do sistema computacional:

| Frente | Hipótese | Diagnóstico |
|---|---|---|
| Software | O driver do *trackpad* do notebook não está instalado | O sistema operacional não reconhece o dispositivo apontador |
| Hardware | O mouse físico está com defeito ou sem pilha | O componente em si não opera |
| Pessoa (usuário) | O mouse é sem fio e não está pareado com o computador | O hardware e o software estão corretos; falta uma ação do usuário |

Repare que, no terceiro caso, não há defeito de hardware nem de software: o problema está inteiramente na operação. É comum que problemas relatados como falha técnica sejam, na prática, erro de uso — por isso o técnico precisa investigar as três frentes antes de concluir qualquer diagnóstico.


!!! warning "Figura pendente"
    diagrama "sistema computacional = hardware + software + pessoas" com o exemplo do mouse ramificando nas três hipóteses


## 12.3 Manutenção corretiva e manutenção preventiva

- **Manutenção corretiva**: conjunto de ações tomadas para sanar um problema já identificado. O computador chega com sintomas de um comportamento indevido, e a tarefa do técnico é, a partir desses sintomas, identificar o defeito e realizar a substituição ou correção — seja em hardware (troca de um módulo), seja em software (reinstalação ou reconfiguração de um programa).
- **Manutenção preventiva**: conjunto de ações tomadas para reduzir a probabilidade de que um problema venha a ocorrer, executadas antes de qualquer falha se manifestar.

Não existe uma periodicidade única para a manutenção preventiva — ela depende do tipo de ação e das condições de uso do equipamento.

**Exemplo.** No ambiente de laboratório de um campus, os computadores costumam ser reinstalados uma vez por ano letivo, prática que reduz o índice de problemas ao longo do semestre; sob uso muito mais intenso, esse intervalo poderia cair para seis meses. Já a cópia de segurança (*backup*) de dados de uso profissional é uma ação de manutenção preventiva que deve ser executada diariamente: um computador sem rotina de backup que sofre uma falha grave perde integralmente os dados que não foram copiados.

Manutenção corretiva e preventiva se aplicam às três frentes do sistema computacional (Seção 12.2): existem ações preventivas relacionadas a hardware (limpeza, inspeção), a software (backup, atualização) e também a pessoas — treinamento e orientação do usuário para reduzir erros de operação recorrentes.

### 12.3.1 Condições reais e ideais de trabalho

A qualidade de uma manutenção não depende só do diagnóstico correto (Seção 12.4): depende também das condições físicas em que o reparo é executado. Três fatores concentram a maior parte do risco evitável numa bancada de manutenção.

**Controle eletrostático (ESD).** O corpo humano acumula, por atrito simples (caminhar sobre um carpete, por exemplo), uma carga eletrostática que pode chegar a milhares de volts — imperceptível ao toque, mas suficiente para danificar permanentemente um circuito integrado sensível, cuja tolerância a descargas é medida em dezenas ou centenas de volts `[2]`. A condição ideal de bancada inclui uma superfície de trabalho **antiestática** (um tapete condutor aterrado) e, quando disponível uma instalação de aterramento confiável (Apêndice A, §A.4), uma pulseira antiestática conectando o técnico a essa mesma referência de terra — a mesma ressalva já feita no Capítulo 11 (§11.5.2) se aplica aqui: só vale a pena se conectar a um aterramento em que se confia.

**Umidade e risco de condensação.** Um componente eletrônico transportado de um ambiente frio (por exemplo, um veículo com ar-condicionado) para um ambiente quente e úmido pode sofrer condensação de água em sua superfície — o mesmo fenômeno que embaça um copo gelado num dia quente. Água condensada sobre um circuito energizado é um risco direto de curto-circuito. A prática recomendada é deixar o equipamento estabilizar à temperatura ambiente, ainda desligado, antes de energizá-lo.

**Organização como parte do método, não só do ambiente.** Ao desmontar um equipamento com múltiplos parafusos e cabos semelhantes entre si (o Capítulo 8, §8.2, trata o procedimento de desmontagem em detalhe), separar e identificar cada peça na ordem de remoção evita o erro mais comum de reparo malsucedido: a remontagem incorreta. Essa organização não é uma questão de estética de bancada — é uma extensão direta do método de diagnóstico por hipóteses (Seção 12.4): um técnico que não sabe de onde veio cada parafuso não consegue isolar, com confiança, se um problema após a remontagem foi causado pelo reparo em si ou por uma montagem incorreta.

## 12.4 O raciocínio diagnóstico: hipóteses e método científico

A habilidade central desenvolvida ao longo desta disciplina é a de **isolar um problema** dentro do sistema computacional. Essa habilidade, como programar ou nadar, não se aprende apenas lendo — desenvolve-se pela prática repetida.

O procedimento subjacente ao diagnóstico técnico reproduz o método científico: a partir de uma observação (o sintoma relatado), formula-se uma **hipótese** que explique aquele comportamento, testa-se essa hipótese e verifica-se se ela é válida ou deve ser descartada em favor de outra.

**Exemplo.** Um computador entra em ciclo de reinicialização (POST bem-sucedido, tela de instalação do sistema operacional trava e reinicia). As hipóteses possíveis incluem: defeito na memória secundária, imagem de instalação corrompida, problema de configuração da máquina, ou defeito de hardware específico daquele computador. Um teste direcionado — por exemplo, conectar o disco em outra máquina e rodar um software de diagnóstico de saúde do disco (percentual de blocos defeituosos) — permite confirmar ou descartar a hipótese do disco sem precisar investigar as demais.

Um princípio prático orienta a ordem em que as hipóteses devem ser testadas: **teste primeiro a hipótese mais barata de verificar**, não necessariamente a mais provável. Tempo é um recurso escasso no trabalho técnico; investigar uma hipótese complexa (por exemplo, desmontar o computador para testar um componente em outra máquina) antes de descartar uma hipótese simples (por exemplo, trocar a imagem de instalação e tentar de novo) desperdiça tempo caso a causa fosse, de fato, a mais simples.

Esse tipo de raciocínio — geração de hipóteses, priorização por custo de verificação, teste e confirmação ou descarte — não é adquirido de uma vez; desenvolve-se ao longo da prática cotidiana como técnico, à medida que se acumula repertório de problemas já vistos e resolvidos. É esse mesmo raciocínio, aplicado em escala organizacional em vez de a um único chamado, que estrutura o Capítulo 14.

---

## Síntese do capítulo

Este capítulo apresentou a manutenção de computadores como disciplina fundamentada na distinção entre manutenção corretiva e preventiva, nas condições físicas ideais de bancada (controle eletrostático, umidade, organização), no raciocínio de diagnóstico por hipóteses e no reconhecimento do sistema computacional como uma tríade de hardware, software e pessoas. Esses fundamentos — sobretudo a noção de que todo diagnóstico começa por isolar em qual das três frentes está o problema, e que hipóteses devem ser testadas da mais barata para a mais cara — sustentam o capítulo seguinte, que trata da gestão desse trabalho em escala organizacional.

---

## Referências

1. ASSOCIAÇÃO BRASILEIRA DE NORMAS TÉCNICAS. *NBR 5462: Confiabilidade e mantenabilidade — Terminologia*. Rio de Janeiro: ABNT, 1994.
2. ESD ASSOCIATION. *Fundamentals of Electrostatic Discharge*. Disponível em: <https://www.esda.org>; ou ABNT NBR IEC 61340-5-1 (controle eletrostático em ambientes que manuseiam dispositivos sensíveis).
