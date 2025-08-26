defmodule Util do
  @moduledoc """
  Módulo de utilidades para mostrar mensajes usando programas externos.
  """
  @doc """
  Muestra un mensaje llamando a un script de Python (`mostrar_dialogo.py`). cabe aclarar que aun no funciona en py

  ## Parámetros
    - `mensaje`: el texto que se enviará al script de Py.

  ## Autor: Juan Esteban Piñeros Maldonado
  ## Fecha: 19/08/2025
  ## Licencia: GNU GPL V3

  """
  def mostrar_mensaje_python(mensaje) do
    System.cmd("python", [
      "C:/Users/User/OneDrive/Documentos/Programacion 3/mostrar_dialogo.py",
      mensaje
    ])
  end

  @doc """
  Muestra un mensaje llamando a un programa en Java (`Ejercicio`).

  ## Parámetros
    - `mensaje`: el texto que se pasará al programa Java.
  """
   def mostrar_mensaje2(mensaje) do
    System.cmd("java", ["Mensaje", mensaje])
    end

  @doc """

  def ingresar(mensaje, :texto) do
    mensaje
    |> IO.gets()
    |> String.trim()
  end
  """

  def ingresarJava(mensaje, :texto) do
    # llama al programa java para ingresar texto y capturar la entrada
    case System.cmd("java", ["-cp", ".", "Mensaje", "input", mensaje]) do
      {output, 0} ->
        IO.puts("Texto ingresado correctamente.")
        IO.puts("Entrada: #{output}")
        String.trim(output) # Retorna la entrada sin espacios extra
        {error, code} ->
          IO.puts("Error al ingresar el texto. Código: #{code}")
          IO.puts("Detalles: #{error}")
          nil
    end
  end



  @doc """
  Solicita al usuario un valor entero.

  - `mensaje`: texto que se mostrará al usuario antes de leer.
  - Convierte la entrada en `integer`.
  """
  def ingresar(mensaje, :entero) do
    mensaje
    |> Util.ingresar(:texto)
    |> String.to_integer()
  end

  @doc """
  Solicita al usuario un texto.

  - `mensaje`: texto que se muestra antes de capturar.
  """
  def ingresar(mensaje, :texto) do
    mensaje
    |> IO.gets()
    |> String.trim()
  end

  @doc """
  Solicita al usuario un número real (`float`).
  - Si ocurre un `ArgumentError`, muestra un error
    y vuelve a pedir la entrada al usuario recursivamente.
  """
  def ingresar(mensaje, :real) do
    try do
      mensaje
      |> Util.ingresar(:texto)
      |> String.to_float()
    rescue
      ArgumentError ->
        "Error, se espera que ingrese un número real\n"
        |> Util.mostrar_error()

        mensaje |> Util.ingresar(:real)
    end
  end

  @doc """
  Muestra un mensaje de error en la salida de error.
  """
  def mostrar_error(mensaje) do
    IO.puts(:standard_error, mensaje)
  end

  @doc """
  Muestra un mensaje normal en la salida estándar.
  """
  def mostrar_mensaje(mensaje) do
    IO.puts(mensaje)
  end
end
