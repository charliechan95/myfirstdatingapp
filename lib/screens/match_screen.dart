import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../data/models.dart';
import '../theme.dart';
import '../nav.dart';
import '../l10n/translations.dart';

class MatchScreen extends StatefulWidget {
  final User user;

  const MatchScreen({super.key, required this.user});

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> with TickerProviderStateMixin {
  late AnimationController _heartController;
  late AnimationController _confettiController;
  late Animation<double> _heartAnimation;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _confettiController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _heartAnimation = CurvedAnimation(
      parent: _heartController,
      curve: Curves.elasticOut,
    );

    _heartController.forward();
    _confettiController.repeat();
  }

  @override
  void dispose() {
    _heartController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Confetti Animation
          Positioned.fill(
            child: _ConfettiOverlay(controller: _confettiController),
          ),
          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),
                // It's a Match Text
                Text(
                  t.itsAMatch,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Serif',
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black.withOpacity(0.3),
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 800.ms).slideY(begin: -0.3),
                const SizedBox(height: 20),
                Text(
                  'You and ${widget.user.name} liked each other',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black.withOpacity(0.3),
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 300.ms, duration: 800.ms),
                const SizedBox(height: 40),
                // Profile Images with Heart
                Center(
                  child: SizedBox(
                    height: 300,
                    width: 280,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Current User Placeholder
                        Positioned(
                          left: 0,
                          child: Container(
                            width: 130,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [AppColors.primary, AppColors.secondary],
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                        ).animate().slideX(begin: -0.5, duration: 800.ms, curve: Curves.easeOut),
                        // Matched User
                        Positioned(
                          right: 0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              widget.user.imageUrls.first,
                              width: 130,
                              height: 200,
                              fit: BoxFit.cover,
                              errorBuilder: (c, e, s) => Container(
                                width: 130,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade800,
                                ),
                                child: const Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Colors.white54,
                                ),
                              ),
                            ),
                          ),
                        ).animate().slideX(begin: 0.5, duration: 800.ms, curve: Curves.easeOut),
                        // Heart Animation
                        Center(
                          child: ScaleTransition(
                            scale: _heartAnimation,
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary,
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                // Send Message Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => context.push('${AppRoutes.chatDetail}/new_${widget.user.id}'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      icon: const Icon(Icons.message),
                      label: Text(
                        t.sendMessage,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 600.ms, duration: 800.ms).slideY(begin: 1),
                ),
                const SizedBox(height: 16),
                // Keep Swiping Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                        side: BorderSide(color: AppColors.primary, width: 2),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        t.keepSwiping,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 800.ms, duration: 800.ms).slideY(begin: 1),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ConfettiOverlay extends StatefulWidget {
  final AnimationController controller;

  const _ConfettiOverlay({required this.controller});

  @override
  State<_ConfettiOverlay> createState() => _ConfettiOverlayState();
}

class _ConfettiOverlayState extends State<_ConfettiOverlay> {
  final List<ConfettiParticle> particles = [];

  @override
  void initState() {
    super.initState();
    _generateParticles();
    widget.controller.addListener(_updateParticles);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateParticles);
    super.dispose();
  }

  void _generateParticles() {
    for (int i = 0; i < 50; i++) {
      particles.add(
        ConfettiParticle(
          id: i,
          color: [
            AppColors.primary,
            Colors.white,
            AppColors.secondary,
            Colors.amber,
            Colors.pink,
          ][i % 5],
          startX: 0.5 + (DateTime.now().millisecond % 100 - 50) / 100.0,
          startY: -0.1,
        ),
      );
    }
  }

  void _updateParticles() {
    for (var particle in particles) {
      particle.update();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ConfettiPainter(particles: particles),
    );
  }
}

class ConfettiParticle {
  final int id;
  final Color color;
  final double startX;
  final double startY;
  double x;
  double y;
  double velocityX;
  double velocityY;
  double size;
  double rotation;
  double rotationSpeed;

  ConfettiParticle({
    required this.id,
    required this.color,
    required this.startX,
    required this.startY,
  })  : x = startX,
        y = startY,
        velocityX = 0,
        velocityY = 0.02,
        size = 8,
        rotation = 0,
        rotationSpeed = 0.05;

  void update() {
    x += velocityX;
    y += velocityY;
    velocityY += 0.002;
    rotation += rotationSpeed;
    if (y > 1.1) {
      y = -0.1;
      x = startX;
      velocityX = (DateTime.now().millisecond % 200 - 100) / 100.0;
      velocityY = 0.02;
    }
  }
}

class ConfettiPainter extends CustomPainter {
  final List<ConfettiParticle> particles;

  ConfettiPainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      canvas.save();
      canvas.translate(size.width * particle.x, size.height * particle.y);
      canvas.rotate(particle.rotation);
      
      final paint = Paint()
        ..color = particle.color
        ..style = PaintingStyle.fill;
      
      final rect = Rect.fromCenter(
        center: Offset.zero,
        width: particle.size,
        height: particle.size * 0.6,
      );
      canvas.drawRect(rect, paint);
      
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
