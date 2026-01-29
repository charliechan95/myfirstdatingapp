import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme.dart';
import '../nav.dart';
import '../services/payment_service.dart';
import '../l10n/translations.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(t.subscriptionPlans),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRoutes.home),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                t.upgradeToUnlockMore,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 30),

              // Subscription Plans
              ...PaymentService.subscriptionPlans.map(
                (plan) => _buildSubscriptionCard(context, plan),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard(BuildContext context, SubscriptionPlan plan) {
    final t = Translations.of(context);
    final isPopular = plan.name == 'plus';
    final gradient = isPopular 
        ? const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
          )
        : null;
    
    final textColor = isPopular ? Colors.white : Colors.black;
    final buttonColor = isPopular ? Colors.white : const Color(0xFFFF6B6B);
    final buttonTextColor = isPopular ? const Color(0xFFFF6B6B) : Colors.white;

    // Get translated plan name
    String getPlanName() {
      switch (plan.name) {
        case 'free':
          return t.free;
        case 'plus':
          return t.plus;
        case 'premium':
          return t.premium;
        default:
          return plan.name;
      }
    }

    // Get translated feature name
    String getFeatureName(String key) {
      switch (key) {
        case 'unlimitedSwipes':
          return t.unlimitedSwipes;
        case 'basicFilters':
          return t.basicFilters;
        case 'secureMessaging':
          return t.secureMessaging;
        case 'seeWhoLikedYou':
          return t.seeWhoLikedYou;
        case 'advancedFilters':
          return t.advancedFilters;
        case 'oneBoostPerMonth':
          return t.oneBoostPerMonth;
        case 'unlimitedBoosts':
          return t.unlimitedBoosts;
        case 'prioritySupport':
          return t.prioritySupport;
        case 'readReceipts':
          return t.readReceipts;
        default:
          return key;
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: gradient,
        color: gradient == null ? Colors.white : null,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPopular ? Colors.transparent : const Color(0xFFE5E5E5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Plan Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.celebration,
                    color: Color(0xFFFF6B6B),
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    getPlanName(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              Text(
                plan.price == 0 
                    ? '${t.free}/month' 
                    : '\$${plan.price.toStringAsFixed(2)}/month',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Features List
          ...plan.features.map(
            (featureKey) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    getFeatureName(featureKey),
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Choose Plan Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _subscribe(context, plan),
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: isPopular 
                      ? BorderSide.none 
                      : const BorderSide(
                          color: Color(0xFFFF6B6B),
                          width: 2,
                        ),
                ),
              ),
              child: Text(
                t.choosePlan,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: buttonTextColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _subscribe(BuildContext context, SubscriptionPlan plan) async {
    final t = Translations.of(context);
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      ),
    );

    try {
      // Process subscription
      final success = await PaymentService.processSubscription(context, plan);

      // Close loading indicator
      Navigator.of(context).pop();

      if (success) {
        // Show success message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(t.success),
            content: Text('${t.youAreNowSubscribed} ${plan.name}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.go(AppRoutes.home);
                },
                child: Text(t.ok),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Close loading indicator
      Navigator.of(context).pop();
      
      // Show error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(t.error),
          content: Text('${t.subscriptionFailed}${e.toString()}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(t.ok),
            ),
          ],
        ),
      );
    }
  }
}
