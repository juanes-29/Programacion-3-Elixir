import javax.swing.JOptionPane;

/**
 * Clase Ejercicio en java
 *
 * esto muestra un mensaje de bienvenida en una ventana emergente.
 * El mensaje se recibe como argumento.
 * 
 * Autor: Juan Esteban Piñeros Maldonado
   Fecha: 19/08/2025
   Licencia: GNU GPL V3
 */

 /*
  * public class Ejercicio {
    public static void main(String[] args){
        JOptionPane.showMessageDialog(null, args[0], "Bienvenida", JOptionPane.INFORMATION_MESSAGE);
    }
}

  */

  public class Mensaje {
public static void main(String[] args) {
if (args.length > 0 && args[0].equals("input")) {
String mensaje = args.length > 1 ? args[1] : "Ingrese un valor:";
String input = JOptionPane.showInputDialog(null, mensaje);
System.out.println(input);
} else if (args.length > 0) {
JOptionPane.showMessageDialog(null, args[0]);
} else {
JOptionPane.showMessageDialog(null, "No se proporcionó ningún mensaje");
}
}
}
