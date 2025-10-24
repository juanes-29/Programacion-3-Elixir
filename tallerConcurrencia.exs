defmodule MatrizOperaciones do
  @moduledoc """
  ## Laboratorio de Concurrencia — Programación 3

  Este módulo implementa operaciones básicas sobre una matriz utilizando **recursividad** y **tareas concurrentes (`Task`)**.
  Las funciones S1, S2, S3 y S4 representan distintos pasos de procesamiento concurrente:

  - **S1:** Suma de los elementos debajo de la diagonal principal (recursiva)
  - **S2:** Promedio de los elementos encima de la diagonal principal (recursiva)
  - **S3:** Multiplicación de los resultados anteriores (con `Task`)
  - **S4:** Resultado final, procesado también en una tarea concurrente
  """

  # ----------------------- Matriz base -----------------------
  @matriz [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
  ]

  # ----------------------- S1 -----------------------
  @doc """
  Calcula la **suma de los elementos por debajo de la diagonal principal**
  de una matriz cuadrada.

  ## Parámetros
    - `matriz`: lista de listas que representa la matriz.

  ## Ejemplo

      iex> MatrizOperaciones.suma_debajo_diagonal([[1,2,3],[4,5,6],[7,8,9]])
      19
  """
  def suma_debajo_diagonal(matriz), do: suma_recursiva(matriz, 0, 0, 0)

  defp suma_recursiva(matriz, i, j, acc) do
    n = length(matriz)

    cond do
      i >= n ->
        acc

      j >= n ->
        suma_recursiva(matriz, i + 1, 0, acc)

      j < i ->
        valor = Enum.at(Enum.at(matriz, i), j)
        suma_recursiva(matriz, i, j + 1, acc + valor)

      true ->
        suma_recursiva(matriz, i, j + 1, acc)
    end
  end

  # ----------------------- S2 -----------------------
  @doc """
  Calcula el **promedio de los elementos por encima de la diagonal principal**
  de una matriz cuadrada, usando recursión.

  ## Parámetros
    - `matriz`: lista de listas que representa la matriz.

  ## Ejemplo

      iex> MatrizOperaciones.promedio_encima_diagonal([[1,2,3],[4,5,6],[7,8,9]])
      5.0
  """
  def promedio_encima_diagonal(matriz), do: promedio_recursivo(matriz, 0, 0, 0, 0)

  defp promedio_recursivo(matriz, i, j, suma, conteo) do
    n = length(matriz)

    cond do
      i >= n ->
        if conteo == 0, do: 0, else: suma / conteo

      j >= n ->
        promedio_recursivo(matriz, i + 1, 0, suma, conteo)

      j > i ->
        valor = Enum.at(Enum.at(matriz, i), j)
        promedio_recursivo(matriz, i, j + 1, suma + valor, conteo + 1)

      true ->
        promedio_recursivo(matriz, i, j + 1, suma, conteo)
    end
  end

  # ----------------------- S3 -----------------------
  @doc """
  Multiplica dos valores numéricos.

  Representa la operación **S3 = S1 * S2**, ejecutada concurrentemente
  mediante tareas (`Task`).
  """
  def multiplicacion(a, b), do: a * b

  # ----------------------- S4 -----------------------
  @doc """
  Devuelve el **resultado final** de la operación (S4).

  Actualmente solo retorna el valor de entrada, pero puede modificarse
  para aplicar transformaciones adicionales.
  """
  def resultado_final(c), do: c

  # ----------------------- main -----------------------
  @doc """
  Función principal del laboratorio.

  - Lanza las tareas **S1** y **S2** concurrentemente.
  - Espera los resultados de ambas y luego ejecuta **S3** y **S4** también como tareas.
  - Muestra los resultados intermedios y finales por consola.
  """
  def main do
    # Tareas S1 y S2 concurrentes
    t1 = Task.async(fn -> suma_debajo_diagonal(@matriz) end)
    t2 = Task.async(fn -> promedio_encima_diagonal(@matriz) end)

    a = Task.await(t1)
    b = Task.await(t2)

    # Tareas S3 y S4 concurrentes
    t3 = Task.async(fn -> multiplicacion(a, b) end)
    c = Task.await(t3)
    t4 = Task.async(fn -> resultado_final(c) end)
    d = Task.await(t4)

    # Mostrar resultados
    IO.puts("S1 -> a (suma debajo diagonal): #{a}")
    IO.puts("S2 -> b (promedio encima diagonal): #{b}")
    IO.puts("S3 -> c = a * b: #{c}")
    IO.puts("S4 -> resultado final: #{d}")
  end
end

# Ejecutar el laboratorio
MatrizOperaciones.main()
