*** Settings ***
Resource    ../keywords/BuscaKeywords.robot
Resource    ../variables/CommonVariables.robot
Suite Setup    Abrir Navegador
Suite Teardown    Fechar Navegador

*** Test Cases ***
Buscar produtos utilizando uma palavra-chave válida
    [Documentation]    Cenário: Buscar produtos utilizando uma palavra-chave válida
    Abrir Página Inicial
    Inserir Palavra-Chave no Campo de Busca    smartphone
    Clicar no Botão de Busca
    Verificar Lista de Produtos Contendo Palavra-Chave    smartphone

Aplicar filtros na busca de produtos
    [Documentation]    Cenário: Aplicar filtros na busca de produtos
    Buscar Por Palavra-Chave    notebook
    Aplicar Filtro de Preço
    Verificar Lista de Produtos Filtrados Por Preço    600    999

Buscar produto inexistente
    [Documentation]    Cenário: Buscar produto inexistente
    Abrir Página Inicial
    Inserir Palavra-Chave no Campo de Busca    Produtoinexistente
    Clicar no Botão de Busca
    Verificar Mensagem de Produto Não Encontrado