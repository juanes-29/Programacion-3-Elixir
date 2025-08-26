defmodule EntradaEnteros do
  @moduledoc """
  Ejercicio que calcula la devuelta de una factura a partir del valor total y el valor entregado por el cliente.
  """

  @doc """
  Función principal main.

  lo que hace es lo sgte:
    1. Solicita el valor total de la factura al usuario.
    2. Solicita el valor entregado para el pago.
    3. Calcula la devuelta.
    4. Genera un mensaje.
    5. Muestra el mensaje.

      ## Autor: Juan Esteban Piñeros Maldonado
      ## Fecha: 26/08/2025
      ## Licencia: GNU GPL V3
  """
  def main do
    valor_total =
      "Ingrese valor total de la factura: "
      |> Util.ingresar(:entero)

    valor_entregado =
      "Ingrese valor entregado para el pago: "
      |> Util.ingresar(:entero)

    calcular_devuelta(valor_entregado, valor_total)
    |> generar_mensaje()
    |> Util.mostrar_mensaje()
  end

  @doc """
  metodo que calcula la devuelta restando el valor total al valor entregado.
  """
  defp calcular_devuelta(valor_pago, valor_total) do
    valor_pago - valor_total
  end

  @doc """
  metodo que Genera un mensaje indicando el valor de la devuelta.
  """
  defp generar_mensaje(devuelta) do
    "El valor de devuelta es $ #{devuelta}"
  end
end

# Ejecuta la función principal
EntradaEnteros.main()
