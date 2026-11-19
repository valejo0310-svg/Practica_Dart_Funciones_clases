class Producto {
  final String nombre;
  final int precio;

  Producto(this.nombre, this.precio);
}

class ItemPedido {
  final Producto producto;
  int cantidad;
  String? observacion;

  ItemPedido(
    this.producto,
    this.cantidad, {
    this.observacion,
  });

  int get subtotal => producto.precio * cantidad;
}

class Pedido {
  final int mesa;
  final String mesero;
  final List<ItemPedido> items = [];

  Pedido(this.mesa, this.mesero);

  // Agregar productos al pedido
  void agregarProducto(
    Producto producto,
    int cantidad, {
    String? observacion,
  }) {
    if (cantidad <= 0) return;

    for (var item in items) {
      if (item.producto.nombre == producto.nombre) {
        item.cantidad += cantidad;
        return;
      }
    }

    items.add(
      ItemPedido(
        producto,
        cantidad,
        observacion: observacion,
      ),
    );
  }

  // Quitar productos del pedido
  bool quitarProducto(String nombre, int cantidad) {
    for (var item in items) {
      if (item.producto.nombre == nombre) {
        if (cantidad <= 0 || cantidad > item.cantidad) {
          return false;
        }

        item.cantidad -= cantidad;

        if (item.cantidad == 0) {
          items.remove(item);
        }

        return true;
      }
    }

    print('$nombre no está en el pedido');
    return false;
  }

  // Calcular el total del pedido
  int get total {
    int suma = 0;

    for (var item in items) {
      suma += item.subtotal;
    }

    return suma;
  }

  // Calcular la cantidad total de artículos
  int get cantidadArticulos {
    int cantidad = 0;

    for (var item in items) {
      cantidad += item.cantidad;
    }

    return cantidad;
  }

  // Imprimir la comanda
  void imprimirComanda() {
    print('Mesa $mesa - Mesero: $mesero');

    for (var item in items) {
      String detalle =
          '${item.cantidad} x ${item.producto.nombre}';

      if (item.observacion != null) {
        detalle += ' (${item.observacion})';
      }

      print('$detalle = ${item.subtotal}');
    }

    print('Total: $total ($cantidadArticulos artículos)');
  }
}

// Código de prueba del SENA (sin modificar)
void main() {
  var bandeja = Producto('Bandeja paisa', 32000);
  var limonada = Producto('Limonada', 6000);
  var postre = Producto('Postre del día', 9000);

  var pedido = Pedido(4, 'Carlos');
  pedido.agregarProducto(bandeja, 2, observacion: 'Una sin chicharrón');
  pedido.agregarProducto(limonada, 2);
  pedido.agregarProducto(postre, 1);
  pedido.agregarProducto(limonada, 1);
  pedido.quitarProducto('Postre del día', 1);
  pedido.quitarProducto('Ajiaco', 1);
  pedido.imprimirComanda();
}
