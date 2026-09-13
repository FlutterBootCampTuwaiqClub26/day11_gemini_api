import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:day11_ai_platform_api/screens/stateful_demo_screen.dart';
import 'package:day11_ai_platform_api/service/gemini_api.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
    ChatUser user1 = ChatUser(
    id: '1',
    firstName: 'me',
  );
    ChatUser user2 = ChatUser(
    id: '2',
    firstName: 'bot',
  );

  List<ChatMessage> messagesList = [];

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            tooltip: 'مثال StatefulWidget',
            icon: const Icon(Icons.school_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const StatefulDemoScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: DashChat(
        messageOptions: MessageOptions(
          avatarBuilder: (p0, onPressAvatar, onLongPressAvatar) {
            return Image.network("https://media.discordapp.net/attachments/1544648774100459611/1546216449863843991/1280px-Google_Gemini_icon_2025.svg.png?ex=6a9ef9c8&is=6a9da848&hm=01b45075aedd015085ef761058894a82b4384fbbd4a8e705e198fbc997c9a8b0&=&format=webp&quality=lossless&width=700&height=700",height: 30,width: 30,);
          },
        ),
        currentUser: user1, 
        onSend: (messages)async{
          messagesList.insert(0,messages);
          setState(() {
          });

          String botMessage = await GeminiApi().sendRequest(messages.text);
          ChatMessage reply = ChatMessage(
            user: user2, 
            createdAt: DateTime.now(),
            text: botMessage
          );
          messagesList.insert(0,reply);
          setState(() {
          });
        }, 
        messages: messagesList
      ),
    );
  }
}