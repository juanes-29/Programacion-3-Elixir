defmodule Estructuras do
  def main do
    crear_lista_clientes()
    |> Cliente.escribir_csv("clientes.csv")
  end

  defp crear_lista_clientes() do


    [
      Cliente.crear("Ana", 30, 1.75),
      Cliente.crear("María", 25, 1.65),
      Cliente.crear("Pedro", 40, 1.80),
      Cliente.crear("Luis", 28, 1.70),
      Cliente.crear("Carmen", 35, 1.60),
      Cliente.crear("Jorge", 45, 1.85)
    ]
  end
end

Estructuras.main()
