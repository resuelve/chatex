# Chatex

Cliente de Elixir para el GoogleChat API.

## Instalación

Primero, agrega Flowex a su tus dependencias en mix.exs:

```elixir
def deps do
  [
    {:chatex, "~> 1.0.0"}
  ]
end
```

### Configurar variables de entorno.

El archivo __.env.dist__ contiene un listado actualizado de las variables de entorno necesarias para el proyecto, se debe copiar ese archivo a uno nuevo llamado __.env__

Tambien necesitaras crear un archivo llamando google_credentials.json dentro de la carpeta secrets.

Preguntar al equipo por los valores de las variables de entorno.

Exporta las variables

```shell
export $(cat .env | xargs)
```

## Como contribuir.

Pasos para contribuir en el proyecto:

- Hacer un __fork__ del repositorio a nuestra cuenta privada de Github.
- Clonar nuestro __fork__ en nuestra maquina de trabajo.
- Crear un remote llamado upstream que apunte hacia el repo de Resuelve.

```shell
git remote add upstream git@github.com:resuelve/chatex.git
```

- Lee las [guías de desarrollo.](https://github.com/resuelve/guias-desarrollo)

## Instalar dependencias

```shell
mix deps.get
```
## Uso

### Chatex.Service.Spaces

Lista los espacios en los cuales se agregado al bot. [(📘)](https://developers.google.com/hangouts/chat/reference/rest/v1/spaces/list)

```elixir
list(pageSize \\ 100, acc \\ [], pageToken \\ "")
```

### Chatex.Service.Spaces.Members

Lista los miembros de un canal. [(📘)](https://developers.google.com/hangouts/chat/reference/rest/v1/spaces.members/list)

```elixir
list(room, pageSize \\ 100, acc \\ [], pageToken \\ nil)
```

### Chatex.Service.Spaces.Messages

Crea un mensaje. [(📘)](https://developers.google.com/hangouts/chat/reference/rest/v1/spaces.messages/create)

```elixir
create(room, message)
```

Actualiza un mensaje. [(📘)](https://developers.google.com/hangouts/chat/reference/rest/v1/spaces.messages/update)

```elixir
update(room, update_mask, message)
```
