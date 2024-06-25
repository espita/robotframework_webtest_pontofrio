*** Settings ***
Library           SeleniumLibrary
Library           Collections
Library           OperatingSystem
Resource          ../variables/CommonVariables.robot

*** Variables ***
${CARRINHO_LOCATOR}        xpath://a[@data-testid='cart']
${QUANTIDADE_LOCATOR}      css:select[data-testid^='quantity-select-']
${REMOVER_MENSAGEM_LOCATOR}    xpath://p[contains(@class, 'styled__Container-e8qtbd-0') and text()='Produto removido do carrinho']
${REMOVER_BOTAO_LOCATOR}   xpath://button[contains(@class, 'dsvia-button css-arp470') and contains(text(), 'Remover')]

*** Keywords ***
Abrir Navegador
    [Documentation]    Abre o navegador, inicia sessão e navega para a página inicial
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    ${USER_AGENT}
    Create WebDriver    Chrome    chrome_options=${options}
    Go To    ${BASE_URL}
    Maximize Browser Window
    Wait Until Page Contains    ${PONTO_FRIO}

Fechar Navegador
    [Documentation]    Captura a tela, fecha o navegador e encerra a sessão
    Capture Page Screenshot
    Close All Browsers    

Abrir Página de Detalhes do Produto
    [Documentation]    Abre a página de detalhes de um produto específico
    Maximize Browser Window
    Go To    ${BASE_URL}/controle-xbox-series-carbon-black/p/1563547708

Clicar no Botão "Comprar"
    [Documentation]    Clica no botão "Comprar" na página de detalhes do produto
    Wait Until Element Is Visible    id:buy-button    timeout=15s
    Click Element    id:buy-button

Verificar Produto Adicionado ao Carrinho
    [Documentation]    Verifica se o produto foi adicionado corretamente ao carrinho
    Wait Until Element Is Visible    css:.dsvia-heading.css-af5b0r    timeout=15s
    Element Text Should Be    css:.dsvia-heading.css-af5b0r    Controle Xbox Series Carbon Black

Abrir Carrinho de Compras
    [Documentation]    Abre o carrinho de compras
    Scroll Element Into View    ${CARRINHO_LOCATOR}
    Wait Until Element Is Visible    ${CARRINHO_LOCATOR}    timeout=10s
    Click Element    ${CARRINHO_LOCATOR}
    Wait Until Page Contains Element    ${QUANTIDADE_LOCATOR}    timeout=10s

Remover Produto do Carrinho
    [Documentation]    Remove um produto específico do carrinho
    Wait Until Element Is Visible    ${REMOVER_BOTAO_LOCATOR}    timeout=10s
    Click Element    ${REMOVER_BOTAO_LOCATOR}
    Wait Until Element Is Visible    ${REMOVER_MENSAGEM_LOCATOR}    timeout=10s

Verificar Carrinho Atualizado
    [Documentation]    Verifica se o carrinho foi atualizado corretamente após remover um produto
    Element Text Should Be    ${REMOVER_MENSAGEM_LOCATOR}    Produto removido do carrinho

Alterar Quantidade de Produto no Carrinho
    [Arguments]    ${quantidade}
    ${quantidade_locator}=    Set Variable    xpath://select[@data-qa='item-quantity']
    Wait Until Element Is Visible    ${quantidade_locator}    timeout=15s
    Set Focus To Element    ${quantidade_locator}
    Select From List By Value    ${quantidade_locator}    ${quantidade}
    Wait Until Element Is Visible    ${quantidade_locator}       ${quantidade} 

Adicionar Produto ao Carrinho
    [Documentation]    Adiciona um produto ao carrinho
    Abrir Navegador
    Go To    ${BASE_URL}/controle-xbox-series-carbon-black/p/1563547708
    Clicar no Botão "Comprar"

Navegar para Outro Produto e Adicionar ao Carrinho
    [Documentation]    Navega para outro produto e o adiciona ao carrinho
    Go To    ${BASE_URL}/jogo-do-xbox-one-red-dead-redemption-2/p/1548262380
    Clicar no Botão "Comprar"

Verificar Ambos os Produtos no Carrinho
    [Documentation]    Verifica se ambos os produtos estão no carrinho
    Wait Until Element Is Visible    xpath://li[contains(@data-id, 'cart-sku')]