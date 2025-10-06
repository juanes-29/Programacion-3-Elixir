defmodule Taller1Elixir do
  @moduledoc """
  ## Módulo Taller1Elixir
  **Autor:** Miguel Ángel Betancourt
  **Fecha:** 8 de septiembre de 2025
  **Licencia:** GNU GPL V3

  Este módulo implementa seis ejercicios de Programación III en Elixir.

  ### Ejercicio 1: Cálculo de consumo de combustible
  - Solicita nombre del conductor, distancia recorrida y combustible consumido.
  - Calcula el rendimiento (km/l).
  - Muestra el resultado.

  ### Ejercicio 2: Control de inventario de librería
  - Solicita título del libro, unidades disponibles y precio unitario.
  - Calcula el valor total del inventario.
  - Muestra un resumen del libro.

  ### Ejercicio 3: Conversión de unidades de temperatura
  - Solicita nombre del usuario y temperatura en Celsius.
  - Convierte a Fahrenheit y Kelvin.
  - Muestra las tres temperaturas con el nombre del usuario.

  ### Ejercicio 4: Cálculo del salario de un empleado
  - Solicita nombre del empleado, salario base y horas extra.
  - Calcula valor por hora y valor de horas extra.
  - Calcula el salario total y lo muestra.

  ### Ejercicio 5: Registro de vehículos en un peaje
  - Solicita placa, tipo de vehículo y peso.
  - Calcula la tarifa según tipo y peso.
  - Muestra la tarifa y el registro creado.

  ### Ejercicio 6: Cálculo del costo de envío de un paquete
  - Solicita nombre del cliente, peso y tipo de envío.
  - Calcula el costo según las reglas especificadas.
  - Muestra una tupla con el detalle completo.
  """

  @doc """
  ### Ejercicio 1: Calcular consumo de combustible

  Calcula el rendimiento del vehículo (km/l).

  ## Flujo:
    - Solicita nombre del conductor, distancia y combustible.
    - Calcula `rendimiento = distancia / combustible`.
    - Muestra el resultado formateado.

  ## Retorno:
    - Cadena con el rendimiento calculado.
  """
  def calcular_consumo_combustible() do
    _conductor = Util.ingresar("Ingrese el nombre del conductor: ", :texto)
    distancia = Util.ingresar("Ingrese la distancia recorrida en kilómetros: ", :real)
    combustible = Util.ingresar("Ingrese la cantidad de combustible consumido en litros: ", :real)

    rendimiento = distancia / combustible
    mensaje = "El rendimiento del vehículo es de #{Float.round(rendimiento, 2)} km/l"
    Util.mostrar_mensaje(mensaje)
    mensaje
  end

  @doc """
  ### Ejercicio 2: Control de inventario de librería

  Calcula el valor total del inventario de un libro.

  ## Retorno:
    - Cadena con el resumen del libro y el valor total.
  """
  def control_inventario_libreria() do
    titulo_libro = Util.ingresar("Ingrese el título del libro: ", :texto)
    cantidad_unidades = Util.ingresar("Ingrese la cantidad de unidades disponibles: ", :entero)
    precio_unitario = Util.ingresar("Ingrese el precio unitario del libro: ", :real)

    valor_total = cantidad_unidades * precio_unitario
    mensaje =
      "El libro '#{titulo_libro}' tiene #{cantidad_unidades} unidades a $#{Float.round(precio_unitario, 2)} " <>
      "cada una. El valor total del inventario es $#{Float.round(valor_total, 2)}."
    Util.mostrar_mensaje(mensaje)
    mensaje
  end

  @doc """
  ### Ejercicio 3: Conversión de unidades de temperatura

  Convierte grados Celsius a Fahrenheit y Kelvin.

  ## Retorno:
    - Cadena con las tres temperaturas y el nombre del usuario.
  """
  def conversion_unidades_temperatura() do
    nombre_usuario = Util.ingresar("Ingrese su nombre: ", :texto)
    temperatura_celsius = Util.ingresar("Ingrese la temperatura en grados Celsius: ", :real)

    temperatura_fahrenheit = (temperatura_celsius * 9 / 5) + 32
    temperatura_kelvin = temperatura_celsius + 273.15
    mensaje =
      "Hola #{nombre_usuario}, la temperatura en Fahrenheit es #{Float.round(temperatura_fahrenheit, 2)}°F " <>
      "y en Kelvin es #{Float.round(temperatura_kelvin, 2)}K."
    Util.mostrar_mensaje(mensaje)
    mensaje
  end

  @doc """
  ### Ejercicio 4: Cálculo del salario de un empleado

  Calcula el salario total incluyendo horas extra.

  ## Retorno:
    - Cadena con el detalle del salario.
  """
  def salario_empleado() do
    nombre = Util.ingresar("Ingrese el nombre del empleado: ", :texto)
    salario_base = Util.ingresar("Ingrese el salario base del empleado por 160 horas: ", :real)
    horas_extra = Util.ingresar("Ingrese el número de horas extra trabajadas por el empleado: ", :entero)

    valor_hora_normal = salario_base / 160
    valor_hora_extra = valor_hora_normal * 1.5
    salario_total = salario_base + (valor_hora_extra * horas_extra)

    mensaje =
      "El empleado #{nombre} gana por hora normal $#{Float.round(valor_hora_normal, 2)}, " <>
      "por hora extra $#{Float.round(valor_hora_extra, 2)}.\n" <>
      "El salario total es $#{Float.round(salario_total, 2)}."
    Util.mostrar_mensaje(mensaje)
    mensaje
  end

  @doc """
  ### Ejercicio 5: Registro de vehículos en un peaje

  Calcula la tarifa de un vehículo según tipo y peso.

  ## Retorno:
    - Tupla con `{placa, tipo, tarifa}`.
  """
  defmodule Peaje do
    @moduledoc """
    Submódulo para el manejo de registros de peaje.
    """

    def registro_peaje() do
      placa = Util.ingresar("Ingrese la placa del vehículo: ", :texto)
      tipo = ingresar_tipo()
      peso = Util.ingresar("Ingrese el peso del vehículo en kg: ", :real)
      tarifa = calcular_tarifa(tipo, peso)

      registro = {placa, tipo, tarifa}
      Util.mostrar_mensaje("Registro creado: #{inspect(registro)}")
      Util.mostrar_mensaje("Vehículo #{placa} debe pagar $#{tarifa}.")
      registro
    end

    defp ingresar_tipo() do
      tipo = Util.ingresar("""
      Ingrese el tipo de vehículo con el número correspondiente:
      1. Moto
      2. Carro
      3. Camión
      """, :entero)

      if tipo in [1, 2, 3], do: tipo, else: (Util.mostrar_mensaje("Debe ingresar un valor válido"); ingresar_tipo())
    end

    defp calcular_tarifa(1, _peso), do: 5_000
    defp calcular_tarifa(2, _peso), do: 10_000
    defp calcular_tarifa(3, peso), do: 20_000 + (2_000 * (peso / 1000))
  end

  @doc """
  ### Ejercicio 6: Cálculo del costo de envío de un paquete

  Calcula el costo del envío según el tipo y peso.

  ## Retorno:
    - Tupla con `{nombre, peso, tipo_envio, costo_total}`.
  """
  def calcular_costo_envio() do
    nombre = Util.ingresar("Ingrese el nombre del cliente: ", :texto)
    peso = Util.ingresar("Ingrese el peso del paquete en kg: ", :real)
    tipo_envio = ingresar_tipo_envio()
    costo_total = calcular_tarifa(tipo_envio, peso)

    result = {nombre, peso, tipo_envio, costo_total}
    Util.mostrar_mensaje("Resultado del envío: #{inspect(result)}")
    result
  end

  defp ingresar_tipo_envio() do
    tipo = Util.ingresar("""
    Ingrese el tipo de envío:
    1. Económico
    2. Express
    3. Internacional
    """, :entero)

    case tipo do
      1 -> :economico
      2 -> :express
      3 -> :internacional
      _ -> Util.mostrar_mensaje("Opción no válida, intente de nuevo"); ingresar_tipo_envio()
    end
  end

  defp calcular_tarifa(:economico, peso), do: peso * 5_000
  defp calcular_tarifa(:express, peso), do: peso * 8_000
  defp calcular_tarifa(:internacional, peso) do
    cond do
      peso <= 5 -> peso * 15_000
      peso > 5 -> peso * 12_000
    end
  end

  @doc """
  Muestra un menú interactivo para seleccionar cuál ejercicio ejecutar.
  """
  def menu() do
    Util.mostrar_mensaje("""
    Seleccione una operación:
    1. Calcular consumo de combustible
    2. Control de inventario de librería
    3. Conversión de unidades de temperatura
    4. Cálculo del salario de un empleado
    5. Registro de vehículos en un peaje
    6. Cálculo del costo de envío de un paquete
    0. Salir
    """)
    opcion = Util.ingresar("Opción: ", :entero)
    case opcion do
      1 -> calcular_consumo_combustible()
      2 -> control_inventario_libreria()
      3 -> conversion_unidades_temperatura()
      4 -> salario_empleado()
      5 -> Peaje.registro_peaje()
      6 -> calcular_costo_envio()
      0 -> Util.mostrar_mensaje("Saliendo...")
      _ -> Util.mostrar_mensaje("Opción no válida"); menu()
    end
  end
end

Taller1Elixir.menu()
