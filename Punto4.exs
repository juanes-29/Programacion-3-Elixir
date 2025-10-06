defmodule Punto4 do
  def calcular_descuentos(productos, porcentaje) do
    case productos do
      [] ->
        {[], 0}
        _->

          lista_descuentos =
            Enum.map(productos, fn {nombre, precio} ->
              descuento = precio * porcentaje
              {nombre, descuento}
            end)

      total_descuento = Enum.sum(Enum.map(lista_descuentos, fn {_n, d} -> d end))

      {lista_descuentos, total_descuento}
      end
  end
end


inventario = [
 {"Papa", 10000},
 {"Panela", 5000},
 {"Maiz", 7000},
 {"Sandia", 12000}
]

IO.inspect(Punto4.calcular_descuentos(inventario, 0.1))
