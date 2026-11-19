class Caja {
  // Atributos privados
  bool _abierta = false;
  int _base = 0;

  final Map<String, int> _ventasPorMedio = {
    'efectivo': 0,
    'debito': 0,
    'credito': 0,
  };

  final List<int> _egresos = [];
  int _cantidadVentas = 0;

  // Getters
  bool get abierta => _abierta;

  int get totalVendido {
    int total = 0;
    for (int valor in _ventasPorMedio.values) {
      total += valor;
    }
    return total;
  }

  int get totalEgresos {
    int total = 0;
    for (int valor in _egresos) {
      total += valor;
    }
    return total;
  }

  int get efectivoEsperado =>
      _base + _ventasPorMedio['efectivo']! - totalEgresos;

  // Abrir caja
  bool abrir(int base) {
    if (_abierta) {
      print('Error: la caja ya está abierta');
      return false;
    }

    if (base < 0 || base > 10000000) {
      print('Error: base no válida');
      return false;
    }

    _base = base;
    _abierta = true;

    print('Caja abierta con base $base');
    return true;
  }

  // Registrar venta
  bool registrarVenta(int total, String medio) {
    if (!_abierta) {
      print('Error: la caja está cerrada');
      return false;
    }

    if (!_ventasPorMedio.containsKey(medio)) {
      print('Error: medio de pago $medio no válido');
      return false;
    }

    if (total <= 0) {
      print('Error: el total debe ser mayor que 0');
      return false;
    }

    _ventasPorMedio[medio] =
        _ventasPorMedio[medio]! + total;

    _cantidadVentas++;
    return true;
  }

  // Registrar egreso
  bool registrarEgreso(String concepto, int valor) {
    if (!_abierta) {
      print('Error: la caja está cerrada');
      return false;
    }

    if (valor <= 0) {
      print('Error: el egreso debe ser mayor que 0');
      return false;
    }

    _egresos.add(valor);
    print('Egreso registrado: $concepto ($valor)');
    return true;
  }

  // Cerrar caja
  String cerrar(int efectivoContado) {
    if (!_abierta) {
      return 'Error: la caja está cerrada';
    }

    int esperado = efectivoEsperado;
    int diferencia = efectivoContado - esperado;

    print('===== CIERRE DE CAJA =====');
    print('Ventas: $_cantidadVentas por $totalVendido');
    print('Por medio de pago: $_ventasPorMedio');
    print('Egresos: $totalEgresos');
    print('Efectivo esperado: $esperado');
    print('Efectivo contado: $efectivoContado');

    _abierta = false;

    if (diferencia == 0) {
      return 'Caja cuadrada';
    } else if (diferencia > 0) {
      return 'Sobrante de $diferencia';
    } else {
      return 'Faltante de ${diferencia.abs()}';
    }
  }
}

// Código de prueba
void main() {
  var caja = Caja();
  caja.registrarVenta(45000, 'efectivo');
  caja.abrir(200000);

  List<int> totales = [45000, 120000, 38000, 76000, 54000, 91000];
  List<String> medios = ['efectivo', 'debito', 'efectivo', 'credito', 'efectivo', 'debito'];
  for (var i = 0; i < totales.length; i++) {
    caja.registrarVenta(totales[i], medios[i]);
  }
  caja.registrarVenta(50000, 'bitcoin');

  caja.registrarEgreso('Compra de hielo', 15000);
  caja.registrarEgreso('Recarga de gas', 20000);

  print(caja.cerrar(300000));
  caja.registrarVenta(10000, 'efectivo');
}
