import 'package:soulsync/data/models.dart';
import 'package:soulsync/services/firebase_service.dart';

class MessagingService {
  final FirebaseService _firebase = FirebaseService();

  // In-memory storage for demo purposes
  final Map<String, List<ChatMessage>> _messages = {};
  final Map<String, Map<String, dynamic>> _chats = {};

  // Send a message
  Future<void> sendMessage(String chatId, String senderId, String content,
      [String type = 'text']) async {
    try {
      final message = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        senderId: senderId,
        content: content,
        timestamp: DateTime.now(),
        isMe: true,
      );

      if (!_messages.containsKey(chatId)) {
        _messages[chatId] = [];
      }
      _messages[chatId]!.add(message);

      // Update last message in chat document
      if (_chats.containsKey(chatId)) {
        _chats[chatId]!['lastMessage'] = content;
        _chats[chatId]!['lastMessageTime'] = DateTime.now().toIso8601String();
        _chats[chatId]!['lastMessageSenderId'] = senderId;
      }
    } catch (e) {
      rethrow;
    }
  }

  // Get messages for a chat
  List<ChatMessage> getMessages(String chatId) {
    return _messages[chatId] ?? [];
  }

  // Mark messages as read
  Future<void> markMessagesAsRead(String chatId, String userId) async {
    try {
      // In a real app, this would update Firestore
    } catch (e) {
      rethrow;
    }
  }

  // Get chat details
  Future<Map<String, dynamic>?> getChatDetails(String chatId) async {
    try {
      return _chats[chatId];
    } catch (e) {
      rethrow;
    }
  }

  // Get unread messages count
  Future<int> getUnreadMessagesCount(String userId) async {
    try {
      int unreadCount = 0;
      for (final chatId in _messages.keys) {
        final messages = _messages[chatId] ?? [];
        for (final message in messages) {
          if (message.senderId != userId) {
            unreadCount++;
          }
        }
      }
      return unreadCount;
    } catch (e) {
      rethrow;
    }
  }

  // Delete a message
  Future<void> deleteMessage(String chatId, String messageId) async {
    try {
      if (_messages.containsKey(chatId)) {
        _messages[chatId]!.removeWhere((msg) => msg.id == messageId);
      }
    } catch (e) {
      rethrow;
    }
  }
}
