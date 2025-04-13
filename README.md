# Chatex

**Cliente de Elixir para la API de Google Chat.**

## 🚀 Instalación

Agrega `:chatex` a tus dependencias en el archivo `mix.exs`:

```elixir
def deps do
  [
    {:chatex, "~> 3.0.0"}
  ]
end
```

### ⚙️ Configurar variables de entorno.

El archivo __.env.dist__ contiene un listado actualizado de las variables de entorno necesarias para el proyecto, se debe copiar ese archivo a uno nuevo llamado __.env__


Exporta las variables:

```shell
export $(cat .env | xargs)
```

## Instalar dependencias

```shell
mix deps.get
```
