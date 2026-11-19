class Producto {
  // Atributos
  final String nombre;
  int precio;
  String categoria;
  bool disponible;

  // Constructor con parámetros nombrados
  Producto({
    required this.nombre,
    required this.precio,
    required this.categoria,
    this.disponible = true,
  });

  // Descripción del producto
  String descripcion() {
    String estado = disponible ? 'disponible' : 'agotado';
    return '$nombre ($categoria): $precio - $estado';
  }

  // Cambiar precio con validación
  bool cambiarPrecio(int nuevoPrecio) {
    if (nuevoPrecio <= 0) {
      print('Precio no válido para $nombre: $nuevoPrecio');
      return false;
    }

    precio = nuevoPrecio;
    return true;
  }

  // Marcar producto como agotado
  void marcarAgotado() {
    disponible = false;
  }

  // Representación del objeto
  @override
  String toString() {
    return 'Producto($nombre, $precio)';
  }
}

// Código de prueba
void main() {
  List<Producto> carta = [
    Producto(nombre: 'Ajiaco', precio: 28000, categoria: 'Platos fuertes'),
    Producto(nombre: 'Sancocho', precio: 26000, categoria: 'Platos fuertes'),
    Producto(nombre: 'Limonada', precio: 6000, categoria: 'Bebidas'),
    Producto(nombre: 'Postre del día', precio: 9000, categoria: 'Postres'),
  ];

  carta[0].cambiarPrecio(-100);
  bool cambio = carta[2].cambiarPrecio(6500);
  print('¿Se cambió el precio de la limonada? $cambio');
  carta[1].marcarAgotado();

  print('--- Carta ---');
  int disponibles = 0;
  for (var producto in carta) {
    print(producto.descripcion());
    if (producto.disponible) {
      disponibles++;
    }
  }
  print('Disponibles: $disponibles de ${carta.length}');
  print(carta[2]);
}
