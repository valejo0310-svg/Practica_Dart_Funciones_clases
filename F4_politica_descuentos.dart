int calcularPorcentajeDescuento({
  required int subtotal,
  String? cupon,
  bool clienteFrecuente = false,
  int maximo = 20,
}) {
  int descuento = 0;

  if (subtotal >= 150000) {
    descuento += 10;
  }

  if (cupon != null) {
    switch (cupon.toUpperCase()) {
      case 'CUMPLE':
        descuento += 15;
      case 'ESTUDIANTE':
        descuento += 5;
      default:
        print('Cupón $cupon no válido');
    }
  }

  if (clienteFrecuente) {
    descuento += 5;
  }

  if (descuento > maximo) {
    descuento = maximo;
  }

  return descuento;
}

int aplicarDescuento(int subtotal, int porcentaje) {
  int valorDescuento = subtotal * porcentaje ~/ 100;
  return subtotal - valorDescuento;
}

// Código de prueba del SENA (sin modificar)
void main() {
  List<int> subtotales = [162000, 162000, 80000, 80000];
  List<String?> cupones = ['CUMPLE', null, 'estudiante', 'GRATIS'];
  List<bool> frecuentes = [true, true, false, false];

  for (var i = 0; i < subtotales.length; i++) {
    int porcentaje = calcularPorcentajeDescuento(
       subtotal: subtotales[i],
       cupon: cupones[i],
       clienteFrecuente: frecuentes[i],
    );
    int total = aplicarDescuento(subtotales[i], porcentaje);
    print('Caso ${i + 1}: subtotal ${subtotales[i]}, descuento $porcentaje %, total $total');
  }
}
