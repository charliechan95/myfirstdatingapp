import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../nav.dart';
import '../l10n/translations.dart';
import '../services/firebase_service.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final firebaseService = FirebaseService();
    
    // Auto navigate to auth screen
    Future.delayed(const Duration(seconds: 3), () {
      if (context.mounted) {
        context.pushReplacement(AppRoutes.auth);
      }
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE91E63),
              Color(0xFFF8BBD0),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Animation
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(
                      Icons.favorite,
                      size: 120,
                      color: Colors.white,
                    ).animate()
                        .fadeIn(duration: 800.ms)
                        .scaleXY(
                          duration: 800.ms,
                          begin: 0.5,
                          end: 1.0,
                          curve: Curves.easeOutBack,
                        ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(
                          Icons.flash_on,
                          size: 40,
                          color: Color(0xFFE91E63),
                        ),
                      ).animate()
                          .fadeIn(delay: 600.ms, duration: 800.ms)
                          .scaleXY(
                            delay: 600.ms,
                            duration: 800.ms,
                            begin: 0.3,
                            end: 1.0,
                            curve: Curves.bounceOut,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // App Name
              Text(
                t.appTitle,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Serif',
                  letterSpacing: 2,
                ),
              ).animate()
                  .fadeIn(delay: 800.ms, duration: 800.ms)
                  .slideY(
                    delay: 800.ms,
                    duration: 800.ms,
                    begin: 20,
                    end: 0,
                    curve: Curves.easeOut,
                  ),
              const SizedBox(height: 16),
              // Tagline
              Text(
                t.findYourPerfectMatch,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                  letterSpacing: 1.5,
                ),
              ).animate()
                  .fadeIn(delay: 1200.ms, duration: 800.ms)
                  .slideY(
                    delay: 1200.ms,
                    duration: 800.ms,
                    begin: 20,
                    end: 0,
                    curve: Curves.easeOut,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
