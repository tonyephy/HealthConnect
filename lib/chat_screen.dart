import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  final String therapistName;

  const ChatScreen({super.key, required this.therapistName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: 'patient_id'); // Replace with the actual user ID
  final _therapist = const types.User(id: 'therapist_id'); // Replace with the actual therapist ID

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() {
    FirebaseFirestore.instance
        .collection('chats')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      setState(() {
        _messages.clear();
        for (var doc in snapshot.docs) {
          final data = doc.data();
          final message = types.TextMessage(
            author: data['authorId'] == _user.id ? _user : _therapist,
            createdAt: data['createdAt'],
            id: doc.id,
            text: data['text'],
          );
          _messages.insert(0, message);
        }
      });
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: '',
      text: message.text,
    );

    FirebaseFirestore.instance.collection('chats').add({
      'authorId': _user.id,
      'createdAt': textMessage.createdAt,
      'text': textMessage.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.therapistName}'),
      ),
      body: Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _user,
      ),
    );
  }
}
