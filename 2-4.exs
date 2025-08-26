defmodule EntradaReales do
  @moduledoc """
  un ejercicio que calcula el descuento y valor final de un producto
  a partir del valor inicial y un porcentaje ingresado por el cliente.
  """

  @doc """
  Función principal que solicita al usuario:
    - El valor del producto
    - El porcentaje de descuento

  Luego calcula:
    - El valor del descuento
    - El valor final del producto

  Finalmente muestra un mensaje con los resultados.

    ## Autor: Juan Esteban Piñeros Maldonado
    ## Fecha: 26/08/2025
    ## Licencia: GNU GPL V3
  """
  def main do
    valor_producto =
      "Ingrese el valor del producto: "
      |> Util.ingresar(:entero)

    porcentaje_descuento =
      "Ingrese el porcentaje de descuento: "
      |> Util.ingresar(:real)

    valor_descuento = calcular_valor_descuento(valor_producto, porcentaje_descuento)
    valor_final = calcular_valor_final(valor_producto, valor_descuento)

    generar_mensaje(valor_descuento, valor_final)
    |> Util.mostrar_mensaje()
  end

  @doc """
   metodo que calcula el valor del descuento a partir del valor del producto
  y el porcentaje de descuento.
  """
  defp calcular_valor_descuento(valor_producto, porcentaje_descuento) do
    valor_producto * porcentaje_descuento
  end

  @doc """
  metodo que calcula el valor final restando al valor del producto el descuento.
  """
  defp calcular_valor_final(valor_producto, valor_descuento) do
    valor_producto - valor_descuento
  end

  @doc """
  metodo que genera el mensaje de salida:
    - El valor del descuento (redondeado a 1 decimal)
    - El valor final (redondeado a 1 decimal)
  """
  defp generar_mensaje(valor_descuento, valor_final) do
    valor_descuento = Float.round(valor_descuento, 1)
    valor_final = Float.round(valor_final, 1)

    "Valor de descuento de $#{valor_descuento} y el valor final $#{valor_final}"
  end
end

EntradaReales.main()
