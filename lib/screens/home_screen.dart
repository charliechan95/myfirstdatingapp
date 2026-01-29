import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../data/mock_data.dart';
import '../data/models.dart';
import '../data/user_preferences.dart';
import '../theme.dart';
import '../services/matching_service.dart';
import '../widgets/app_end_drawer.dart';
import '../widgets/swipe_card.dart';
import '../l10n/translations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AppinioSwiperController controller = AppinioSwiperController();
  List<Widget> cards = [];
  int _selectedIndex = 0;
  bool _showHeartIndicator = false;
  bool _showCrossIndicator = false;
  bool _isDatingMode = true; // true for Dating, false for BFF

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  void _loadCards() {
    // For demo purposes, use current user with default preferences
    final currentUser = MockData.currentUser; // In real app, this would be the authenticated user
    
    // Load recommended users based on matching algorithm
    final recommendedUsers = MatchingService.getRecommendedUsers(
      currentUser,
      MockData.users,
      10, // Limit to 10 matches
      isDatingMode: _isDatingMode,
    );
    
    cards = recommendedUsers.map((user) => SwipeCard(user: user)).toList();
  }

  void _toggleMode() {
    setState(() {
      _isDatingMode = !_isDatingMode;
      _loadCards();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        // Already on Match
        break;
      case 1:
        context.push('/explore');
        break;
      case 2:
        context.push('/chats');
        break;
      case 3:
        context.push('/profile');
        break;
    }
  }

  void _showHeartIndicatorAndMatch(User user) {
    setState(() {
      _showHeartIndicator = true;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _showHeartIndicator = false;
        });
        // Navigate to match screen
        context.push('/match', extra: user);
      }
    });
  }

  void _showCrossIndicatorAnimation() {
    setState(() {
      _showCrossIndicator = true;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _showCrossIndicator = false;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (!_isDatingMode) _toggleMode();
                    },
                    child: Text(
                      'Dating',
                      style: TextStyle(
                        color: _isDatingMode ? AppColors.primary : Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      if (_isDatingMode) _toggleMode();
                    },
                    child: Text(
                      'BFF',
                      style: TextStyle(
                        color: !_isDatingMode ? AppColors.primary : Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: const AppEndDrawer(),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AppinioSwiper(
                    controller: controller,
                    cardCount: cards.length,
                    cardBuilder: (context, index) {
                      return cards[index];
                    },
                    onSwipeEnd: (previousIndex, targetIndex, activity) {
                      if (activity is Swipe) {
                        if (activity.direction == AxisDirection.right) {
                          _showHeartIndicatorAndMatch(MockData.users[targetIndex - 1]);
                        } else if (activity.direction == AxisDirection.left) {
                          _showCrossIndicatorAnimation();
                        }
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _actionButton(
                      icon: Icons.replay,
                      color: Colors.orange,
                      onTap: () {},
                      isSmall: true,
                    ),
                    _actionButton(
                      icon: Icons.close,
                      color: AppColors.primary,
                      onTap: () => controller.swipeLeft(),
                    ),
                    _actionButton(
                      icon: Icons.star_border,
                      color: Colors.blue,
                      onTap: () {},
                      isSmall: true,
                    ),
                    _actionButton(
                      icon: Icons.favorite_border,
                      color: Colors.green,
                      onTap: () => controller.swipeRight(),
                    ),
                    _actionButton(
                      icon: Icons.bolt,
                      color: Colors.purple,
                      onTap: () {},
                      isSmall: true,
                    ),
                  ],
                ),
              ).animate().slideY(begin: 1, end: 0, duration: 500.ms, curve: Curves.easeOutBack),
            ],
          ),
          // Heart Indicator
          if (_showHeartIndicator)
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.5),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: const Text(
                  'LIKED',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ).animate().scale(
                duration: 300.ms,
                curve: Curves.elasticOut,
              ),
            ),
          // Cross Indicator
          if (_showCrossIndicator)
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.5),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: const Text(
                  'PASS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ).animate().scale(
                duration: 300.ms,
                curve: Curves.elasticOut,
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.local_fire_department),
            label: t.match,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.explore_outlined),
            label: t.explore,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.chat_bubble_outline),
            label: t.chat,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            label: t.profile,
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    bool isSmall = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isSmall ? 50 : 64,
        height: isSmall ? 50 : 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: color,
          size: isSmall ? 24 : 30,
        ),
      ),
    );
  }
}
