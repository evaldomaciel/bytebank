# ByteBank

Curso de Flutter da Alura. 
## Flutter com Web API
### Checklist de aulas: 

- [X] Introdução
- [X] Novas funcionalidades no dashboard
- [X] Delegando eventos com callbacks
- [X] Adicionando a lista de transferências
- [X] Configurando o ambiente da web API
- [X] Buscando transferências da web API
- [X] Utilizando o interceptador do HTTP 
- [ ] Convertendo JSON para objeto do Dart 
- [ ] Carregando a lista de transferências na tela 
- [ ] Lidando com problemas da comunicação externa 
- [ ] Salvando transferências 
- [ ] Integrando a inserção de transferências
- [ ] Recapturando o código 
- [ ] Serializando JSON no objeto
- [ ] Simplificando o código de conversão 
- [ ] Conclusão


## Dependências instaladas
- flutter:
-   sdk: flutter
- sqflite: 
- path:
- http: ^0.13.5
- http_interceptor: ^1.0.2

Dependência http foi instalada via linha de comando "$ dart pub add http" e especificando o número da versão. Depois foi rodando o comando para validar se há atualização e realizar o upgrade "$ dart pub upgrade http";


# Bytebank web API

Web API em Spring Boot para consumo do App em Flutter do Bytebank

## Funcionalidades

A Web API oferece as seguintes funcionalidades:

- Listagem e cadastro de transações.

## Como executar

Abra o terminal ou prompt e acesse o arquivo **server.jar**, então execute o seguinte comando:

```
java -jar server.jar
```

> A build do projeto foi feita com base no Java 8, portanto, é recomendado usar o Java 8 para que tudo funcione como esperado.

## Modificando properties de inicialização

Por padrão o Spring Boot vai rodar a aplicação na porta `8080` e vai configurar a senha padrão no valor `1000` para salvar transações.

Caso queria modificar ambos valores execute o arquivo da seguinte maneira:

```
java -jar server.jar --server.port=8081 --user.password=2000
```

> Nesta amostra a web api vai rodar na porta `8081` com a senha de transações `2000`

## Mapeamento de end-points

Para acessar as funcionalidades foram disponibilizados os seguintes end-points:

- `/transactions`:
  - **GET**: Listagem:
    - O resultado é ordenado pela data e hora da criação em ordem crescente.

  ```
  // response example
  [
      {
          "id": "b9663ef3-3749-400e-be8f-1280db94aac8",
          "value": 200.00,
          "contact": {
              "name": "gui",
              "accountNumber": 1000
          },
          "dateTime": "2019-11-06 12:57:23"
      },
      {
          "id": "d1bf689c-caa2-4e45-b1fc-5a90b10d6d48",
          "value": 200.00,
          "contact": {
              "name": "gui",
              "accountNumber": 1500
          },
          "dateTime": "2019-11-06 12:57:37"
      }
  ]
  ```

  - **POST**: Inserção:
    - Para salvar a transação é necessário o envio no *header* do parâmetro `password` conforme o valor configurado na aplicação:
      - Caso não seja enviado, é retornado `400 BAD REQUEST`;
      - Caso falhar na autenticação `401 UNAUTHORIZED`.
    - Não é possível alterar a transação, caso haja a tentativa é retornado `409 CONFLICT`.

  ```
  // request body example
  {
    	"value": 200.0,
    	"contact": {
    		"name": "gui",
    		"accountNumber": 1000
    	}
  }

  // response example
  {
        "id": "b9663ef3-3749-400e-be8f-1280db94aac8",
        "value": 200.00,
        "contact": {
            "name": "gui",
            "accountNumber": 1000
        },
        "dateTime": "2019-11-06 12:57:23"
  }
  ```