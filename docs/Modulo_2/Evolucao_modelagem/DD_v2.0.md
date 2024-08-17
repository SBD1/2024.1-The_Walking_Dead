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

# Dicionário de dados

## Entidade: Inventário

#### Descrição: A entidade Item descreve os itens que estarão presentes no jogo. Um item pode ser do tipo equipamento ou consumível

#### Observação: Essa tabela possui chave estrangeira da entidade `Personagem` e `Instância_Item`.

| Nome Variável          |     Tipo     |            Descrição                                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :--------------------: | :----------: | :---------------------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|        ID              |      int     | código de identificação do inventário                 |         1-99       |          não           |    PK    |                   |
|        ID_item         |      int     | código de identificação da instância do item          |         1-99       |          não           |    FK    |                   |
|        ID_Personagem   |      int     | código de identificação do Personagem associado      |         1-99        |          não           |    FK    |                   |
| Tamanho                |      int     | Indica limite de itens do inventário           |      1 - 50     |          não           |          |                   |

## Entidade: Item

#### Descrição: A entidade Item descreve os itens que estarão presentes no jogo. Um item pode ser do tipo equipamento ou consumível

#### Observação: Essa tabela possui chave estrangeira da entidade ``.

| Nome Variável          |     Tipo     |            Descrição                                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :--------------------: | :----------: | :---------------------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|       nome             |  varchar[60] |      Nome do item                                     |      a-z, A-Z      |          não           |          |                   |
|        ID              |      int     | código de identificação do item                       |         1-99       |          não           |    PK    |                   |
|     Descrição          | varchar [200]| texto de descrição do item                           |      a-z, A-Z         |          não           |          |                   |
|      Tipo              |      enum    |Indica o tipo do item    |Arma, ferramenta, vestimenta, alimento, medicamento |          não           |          |                   |
| Valor                  |      int     | Indica o valor de venda ou de compra do item           |      1 - 5000     |          sim           |          |                   |

## Entidade: Instância_Item

#### Descrição: A entidade Inst_ancia_Item descreve as instâncias dos itens que o usuário poderá encontrar no mapa, em seu inventário ou em NPCs mercadores.

#### Observação: Essa tabela possui chave estrangeira da entidade `Local`.

| Nome Variável          |     Tipo     |            Descrição                                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :--------------------: | :----------: | :---------------------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|        ID              |      int     | código de identificação do item                       |         1-999       |          não           |    PK    |                   |
|    Item_ID             |      int     | código de identificação do item                       |         1-99        |          não           |    FK    |                   |
|     Localização        | varchar [60] | Indica onde o item está localizado                     |      a-z, A-Z     |          sim           |    FK    |                   |



## Entidade: Item-Equipamento

#### Descrição: A entidade Equipamento descreve os itens do tipo equipáveis. Um equipamento pode ser do tipo Arma ou Armadura.


| Nome Variável          |     Tipo     |            Descrição                                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :--------------------: | :----------: | :---------------------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|     Estado             |      varchar [20]    | Indica se o equipamento está danificado, com/sem munição, estragado, etc.  | a-z, A-Z | não            |          |                   |
|      Tipo              |      enum    |Indica o tipo do item    |Arma, ferramenta, vestimenta, alimento, medicamento |          não           |          |                   |

## Entidade: Item-Equipamento-Arma

#### Descrição: A entidade Item-Equipamento-Arma descreve os itens do tipo equipáveis do tipo Arma (ofensivo).


| Nome Variável          |     Tipo     |            Descrição                                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :--------------------: | :----------: | :---------------------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
| Poder de ataque        |     int     | Indica o poder de ataque da arma equipável             | 0-5000             |    não                 |          |                   |

## Entidade: Item-Equipamento-Armadura

#### Descrição: A entidade Item-Equipamento-Armadura descreve os itens do tipo equipáveis do tipo Armadura (defensivo).

| Nome Variável          |     Tipo     |            Descrição                                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :--------------------: | :----------: | :---------------------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
| Poder de defesa        |     int     | Indica o poder de defesa da armadura equipável         | 0-5000             |    não                 |          |                   |

## Entidade: Item-Consumível

#### Descrição: A entidade Item-Consumível descreve os itens que podem ser consumidos pelo jogador.


| Nome Variável          |     Tipo     |            Descrição                                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :--------------------: | :----------: | :---------------------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|Poder de Regeneração |      int      | Indica o poder de regeneração do item a ser consumido pelo jogador | 0-5000 | não            |          |                   |


## Entidade: Personagem

#### Descrição: A entidade Pesonagem guarda as informações relacionadas aos personagens presentes no jogo.

#### Observação: Essa tabela possui chave estrangeira da entidade `Local`.

| Nome Variável|     Tipo     |            Descrição                                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :---------:  | :----------: | :---------------------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|       nome   |  varchar[60] |      Nome do personagem                               |      a-z, A-Z      |          não           |          |                   |
|        ID    |      int     | código de identificação do Personagem                 |         1-99        |          não           |    PK    |                   |
|     Gênero   | varchar[50]  | identifica o gênero do personagem                     |      a-z, A-Z      |          não           |          |                   |
|     HP       |      int     |Indica quantos ponto de saúde o personagem possui      |      1 - 2000      |         não            |          |                   |
|   Status     | varchar [60] |Indica se o personagem está com fome, morto, envenenado, etc.|      a-z, A-Z      |         sim      |          |                   |
|Localização   | varchar [60] | Indica onde o personagem está localizado              |      a-z, A-Z      |          sim           |    FK    |                   |
|ID_inventario |      int     | código de identificação do inventário do personagem   |         1-99        |          não           |    FK    |                   |

## Entidade: Personagem-Jogador

#### Descrição: A entidade Pesonagem-jogador guarda as informações relacionadas ao personagem que será utilziado pelo usuário.


| Nome Variável|     Tipo     |            Descrição                                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :---------:  | :----------: | :---------------------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|      Força   |      int     |Indica quantos pontos há no atributo força             |      1 - 100       |          não           |          |                   |
| Velocidade   |      int     |Indica quantos pontos há no atributo velocidade        |      1 - 500       |          não           |          |                   |
|  ID_Habilidades | int  | identificador de Habilidades especiais que afetam a jogabilidade       |      1-99      |          sim           |     FK   |                   |

## Entidade: Personagem-NPC

#### Descrição: A entidade Pesonagem-jogador guarda as informações relacionadas ao personagem que será utilziado pelo usuário.


| Nome Variável|     Tipo     |            Descrição                                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :---------:  | :----------: | :---------------------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|      Função   |     enum    |Indica a função do NPC        | mercador, missão,        |          não           |          |                   |
|  Diálogo  | varchar[500]  | Diálogo exibido pelo NPC ao jogador interagir com ele |      a-z, A-Z      |          sim           |          |                   |


## Entidade: Zumbi

#### Descrição: A entidade Zumbi descreve os zumbis que o jogador poderá encontrar ao decorrer do jogo.

#### Observação: Essa tabela possui chave estrangeira da entidade `Mapa`.

| Nome Variável|     Tipo     |            Descrição                                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :---------:  | :----------: | :---------------------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|        ID    |      int     | código de identificação do Zumbi                      |         1-9        |          não           |    PK    |                   |
|     Tipo     |      enum    | identifica o tipo de zumbi                            |         1-5        |          não           |          |                   |
|      Força   |      int     |Indica quantos pontos há no atributo força             |      1 - 100       |          não           |          |                   |
| Velocidade   |      int     |Indica quantos pontos há no atributo velocidade        |      1 - 500       |          não           |          |                   |
|     HP       |      int     |Indica quantos ponto de saúde o Zumbi possui           |      1 - 2000      |         não            |          |                   |

## Entidade: Instância_Zumbi

#### Descrição: A entidade Instância_Zumbi descreve as instâncias dos zumbis que o jogador poderá encontrar ao decorrer do jogo.

#### Observação: Essa tabela possui chave estrangeira da entidade `Local`.

| Nome Variável|     Tipo     |            Descrição                                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :---------:  | :----------: | :---------------------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|        ID    |      int     | código de identificação do Zumbi                      |         1-999        |          não           |    PK    |                   |
|   ID_Zumbi   |      int     | código de identificação do Zumbi                      |         1-99        |          não           |    FK    |                   |
|   Status     | varchar [60] |Indica se o Zumbi está com morto, imobilizado, etc     |      a-z, A-Z      |         não            |          |                   |
|Localização   | varchar [60] | Indica onde o Zumbi está localizado                   |      a-z, A-Z      |          sim           |    FK    |                   |




## Entidade: Missão

#### Descrição: A entidade Missão descreve as missões que guiarão o jogador a algum objetivo do jogo.

#### Observação: 

| Nome Variável          |     Tipo     |            Descrição                                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :--------------------: | :----------: | :---------------------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|       nome             |  varchar[60] |      Nome da missão                                   |      a-z, A-Z      |          não           |          |                   |
|        ID              |      int     | código de identificação da missão                     |         1-99        |          não           |    PK    |                   |
|     Região_ID          |      int     | código de identificação da região qeu a missão está associada |    1-9    |          não           |    FK    |                   |
|     Descrição          | varchar [500]| descrição da missão                                   |     a-z, A-Z       |          não           |          |                   |
|      Tipo              |      enum    |Indica o tipo de objetivo da missão                   |Combate, busca, dialogo|        não           |          |                   |
| Recompensa             | varchar[60]  |O que o jogador irá receber a oconcluir a missão       |      1 - 500       |          não           |          |                   |
| Dificuldade  |      int     | Nível de dificuldade da missão         |         1-99        |          não           |        |                   |
|   Status     | enum | Indica o Status da Missão|Disponível, Concluída, Indisponível|         não            |          |                   |


## Entidade: Local

#### Descrição: A entidade Local 

#### Observação:

| Nome Variável          |     Tipo     |            Descrição                                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :--------------------: | :----------: | :---------------------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|       nome             |  varchar[60] |      Nome do mapa                                     |      a-z, A-Z      |          não           |          |                   |
|        ID              |      int     | código de identificação do mapa                       |         1-9        |          não           |    PK    |                   |
|      Dimensões    |      int      |   As dimensões do local em metros quadrados               |      1 - 500     |          não           |          |                   |
|     tipo              |      enum     |indica o tipo do mapa                                  |Cidade, cadeia, floresta| não                |          |                   |
|     Descrição         |varchar[200]   |indica a descrição do mapa (contextualização)          |      a-z, A-Z      |          sim           |          |                   |
|     Recursos          |      int      |indica a quantidade de recursos disponível no mapa     |      1 - 99     |          sim           |          |                   |
|     Dificuldade       |      int      |indica o nível de dificuldade do local    |      1 - 99     |          sim           |          |                   |

## Entidade: Região

#### Descrição: A entidade Região 

#### Observação:

| Nome Variável          |     Tipo     |            Descrição                                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :--------------------: | :----------: | :---------------------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|       nome             |  varchar[60] |      Nome do mapa                                     |      a-z, A-Z      |          não           |          |                   |
|        ID              |      int     | código de identificação do mapa                       |         1-9        |          não           |    PK    |                   |
|     tipo              |      enum     |indica o tipo do mapa                                  |Cidade, cadeia, floresta| não                |          |                   |
|     Descrição         |varchar[200]   |indica a descrição do mapa (contextualização)          |      a-z, A-Z      |          sim           |          |                   |

## 📑 Histórico de Versões

| **Versão**   |   **Data**   | **Descrição** | **Autor** |
|--------|---------|-----------|--------|
|`1.0`| 28/04/2024 | Criação da página do dicionário de dados| [Mayara Alves](https://github.com/Mayara-tech)|
|`1.1`| 22/07/2024 | confecção do dicionário de dados| [Joel](https://github.com/JoelSRangel)|  
|`2.0`| 15/08/2024 | primeira correção do dicionário de dados| [Joel](https://github.com/JoelSRangel)|  
