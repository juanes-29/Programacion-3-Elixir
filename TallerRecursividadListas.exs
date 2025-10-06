defmodule TallerRecursividadListas do
  @moduledoc """
  Taller Recursividad listas.

  ## Autor: Juan Esteban Piñeros Maldonado
  ## Fecha: 05/10/2025
  ## Licencia: GNU GPL V3
  """

  # Ejercicio 1 Contar elementos pares en una lista
  def contar_pares([]), do: 0

  def contar_pares([h | t]) do
    if rem(h, 2) == 0 do
      1 + contar_pares(t)
    else
      contar_pares(t)
    end
  end


  # Ejercicio 2 Invertir una lista sin usar Enum.reverse
  def invertir_lista([]), do: []
  def invertir_lista([h | t]), do: invertir_lista(t) ++ [h]


  # Ejercicio 3 Sumar todos los elementos de una matriz (lista de listas)
  def sumar_matriz([]), do: 0
  def sumar_matriz([fila | resto]), do: sumar_lista(fila) + sumar_matriz(resto)

  # Función auxiliar para sumar una lista
  defp sumar_lista([]), do: 0
  defp sumar_lista([h | t]), do: h + sumar_lista(t)


  # Ejercicio 4 Transposición de una matriz
  def transponer([]), do: []
  def transponer([[] | _]), do: []

  def transponer(matriz) do
    primera_columna = Enum.map(matriz, fn [h | _] -> h end)
    resto = Enum.map(matriz, fn [_ | t] -> t end)
    [primera_columna | transponer(resto)]
  end

  # Ejecución de pruebas del taller
  def ejecutar() do
    lista = [2, 5, 8, 11, 14, 17, 20]
    matriz = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ]

    IO.puts("Taller de Recursividad con Listas y Matrices :)\n")

    # Ejercicio 1 Contar los pares si sabe
    IO.puts("1. Elementos pares en la lista: #{contar_pares(lista)}")

    # Ejercicio 2 Invertir lista
    IO.puts("2. Lista original: #{inspect(lista)}")
    IO.puts("   Lista invertida: #{inspect(invertir_lista(lista))}")

    # Ejercicio 3 Sumar matriz
    IO.puts("3. Suma de todos los elementos de la matriz: #{sumar_matriz(matriz)}")

    # Ejercicio 4 Transponer matriz
    IO.puts("4. Matriz original:")
    Enum.each(matriz, &IO.inspect/1)

    IO.puts("   Matriz transpuesta:")
    Enum.each(transponer(matriz), &IO.inspect/1) #expulsa ~c"\a\b\t" por algo de elixir y el codigo Ascii
  end
end

TallerRecursividadListas.ejecutar()
