import os
import psycopg2
import time
import sys

def limpar_tela():
    if os.name == 'nt':  # Windows
        os.system('cls')
    else:  # Linux e macOS
        os.system('clear')

def imprimir_lentamente(texto, delay=0.025, fim='\n'):
    for char in texto:
        sys.stdout.write(char)
        sys.stdout.flush()
        time.sleep(delay)
    print(end=fim)

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

def exibir_menu():
    print("  ====================================")
    print("   Bem-vindo ao MUD: The Walking Dead")
    print("  ====================================")
    print("1. Iniciar Novo Jogo")
    print("2. Carregar Jogo Salvo")
    print("3. Fechar")
    print("======================================")

def escolher_personagem(conn):
    cursor = conn.cursor()

    while True:
        cursor.execute("SELECT id, nome FROM Personagem WHERE id IN (1, 2)")
        personagens = cursor.fetchall()

        imprimir_lentamente("\nEscolha um personagem:")
        for idx, personagem in personagens:
            imprimir_lentamente(f"{idx}. {personagem}")

        try:
            imprimir_lentamente("\nDigite o número do personagem escolhido: ", fim='')
            personagem_escolhido = int(input())
        except ValueError:
            limpar_tela()
            imprimir_lentamente("\nEntrada inválida. Por favor, digite um número.")
            continue

        if personagem_escolhido not in [1, 2]:
            imprimir_lentamente("\nPersonagem inválido. Escolha um personagem com ID 1 ou 2.")
            continue

        cursor.execute("SELECT nome, genero, hp, estado, localizacao FROM Personagem WHERE id = %s", (personagem_escolhido,))
        personagem = cursor.fetchone()

        if personagem:
            if personagem_escolhido == 1:
                nome, forca, agilidade, habilidades_id, hp, estado, localizacao = personagem[0], 11, 6, 1, personagem[2], personagem[3], personagem[4]
            elif personagem_escolhido == 2:
                nome, forca, agilidade, habilidades_id, hp, estado, localizacao = personagem[0], 7, 10, 2, personagem[2], personagem[3], personagem[4]
            
            imprimir_lentamente(f"\nPersonagem '{personagem[0]}' escolhido com sucesso!")
            imprimir_lentamente(f"Atributos: HP={personagem[2]}, Localização={personagem[4]}")
            imprimir_lentamente(f"Forca = {forca}, Agilidade={agilidade}, habilidade={habilidades_id}")

            imprimir_lentamente("Deseja confirmar a escolha? (S/N): ", fim='')
            confirma = input().strip().upper()

            if confirma == "S":
                cursor.execute(
                    "INSERT INTO Jogador (ID_personagem, nome, forca, agilidade, habilidades_ID, hp, estado, localizacao) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)",
                    (personagem_escolhido, nome, forca, agilidade, habilidades_id, hp, estado, localizacao)
                )
                conn.commit()

                limpar_tela()
                imprimir_lentamente("\nJogador adicionado com sucesso à tabela!")
                break
            elif confirma == "N":
                limpar_tela()
                imprimir_lentamente("\nEscolha novamente um personagem.")
        else:
            limpar_tela()
            imprimir_lentamente("\nPersonagem inválido. Tente novamente.")

    cursor.close()
    return personagem_escolhido

def listar_locais_disponiveis(conn):
    cursor = conn.cursor()
    cursor.execute("SELECT id, nome, descricao, dificuldade FROM Local")
    locais = cursor.fetchall()

    imprimir_lentamente("\n-- Locais Disponíveis --")
    for idx, nome, descricao, dificuldade in locais:
        imprimir_lentamente(f"{idx}. {nome} - {descricao} (Dificuldade: {dificuldade})")

    cursor.close()
    return locais

def mover_para_local(conn, jogador_id):
    locais = listar_locais_disponiveis(conn)
    
    try:
        imprimir_lentamente("\nEscolha um local para mover-se: ", fim='')
        local_escolhido = int(input())
    except ValueError:
        imprimir_lentamente("Entrada inválida. Por favor, digite um número.")
        return

    local_existe = any(local[0] == local_escolhido for local in locais)

    if not local_existe:
        imprimir_lentamente("\nLocal inválido. Tente novamente.")
        return

    cursor = conn.cursor()
    cursor.execute("SELECT nome FROM Local WHERE id = %s", (local_escolhido,))
    local_nome = cursor.fetchone()[0]

    cursor.execute("UPDATE Jogador SET localizacao = %s WHERE ID = %s", (local_nome, jogador_id))
    conn.commit()

    imprimir_lentamente(f"\nVocê se moveu para {local_nome}.")
    cursor.close()

def jogo(conn, personagem_escolhido):
    cursor = conn.cursor()

    cursor.execute(
        """
        SELECT j.nome, j.hp, j.estado, j.localizacao, j.forca, j.agilidade
        FROM Jogador j
        WHERE j.ID = %s
        """, 
        (personagem_escolhido,)
    )
    jogador = cursor.fetchone()

    if not jogador:
        print("Nenhum jogador encontrado com o personagem selecionado.")
        return

    nome_jogador, hp_atual, estado, localizacao, forca, agilidade = jogador

    while True:
        imprimir_lentamente(f"\n-- Informações do Jogador --")
        imprimir_lentamente(f"Nome do Jogador: {nome_jogador}")
        imprimir_lentamente(f"HP: {hp_atual}/100")
        imprimir_lentamente(f"Estado: {estado}")
        imprimir_lentamente(f"Localização: {localizacao}")
        imprimir_lentamente(f"Atributos: Força={forca}, Agilidade={agilidade}")

        imprimir_lentamente("\n-- O que você deseja fazer? --")
        imprimir_lentamente("1. Acessar inventário")
        imprimir_lentamente("2. Interagir com o NPC local")
        imprimir_lentamente("3. Mover para outro local")
        imprimir_lentamente("4. Lutar contra o zumbi presente")
        imprimir_lentamente("5. Sair do jogo")

        escolha = input("\nEscolha uma opção: ")

        if escolha == "1":
            imprimir_lentamente("\nAcessando o inventário...")
        elif escolha == "2":
            imprimir_lentamente("\nInteragindo com o NPC local...")
            interagir_com_fazendeiro(conn)
        elif escolha == "3":
            imprimir_lentamente("\nMovendo-se para outro local...")
            mover_para_local(conn, personagem_escolhido)
        elif escolha == "4":
            imprimir_lentamente("\nLutando contra o zumbi presente...")
        elif escolha == "5":
            imprimir_lentamente("\nSaindo do jogo...")
            break
        else:
            print("\nOpção inválida. Tente novamente.")

    cursor.close()

def iniciar_novo_jogo():
    conn = conectar_banco()
    if conn:
        personagem_escolhido = escolher_personagem(conn)
        if personagem_escolhido:
            jogo(conn, personagem_escolhido)
        conn.close()
    else:
        print("Não foi possível iniciar o jogo por problemas de conexão com o banco de dados.")

def carregar_jogo():
    print("\nCarregando jogo salvo...")
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
