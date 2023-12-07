import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/config/theme/app_theme.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

void main() => runApp(const ChatScreen());

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yes-No App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 1).theme(),
      home: Scaffold(
          appBar: AppBar(
            leading: const Padding(
              padding: EdgeInsets.all(4.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://estaticos-cdn.prensaiberica.es/clip/5ff96a7a-993a-42f6-9da8-6cfc540f0543_16-9-aspect-ratio_default_0.jpg'),
              ),
            ),
            title: const Text('Daenerys targaryen'),
            centerTitle: true,
          ),
          body: _ChatView()),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  controller: chatProvider.chatScrollController,
                  itemCount: chatProvider.messageList.length,
                  itemBuilder: (context, index) {
                    final message = chatProvider.messageList[index];
                    return (message.fromWho == FromWho.hers)
                        ? HerMessageBubble(message: message)
                        : MyMessageBubble(message: message);
                  },
                ),
              ),
            ),
            // Text Box
            MessageFieldBox(onValue: chatProvider.sendMessage),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
