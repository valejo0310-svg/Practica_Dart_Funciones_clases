String? validarAperturaCaja(
    String rol, int base, bool cajaAbierta) {

  // 1. Verificar si ya existe una caja abierta
  if (cajaAbierta) {
    return 'Ya hay una caja abierta';
  }

  // 2. Verificar el rol del usuario
  if (rol != 'cajero' && rol != 'admin') {
    return 'El rol $rol no puede abrir la caja';
  }

  // 3. Verificar que la base no sea negativa
  if (base < 0) {
    return 'La base no puede ser negativa';
  }

  // 4. Verificar que no supere el máximo
  if (base > 10000000) {
    return 'La base supera el máximo permitido';
  }

  // 5. No existe ningún error
  return null;
}

// Función flecha para mostrar el estado
String estadoCaja(bool abierta) =>
    abierta ? 'ABIERTA' : 'CERRADA';

// Código de prueba del instructor (sin modificar)
void main() {
  List<String> roles = ['cajero', 'mesero', 'admin', 'cajero', 'admin'];
  List<int> bases = [200000, 200000, -5000, 10000001, 100000];
  List<bool> abiertas = [false, false, false, false, true];

  for (var i = 0; i < roles.length; i++) {
    String? error = validarAperturaCaja(roles[i], bases[i], abiertas[i]);
    bool quedaAbierta = abiertas[i] || error == null;
    String resultado = error ?? 'Caja abierta con base ${bases[i]}';
    print('Caso ${i + 1}: $resultado. Estado: ${estadoCaja(quedaAbierta)}');
  }
}
