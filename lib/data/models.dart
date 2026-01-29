class User {
  final String id;
  final String name;
  final List<String> imageUrls;
  final int age;
  final String bio;
  final String location;
  final List<String> interests;
  final bool starSignVerified;
  final String zodiacSign;
  final String jobTitle;
  final String gender;
  final int heightCm;
  final String education;
  final String datingPreference;
  final int distance;
  final String relationshipGoals;
  final String birthday;
  final String occupation;
  final String drinks;
  final String smokes;
  final String pets;

  // Aliases for compatibility
  bool get isVerified => starSignVerified;
  String get work => jobTitle;

  const User({
    required this.id,
    required this.name,
    required this.imageUrls,
    required this.age,
    required this.bio,
    required this.location,
    required this.interests,
    this.starSignVerified = false,
    this.zodiacSign = '',
    this.jobTitle = '',
    this.gender = '',
    this.heightCm = 0,
    this.education = '',
    this.datingPreference = '',
    this.distance = 5,
    this.relationshipGoals = 'Long-term Relationship',
    this.birthday = 'January 15, 1995',
    this.occupation = 'Software Engineer',
    this.drinks = 'Socially',
    this.smokes = 'No',
    this.pets = 'Dog lover',
  });
}

class Event {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String location;
  final String imageUrl;
  final double price;
  final int attendeesCount;

  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.imageUrl,
    required this.price,
    this.attendeesCount = 0,
  });
}

class ChatMessage {
  final String id;
  final String senderId;
  final String content;
  final DateTime timestamp;
  final bool isMe;

  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.content,
    required this.timestamp,
    required this.isMe,
  });
}

class Chat {
  final String chatId;
  final User user;
  final ChatMessage lastMessage;
  final int unreadCount;

  const Chat({
    required this.chatId,
    required this.user,
    required this.lastMessage,
    required this.unreadCount,
  });
}
