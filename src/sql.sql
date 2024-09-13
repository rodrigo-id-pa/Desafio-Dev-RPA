/*
Você é o analista de dados responsável por gerenciar o banco de dados de uma empresa de varejo alimentício. Para isso, você precisa criar uma consulta para obter o nome das lojas que apresentaram um aumento no faturamento entre o ano atual e o ano anterior. A consulta deve considerar as tabelas relevantes, como DimStore e FactSales, e deve filtrar apenas as lojas que tiveram aumento no faturamento.

●Tabela DimStore:
-Colunas Relevantes: StoreID, StoreName
●Tabela FactSales:
-Colunas Relevantes: StoreID, SalesAmount, SaleDate

Com base nessa situação, qual seria a consulta SQL correta?

1 Envolve um SELECT do nome da loja na tabela DimStore, onde o ID da loja está presente na tabela FactSales. O filtro compara o valor atual de vendas com o valor máximo de vendas do ano anterior, selecionando apenas as lojas que tiveram aumento no faturamento. 
2 Consiste em uma consulta SQL que busca o nome das lojas na tabela DimStore. O filtro é baseado no ID da loja presente na tabela FactSales, considerando apenas aquelas cujo valor atual de vendas é maior que a média do valor de vendas do ano anterior. 
3 Requer um SELECT do nome da loja a partir da tabela DimStore, onde o ID da loja está presente na tabela FactSales. O filtro compara o valor atual de vendas com o valor mínimo de vendas do ano anterior, selecionando apenas as lojas que tiveram aumento no faturamento. 
4 Deve ser realizado um SELECT do nome da loja a partir da tabela DimStore, onde o ID da loja está presente na tabela FactSales. A condição de filtro compara o valor atual de vendas (SalesAmount) com a soma do valor de vendas do ano anterior, apenas para as lojas que apresentaram aumento no faturamento. 
5 Implica em um SELECT do nome da loja na tabela DimStore. A condição de filtro compara o valor atual de vendas com a soma do valor de vendas do ano anterior, além de garantir que o valor atual de vendas seja maior que zero, selecionando apenas as lojas que apresentaram aumento no faturamento

RESP: 4 Deve ser realizado um SELECT do nome da loja a partir da tabela DimStore, onde o ID da loja está presente na tabela FactSales. 
A condição de filtro compara o valor atual de vendas (SalesAmount) com a soma do valor de vendas do ano anterior, apenas para as lojas que apresentaram aumento no faturamento.
*/

SELECT ds.StoreName
FROM DimStore ds
  JOIN (
    SELECT fs.StoreID,
    SUM(CASE WHEN YEAR(fs.SaleDate) = YEAR(CURDATE()) THEN fs.SalesAmount ELSE 0 END) AS CurrentYearSales,
    SUM(CASE WHEN YEAR(fs.SaleDate) = YEAR(CURDATE()) - 1 THEN fs.SalesAmount ELSE 0 END) AS PreviousYearSales
  FROM FactSales fs
  GROUP BY fs.StoreID
) AS SalesSummary
  ON ds.StoreID = SalesSummary.StoreID
WHERE SalesSummary.CurrentYearSales > SalesSummary.PreviousYearSales;


/*
O diretor comercial busca uma análise mais aprofundada da performance das lojas físicas da sua companhia em termos de quantidade vendida e quantidade devolvida. Ele deseja incluir apenas as lojas cujas vendas foram superiores à média geral das vendas em todas as lojas, levando em consideração a margem de lucro dos produtos. Além disso, a análise deve abranger o período dos últimos três meses.
Considerando um banco de dados de uma indústria de varejo, com as tabelas FactSales (com as colunas SaleID, ProductID, StoreID, QuantitySold, QuantityReturned, SaleDate) foi desenvolvido um código para essa consulta.

Esse código não está retornando o esperado, o que pode estar errado?

1 A cláusula ORDER BY deve ser posicionada antes da cláusula GROUP BY. 
2 A cláusula WHERE não é permitida após a cláusula GROUP BY. 
3 A condição SaleDate >= CURRENT_DATE - INTERVAL '3' MONTH deve ser movida para a cláusula HAVING. 
4 A função AVG(QuantitySold) na cláusula HAVING não pode ser comparada diretamente com a subconsulta. 
5 A cláusula HAVING deve ser utilizada após a cláusula GROUP BY e a cláusula WHERE antes do GROUP BY.

RESP: 5 A cláusula HAVING deve ser utilizada após a cláusula GROUP BY e a cláusula WHERE antes do GROUP BY.

--Análise dos Problemas--
Ordem das Cláusulas:

HAVING e GROUP BY: A cláusula HAVING deve ser usada após a cláusula GROUP BY. No código fornecido, a cláusula HAVING está antes do GROUP BY, o que está incorreto.

WHERE: A cláusula WHERE deve ser usada antes da cláusula GROUP BY para filtrar as linhas antes da agregação. No código fornecido, a cláusula WHERE está após o GROUP BY, o que está incorreto.

ORDER BY: A cláusula ORDER BY deve ser usada após a cláusula GROUP BY, e isso está correto no código fornecido.
*/

SELECT storeid,
  AVG(quantitysold) AS mediavendido,
  AVG(quantityreturned) AS mediadevolvido
FROM
  factsales
HAVING 
    AVG(quantitysold) > (SELECT AVG(quantitysold)
FROM factsales)
GROUP BY  storeid
WHERE saledate >= CURRENT_DATE - INTERVAL '3' MONTH
ORDER BY mediavendido DESC

/*
Você foi contratado para trabalhar em uma empresa de varejo que vende produtos pela internet e fisicamente. Você recebeu a atividade de criar relatórios de vendas para a empresa de varejo. Considere a tabela TBL_Products com as colunas ProductID, ProductName, UnitPrice, Weight e SalesAmount .

Você precisa listar os TOP 10 produtos em vendas e, em caso de empate, pelo que tem o maior preço unitário. Qual consulta SQL atende a esse requisito?

1 SELECT * FROM Products ORDER BY UnitPrice ASC, SalesAmount ASC LIMIT 10; 
2 SELECT * FROM Products ORDER BY SalesAmount ASC, UnitPrice DESC LIMIT 10; 
3 SELECT * FROM Products ORDER BY SalesAmount DESC, UnitPrice DESC LIMIT 10; 
4 SELECT * FROM Products ORDER BY UnitPrice DESC, SalesAmount ASC LIMIT 10; 
5 SELECT * FROM Products ORDER BY UnitPrice DESC, SalesAmount DESC FETCH FIRST 10 ROWS ONLY;

RESP: 3 SELECT * FROM Products ORDER BY SalesAmount DESC, UnitPrice DESC LIMIT 10;
*/


/*
Em qual dos seguintes cenários seria mais apropriado utilizar um banco de dados não estruturado em vez de um banco de dados estruturado?

1 Uma empresa precisa armazenar informações detalhadas sobre transações financeiras, incluindo datas, valores e contas de origem e destino. 
2 Uma loja de comércio eletrônico precisa gerenciar informações sobre produtos, incluindo categorias, preços e estoque. 
3 Um blogueiro deseja armazenar postagens de blog que variam em formato e conteúdo, com diferentes tipos de mídia incorporada. 
4 Um hospital precisa manter registros de pacientes, incluindo informações pessoais, histórico médico e resultados de exames. 
5 Uma equipe de desenvolvimento está criando um sistema de gerenciamento de biblioteca, onde é necessário rastrear informações sobre livros, autores e empréstimos.

RESP: 3 Um blogueiro deseja armazenar postagens de blog que variam em formato e conteúdo, com diferentes tipos de mídia incorporada.
*/


/*
Estamos estruturando a arquitetura de dados de uma empresa do segmento de logística para que seus dados passem a ser armazenados de forma automática e digital. Essa empresa de logística, nesse momento, deseja registrar o dia, código da caixa e a quantidade de caixas daquele mesmo pedido que chegaram em seu centro. Para isso, conta com uma esteira que contém sensores que registram essas informações com o dia, hora, minuto e segundo que a caixa passa pelo sensor, lê o código da caixa e também disponibiliza informações sobre velocidade da esteira, vibração e potência. Como você estruturaria o fluxo de informações para termos o relatório desejado?

Resposta obrigatória
1 Extrai o relatório da esteira periodicamente, envia para o Data Lake, carrega os relatórios do Data Lake para fazer o refinamento necessário das informações para salvar esse relatório resultante em um Data Warehouse e disponibiliza a informação 
2 Extrai o relatório da esteira periodicamente e envia para seu Data Warehouse apresentando todas as informações 
3 Extrai o relatório da esteira periodicamente, envia para o Data Lake, carrega os relatórios do Data Lake para fazer o refinamento necessário das informações e ter somente o conteúdo desejado e sobrescreve o arquivo no Data Lake 
4 Extrai o relatório da esteira periodicamente, envia para o Data Warehouse, realiza as transformações necessárias para ter somente as informações necessárias no Data Warehouse e salva em uma nova tabela.

RESP: 1 Extrai o relatório da esteira periodicamente, envia para o Data Lake, carrega os relatórios do Data Lake para fazer o refinamento necessário das informações para salvar esse relatório resultante em um Data Warehouse e disponibiliza a informação.
*/


/*
Considere a base de dados de um varejo eletrônico apresentada a seguir.
Para aplicar técnicas de machine learning, quais tratamentos de dados são necessários?

D. Todas as alternativas são necessárias para preparar os dados para técnicas de machine learning.
B. Normalizar as colunas numéricas, como "Preço" e "Quantidade em Estoque", para garantir que todas estejam na mesma escala.
E. Apenas os demais, pois get_dummies não é aplicável neste contexto.
A. Aplicar get_dummies na variável "Categoria do Produto" para converter as categorias em colunas binárias.
C. Tratar valores ausentes, se houver, em qualquer uma das colunas.

uma tabela com 5 colunas com id, produto, categoria, preco e quantidade com N linhas

RESP: D. Todas as alternativas são necessárias para preparar os dados para técnicas de machine learning.
*/

/*
Você é um cientista de dados em uma empresa de segurança cibernética e tem o desafio de desenvolver um modelo de classificação de e-mails para distinguir entre e-mails de spam e e-mails legítimos (não spam). Você tem à disposição três modelos de machine learning para abordar esse problema. Cada modelo foi avaliado usando matrizes de confusão. Analise as matrizes e escolha a alternativa que justifica qual modelo tem o melhor desempenho para o problema em questão.

1 O Modelo C é preferível, pois possui um equilíbrio entre precisão e recall, minimizando tanto os falsos positivos quanto os falsos negativos. 
2 O Modelo B é superior, pois tem a menor contagem de falsos positivos, indicando menor probabilidade de classificar erroneamente um e-mail legítimo como spam. 
3 O Modelo B é o melhor, pois apresenta a maior precisão, indicada pela maior contagem de verdadeiros positivos em relação aos falsos positivos. 
4 O Modelo A é o mais adequado, pois possui a maior contagem de verdadeiros positivos e a menor contagem de falsos negativos. 
5 O Modelo A é o mais eficaz, pois alcança a maior taxa de verdadeiros negativos, indicando uma boa capacidade de identificar e-mails não spam.

tabela com 4 colunas, modelo, spam/naospam, previsto com numeros inteiros, imprevisto com numeros inteiros
GROUP BY em coluna modelos com valores modelo A, B e C, cada um com 2 infos.

RESP: 4 O Modelo A é o mais adequado, pois possui a maior contagem de verdadeiros positivos e a menor contagem de falsos negativos.
*/


/*
Você está responsável por realizar um projeto de manutenção preditiva de uma máquina importante no processo produtivo de uma indústria. Logo, dadas algumas caraterísticas da máquina, informar em quanto tempo a máquina irá possivelmente ter um problema para fazer a manutenção antecipada. Para tal, os dados se dispõem da seguinte forma:

Qual das seguintes transformações nos dados deveria ser feita para realizar o modelo proposto?

1 Remover o dado de vibração ou ruído pois, como possuem alta correlação, isso prejudicará o modelo além de fazer um lag na feature de falha 
2 Remover o dado de vibração ou ruído pois, como possuem alta correlação, isso prejudicará o modelo 
3 Transformar a coluna de Falha para um valor contínuo 
4 Remover o dado de ruído pois ele não possui relação com o problema 
5 Remover o dado de vibração ou ruído pois, como possuem baixa correlação, isso prejudicará o modelo

tabela:
data | potencia | vibração | ruido | falha
010123 | x1 | y1 | z1 | 0
010223 | x2 | y2 | z2 | 0
010323 | x3 | y3 | z3 | 1

RESP: 1 Remover o dado de vibração ou ruído pois, como possuem alta correlação, isso prejudicará o modelo além de fazer um lag na feature de falha.
*/


/*
Você está desenvolvendo um modelo para dizer o salário de uma pessoa com base em características da pessoa e percebe que as variáveis de Idade e Salário Médio da companhia que trabalha são importantes para o modelo. Para utilizar essas duas variáveis na previsão é necessário:

1 Normalizar os dados de Idade para que sigam uma distribuição assimétrica 
2 Remover os valores médios das duas variáveis no dataset uma vez que isso pode influenciar o modelo a seguir um comportamento médio 
3 Normalizar ambos os dados de idade e salário médio para que sigam uma distribuição assimétrica 
4 Escalar os dados de idade e salário para que variem dentro de um mesmo intervalo 
5 Normalizar os dados de Salário médio para que sigam uma distribuição assimétrica

RESP: 4 - Escalar os dados de idade e salário para que variem dentro de um mesmo intervalo.
*/