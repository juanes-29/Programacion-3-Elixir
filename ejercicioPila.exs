defmodule DivideYVenceras do
  def recorrer([]), do: :ok

  def recorrer([x]) do
    IO.puts("Número: #{x}")
  end

  def recorrer(lista) do
    {izq, der} = Enum.split(lista, div(length(lista), 2))
    recorrer(izq)
    recorrer(der)
  end

  def mayor_lista([x]), do: x

  def mayor_lista(lista) do
    {izq, der} = Enum.split(lista, div(length(lista), 2))
    mayor_izq = mayor_lista(izq)
    mayor_der = mayor_lista(der)
    max(mayor_izq, mayor_der)
  end
end

IO.puts(DivideYVenceras.mayor_lista([10, 2, 3, 4, 5, 8, 9]))
DivideYVenceras.recorrer([1, 2, 3, 4, 5])
