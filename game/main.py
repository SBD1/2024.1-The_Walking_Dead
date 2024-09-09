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

# Função para criar um novo personagem
def criar_personagem(conn):
    nome = input("Escolha o nome do seu personagem: ")

    cursor = conn.cursor()
    cursor.execute("SELECT id, nome FROM Habilidades")
    habilidades = cursor.fetchall()

    print("\nEscolha uma habilidade:")
    for idx, habilidade in habilidades:
        print(f"{idx}. {habilidade}")

    habilidade_escolhida = int(input("\nDigite o número da habilidade escolhida: "))

    hp = 100
    forca = 100

    # Inserir o personagem no banco de dados
    try:
        cursor.execute("""
            INSERT INTO Personagem (nome, genero, forca, velocidade, hp, habilidades, status, localizacao)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """, (nome, "indefinido", forca, 50, hp, habilidade_escolhida, "vivo", "fazenda"))
        conn.commit()
        print(f"\nPersonagem '{nome}' criado com sucesso!")
    except Exception as e:
        print(f"Erro ao criar o personagem: {e}")
        conn.rollback()

    cursor.close()

# Interação com o NPC "Fazendeiro"
def interagir_com_fazendeiro():
    print("\nVocê está na fazenda.")
    print("Fazendeiro: 'Olá novato, vamos começar o trabalho, você pode escolher algumas opções:'")
    # Aqui você pode adicionar mais lógica para interação com o NPC

# Função para iniciar um novo jogo
def iniciar_novo_jogo():
    conn = conectar_banco()
    if conn:
        criar_personagem(conn)
        interagir_com_fazendeiro()
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
