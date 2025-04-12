import 'dart:async';

enum PurchaseStatus { pending, purchased, error }

class Purchase {
  final String productId;
  final PurchaseStatus status;

  Purchase(this.productId, this.status);
}

class SubscriptionService {
  final StreamController<List<Purchase>> _purchaseController = StreamController.broadcast();
  Stream<List<Purchase>> get purchaseStream => _purchaseController.stream;

  Future<void> purchaseProduct(String productId) async {
    // Simulate a purchase
    await Future.delayed(Duration(seconds: 2));
    _purchaseController.add([Purchase(productId, PurchaseStatus.purchased)]);
  }
}