import os
import psycopg2

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
    cursor.execute("SELECT id, nome FROM Personagem")
    personagens = cursor.fetchall()

    print("\nEscolha um personagem:")
    for idx, personagem in personagens:
        print(f"{idx}. {personagem}")

    personagem_escolhido = int(input("\nDigite o número do personagem escolhido: "))

    # Verificar se o personagem escolhido existe
    cursor.execute("SELECT nome, genero, hp, forca, habilidades, status, localizacao FROM Personagem WHERE id = %s", (personagem_escolhido,))
    personagem = cursor.fetchone()

    if personagem:
        print(f"\nPersonagem '{personagem[0]}' escolhido com sucesso!")
        print(f"Atributos: HP={personagem[2]}, Força={personagem[3]}, Localização={personagem[6]}")
    else:
        print("\nPersonagem inválido. Tente novamente.")
    
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
        escolha = input("Escolha uma opção: ")

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
