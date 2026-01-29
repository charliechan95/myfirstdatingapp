import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme.dart';
import '../nav.dart';
import '../data/user_preferences.dart';

class AiDatingAdviceScreen extends StatefulWidget {
  const AiDatingAdviceScreen({super.key, this.userPreferences});

  final UserPreferences? userPreferences;

  @override
  State<AiDatingAdviceScreen> createState() => _AiDatingAdviceScreenState();
}

class _AiDatingAdviceScreenState extends State<AiDatingAdviceScreen> {
  int _activeAdviceIndex = 0;

  final List<Map<String, dynamic>> _datingAdvice = [
    {
      'title': 'First Impressions Matter',
      'content': 'Your profile picture is the first thing people see. Choose a clear, friendly photo where you\'re smiling and looking at the camera. Avoid group photos or overly filtered images.',
      'icon': Icons.camera_alt,
      'color': Colors.blue
    },
    {
      'title': 'Be Authentic',
      'content': 'Write a bio that reflects your true personality. Be specific about your interests and what you\'re looking for. Avoid clichés like "I love to laugh" and be genuine.',
      'icon': Icons.person,
      'color': Colors.green
    },
    {
      'title': 'Message Quality Over Quantity',
      'content': 'When messaging someone, personalize your opening line based on their profile. Ask specific questions about their interests rather than just saying "Hi!".',
      'icon': Icons.message,
      'color': Colors.purple
    },
    {
      'title': 'Take It Offline',
      'content': 'Don\'t spend too much time messaging. If you have a good conversation, suggest meeting in person for a coffee or walk within a week.',
      'icon': Icons.location_on,
      'color': Colors.orange
    },
    {
      'title': 'Safety First',
      'content': 'Always meet in public places first, let someone know where you\'re going, and trust your instincts. Don\'t share personal information too quickly.',
      'icon': Icons.security,
      'color': Colors.red
    },
    {
      'title': 'Have Realistic Expectations',
      'content': 'Not every match will be perfect. Be open to different types of people and don\'t get discouraged by rejections. The right person is worth waiting for.',
      'icon': Icons.timeline,
      'color': Colors.teal
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Dating Advice'),
        backgroundColor: AppTheme.primary,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.gradient,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AI Assistant Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.blue.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: const Icon(
                        Icons.psychology,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: const Text(
                        '🤖 Your AI Matchmaking Assistant',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Welcome Message
              const Text(
                'Welcome to SoulMatch!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Based on your preferences, we\'ve compiled some personalized dating advice to help you find meaningful connections.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 30),

              // Advice Cards
              Container(
                height: 280,
                child: PageView.builder(
                  itemCount: _datingAdvice.length,
                  onPageChanged: (index) {
                    setState(() {
                      _activeAdviceIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final advice = _datingAdvice[index];
                    return _buildAdviceCard(
                      advice['title'],
                      advice['content'],
                      advice['icon'],
                      advice['color'],
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Page Indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_datingAdvice.length, (index) {
                  return Container(
                    width: _activeAdviceIndex == index ? 12 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: _activeAdviceIndex == index
                          ? AppTheme.primary
                          : Colors.white.withOpacity(0.3),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 40),

              // Matchmaking Features
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🎯 Our Matchmaking Features:',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...[
                      _buildFeatureItem('AI-Powered Matching', 'Algorithm learns from your preferences'),
                      _buildFeatureItem('Personality Assessment', 'Deep compatibility insights'),
                      _buildFeatureItem('Video Verification', 'Ensures real people only'),
                      _buildFeatureItem('Smart Messaging', 'Suggests conversation starters'),
                      _buildFeatureItem('Success Metrics', 'Track your dating progress'),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Final Steps
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.green.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '✅ You\'re Almost Ready!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Your profile is now complete. Our AI will start analyzing your preferences and find compatible matches based on shared interests, values, and goals.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Get Started Button
              Center(
                child: ElevatedButton(
                  onPressed: _completeOnboarding,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 60,
                      vertical: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdviceCard(
      String title,
      String content,
      IconData icon,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.2),
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String title, String description) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _completeOnboarding() {
    // Complete onboarding process
    context.go(AppRoutes.home);
  }
}
