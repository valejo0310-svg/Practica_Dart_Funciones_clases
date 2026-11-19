enum EstadoMesa { libre, ocupada, enCuenta }

class Mesa {
  // Atributos
  final int numero;
  final int capacidad;
  EstadoMesa estado = EstadoMesa.libre;
  int comensales = 0;

  // Constructor
  Mesa(this.numero, this.capacidad);

  // Ocupar mesa
  bool ocupar(int personas) {
    if (estado != EstadoMesa.libre) {
      print('Mesa $numero: no se puede ocupar, está ${estado.name}');
      return false;
    }

    if (personas < 1 || personas > capacidad) {
      print('Mesa $numero: $personas personas no caben (capacidad $capacidad)');
      return false;
    }

    comensales = personas;
    estado = EstadoMesa.ocupada;

    print('Mesa $numero: ocupada por $personas personas');
    return true;
  }

  // Solicitar cuenta
  bool pedirCuenta() {
    if (estado != EstadoMesa.ocupada) {
      print('Mesa $numero: no se puede pedir la cuenta');
      return false;
    }

    estado = EstadoMesa.enCuenta;
    print('Mesa $numero: cuenta solicitada');
    return true;
  }

  // Liberar mesa
  bool liberar() {
    if (estado != EstadoMesa.enCuenta) {
      print('Mesa $numero: no se puede liberar sin pedir la cuenta');
      return false;
    }

    estado = EstadoMesa.libre;
    comensales = 0;

    print('Mesa $numero: liberada');
    return true;
  }

  // Representación del objeto
  @override
  String toString() {
    return 'Mesa $numero ($capacidad puestos): ${estado.name}, $comensales personas';
  }
}

// Código de prueba
void main() {
  Mesa mesa4 = Mesa(4, 4);
  mesa4.ocupar(6);
  mesa4.ocupar(3);
  mesa4.ocupar(2);
  mesa4.liberar();
  mesa4.pedirCuenta();
  print(mesa4);
  mesa4.liberar();
  print(mesa4);
}
