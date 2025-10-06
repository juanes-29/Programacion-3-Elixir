defmodule Quiz do
  def buscar([head]), do: head
  def buscar([head | tail]) do
    mayor_tail = buscar(tail)
    if head > mayor_tail, do: head,
  else: mayor_tail
  end
end

lista = [3, 7, 2, 9, 5]
IO.puts("El numero mayor de la lista es: #{Quiz.buscar(lista)}")
