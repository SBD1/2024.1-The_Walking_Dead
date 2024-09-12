import os
import psycopg2
import time
import sys

def limpar_tela():
    if os.name == 'nt':  # Windows
        os.system('cls')
    else:  # Linux e macOS
        os.system('clear')

def imprimir_lentamente(texto, delay=0.01, fim='\n'):
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
                    "INSERT INTO Jogador (ID_personagem, nome, forca, agilidade, habilidades_ID, hp, estado, localizacao) VALUES (%s, %s, %s, %s, %s, %s, %s, %s) RETURNING ID",
                    (personagem_escolhido, nome, forca, agilidade, habilidades_id, hp, estado, localizacao)
                )

                jogador_id = cursor.fetchone()[0]
                cursor.execute(
                    "INSERT INTO Inventario (Jogador_ID, Tamanho) VALUES (%s, %s)",
                    (jogador_id, 15)  # Tamanho do inventário é 15
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
        print(f"{idx}. {nome} - {descricao} (Dificuldade: {dificuldade})")

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

def lutar_contra_zumbi(conn, jogador_id):
    cursor = conn.cursor()

    # Buscar localização atual do jogador
    cursor.execute("SELECT localizacao, forca, hp FROM Jogador WHERE ID = %s", (jogador_id,))
    jogador = cursor.fetchone()
    if not jogador:
        imprimir_lentamente("Erro: Jogador não encontrado.")
        return

    localizacao_jogador, forca_jogador, hp_jogador = jogador

    # Verificar se há um zumbi na mesma localização
    cursor.execute("""
        SELECT z.id, z.forca, z.velocidade, z.hp, iz.estado
        FROM Zumbi z
        JOIN Instancia_Zumbi iz ON z.id = iz.ID_Zumbi
        WHERE iz.localizacao = %s AND iz.estado = 'Ativo'
    """, (localizacao_jogador,))
    zumbi = cursor.fetchone()

    if not zumbi:
        imprimir_lentamente(f"Não há nenhum zumbi ativo em {localizacao_jogador}.")
        return

    id_zumbi, forca_zumbi, velocidade_zumbi, hp_zumbi, estado_zumbi = zumbi

    imprimir_lentamente(f"\nVocê encontrou um zumbi na {localizacao_jogador}!")
    imprimir_lentamente(f"Zumbi - HP: {hp_zumbi}, Força: {forca_zumbi}, Velocidade: {velocidade_zumbi}")
    imprimir_lentamente(f"Prepare-se para a batalha!")

    # Loop da batalha
    while hp_jogador > 0 and hp_zumbi > 0:
        # Turno do jogador
        imprimir_lentamente("\nSeu turno de ataque!")
        imprimir_lentamente(f"Você ataca o zumbi com força {forca_jogador}!")
        hp_zumbi -= forca_jogador
        if hp_zumbi <= 0:
            imprimir_lentamente("Você derrotou o zumbi!")
            cursor.execute("UPDATE Instancia_Zumbi SET estado = 'Inativo' WHERE ID_Zumbi = %s", (id_zumbi,))
            conn.commit()
            break
        imprimir_lentamente(f"O zumbi ainda tem {hp_zumbi} de HP.")

        # Turno do zumbi
        imprimir_lentamente("\nTurno do zumbi!")
        imprimir_lentamente(f"O zumbi ataca com força {forca_zumbi}!")
        hp_jogador -= forca_zumbi
        if hp_jogador <= 0:
            imprimir_lentamente("Você foi derrotado pelo zumbi!")
            cursor.execute("UPDATE Jogador SET hp = 0 WHERE ID = %s", (jogador_id,))
            conn.commit()
            break
        imprimir_lentamente(f"Você ainda tem {hp_jogador} de HP.")

    # Atualizar o HP do jogador e do zumbi no banco de dados
    cursor.execute("UPDATE Jogador SET hp = %s WHERE ID = %s", (hp_jogador, jogador_id))
    cursor.execute("UPDATE Zumbi SET hp = %s WHERE id = %s", (hp_zumbi, id_zumbi))
    conn.commit()

    cursor.close()

def acessar_inventario(conn, personagem_escolhido):
    cursor = conn.cursor()

    # Obter o ID do jogador relacionado ao personagem escolhido
    cursor.execute("SELECT ID FROM Jogador WHERE ID_personagem = %s", (personagem_escolhido,))
    jogador_id = cursor.fetchone()[0]

    # Obter o inventário do jogador
    cursor.execute("SELECT ID, Tamanho FROM Inventario WHERE Jogador_ID = %s", (jogador_id,))
    inventario = cursor.fetchone()

    if inventario:
        inventario_id, tamanho_inventario = inventario
        imprimir_lentamente(f"\n-- Inventário do Jogador --\nTamanho: {tamanho_inventario}")

        # Selecionar os itens no inventário do jogador
        cursor.execute("""
            SELECT it.ID, it.nome, it.descricao
            FROM Inventario_item ii
            JOIN Instancia_Item inst ON ii.ID_item = inst.ID
            JOIN Item it ON inst.Item_ID = it.ID
            WHERE ii.ID_inventario = %s
        """, (inventario_id,))

        itens = cursor.fetchall()

        if itens:
            imprimir_lentamente("\nItens no inventário:")
            for item in itens:
                imprimir_lentamente(f"ID: {item[0]}, Nome: {item[1]}, Descrição: {item[2]}")
        else:
            imprimir_lentamente("\nO inventário está vazio.")
    else:
        imprimir_lentamente("\nInventário não encontrado para o jogador.")

    cursor.close()


def interagir_com_npc(conn, jogador_id):
    cursor = conn.cursor()

    # Buscar localização atual do jogador
    cursor.execute("SELECT localizacao FROM Jogador WHERE ID = %s", (jogador_id,))
    jogador = cursor.fetchone()
    if not jogador:
        imprimir_lentamente("Erro: Jogador não encontrado.")
        return

    localizacao_jogador = jogador[0]

    # Verificar se há um NPC na mesma localização
    cursor.execute("""
        SELECT n.id, n.nome, n.dialogo
        FROM NPC n
        JOIN Instancia_NPC i ON n.id = i.ID_NPC
        WHERE i.localizacao = %s
    """, (localizacao_jogador,))
    npc = cursor.fetchone()

    if not npc:
        imprimir_lentamente(f"Não há nenhum NPC ativo em {localizacao_jogador}.")
        return

    npc_id, npc_nome, npc_dialogo = npc

    imprimir_lentamente(f"\nVocê encontrou o NPC {npc_nome} em {localizacao_jogador}!")
    imprimir_lentamente(f"{npc_nome} diz: {npc_dialogo}")

    # Listar missões disponíveis
    cursor.execute("""
        SELECT m.ID, m.nome, m.descricao, m.tipo, m.premio
        FROM Missao m
        JOIN Instancia_Missao im ON m.ID = im.ID_Missao
        WHERE im.ID_NPC = %s AND im.estado = 'Disponível'
    """, (npc_id,))
    missoes = cursor.fetchall()

    if not missoes:
        imprimir_lentamente("\nNão há missões disponíveis com este NPC.")
        return

    imprimir_lentamente("\nMissões disponíveis:")
    for missao in missoes:
        missao_id, nome, descricao, tipo, premio = missao
        imprimir_lentamente(f"ID: {missao_id}, Nome: {nome}, Descrição: {descricao}, Tipo: {tipo}, Prêmio: {premio}")

    # Escolher missão
    try:
        imprimir_lentamente("\nDigite o ID da missão que deseja aceitar: ", fim='')
        missao_escolhida = int(input())
    except ValueError:
        imprimir_lentamente("Entrada inválida. Por favor, digite um número.")
        return

    # Verificar se a missão escolhida está disponível
    if any(m[0] == missao_escolhida for m in missoes):
        cursor.execute("UPDATE Instancia_Missao SET estado = 'Aceita' WHERE ID_Missao = %s AND ID_NPC = %s", (missao_escolhida, npc_id))
        conn.commit()
        imprimir_lentamente(f"\nVocê aceitou a missão '{missao_escolhida}' com sucesso!")
    else:
        imprimir_lentamente("\nMissão inválida. Tente novamente.")

    cursor.close()

def pegar_item(conn, personagem_escolhido):
    cursor = conn.cursor()

    # Verifica o inventário do jogador
    cursor.execute("""
        SELECT ID, Tamanho
        FROM Inventario
        WHERE Jogador_ID = %s
    """, (personagem_escolhido,))
    inventario = cursor.fetchone()

    if not inventario:
        print("Inventário não encontrado para o jogador.")
        return

    inventario_id, tamanho_atual = inventario

    # Verifica o número de itens já no inventário
    cursor.execute("""
        SELECT COUNT(*)
        FROM Inventario_item
        WHERE ID_inventario = %s
    """, (inventario_id,))
    numero_itens = cursor.fetchone()[0]

    # Verifica se há espaço no inventário
    if numero_itens >= tamanho_atual:
        imprimir_lentamente("\nSeu inventário está cheio. Não é possível pegar mais itens.")
        return

    # Verifica se existe um item na localização do jogador
    cursor.execute("""
        SELECT ii.ID, i.nome, i.descricao
        FROM Instancia_Item ii
        JOIN Item i ON ii.Item_ID = i.ID
        WHERE ii.localizacao = (
            SELECT localizacao
            FROM Jogador
            WHERE ID = %s
        )
    """, (personagem_escolhido,))
    item = cursor.fetchone()

    if not item:
        imprimir_lentamente("\nNão há nenhum item disponível no local.")
        return

    item_id, nome_item, descricao_item = item

    # Adiciona o item ao inventário do jogador
    cursor.execute("""
        INSERT INTO Inventario_item (ID_inventario, ID_item)
        VALUES (%s, %s)
    """, (inventario_id, item_id))

    # Atualiza a localização do item para NULL (item foi retirado do local)
    cursor.execute("""
        UPDATE Instancia_Item
        SET localizacao = NULL
        WHERE ID = %s
    """, (item_id,))

    conn.commit()

    imprimir_lentamente(f"\nVocê pegou o item '{nome_item}' e ele foi adicionado ao seu inventário.")
    imprimir_lentamente("O item não está mais disponível no local.")

    cursor.close()



def jogo(conn, personagem_escolhido):
    while True:
        cursor = conn.cursor()

        # Obter informações do jogador
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
        imprimir_lentamente(f"\n-- Informações do Jogador --")
        imprimir_lentamente(f"Nome do Jogador: {nome_jogador}")
        imprimir_lentamente(f"HP: {hp_atual}/1000")
        imprimir_lentamente(f"Estado: {estado}")
        imprimir_lentamente(f"Localização: {localizacao}")
        imprimir_lentamente(f"Atributos: Força={forca}, Agilidade={agilidade}")

        # Verificar se há NPC na localização atual
        cursor.execute(
            """
            SELECT p.nome, n.funcao
            FROM NPC n
            JOIN Personagem p ON n.ID = p.ID
            WHERE p.localizacao = %s AND p.ID NOT IN (1, 2)
            """, 
            (localizacao,)
        )
        npc = cursor.fetchone()

        if npc:
            nome_npc, funcao_npc = npc
            imprimir_lentamente(f"\nNPC presente: {nome_npc} ({funcao_npc})")
        else:
            imprimir_lentamente("\nNenhum NPC presente.")

        # Verificar se há zumbi na localização atual
        cursor.execute(
            """
            SELECT z.ID, z.forca, z.velocidade, z.hp
            FROM Instancia_Zumbi iz
            JOIN Zumbi z ON iz.ID_Zumbi = z.ID
            WHERE iz.localizacao = %s
            """, 
            (localizacao,)
        )
        zumbi = cursor.fetchone()

        if zumbi:
            zumbi_id, zumbi_forca, zumbi_velocidade, zumbi_hp = zumbi
            imprimir_lentamente(f"\nZumbi presente: Força={zumbi_forca}, Velocidade={zumbi_velocidade}, HP={zumbi_hp}")
        else:
            imprimir_lentamente("\nNenhum zumbi presente.")

        # Verificar se há item na localização atual
        cursor.execute(
            """
            SELECT it.nome, it.descricao
            FROM Instancia_Item ii
            JOIN Item it ON ii.Item_ID = it.ID
            WHERE ii.localizacao = %s
            """, 
            (localizacao,)
        )
        item = cursor.fetchone()

        if item:
            nome_item, descricao_item = item
            imprimir_lentamente(f"\nItem presente: {nome_item} - {descricao_item}")
        else:
            imprimir_lentamente("\nNenhum item presente.")

        # Opções do jogador
        imprimir_lentamente("\n-- O que você deseja fazer? --")
        imprimir_lentamente("1. Acessar inventário")
        imprimir_lentamente("2. Interagir com o NPC local")
        imprimir_lentamente("3. Mover para outro local")
        imprimir_lentamente("4. Lutar contra o zumbi presente")
        imprimir_lentamente("5. Pegar o item disponivel")
        imprimir_lentamente("6. Sair do jogo")

        escolha = input("\nEscolha uma opção: ")

        if escolha == "1":
            imprimir_lentamente("\nAcessando o inventário...")
            acessar_inventario(conn, personagem_escolhido)
        elif escolha == "2":
            if npc:
                imprimir_lentamente("\nInteragindo com o NPC local...")
                interagir_com_npc(conn, personagem_escolhido)
            else:
                imprimir_lentamente("\nNão há NPCs para interagir.")
        elif escolha == "3":
            imprimir_lentamente("\nMovendo-se para outro local...")
            mover_para_local(conn, personagem_escolhido)
        elif escolha == "4":
            if zumbi:
                imprimir_lentamente("\nLutando contra o zumbi presente...")
                lutar_contra_zumbi(conn, personagem_escolhido)
            else:
                imprimir_lentamente("\nNão há zumbis para lutar.")
        elif escolha == "5":
            if item:
                imprimir_lentamente("\nPegando o item presente no local")
                pegar_item(conn, personagem_escolhido)
            else:
                imprimir_lentamente("\nNão há itens disponiveis")
        elif escolha == "6":
            imprimir_lentamente("\nSaindo do jogo...")
            break
        else:
            imprimir_lentamente("\nOpção inválida. Tente novamente.")

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
    conn = conectar_banco()
    cursor = conn.cursor()

    # Consultar todos os jogadores na tabela Jogador
    cursor.execute("SELECT ID, nome, localizacao, missao_completada FROM Jogador")
    jogadores = cursor.fetchall()

    if not jogadores:
        print("Nenhum jogo salvo encontrado.")
        return None

    # Exibir os jogadores disponíveis
    print("\n-- Jogos Salvos --")
    for jogador in jogadores:
        imprimir_lentamente(f"ID: {jogador[0]}, Nome: {jogador[1]}, Localização: {jogador[2]}, Missão Completada: {jogador[3]}")

    # Solicitar que o usuário escolha um jogador pelo ID
    try:
        imprimir_lentamente("\nDigite o ID do jogador que deseja carregar: ", fim="")
        jogador_escolhido = int(input())
        
        # Verificar se o ID selecionado está na lista de jogadores
        if any(j[0] == jogador_escolhido for j in jogadores):
            imprimir_lentamente(f"Jogador com ID {jogador_escolhido} carregado com sucesso!")
            jogo(conn, jogador_escolhido)
            return jogador_escolhido  # Retorna o ID do jogador selecionado
        else:
            print("\nID inválido. Tente novamente.")
            return None
    except ValueError:
        print("\nEntrada inválida. Tente novamente.")
        return None
    finally:
        cursor.close()


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
