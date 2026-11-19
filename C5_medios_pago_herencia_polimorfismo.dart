abstract class MetodoPago {
  String get nombre;
  String procesar(int total);
}

// Pago en efectivo
class Efectivo extends MetodoPago {
  final int recibido;

  Efectivo(this.recibido);

  @override
  String get nombre => 'Efectivo';

  @override
  String procesar(int total) {
    if (recibido < total) {
      int faltante = total - recibido;
      return 'Pago rechazado. Faltan $faltante';
    }

    int cambio = recibido - total;
    return 'Pago aprobado. Cambio: $cambio';
  }
}

// Pago con tarjeta débito
class Debito extends MetodoPago {
  final String referencia;

  Debito(this.referencia);

  @override
  String get nombre => 'Débito';

  @override
  String procesar(int total) {
    if (referencia.isEmpty) {
      return 'Pago rechazado. Falta la referencia del datáfono';
    }

    return 'Pago aprobado. Referencia: $referencia';
  }
}

// Pago a crédito
class Credito extends MetodoPago {
  final String cliente;
  int cupoDisponible;

  Credito(this.cliente, this.cupoDisponible);

  @override
  String get nombre => 'Crédito ($cliente)';

  @override
  String procesar(int total) {
    if (total > cupoDisponible) {
      return 'Pago rechazado. Supera el cupo de $cupoDisponible';
    }

    cupoDisponible -= total;
    return 'Pago aprobado. Cupo restante: $cupoDisponible';
  }
}

// Código de prueba
void main() {
  int total = 100100;
  List<MetodoPago> pagos = [
    Efectivo(110000),
    Efectivo(90000),
    Debito('A-48213'),
    Debito(''),
    Credito('Ana Gómez', 150000),
    Credito('Pedro Ruiz', 50000),
  ];

  print('Total a pagar: $total');
  for (var pago in pagos) {
    print('${pago.nombre}: ${pago.procesar(total)}');
  }
}
