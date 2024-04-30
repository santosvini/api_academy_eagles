# Robor Framework - API Tests Academy(Team Eagles):robot:

![Logo Robot](image.png)

Projeto de automação de API com o ```Robot Framework```.

O ServeRest é uma API REST gratuita que simula uma loja virtual com intuito de servir de material de estudos de testes de API.

## Instalação

*Instalando o Python*

[Python](https://python.org.br/instalacao-windows/)

*Instalando o Pip*

```bash
  pip -m pip install --upgrade pip
  pip -m pip --version
```

*Instalando as tecnologias e libs necessárias do projeto*

[Instalação do Robot](https://robotframework.org/?tab=1#getting-started)

```bash
  pip install robotframework
```

*Demais Libraries para os testes de API*

```bash
  pip install robotframework-requests
```
```bash
  pip install robotframework-jsonlibrary
```

Siga os comandos e após, caso seja do interesse, instale a lib faker

```bash
  pip install robotframework-faker
```

Para validar todas as instalações

```bash
  pip list
  pip freeze
```

Criar requirements.txt com as

## Stacks utilizada

**Libraries**: Builtin, Faker, SeleniumLibrary, Collections, String, JsonLibrary e Requests

**Automação:** Robot Framework

<!-- **Shell**: Shell Script -->

## Rodando localmente

Clone o projeto:

```bash
  git clone https://github.com/santosvini/api_academy_eagles.git
```

Entre no diretório do projeto

```bash
  cd api_academy_eagles
```
Para rodar os testes, rode o seguinte comando

```bash
  robot -d ./log /tests
```

## Feedback

Se você tiver algum feedback, por favor nos deixe saber por meio de [issues](https://github.com/santosvini/api_academy_eagles/issues), desse repositorios

## Autor

- [@santosvini](https://github.com/santosvini)
