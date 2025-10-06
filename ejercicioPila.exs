defmodule DivideYVenceras do
  @moduledoc """
  Trabajo que implementa algoritmos básicos usando Divide y Vencerás

  Este módulo muestra cómo dividir una lista en mitades para:
  - Recorrer e imprimir sus elementos.
  - Encontrar el número mayor de forma recursiva.

  La técnica de **Divide y Vencerás** consiste en:
  1. Dividir el problema en subproblemas más pequeños.
  2. Resolver cada subproblema de forma recursiva.
  3. Combinar los resultados para obtener la solución final.

  ## Autor
  Juan Esteban Piñeros Maldonado
  **Fecha:** 05/10/2025
  **Licencia:** GNU GPL v3
  """
  @doc """
  Recorre una lista dividiéndola en mitades y muestra cada número por consola.
  ## Detalles
  - Si la lista está vacía, termina (`:ok`).
  - Si tiene un solo elemento, lo imprime.
  - Si tiene más de uno, la divide en dos mitades y recorre cada una recursivamente :)
  """
  def recorrer([]), do: :ok

  def recorrer([x]) do
    IO.puts("Número: #{x}")
  end

  def recorrer(lista) do
    # Divide la lista en dos mitades aproximadamente iguales
    {izq, der} = Enum.split(lista, div(length(lista), 2))

    # Llamadas recursivas a cada mitad
    recorrer(izq)
    recorrer(der)
  end


  @doc """
  Encuentra el número mayor dentro de una lista usando recursividad y divide y vencerás.
  ## Detalles
  - Si la lista tiene un solo elemento, ese es el mayor.
  - Si tiene varios, se divide en dos mitades, se busca el mayor de cada una,
    y luego se toma el mayor entre ambos.
  """

  def mayor_lista([x]), do: x

  def mayor_lista(lista) do
    # Divide la lista en dos mitades
    {izq, der} = Enum.split(lista, div(length(lista), 2))

    # Busca el mayor en cada mitad
    mayor_izq = mayor_lista(izq)
    mayor_der = mayor_lista(der)

    # Combina los resultados comparando los dos mayores
    max(mayor_izq, mayor_der)
  end
end


IO.puts("Mayor en la lista: #{DivideYVenceras.mayor_lista([10, 2, 8, 4, 5])}")

IO.puts("Recorrido de la lista:")
DivideYVenceras.recorrer([1, 2, 3, 4, 5])
