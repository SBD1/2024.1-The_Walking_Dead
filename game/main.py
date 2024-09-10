import os
import psycopg2
import time
import sys

def limpar_tela():
    # Limpar a tela, verificando o sistema operacional
    if os.name == 'nt':  # Windows
        os.system('cls')
    else:  # Linux e macOS
        os.system('clear')

def imprimir_lentamente(texto, delay=0.038, fim='\n'):
    # Função para imprimir o texto letra por letra
    for char in texto:
        sys.stdout.write(char)
        sys.stdout.flush()
        time.sleep(delay)
    print(end=fim)  # Para quebrar a linha ao final do texto

def conectar_banco():
    try:
        conn = psycopg2.connect(
            dbname="the_walking_dead",
            user="postgres",
            password="postgres",
            host="localhost",
            port="5432",
            options="-c client_encoding=UTF8"
        )
        return conn
    except Exception as e:
        print(f"Erro ao conectar ao banco de dados: {e}")
        return None

# Exibir menu principal
def exibir_menu():
    print("  ====================================")
    print("   Bem-vindo ao MUD: The Walking Dead")
    print("  ====================================")
    print("1. Iniciar Novo Jogo")
    print("2. Carregar Jogo Salvo")
    print("3. Fechar")
    print("======================================")

# Função para escolher um personagem existente no banco de dados
def escolher_personagem(conn):
    cursor = conn.cursor()

    while True:
        # Selecionar personagens com ID 1 ou 2
        cursor.execute("SELECT id, nome FROM Personagem WHERE id IN (1, 2)")
        personagens = cursor.fetchall()

        imprimir_lentamente("\nEscolha um personagem:")
        for idx, personagem in personagens:
            imprimir_lentamente(f"{idx}. {personagem}")

        
        # Tentar converter o input para número
        try:
            imprimir_lentamente("\nDigite o número do personagem escolhido: ", fim='')
            personagem_escolhido = int(input())
        except ValueError:
            limpar_tela()
            imprimir_lentamente("\nEntrada inválida. Por favor, digite um número.")
            continue  # Volta para o início do loop e pede novamente

        # Verificar se o personagem escolhido é válido (apenas ID 1 ou 2)
        if personagem_escolhido not in [1, 2]:
            imprimir_lentamente("\nPersonagem inválido. Escolha um personagem com ID 1 ou 2.")
            continue

        # Consultar detalhes do personagem
        cursor.execute("SELECT nome, genero, hp, estado, localizacao FROM Personagem WHERE id = %s", (personagem_escolhido,))
        personagem = cursor.fetchone()

        if personagem:
            # Definir atributos pré-definidos para cada personagem
            if personagem_escolhido == 1:
                nome, forca, agilidade, habilidades_id = personagem[0], 11, 6, 1  # Atributos para personagem com ID 1
            elif personagem_escolhido == 2:
                nome, forca, agilidade, habilidades_id = personagem[0], 7, 10, 2  # Atributos para personagem com ID 2
            imprimir_lentamente(f"\nPersonagem '{personagem[0]}' escolhido com sucesso!")
            imprimir_lentamente(f"Atributos: HP={personagem[2]}, Localização={personagem[4]}")
            imprimir_lentamente(f"Forca = {forca}, Agilidade={agilidade}, habilidade={habilidades_id}")

            # Solicitar confirmação
            imprimir_lentamente("Deseja confirmar a escolha? (S/N): ", fim='')
            confirma = input().strip().upper()

            if confirma == "S":

                # Inserir o personagem na tabela Jogador com atributos pré-definidos
                cursor.execute(
                    "INSERT INTO Jogador (ID, nome, forca, agilidade, habilidades_ID) VALUES (%s, %s, %s, %s, %s)",
                    (personagem_escolhido, nome, forca, agilidade, habilidades_id)
                )
                conn.commit()

                limpar_tela()

                imprimir_lentamente("\nJogador adicionado com sucesso à tabela!")
                break  # Saindo do loop, pois a escolha foi confirmada
            elif confirma == "N":
                limpar_tela()
                imprimir_lentamente("\nEscolha novamente um personagem.")
        else:
            limpar_tela()
            imprimir_lentamente("\nPersonagem inválido. Tente novamente.")

    cursor.close()
    return personagem_escolhido

# Função para exibir e escolher missões
def escolher_missao(conn):
    cursor = conn.cursor()
    cursor.execute("SELECT id, descricao FROM Missao")  # Supondo que exista uma tabela Missao com id e descricao
    missoes = cursor.fetchall()

    print("\nEscolha uma missão:")
    for idx, missao in missoes:
        print(f"{idx}. {missao}")

    missao_escolhida = int(input("\nDigite o número da missão escolhida: "))

    # Verificar se a missão escolhida existe
    cursor.execute("SELECT descricao FROM Missao WHERE id = %s", (missao_escolhida,))
    missao = cursor.fetchone()

    if missao:
        print(f"\nMissão '{missao[0]}' escolhida com sucesso!")
    else:
        print("\nMissão inválida. Tente novamente.")
    
    cursor.close()
    return missao_escolhida

# Interação com o NPC "Fazendeiro"
def interagir_com_fazendeiro(conn):
    print("\nVocê está na fazenda.")
    print("Fazendeiro: 'Olá novato, vamos começar o trabalho, você pode escolher algumas opções:'")
    
    # Escolher uma missão
    escolher_missao(conn)
    
    # Despedida do fazendeiro
    print("Fazendeiro: 'Se esforce bastante e você não morrerá nesse apocalipse!'")

# Função para iniciar um novo jogo
def iniciar_novo_jogo():
    conn = conectar_banco()
    if conn:
        personagem_escolhido = escolher_personagem(conn)
        if personagem_escolhido:
            interagir_com_fazendeiro(conn)
        conn.close()
    else:
        print("Não foi possível iniciar o jogo por problemas de conexão com o banco de dados.")

def carregar_jogo():
    print("\nCarregando jogo salvo...")
    # Coloque aqui a lógica para carregar o jogo salvo
    pass

def fechar_jogo():
    print("\nSaindo do jogo... Até mais!")
    exit()

def main():
    while True:
        exibir_menu()
        imprimir_lentamente("Escolha uma opção: ", fim='')
        escolha = input()

        if escolha == '1':
            iniciar_novo_jogo()
        elif escolha == '2':
            carregar_jogo()
        elif escolha == '3':
            fechar_jogo()
        else:
            print("\nOpção inválida. Tente novamente.\n")

if __name__ == "__main__":
    main()
