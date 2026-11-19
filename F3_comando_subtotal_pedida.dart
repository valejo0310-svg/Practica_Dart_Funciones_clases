final Map<String, int> menuDelDia = {
  'Ajiaco': 28000,
  'Bandeja paisa': 32000,
  'Sancocho': 26000,
  'Limonada': 6000,
  'Jugo natural': 7000,
  'Gaseosa': 5000,
  'Postre del día': 9000,
};

// FUNCIÓN 1: Calcular subtotal
int calcularSubtotalPedido(
  Map<String, int> menu,
  Map<String, int> pedido
) {
  int subtotal = 0;

  for (var item in pedido.entries) {
    if (menu.containsKey(item.key)) {
      int precio = menu[item.key]!;
      subtotal += precio * item.value;
    }
  }

  return subtotal;
}

// FUNCIÓN 2: Buscar productos no encontrados
List<String> productosNoEncontrados(
  Map<String, int> menu,
  Map<String, int> pedido
) {
  List<String> faltantes = [];

  for (var nombre in pedido.keys) {
    if (!menu.containsKey(nombre)) {
      faltantes.add(nombre);
    }
  }

  return faltantes;
}

// FUNCIÓN 3: Imprimir comanda
void imprimirComanda(
  int mesa,
  Map<String, int> menu,
  Map<String, int> pedido
) {
  print('--- COMANDA MESA $mesa ---');

  // Mostrar los productos válidos
  for (var item in pedido.entries) {
    String nombre = item.key;
    int cantidad = item.value;

    if (!menu.containsKey(nombre)) {
      continue;
    }

    int valor = menu[nombre]! * cantidad;
    print('$cantidad x $nombre = $valor');
  }

  // Llamar a la función 2
  List<String> faltantes =
      productosNoEncontrados(menu, pedido);

  if (faltantes.isNotEmpty) {
    print('No están en el menú: $faltantes');
  }

  // Llamar a la función 1
  int subtotal = calcularSubtotalPedido(menu, pedido);
  print('Subtotal: $subtotal');
}

// CÓDIGO DE PRUEBA
void main() {
  Map<String, int> pedidoMesa4 = {
    'Bandeja paisa': 2,
    'Limonada': 3,
    'Postre del día': 1,
    'Cazuela': 1,
  };
  imprimirComanda(4, menuDelDia, pedidoMesa4);

  Map<String, int> pedidoMesa9 = {'Ajiaco': 2, 'Gaseosa': 2};
  imprimirComanda(9, menuDelDia, pedidoMesa9);
}
