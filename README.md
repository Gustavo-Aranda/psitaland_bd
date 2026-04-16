# Projeto PSITaLand DB

Este projeto contém a configuração do banco de dados Oracle XE em Docker, incluindo scripts de inicialização localizados em `init-db/`.

## Estrutura do projeto

- `docker-compose.yml` - define o serviço do banco Oracle XE e o volume de dados.
- `init-db/` - scripts SQL que serão executados automaticamente na primeira inicialização do container.
  - `01_criar user.sql`
  - `02_banco.sql`
  - `03_sequences_e_triggers.sql`

## Requisitos

- Docker instalado
- Docker Compose instalado
- Conexão com internet para baixar a imagem `gvenzl/oracle-xe:21-slim`

## Como iniciar o banco de dados

1. Abra um terminal na pasta do projeto.
2. Execute:

```powershell
docker compose up -d
```

ou, em versões antigas do Docker Compose:

```powershell
docker-compose up -d
```

3. Aguarde o container subir. O serviço do banco ficará disponível em `localhost:1521`.

## Acesso ao banco

O `docker-compose.yml` define estes usuários e senhas:

- `SYS`/`123` (usuário do sistema Oracle)
- `APP_USER=hr` e `APP_USER_PASSWORD=hr` (usuário de aplicação configurado pelo container)

> Se for necessário mudar as credenciais, edite os valores em `docker-compose.yml` antes de subir o container.

## Inicialização dos scripts SQL

Os arquivos dentro de `./init-db` são copiados para `/container-entrypoint-initdb.d` no container Oracle. Eles são executados apenas na primeira inicialização do container, quando a pasta de dados ainda não existe.

Isso significa:

- Na primeira vez que `docker compose up -d` for executado, os scripts serão aplicados.
- Em reinicializações subsequentes, os scripts não serão reaplicados automaticamente.

## Comandos úteis

Parar o serviço:

```powershell
docker compose down
```

Ver logs do container:

```powershell
docker compose logs -f
```

Remover volumes e forçar reexecução dos scripts de inicialização:

```powershell
docker compose down -v
```

> Cuidado: o comando `-v` remove o volume de dados do Oracle e apaga todos os dados persistidos.

## Observações

- Se você alterar os scripts em `init-db/` depois da primeira execução, será necessário remover o volume de dados (`docker compose down -v`) para que os scripts sejam reaplicados.
- O container é configurado para reiniciar automaticamente usando `restart: always`.
