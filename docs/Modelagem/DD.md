# Dicionário de Dados

## Introdução 

Um dicionário de dados é uma compilação de informações que descreve detalhadamente os elementos de dados utilizados em um determinado contexto, como um estudo ou projeto. Ele contém uma lista de nomes, atributos e definições que esclarecem o significado e a natureza dos dados em análise.

O objetivo de um dicionário de dados é explicar o que todos os nomes e valores de variáveis ​​em sua planilha realmente significam. Em um dicionário de dados podem ser encontrados dados sobre os nomes das variáveis ​​exatamente como aparecem na planilha, nomes de variáveis ​​curtos (mas legíveis por humanos), o intervalo de valores ou valores aceitos para a variável, descrição da variável e outras informções pertinentes.

## Metodologia 

A abordagem empregada na construção do dicionário de dados foi a seguinte:

- Identificação dos Elementos de Dados
- Descrição detalhada do elemento de dados, incluindo seu propósito, contexto de uso e significado.
- Tipo de dado e tamanho (para colunas).
- Restrições e características específicas, como chaves primárias, chaves estrangeiras, entre outras.

## Dicionário de dados


## Entidade: Equipamento

#### Descrição: A entidade Equipamento descreve os itens equipáveis que o usuário poderá encontrar no mapa ou em seu inventário

#### Observação: Essa tabela possui chave estrangeira da entidade `Mapa`.

| Nome Variável          |     Tipo     |            Descrição                                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :--------------------: | :----------: | :---------------------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|       nome             |  varchar[60] |      Nome do equipamento                              |      a-z, A-Z      |          não           |          |                   |
|        ID              |      int     | código de identificação do item                       |         1-9        |          não           |    PK    |                   |
|     Descrição          | varchar [200]| identifica se o aluno é de graduação ou pós-graduação |      1-100         |          não           |          |                   |
|      Durabilidade      |      int     |Indica quantos ataques o equipamento resistirá/realizará|      a-z, A-Z     |          não           |          |                   |
| Pode de ataque / defesa|      int     |Indica o poder de ataque ou de defesa do equipamento   |      1 - 500       |          não           |          |                   |
|     Estado             |      int     | Indica se o equipamento está danificado, com/sem munição, estragado, etc.  | 1 - 9 | não            |          |                   |
|     Valor              |      int     | Indica o valor de venda ou de compra do equipamento   |      a-z, A-Z      |          sim           |          |                   |
|     Localização        | varchar [60] | Indica onde o equipamento está localizado             |      a-z, A-Z      |          sim           |    FK    |                   |

## Entidade: Personagem

#### Descrição: A entidade Pesonagem guarda as informações relacionadas à persona jogável do usuário.

#### Observação: Essa tabela possui chave estrangeira da entidade `Mapa`.

| Nome Variável|     Tipo     |            Descrição                                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :---------:  | :----------: | :---------------------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|       nome   |  varchar[60] |      Nome do personagem                               |      a-z, A-Z      |          não           |          |                   |
|        ID    |      int     | código de identificação do Personagem                 |         1-9        |          não           |    PK    |                   |
|     Gênero   | varchar[50]  | identifica o gênero do personagem                     |      a-z, A-Z      |          não           |          |                   |
|      Força   |      int     |Indica quantos pontos há no atributo força             |      1 - 100       |          não           |          |                   |
| Velocidade   |      int     |Indica quantos pontos há no atributo velocidade        |      1 - 500       |          não           |          |                   |
|     HP       |      int     |Indica quantos ponto de saúde o personagem possui      |      1 - 2000      |         não            |          |                   |
|  Habilidades | varchar[60]  | Habilidades especiais que afetam a jogabilidade       |      a-z, A-Z      |          sim           |          |                   |
|   Status     | varchar [60] |Indica se o personagem está com fome, morto, envenenado, etc.|      a-z, A-Z      |         sim      |          |                   |
|Localização   | varchar [60] | Indica onde o personagem está localizado              |      a-z, A-Z      |          sim           |    FK    |                   |


## Entidade: Zumbi

#### Descrição: A entidade Equipamento descreve os itens equipáveis que o usuário poderá encontrar no mapa ou em seu inventário

#### Observação: Essa tabela possui chave estrangeira da entidade `Mapa`.

| Nome Variável|     Tipo     |            Descrição                                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :---------:  | :----------: | :---------------------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|        ID    |      int     | código de identificação do Zumbi                      |         1-9        |          não           |    PK    |                   |
|     Tipo     |      enum    | identifica o tipo de zumbi                            |         1-5        |          não           |          |                   |
|      Força   |      int     |Indica quantos pontos há no atributo força             |      1 - 100       |          não           |          |                   |
| Velocidade   |      int     |Indica quantos pontos há no atributo velocidade        |      1 - 500       |          não           |          |                   |
|     HP       |      int     |Indica quantos ponto de saúde o Zumbi possui           |      1 - 2000      |         não            |          |                   |
|  Habilidades | varchar[60]  | Habilidades especiais do zumbi                        |      a-z, A-Z      |          sim           |          |                   |
|   Status     | varchar [60] |Indica se o Zumbi está com morto, imobilizado, etc     |      a-z, A-Z      |         não            |          |                   |
|Localização   | varchar [60] | Indica onde o Zumbi está localizado                   |      a-z, A-Z      |          sim           |    FK    |                   |

## Entidade: Missão

#### Descrição: A entidade Missão descreve as missões que guiarão o jogador a algum objetivo do jogo.

#### Observação: 

| Nome Variável          |     Tipo     |            Descrição                                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :--------------------: | :----------: | :---------------------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|       nome             |  varchar[60] |      Nome da missão                                   |      a-z, A-Z      |          não           |          |                   |
|        ID              |      int     | código de identificação da missão                     |         1-9        |          não           |    PK    |                   |
|     Descrição          | varchar [500]| descrição da missão                                   |     a-z, A-Z       |          não           |          |                   |
|      Tipo              |      enum    |Indica o tipo de objetivo da missão                   |Combate, busca, dialogo|        não           |          |                   |
| Recompensa             | varchar[60]  |O que o jogador irá receber a oconcluir a missão       |      1 - 500       |          não           |          |                   |
## Entidade: Item

#### Descrição: A entidade Item descreve os itens que o usuário poderá encontrar no mapa ou em seu inventário

#### Observação: Essa tabela possui chave estrangeira da entidade `Mapa`.

| Nome Variável          |     Tipo     |            Descrição                                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :--------------------: | :----------: | :---------------------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|       nome             |  varchar[60] |      Nome do item                                     |      a-z, A-Z      |          não           |          |                   |
|        ID              |      int     | código de identificação do item                       |         1-9        |          não           |    PK    |                   |
|     Descrição          | varchar [200]| texto de descrição do item                           |      a-z, A-Z         |          não           |          |                   |
|      Tipo              |      enum    |Indica o tipo do item    |Arma, ferramenta, vestimenta, alimento, medicamento |          não           |          |                   |
|Dano                    |      int     |Indica o poder de ataque ou da arma   |      1 - 500       |          sim           |          |                   |
|Alcance                 |      int     |Indica as casas de alcance em que a arma é efetiva |1 - 100 | sim            |          |                   |
| Valor                  |      int     | Indica o valor de venda ou de compra do item   |      1 - 5000     |          sim           |          |                   |
|Poder de regeneração    |      int     | Indica o quanto o medicamento é capaz de curar |     1 - 1000     |          sim           |       |                   |
|Poder de força          |      int     | Indica o benefício que o aliento irá prover no poder de ataque/defesa|      1 - 500      |          sim           |       |                   |
|Proteção                |     int      | Indica o quanto a vestimenta irá incrementar na defesa do personagem|      1 - 500     |          sim           |       |                   |
|Resistência             |      int     | Indica resistência da vestimenta|      1 - 500      |          sim           |       |                   |
|     Localização        | varchar [60] | Indica onde o item está localizado                     |      a-z, A-Z      |          sim           |    FK    |                   |

## Entidade: Mapa

#### Descrição: A entidade Mapa 

#### Observação:

| Nome Variável          |     Tipo     |            Descrição                                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :--------------------: | :----------: | :---------------------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|       nome             |  varchar[60] |      Nome do mapa                                     |      a-z, A-Z      |          não           |          |                   |
|        ID              |      int     | código de identificação do mapa                       |         1-9        |          não           |    PK    |                   |
|     Território         | varchar [60] | indica a qual território o mapa está associado        |      1-100         |          não           |          |                   |
|      Coordenada X     |      int      |Indica as coordenadas do eixo horizontal               |      a-z, A-Z      |          não           |          |                   |
|  Coordenada Y         |      int      |Indica as coordenadas do eixo vertical                 |      1 - 500       |          não           |          |                   |
|     tipo              |      enum     |indica o tipo do mapa                                  |Cidade, cadeia, floresta| não                |          |                   |
|     Descrição         |varchar[200]   |indica a descrição do mapa (contextualização)          |      a-z, A-Z      |          sim           |          |                   |
|     Recursos          |      int      |indica a quantidade de recursos disponível no mapa     |      a-z, A-Z      |          sim           |          |                   |

## 📑 Histórico de Versões

| **Versão**   |   **Data**   | **Descrição** | **Autor** |
|--------|---------|-----------|--------|
|`1.0`| 28/04/2024 | Criação da página do dicionário de dados| [Mayara Alves](https://github.com/Mayara-tech)|
|`1.1`| 22/07/2024 | confecção do dicionário de dados| [Joel](https://github.com/JoelSRangel)|  
