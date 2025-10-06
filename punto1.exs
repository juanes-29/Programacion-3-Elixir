defmodule Punto1 do
  def inventario do
    %{
  "monitor" => 10,
   "teclado" => 20,
   "pc" => 70
  }
  end

  def actualizar_inventario(inventario, producto, cantidad_vendida) do
    if Map.has_key?(inventario, producto) do
      stock = Map.get(inventario, producto)
      
      if cantidad_vendida > stock do
        IO.puts("Stock insuficiente")
        inventario
       else
        nuevo_invetario = Map.put(inventario, producto, stock - cantidad_vendida)
          IO.puts("Se compro #{cantidad_vendida} unidades del producto #{producto}")
        nuevo_invetario
        end

      else
        IO.puts("Producto no encontrado")
        inventario
      end
   end

def main do
  inventario = inventario()

  producto = ("Ingrese el producto que desea: ")
    |> Util.ingresar(:texto)


  cantidad = ("Ingrese la cantidad que desea: ")
  |> Util.ingresar(:entero)

  inventario_actualizado = actualizar_inventario(inventario, producto, cantidad)
  IO.inspect(inventario_actualizado)
 end
end

Punto1.main()
