import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'data/mock_data.dart';
import 'data/models.dart';
import 'data/user_preferences.dart';
import 'screens/splash_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/phone_verification_screen.dart';
import 'screens/verify_code_screen.dart';
import 'screens/face_authentication_screen.dart';
import 'screens/video_face_verification_screen.dart';
import 'screens/dating_preferences_screen.dart';
import 'screens/ai_dating_advice_screen.dart';
import 'screens/home_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/events_list_screen.dart';
import 'screens/chat_list_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/profile_detail_screen.dart';
import 'screens/chat_detail_screen.dart';
import 'screens/event_detail_screen.dart';
import 'screens/video_call_screen.dart';
import 'screens/security_screen.dart';
import 'screens/subscription_screen.dart';
import 'screens/match_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String auth = '/auth';
  static const String phoneVerification = '/phone-verification';
  static const String verifyCode = '/phone-verification/code';
  static const String faceAuthentication = '/face-authentication';
  static const String videoFaceVerification = '/video-face-verification';
  static const String datingPreferences = '/dating-preferences';
  static const String aiDatingAdvice = '/ai-dating-advice';
  static const String home = '/home';
  static const String explore = '/explore';
  static const String events = '/events';
  static const String chats = '/chats';
  static const String profile = '/profile';
  static const String profileDetail = '/profile-detail';
  static const String chatDetail = '/chat-detail';
  static const String eventDetail = '/event-detail';
  static const String videoCall = '/video-call';
  static const String security = '/security';
  static const String subscription = '/subscription';
  static const String match = '/match';
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.auth,
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: AppRoutes.phoneVerification,
      builder: (context, state) => const PhoneVerificationScreen(),
    ),
    GoRoute(
      path: AppRoutes.verifyCode,
      builder: (context, state) {
        final arguments = state.extra as Map?;
        return VerifyCodeScreen(
          phoneNumber: arguments?['phoneNumber'] ?? '',
        );
      },
    ),
    GoRoute(
      path: AppRoutes.faceAuthentication,
      builder: (context, state) => const FaceAuthenticationScreen(),
    ),
    GoRoute(
      path: AppRoutes.videoFaceVerification,
      builder: (context, state) => const VideoFaceVerificationScreen(),
    ),
    GoRoute(
      path: AppRoutes.datingPreferences,
      builder: (context, state) => const DatingPreferencesScreen(),
    ),
    GoRoute(
      path: AppRoutes.aiDatingAdvice,
      builder: (context, state) => AiDatingAdviceScreen(
        userPreferences: state.extra as UserPreferences?,
      ),
    ),
    GoRoute(
      path: AppRoutes.subscription,
      builder: (context, state) => const SubscriptionScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.explore,
      builder: (context, state) => const ExploreScreen(),
    ),
    GoRoute(
      path: AppRoutes.events,
      builder: (context, state) => const EventsListScreen(),
    ),
    GoRoute(
      path: AppRoutes.chats,
      builder: (context, state) => const ChatListScreen(),
    ),
    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '${AppRoutes.chatDetail}/:id',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        final chat = MockData.chats.firstWhere(
          (c) => c.chatId == id,
          orElse: () {
            // If chat not found, check if it's a user ID
            final user = MockData.users.firstWhere(
              (u) => u.id == id,
              orElse: () => MockData.users[0],
            );
            // Create a new chat
            return Chat(
              chatId: id,
              user: user,
              lastMessage: ChatMessage(
                id: 'm${DateTime.now().millisecondsSinceEpoch}',
                senderId: MockData.currentUser.id,
                content: '',
                timestamp: DateTime.now(),
                isMe: true,
              ),
              unreadCount: 0,
            );
          },
        );
        return ChatDetailScreen(chat: chat);
      },
    ),
    GoRoute(
      path: '${AppRoutes.eventDetail}/:id',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        final event = MockData.events.firstWhere((e) => e.id == id, orElse: () => MockData.events.first);
        return EventDetailScreen(event: event);
      },
    ),
    GoRoute(
      path: AppRoutes.videoCall,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const VideoCallScreen(userId: 'u2'), // Dummy user ID
    ),
    GoRoute(
      path: AppRoutes.security,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SecurityScreen(),
    ),
    GoRoute(
      path: AppRoutes.subscription,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SubscriptionScreen(),
    ),
    GoRoute(
      path: AppRoutes.match,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final user = state.extra as User?;
        return MatchScreen(user: user ?? MockData.users[0]);
      },
    ),
    GoRoute(
      path: '${AppRoutes.profileDetail}/:id',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        final user = MockData.users.firstWhere((u) => u.id == id);
        return ProfileDetailScreen(user: user);
      },
    ),
  ],
);
