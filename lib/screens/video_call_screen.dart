import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../data/mock_data.dart';

class VideoCallScreen extends StatelessWidget {
  final String userId;

  const VideoCallScreen({super.key, this.userId = 'u2'});

  @override
  Widget build(BuildContext context) {
    final user = MockData.users.firstWhere((u) => u.id == userId, orElse: () => MockData.users.first);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Remote Video (Simulated)
          Image.asset(
            user.imageUrls.first,
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.transparent,
                  Colors.black.withOpacity(0.6),
                ],
              ),
            ),
          ),
          // Local Video (Simulated)
          Positioned(
            right: 20,
            top: 50,
            child: Container(
              width: 100,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Image.asset(
                  MockData.currentUser.imageUrls.first,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Controls
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _controlButton(Icons.mic_off, Colors.white, Colors.white.withOpacity(0.2)),
                _controlButton(Icons.videocam_off, Colors.white, Colors.white.withOpacity(0.2)),
                _controlButton(Icons.call_end, Colors.white, Colors.red, onTap: () => context.pop()),
                _controlButton(Icons.switch_camera, Colors.white, Colors.white.withOpacity(0.2)),
              ],
            ),
          ).animate().slideY(begin: 1, end: 0),
          // User Info
          Positioned(
            top: 60,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  '00:45',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _controlButton(IconData icon, Color iconColor, Color bgColor, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 32),
      ),
    );
  }
}
