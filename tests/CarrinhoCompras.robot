*** Settings ***
Resource      ../keywords/CarrinhoKeywords.robot
Resource      ../variables/CommonVariables.robot
Suite Setup   Abrir Navegador
Suite Teardown   Fechar Navegador

*** Test Cases ***
Adicionar um produto ao carrinho
    [Documentation]  Cenário: Adicionar um produto ao carrinho
    Abrir página de detalhes do produto
    Clicar no botão "Comprar"
    Verificar produto adicionado ao carrinho

Remover um produto do carrinho
    [Documentation]  Cenário: Remover um produto do carrinho
    Remover produto do carrinho
    Verificar carrinho atualizado

Alterar a quantidade de um produto no carrinho
    [Documentation]  Cenário: Alterar a quantidade de um produto no carrinho
    Abrir página de detalhes do produto
    Clicar no botão "Comprar"
    Alterar Quantidade de Produto no Carrinho    ${nova_quantidade}

Adicionar vários produtos ao carrinho
    [Documentation]  Cenário: Adicionar vários produtos ao carrinho
    Abrir página de detalhes do produto
    Adicionar produto ao carrinho
    Navegar para outro produto e adicionar ao carrinho
    Verificar ambos os produtos no carrinho
