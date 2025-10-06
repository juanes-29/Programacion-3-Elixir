defmodule Parcial2 do
  def ventas do
    %{ "1" => 10,
    "2" => 150,
    "3" => 40,
    "4" => 30,
    "5" => 20,
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

      {dia_mejor, _} = Enum.max_by(Map.to_list(ventas), fn {_, cantidad} -> cantidad end)

      {total, promedio, dia_mejor}
    end
  end
end

IO.inspect(Parcial2.analizar_ventas(Parcial2.ventas()))
