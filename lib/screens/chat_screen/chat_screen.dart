import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../blocs/message/message.dart';
import './widgets/input_field.dart';
import './widgets/chat_bubble.dart';
import '../profile_screen/profile_screen.dart';

class ChatScreen extends StatelessWidget {
  final String userId;
  final String username;
  final String userImage;

  ChatScreen({
    @required this.userId,
    @required this.username,
    @required this.userImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProfileScreen(
                    userImage: userImage,
                    username: username,
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: BlocListener<MessageBloc, MessageState>(
        listener: (context, state) {
          if (state is MessageImageFail) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 1),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Error uploading image'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is MessageImageLoading) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 1),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Uploading....'),
                    CircularProgressIndicator()
                  ],
                ),
              ),
            );
          }
        },
        child: BlocBuilder<MessageBloc, MessageState>(
          builder: (context, state) {
            if (state is MessageLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is MessageNotLoaded) {
              return Center(
                child: Text('error occured'),
              );
            }
            if (state is MessageLoaded) {
              final messages = state.messages;

              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/chatbackground.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final int timestamp =
                              messages[index].createdAt.millisecondsSinceEpoch;
                          final date =
                              DateTime.fromMillisecondsSinceEpoch(timestamp);
                          final formatDate = DateFormat('d MMMM HH:mm')
                              .format(date)
                              .toString();
                          return ChatBubble(
                            messages[index].text,
                            messages[index].userId == userId,
                            messages[index].username,
                            messages[index].type,
                            formatDate,
                            messages[index].userImage,
                            key: ValueKey(messages[index].id),
                          );
                        },
                      ),
                    ),
                    InputField(
                      userId: userId,
                      username: username,
                      userImage: userImage,
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
