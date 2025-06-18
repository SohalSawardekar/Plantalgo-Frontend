// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_chat_ui/flutter_chat_ui.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// import 'package:uuid/uuid.dart';
// import '../../services/api_service.dart';

// class ChatbotScreen extends StatefulWidget {
//   const ChatbotScreen({Key? key}) : super(key: key);

//   @override
//   State<ChatbotScreen> createState() => _ChatbotScreenState();
// }

// class _ChatbotScreenState extends State<ChatbotScreen> {
//   final List<types.Message> _messages = [];
//   final _user = const types.User(id: 'user');
//   final _bot = const types.User(id: 'bot', firstName: 'Crop', lastName: 'Expert');
//   late final ChatController _chatController;
//   @override
//   void initState() {
//     super.initState();
//     _chatController = ChatController(
//       messages: _messages,
//     );
//     _addWelcomeMessage();
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
//   }

//   void _addWelcomeMessage() {
//     final welcomeMessage = types.TextMessage(
//       author: _bot,
//       createdAt: DateTime.now().millisecondsSinceEpoch,
//       id: const Uuid().v4(),
//       text: 'Hello! I\'m your AI farming assistant. I can help you with:\n\n'
//           '🌱 Crop disease identification\n'
//           '🚜 Farming best practices\n'
//           '💧 Irrigation advice\n'
//           '🌿 Pest management\n'
//           '🌾 Crop nutrition\n\n'
//           'How can I help you today?',
//     );

//     setState(() {
//       _messages.insert(0, welcomeMessage);
//     });
//   }

//   void _handleSendPressed(types.PartialText message) async {
//     final textMessage = types.TextMessage(
//       author: _user,
//       createdAt: DateTime.now().millisecondsSinceEpoch,
//       id: const Uuid().v4(),
//       text: message.text,
//     );

//     setState(() {
//       _messages.insert(0, textMessage);
//     });

//     // Show typing indicator
//     _showTypingIndicator();

//     // Get response from API
//     final response = await context.read<ApiService>().getChatbotResponse(message.text);

//     // Hide typing indicator and show response
//     _hideTypingIndicator();
    
//     if (response != null) {
//       final botMessage = types.TextMessage(
//         author: _bot,
//         createdAt: DateTime.now().millisecondsSinceEpoch,
//         id: const Uuid().v4(),
//         text: response,
//       );

//       setState(() {
//         _messages.insert(0, botMessage);
//       });
//     }
//   }

//   void _showTypingIndicator() {
//     final typingMessage = types.TextMessage(
//       author: _bot,
//       createdAt: DateTime.now().millisecondsSinceEpoch,
//       id: 'typing',
//       text: 'Typing...',
//     );

//     setState(() {
//       _messages.insert(0, typingMessage);
//     });
//   }

//   void _hideTypingIndicator() {
//     setState(() {
//       _messages.removeWhere((message) => message.id == 'typing');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Crop Expert AI'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () {
//               setState(() {
//                 _messages.clear();
//               });
//               _addWelcomeMessage();
//       body: Chat(
//         chatMessages: _messages,
//         chatController: _chatController,
//         currentUserId: _user.id,
//         resolveUser: (id) => id == _user.id ? _user : _bot,
//         onSendPressed: _handleSendPressed,
//         user: _user,
//         theme: DefaultChatTheme(
//         chatMessages: _messages,
//         onSendPressed: _handleSendPressed,
//         user: _user,
//         theme: DefaultChatTheme(
//           primaryColor: Theme.of(context).colorScheme.primary,
//           secondaryColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
//           backgroundColor: Theme.of(context).colorScheme.background,
//           inputBackgroundColor: Colors.white,
//           inputTextColor: Theme.of(context).colorScheme.onSurface,
//           messageBorderRadius: 16,
//           sentMessageBodyTextStyle: const TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//           ),
//           receivedMessageBodyTextStyle: TextStyle(
//             color: Theme.of(context).colorScheme.onSurface,
//             fontSize: 16,
//           ),
//         ),
//         inputOptions: const InputOptions(
//           sendButtonVisibilityMode: SendButtonVisibilityMode.always,
//         ),
//         showUserAvatars: false,
//         showUserNames: false,
//         emptyState: Container(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.chat_bubble_outline,
//                 size: 80,
//                 color: Colors.grey[400],
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 'Start a conversation',
//                 style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                   color: Colors.grey[600],
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'Ask me anything about farming and crop care',
//                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                   color: Colors.grey[500],
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }