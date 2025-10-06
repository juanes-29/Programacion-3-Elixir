defmodule Punto2 do
  def ventas do
    %{ "1" => 2,
    "2" => 5,
    "3" => 4,
    "4" => 23,
    "5" => 22,
    "6" => 4,
    "7" => 2,
    "8" => 6,
    "9" => 2,
    "10" => 2,
    "11" => 1,
    "12" => 2,
    "13" => 6
  }

 end
   def analizar_ventas (ventas) do
    case ventas do
      %{} = v when map_size(v) == 0 ->
        {0, 0 , "No hay datos"}

     _->
    valores = Map.values(ventas)
    total = Enum.sum(valores)
    promedio = total / Enum.count(valores)

    {dia_mejor, _} = Enum.max_by(Map.to_list(ventas), fn {_dia, cantidad} -> cantidad end)

    {total, promedio, dia_mejor}
      end
   end
end

IO.inspect(Punto2.analizar_ventas(Punto2.ventas()))
