*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String
Library    Collections

*** Variables ***
${BASE_URL}            https://www.pontofrio.com.br

*** Keywords ***
Abrir Navegador
    [Documentation]    Abre o navegador e navega até a página inicial do site
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    ${USER_AGENT}
    Create WebDriver    Chrome    chrome_options=${options}
    Maximize Browser Window

Fechar Navegador
    [Documentation]    Captura a tela e fecha o navegador
    Capture Page Screenshot
    Close Browser    

Abrir Página Inicial
    [Documentation]    Abre a página inicial do site do Ponto Frio
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    ${USER_AGENT}
    Create WebDriver    Chrome    chrome_options=${options}
    Go To    ${BASE_URL}
    Maximize Browser Window
    Wait Until Page Contains Element    css:input#search-form-input
    Wait Until Page Contains               text=${PONTO_FRIO}

Inserir Palavra-Chave no Campo de Busca
    [Arguments]    ${palavra}
    [Documentation]    Insere uma palavra-chave no campo de busca do site
    Element Should Be Visible    css:input#search-form-input
    Input Text    css:input#search-form-input    ${palavra}

Clicar no Botão de Busca
    [Documentation]    Clica no botão de busca do site
    Click Button    css:button.css-1hppjzv

Verificar Lista de Produtos Contendo Palavra-Chave
    [Arguments]    ${palavra}
    [Documentation]    Verifica se a lista de produtos contém a palavra-chave especificada
    Wait Until Element Is Visible    css:h3.product-card__title
    ${produtos}=    Get WebElements    xpath=//h3[contains(@class, 'product-card__title')]
    FOR    ${produto}    IN    @{produtos}
        ${titulo}=    Get Text    ${produto}
        Should Contain    ${titulo.lower()}    ${palavra.lower()}
    END

Buscar Por Palavra-Chave
    [Arguments]    ${palavra}
    [Documentation]    Executa uma busca por palavra-chave no site
    Abrir Página Inicial
    Inserir Palavra-Chave no Campo de Busca    ${palavra}
    Clicar no Botão de Busca

Aplicar Filtro de Preço
    [Documentation]    Aplica um filtro de preço no site
    Sleep    2s
    Scroll Element Into View            xpath=//input[contains(@id, 'Preço - De R$ 600 até R$ 999')]
    Page Should Contain Element         xpath=//input[contains(@id, 'Preço - De R$ 600 até R$ 999')]    timeout=30s
    ${is_visible} =    Execute JavaScript    return document.querySelector("input[id*='Preço - De R$ 600 até R$ 999']") !== null && document.querySelector("input[id*='Preço - De R$ 600 até R$ 999']").offsetHeight > 0;
    Should Be True    ${is_visible}    timeout=30s
    Execute JavaScript    document.querySelector("input[id*='Preço - De R$ 600 até R$ 999']").click();
    Sleep    3s
    Wait Until Page Contains Element    css:h3.product-card__title    timeout=30s
    
Verificar Lista de Produtos Filtrados Por Preço
    [Arguments]    ${precoMinimo}    ${precoMaximo}
    [Documentation]    Verifica se a lista de produtos foi filtrada corretamente por preço
    Wait Until Element Is Visible    css:h3.product-card__title
    ${produtos}=    SeleniumLibrary.Get WebElements    xpath=//div[contains(@class, 'product-card')]
    ${produtos_count}=    BuiltIn.Get Length    ${produtos}
    FOR    ${produto}    IN    @{produtos}
        ${precoElement}=    SeleniumLibrary.Get WebElement    xpath=.//div[contains(@class, 'product-card__highlight-price')]
        ${preco}=    SeleniumLibrary.Get Text    ${precoElement}
        ${preco}=    BuiltIn.Convert To Number    ${preco.replace('R$', '').replace('.', '').replace(',', '.').strip()}
        ${preco_valido}=    Evaluate    ${preco} >= ${precoMinimo} and ${preco} <= ${precoMaximo}
        Should Be True    ${preco_valido}    Evaluation of price range failed
    END

Verificar Mensagem de Produto Não Encontrado
    [Documentation]    Verifica se a mensagem de produto não encontrado é exibida corretamente
    Wait Until Page Contains    Desculpe, não encontramos essa página
