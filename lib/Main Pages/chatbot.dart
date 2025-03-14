import 'package:flutter/material.dart';
import 'AI_engagement.dart';

class XecureChatApp extends StatelessWidget {
  const XecureChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Purple Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.purple[600]!,
          onPrimary: Colors.white,
          secondary: Colors.purple[400]!,
          surface: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.purple[200]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.purple[600]!, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.purple[200]!),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple[600],
            foregroundColor: Colors.white,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(16),
          ),
        ),
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) {
      // Option 1: Do nothing (ignore empty messages)
      return;

      // Option 2: Show a warning to the user
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text("Message cannot be empty!")),
      // );
      // return;
    }

    _textController.clear();

    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
      ));
      _isLoading = true;
    });

    // Scroll to bottom
    _scrollToBottom();

    // Simulate response after a delay
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
        _messages.add(ChatMessage(
          text: _generateResponse(text),
          isUser: false,
        ));
      });

      // Scroll to bottom again after response
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // Simple response generator
  String _generateResponse(String input) {
    final lowercaseInput = input.toLowerCase();

    if (lowercaseInput.contains('hello') || lowercaseInput.contains('hi')) {
      return 'Hello! How can I help you today?';
    } else if (lowercaseInput.contains('how are you')) {
      return 'I\'m just a simple chat assistant, but thanks for asking!';
    } else if (lowercaseInput.contains('bye')) {
      return 'Goodbye! Feel free to chat again anytime.';
    } else if (lowercaseInput.contains('name')) {
      return 'I\'m Purple Chat Assistant, your friendly AI companion.';
    } else if (lowercaseInput.contains('thank')) {
      return 'You\'re welcome! Is there anything else I can help with?';
    } else {
      return 'That\'s interesting. Tell me more or ask me something else!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Back arrow in black
          onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const AIHealthEngagementPage()),
                              ),
        ),
        backgroundColor: Colors.transparent, // No background color
        elevation: 0, // No shadow
      ),

      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? _buildWelcomeScreen()
                : _buildMessageList(),
          ),
          _buildDivider(),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildWelcomeScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 80,
            color: Colors.purple[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Welcome to Xecure Chat!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.purple[600],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Ask me anything and I\'ll do my best to help you.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        return _messages[index];
      },
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: Colors.grey[200],
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Type your message...',
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onSubmitted: _handleSubmitted, // Always handle submission
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              // Always handle submission
              _handleSubmitted(_textController.text);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple[600], // Always purple
              foregroundColor: Colors.white, // Always white
            ),
            child: _isLoading
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.send, color: Colors.white,),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({
    super.key,
    required this.text,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) _buildAvatar(isUser),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isUser ? Colors.purple[600] : Colors.purple[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: isUser ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          if (isUser) _buildAvatar(isUser),
        ],
      ),
    );
  }

  Widget _buildAvatar(bool isUser) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: isUser ? Colors.grey[300] : Colors.purple[600],
        borderRadius: BorderRadius.circular(18),
      ),
      child: Icon(
        isUser ? Icons.person : Icons.smart_toy,
        color: isUser ? Colors.black54 : Colors.white,
        size: 20,
      ),
    );
  }
}