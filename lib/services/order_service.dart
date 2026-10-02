class OrderService {
  static final List<Map<String, dynamic>> orders = [];

  static void addOrder({
    required List<Map<String, dynamic>> items,
    required double subtotal,
    required double deliveryFee,
    required double total,
  }) {
    orders.insert(0, {
      'orderId': '#SE${DateTime.now().millisecondsSinceEpoch % 100000}',
      'date': DateTime.now(),
      'status': 'Processing',
      'items': items
          .map(
            (item) => {
          'name': item['name'],
          'price': item['price'],
          'quantity': item['quantity'],
          'icon': item['icon'],
        },
      )
          .toList(),
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'total': total,
    });
  }
}