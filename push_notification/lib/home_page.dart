import 'package:flutter/material.dart';
import 'package:push_notification/notification_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _onOrderPressed() {
    NotificationService.showSimulatedNotification(
      'Order Placed',
      'Your order has been received.',
    );
  }

  void _onPayPressed() {
    NotificationService.showSimulatedNotification(
      'Payment Success',
      'Your payment was successful.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order & Pay')),
      body: const Center(
        child: Text('Tap a button below to simulate a notification'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _onOrderPressed,
                child: const Text('Order'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: _onPayPressed,
                child: const Text('Pay'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
