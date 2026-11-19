int calcularPropina(int subtotal, {int porcentaje = 10}) {
  return subtotal * porcentaje ~/ 100;
}

int calcularTotal(int subtotal, {bool conPropina = true}) {
  if (conPropina) {
    return subtotal + calcularPropina(subtotal);
  }

  return subtotal;
}

String formatearPesos(int valor) {
  String numero = valor.abs().toString();
  String resultado = '';
  int contador = 0;

  // Recorrer el número de derecha a izquierda
  for (int i = numero.length - 1; i >= 0; i--) {
    if (contador == 3) {
      resultado = '.$resultado';
      contador = 0;
    }

    resultado = numero[i] + resultado;
    contador++;
  }

  String signo = valor < 0 ? '-' : '';
  return '$signo\$ $resultado';
}

// Código de prueba del instructor
void main() {
  int subtotal = 91000;

  print('Subtotal: ${formatearPesos(subtotal)}');
  print('Propina 10 %: ${formatearPesos(calcularPropina(subtotal))}');
  print('Propina 15 %: ${formatearPesos(calcularPropina(subtotal, porcentaje: 15))}');
  print('Total con propina: ${formatearPesos(calcularTotal(subtotal))}');
  print('Total sin propina: ${formatearPesos(calcularTotal(subtotal, conPropina: false))}');
  print(formatearPesos(999));
  print(formatearPesos(1000000));
}
