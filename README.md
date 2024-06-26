
# Projeto de Automação de Testes com Robot Framework no site do Ponto Frio <br>

<br>

### 🧪  Este projeto contém casos de teste em Robot Framework para testar a funcionalidade da aplicação web Site do Ponto Frio 
https://www.pontofrio.com.br/. <br>



<a  name="Configuração do Ambiente"></a>
### 🛠️ Configuração do Ambiente <br>
- Preferencia pelas versões ```Robot Framework 7.0.1 (Python 3.12.4)``` Linux, Windows macOs <br>
- Instale o Python e o pip se ainda não estiver instalados. <br>
- Para validar versões instaladas no terminal: <br>
```python --version``` <br>
```pip --version``` <br>

- Instale o Robot Framework. <br`
```pip install robotframework``` <br`
- Para validar versão instaladas no termina`: <br>
```robot --version``` <br>

- Download do Geckodriver:  https://github.com/mozilla/geckodriver/releases
- Download do chrome driver https://chromedriver.chromium.org/downloads
- Salvar ambos os arquivos executáveis (geckodriver e chrome driver), dentro da pasta scripts onde foi instalado o Python na sua máquina. <br>

- Download do Selenium Library: ```pip install robotframework-seleniumlibrary`` <br>`

`
### 🛠️ Executando os Testes <br>
- Para executar a Suite de testes e salvar o report em uma pasta separada, use os comandos: <br>

```sh
   robot -d ./reports tests/CarrinhoCompras.robot
   robot -d ./reports tests/BuscaProdutos.robot
```



### 📁 Visualizando resultados <br>
Dentro da pasta *reports*  É gerado os resultados dos testes, basta copiar o caminho do arquivos .html e setar no navegador para visualizar os resultados e logs. <br>



