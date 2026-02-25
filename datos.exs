defmodule Estudiante do
  defstruct nombre: "", cedula: "", programa: "", email: ""

  def nuevo(nombre, cedula, programa, email) do
    %Estudiante{nombre: nombre, cedula: cedula, programa: programa, email: email}
  end

  def construir() do
    nombre = "Ingrese el nombre: "
    |> Util.ingresar(:texto)

    cedula = "Ingrese la cédula: "
    |> Util.ingresar(:texto)

    programa = "Ingrese el programa: "
    |> Util.ingresar(:texto)

    email = "Ingrese el email: "
    |> Util.ingresar(:texto)

    %Estudiante{nombre: nombre, cedula: cedula, programa: programa, email: email}
  end

  def buscar(cedula, lista) do
    Enum.find(lista, fn estudiante -> estudiante.cedula == cedula end)
  end

  def listar(lista) do
    Enum.map(lista, fn est ->
      "#{est.cedula} | #{est.nombre} | #{est.programa} | #{est.email}"
    end)
  end

  def
  to_csv(estudiante) do
    "#{estudiante.cedula},#{estudiante.nombre},#{estudiante.programa},#{estudiante.email}\n"
  end

  def from_csv(linea) do
    [cedula, nombre, programa, email] = String.split(linea, ",") |> Enum.map(&String.trim/1)
    %Estudiante{cedula: cedula, nombre: nombre, programa: programa, email: email}
  end

  def cargar_csv(archivo \\ "estudiantes.csv") do
    case File.read(archivo) do
      {:ok, contenido} ->
        contenido
        |> String.split("\n", trim: true)
        |> Enum.map(&from_csv/1)
      {:error, _} -> []
    end
  end

  def guardar_csv(estudiantes, archivo \\ "estudiantes.csv") do
    contenido = Enum.map_join(estudiantes, "", &to_csv/1)
    File.write(archivo, contenido)
  end
end

defmodule Trabajo do
  defstruct id: "", fecha: "", titulo: "", descripcion: "", autores_cedulas: []

  def nuevo(id, fecha, titulo, descripcion, autores_cedulas) do
    %Trabajo{id: id, fecha: fecha, titulo: titulo, descripcion: descripcion, autores_cedulas: autores_cedulas}
  end

  def construir() do
    id = "Ingrese el ID: "
    |> Util.ingresar(:texto)

    fecha = "Ingrese la fecha (DD/MM/AAAA): "
    |> Util.ingresar(:texto)

    titulo = "Ingrese el título: "
    |> Util.ingresar(:texto)

    descripcion = "Ingrese la descripción: "
    |> Util.ingresar(:texto)

    cantidad = "¿Cuántos autores tiene el trabajo? "
    |> Util.ingresar(:entero)

    autores_cedulas = for _ <- 1..cantidad do
      Util.ingresar("Ingrese cédula del autor: ", :texto)
    end

    %Trabajo{id: id, fecha: fecha, titulo: titulo, descripcion: descripcion, autores_cedulas: autores_cedulas}
  end

  def buscar(titulo, lista) do
    Enum.find(lista, fn trabajo -> String.downcase(trabajo.titulo) == String.downcase(titulo) end)
  end

  def buscar_por_id(id, lista) do
    Enum.find(lista, fn trabajo -> trabajo.id == id end)
  end

  def listar(lista) do
    Enum.map(lista, fn trab ->
      autores = Enum.join(trab.autores_cedulas, ", ")
      "ID: #{trab.id} | #{trab.titulo} | Fecha: #{trab.fecha} | Autores: #{autores}"
    end)
  end

  def to_csv(trabajo) do
    autores = Enum.join(trabajo.autores_cedulas, ";")
    "#{trabajo.id},#{trabajo.fecha},#{trabajo.titulo},#{trabajo.descripcion},#{autores}\n"
  end

  def from_csv(linea) do
    [id, fecha, titulo, descripcion, autores_str] = String.split(linea, ",", parts: 5) |> Enum.map(&String.trim/1)
    autores_cedulas = String.split(autores_str, ";", trim: true) |> Enum.map(&String.trim/1)
    %Trabajo{id: id, fecha: fecha, titulo: titulo, descripcion: descripcion, autores_cedulas: autores_cedulas}
  end

  def cargar_csv(archivo \\ "trabajos.csv") do
    case File.read(archivo) do
      {:ok, contenido} ->
        contenido
        |> String.split("\n", trim: true)
        |> Enum.map(&from_csv/1)
      {:error, _} -> []
    end
  end

  def guardar_csv(trabajos, archivo \\ "trabajos.csv") do
    contenido = Enum.map_join(trabajos, "", &to_csv/1)
    File.write(archivo, contenido)
  end
end
