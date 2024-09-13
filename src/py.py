'''
Você trabalha em uma escola e está ajudando a organizar uma olimpíada interna de raciocínio lógico entre os alunos. Ganhará o torneio o aluno que conseguir responder o maior número de questões. Ao final da prova, você como responsável, recebe arquivo “notas.csv” com duas colunas: (Coluna_1: NOME, Coluna_2: QUESTÕES). O problema é que são muitos alunos e você deseja saber rapidamente quem ganhou, mas não tem tempo para procurar nome por nome no arquivo. Um estagiário, para te ajudar, desenvolveu um função em Python que retorna o nome do aluno com maior nota e sua respectiva pontuação. Para realizar um teste ao invés do arquivo “notas.csv” ele passa o seguinte dicionário para a função:
'''
dicionario_de_valores = {'Alice': 8, 'Bob': 35,
                         'Charlie': 20, 'Pedro': 8, 'David': 35}


def encontrar_maior(dicionario):
    if not dicionario:
        return None, None

    # Inicializa a variável com o primeiro item do dicionário
    nome_maior_n, maior_n = next(iter(dicionario.items()))

    # Itera sobre todos os itens do dicionário
    for nome, numero in dicionario.items():
        # Atualiza se encontrar um número maior
        if numero > maior_n:
            maior_n = numero
            nome_maior_n = nome
    print(nome_maior_n, maior_n)
    return nome_maior_n, maior_n


encontrar_maior(dicionario_de_valores)
"resp: BOB: 35"

'''
O estacionamento de uma universidade utiliza uma estrutura de dados do tipo pilha para organizar as informações dos carros. Ao analisar a implementação da classe “PilhaEstacionamento” em Python, foi identificado um erro relacionado à lógica da estrutura de dados. Considere a seguinte implementação:

1 - A função sair_estacionamento está implementada incorretamente, pois remove o primeiro carro adicionado à pilha em vez do último. 
2 - O código não compila devido a um erro na lógica da estrutura de dados. 
3 - O código está correto e implementa uma estrutura de dados do tipo pilha para o estacionamento de carros. 
4 - A função entrar_estacionamento deveria receber como parâmetro um objeto Carro, mas atualmente aceita qualquer tipo de dado. 
5 - Se o estacionamento estiver vazio e a função sair_estacionamento for chamada, o código retorna corretamente "Estacionamento vazio."
'''


class pilhaEstacionamento:
    def __init__(self):
        self.carros = []

    def entrar_estacionamento(self, carro):
        self.carros.append(carro)

    def sair_estacionamento(self):
        if not self.carros:
            return "estacionamento vazio"
        else:
            return f"o carro {self.carros.pop(0)} saiu do estacionamento."
            # certo seria: return f"o carro {self.carros.pop()} saiu do estacionamento.


'''
resp:
1 - A função sair_estacionamento está implementada incorretamente, pois remove o primeiro 
carro adicionado à pilha em vez do último.'''

'''
Considere um cenário em que um cientista de dados precisa ordenar um conjunto de dados contendo as medições de temperatura ao longo de um ano para uma determinada cidade. Dada a necessidade de analisar as variações de temperatura ao longo do tempo, é crucial utilizar um algoritmo de ordenação eficiente.

Qual é o grau de eficiência Big O (notação assintótica) do algoritmo de ordenação (quicksort) aplicado no contexto das medições de temperatura?

1 - O(n) O algoritmo quicksort possui complexidade linear, sendo eficiente para conjuntos pequenos de dados.

2 - O(n^2) A eficiência do quicksort degrada para O(n^2) no pior caso, tornando-se menos adequado para conjuntos extensos.

3 - O(log n) A complexidade logarítmica não é aplicável ao quicksort, que se destaca pela eficiência em relação a abordagens de divisão e conquista.

4 - O(1) O algoritmo quicksort não pode ser descrito como O(1), já que sua complexidade varia de acordo com o tamanho do conjunto de dados.

5 - O(n log n) A complexidade do quicksort é O(n log n), garantindo eficiência para conjuntos de dados moderadamente grandes.
'''


def quicksort(arr):
    if len(arr) <= 1:
        return arr
    else:
        pivot = arr[0]
        less = [x for x in arr[1:] if x <= pivot]
        greater = [x for x in arr[1:] if x > pivot]
        return quicksort(less) + [pivot] + quicksort(greater)


"resp:"
'''
O(n^2) A eficiência do quicksort degrada para 𝑂(𝑛2)O(n2) no pior caso,
tornando-se menos adequado para conjuntos extensos.
'''


# O que será impresso após a execução do trecho de código Python da imagem?
'''
a, b = 0, 1
while a <= 13:
    if (a % 2) == 1:
        print(a)
    a, b = b, a + b
'''
"resp: 1,1,3,5,13"

# O que o algoritmo da imagem realiza?
'''
1 Os fatores do número inserido pelo usuário
2 Uma sequência de linhas conforme o número inserido pelo usuário
3 uma String contendo a multiplicação do número informado pelo usuário por 10
4 A décima potência do número inserido pelo usuário
5 A tabuada do número inserido pelo usuário'''

num = int(input("informe o numero:"))

for i in range(1, 10):
    print(num, 'x', i, '=', (num * i))

"resp: 5 - A tabuada do número inserido pelo usuário"
