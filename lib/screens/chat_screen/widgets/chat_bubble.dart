import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';

import './image_screen.dart';
import './constant.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String username;
  final String type;
  final String date;
  final String userImage;

  ChatBubble(
      this.text, this.isMe, this.username, this.type, this.date, this.userImage,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case IMAGE_MESSAGE_TYPE:
        return Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            !isMe
                ? ClipOval(
                    child: CachedNetworkImage(
                      height: 50,
                      width: 50,
                      imageUrl: userImage,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.contain,
                    ),
                  )
                : Container(),
            Container(
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ImageScreen(
                              imageProvider: NetworkImage(text),
                              tag: text,
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: text,
                        child: CachedNetworkImage(
                          height: 200,
                          width: 200,
                          imageUrl: text,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      color: isMe ? Colors.grey[300] : Colors.black54,
                    ),
                  ),
                ],
              ),
              width: 200,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.only(bottom: 20, right: 10.0, left: 10.0),
              decoration: BoxDecoration(
                color: isMe ? Colors.redAccent : Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
            ),
            isMe
                ? ClipOval(
                    child: CachedNetworkImage(
                      height: 50,
                      width: 50,
                      imageUrl: userImage,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.contain,
                    ),
                  )
                : Container(),
          ],
        );
      case JOIN_ROOM_MESSAGE_TYPE:
        return Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      case STICKER_MESSAGE_TYPE:
        return Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            !isMe
                ? ClipOval(
                    child: CachedNetworkImage(
                      height: 50,
                      width: 50,
                      imageUrl: userImage,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.contain,
                    ),
                  )
                : Container(),
            Container(
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CachedNetworkImage(
                      height: 100,
                      width: 100,
                      imageUrl: text,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      color: isMe ? Colors.grey[300] : Colors.black54,
                    ),
                  ),
                ],
              ),
              width: 200,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.only(bottom: 20, right: 10.0, left: 10.0),
              decoration: BoxDecoration(
                color: isMe ? Colors.redAccent : Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
            ),
            isMe
                ? ClipOval(
                    child: CachedNetworkImage(
                      height: 50,
                      width: 50,
                      imageUrl: userImage,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.contain,
                    ),
                  )
                : Container(),
          ],
        );
      case TEXT_MESSAGE_TYPE:
        return Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            !isMe
                ? ClipOval(
                    child: CachedNetworkImage(
                      height: 50,
                      width: 50,
                      imageUrl: userImage,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.contain,
                    ),
                  )
                : Container(),
            GestureDetector(
              onLongPress: () {
                Clipboard.setData(
                  ClipboardData(text: text),
                );
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(seconds: 1),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Text copied to Clipboard'),
                        Icon(Icons.info),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: isMe ? TextAlign.end : TextAlign.start,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      date,
                      style: TextStyle(
                        color: isMe ? Colors.grey[300] : Colors.black54,
                      ),
                    ),
                  ],
                ),
                width: 200,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: EdgeInsets.only(bottom: 20, right: 10.0, left: 10.0),
                decoration: BoxDecoration(
                  color: isMe ? Colors.redAccent : Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft:
                        !isMe ? Radius.circular(0) : Radius.circular(12),
                    bottomRight:
                        isMe ? Radius.circular(0) : Radius.circular(12),
                  ),
                ),
              ),
            ),
            isMe
                ? ClipOval(
                    child: CachedNetworkImage(
                      height: 50,
                      width: 50,
                      imageUrl: userImage,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.contain,
                    ),
                  )
                : Container(),
          ],
        );
    }
    return Text('');
  }
}
