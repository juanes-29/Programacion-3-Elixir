defmodule Parcial do

  def inventario do
    %{
    "Mouse" => 10,
    "Teclado" => 30,
    "Monitor" => 40
  }
end

  def actualizar_inventario(inventario, producto, cantidad_vendida) do
    if Map.has_key?(inventario, producto) do
        stock = Map.get(inventario, producto)

        if stock < cantidad_vendida do
          IO.puts("Stock insuficiente")
          inventario
        else
          nuevo_invetario = Map.put(inventario, producto, stock - cantidad_vendida)
            IO.puts("Se vendieron #{cantidad_vendida} del producto #{producto}")
            nuevo_invetario
        end
    else
    IO.puts("No se encotro el producto pai")
    inventario
    end
  end

  def main do
  inventario = inventario()

  producto = ("Ingrese el producto que desea: ")
    |> Util.ingresar(:texto)


  cantidad = ("Ingrese la cantidad que desea: ")
  |> Util.ingresar(:entero)

  nuevo_invetario = actualizar_inventario(inventario, producto, cantidad)
  IO.inspect(nuevo_invetario)
 end
end


 Parcial.main()
