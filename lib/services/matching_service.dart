import 'package:soulsync/data/models.dart';
import 'package:soulsync/services/firebase_service.dart';

class MatchingService {
  static final MatchingService instance = MatchingService._internal();
  factory MatchingService() => instance;
  MatchingService._internal();

  final FirebaseService _firebase = FirebaseService();

  // Calculate compatibility score between two users (0-100)
  int calculateCompatibilityScore(User user1, User user2) {
    int score = 50;

    // Age compatibility (±5 years = perfect, ±10 = good, ±15 = fair)
    final ageDiff = (user1.age - user2.age).abs();
    if (ageDiff <= 5) score += 20;
    else if (ageDiff <= 10) score += 10;
    else if (ageDiff <= 15) score += 5;

    // Interest matching (each common interest adds 5 points)
    final commonInterests = user1.interests.toSet().intersection(user2.interests.toSet());
    score += commonInterests.length * 5;

    // Location distance (closer = better)
    if (user2.distance <= 5) score += 15;
    else if (user2.distance <= 10) score += 10;
    else if (user2.distance <= 20) score += 5;

    // Relationship goals matching
    if (user1.relationshipGoals == user2.relationshipGoals) score += 10;

    // Bio length (more detailed = better)
    if (user2.bio.length > 50) score += 5;
    if (user2.bio.length > 100) score += 5;

    // Image count (more images = better)
    if (user2.imageUrls.length >= 3) score += 5;
    if (user2.imageUrls.length >= 5) score += 5;

    return score.clamp(0, 100);
  }

  // For demo purposes - should be removed in production
  static List<User> getRecommendedUsers(
    User currentUser,
    List<User> allUsers,
    int limit, {
    required bool isDatingMode,
  }) {
    // Filter out current user
    final otherUsers = allUsers.where((user) => user.id != currentUser.id).toList();

    // Apply dating preference filter
    final filteredUsers = otherUsers.where((user) => 
      user.gender == currentUser.datingPreference
    ).toList();

    // Sort by compatibility score (highest first)
    filteredUsers.sort((a, b) {
      final scoreA = MatchingService.instance.calculateCompatibilityScore(currentUser, a);
      final scoreB = MatchingService.instance.calculateCompatibilityScore(currentUser, b);
      return scoreB.compareTo(scoreA);
    });

    return filteredUsers.take(limit).toList();
  }

  // Get potential matches for current user with advanced filtering and sorting
  List<User> getPotentialMatches(User currentUser, List<User> allUsers, Map<String, dynamic> preferences) {
    // Filter out current user
    var filteredUsers = allUsers.where((user) => user.id != currentUser.id).toList();

    // Apply dating preference filter
    if (currentUser.datingPreference != null && currentUser.datingPreference.isNotEmpty) {
      filteredUsers = filteredUsers.where((user) => 
        user.gender == currentUser.datingPreference
      ).toList();
    }

    // Sort by compatibility score (highest first)
    filteredUsers.sort((a, b) {
      final scoreA = calculateCompatibilityScore(currentUser, a);
      final scoreB = calculateCompatibilityScore(currentUser, b);
      return scoreB.compareTo(scoreA);
    });

    return filteredUsers;
  }
}
