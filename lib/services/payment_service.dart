import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/material.dart';

class PaymentService {
  // Initialize Stripe with your publishable key
  static const String _publishableKey = 'pk_test_your_publishable_key';
  
  // Subscription plans (using translation keys)
  static const List<SubscriptionPlan> subscriptionPlans = [
    SubscriptionPlan(
      id: '1',
      name: 'free',
      description: 'Basic features',
      price: 0.00,
      currency: 'USD',
      duration: 'monthly',
      features: ['unlimitedSwipes', 'basicFilters', 'secureMessaging'],
    ),
    SubscriptionPlan(
      id: '2',
      name: 'plus',
      description: 'Enhanced features',
      price: 9.99,
      currency: 'USD',
      duration: 'monthly',
      features: ['seeWhoLikedYou', 'advancedFilters', 'oneBoostPerMonth'],
    ),
    SubscriptionPlan(
      id: '3',
      name: 'premium',
      description: 'Premium features',
      price: 19.99,
      currency: 'USD',
      duration: 'monthly',
      features: ['unlimitedBoosts', 'prioritySupport', 'readReceipts'],
    ),
  ];

  // Initialize Stripe
  static Future<void> initialize() async {
    Stripe.publishableKey = _publishableKey;
  }

  // Create payment method and confirm payment
  static Future<bool> processSubscription(
    BuildContext context,
    SubscriptionPlan plan,
  ) async {
    try {
      // Create payment method (simulated for demo)
      final paymentMethodId = await _createPaymentMethod();
      
      if (paymentMethodId != null) {
        // Confirm payment (simulated)
        await _confirmPayment(paymentMethodId, plan);
        
        // Update user subscription status
        return true;
      }
      
      return false;
    } catch (e) {
      print('Error processing payment: $e');
      _showError(context, e.toString());
      return false;
    }
  }

  // Create payment method (simulated)
  static Future<String?> _createPaymentMethod() async {
    try {
      // In real app, you would use Payment Sheet or Card Form
      // This is a simulation
      await Future.delayed(Duration(seconds: 2));
      
      return 'pm_1234567890';
    } catch (e) {
      print('Error creating payment method: $e');
      return null;
    }
  }

  // Confirm payment (simulated)
  static Future<void> _confirmPayment(
    String paymentMethodId,
    SubscriptionPlan plan,
  ) async {
    try {
      // In real app, you would use Stripe API to confirm payment
      // This is a simulation
      await Future.delayed(Duration(seconds: 1, milliseconds: 500));
      
      print('Payment confirmed for ${plan.name}');
    } catch (e) {
      print('Error confirming payment: $e');
      rethrow;
    }
  }

  // Show error dialog
  static void _showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Payment Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class SubscriptionPlan {
  final String id;
  final String name;
  final String description;
  final double price;
  final String currency;
  final String duration;
  final List<String> features;

  const SubscriptionPlan({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.currency,
    required this.duration,
    required this.features,
  });

  String get priceString => '\$${price.toStringAsFixed(2)}/${duration.toLowerCase()}';
}
