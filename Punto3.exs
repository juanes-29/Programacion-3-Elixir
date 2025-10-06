defmodule Punto3 do
  def notas do
    %{
      "Ana" => [10, 3, 7],
      "Pepe" => [10, 3, 7],
      "Estefania" => [10, 3, 7],
    }
  end
  def evaluar_proyecto(notas, estudiantes) do
    case Map.get(notas, estudiantes) do
      nil ->
        {0, "No encotrado"}

        notas ->
          promedio = Enum.sum(notas) / length(notas)

        estado =
          if promedio > 6 do
            IO.puts("Se aprobo la materia")
            "Aprobado"
          else
            IO.puts("No se aprobo la materia")
            "Reprobado"
    end

    {promedio, estado}
  end
 end
end

IO.inspect(Punto3.evaluar_proyecto(Punto3.notas(), "Ana"))
