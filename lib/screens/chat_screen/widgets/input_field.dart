import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/message.dart';
import './sticker_pane.dart';
import './constant.dart';
import '../../../blocs/message/message.dart';
import '../../../blocs/chat_input_bloc.dart';

class InputField extends StatefulWidget {
  final Message message;
  final String userId;
  final String username;
  final String userImage;

  InputField({
    @required this.userId,
    @required this.username,
    @required this.userImage,
    this.message,
  });

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final TextEditingController _inputController = TextEditingController();
  final _textInputFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final inputBloc = ChatInputBloc();
  String _text;

  @override
  void initState() {
    super.initState();
    _textInputFocusNode.addListener(() {
      if (_textInputFocusNode.hasFocus) {
        inputBloc.hideStickerPane();
      }
    });
    inputBloc.hideStickerPane();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textInputFocusNode.addListener(() {
      if (_textInputFocusNode.hasFocus) {
        inputBloc.hideStickerPane();
      }
    });
    _inputController.dispose();
    _textInputFocusNode.dispose();
    inputBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        StreamBuilder<ChatInputAction>(
          stream: inputBloc.inputAction.stream,
          builder: (context, snapshot) {
            if (snapshot.data == ChatInputAction.OnShowSticker) {
              return WillPopScope(
                onWillPop: () {
                  inputBloc.hideStickerPane();
                  return Future.value(false);
                },
                child: StickerPane(
                  onStickerSend: (url) {
                    BlocProvider.of<MessageBloc>(context).add(
                      AddNewMessage(
                        Message(
                          text: url,
                          type: STICKER_MESSAGE_TYPE,
                          userId: widget.userId,
                          username: widget.username,
                          userImage: widget.userImage,
                          createdAt: Timestamp.now(),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return Container();
          },
        ),
        Container(
          child: Row(
            children: <Widget>[
              // Button send image
              Material(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 1.0),
                  child: IconButton(
                    icon: Icon(Icons.image),
                    onPressed: () {
                      BlocProvider.of<MessageBloc>(context).add(
                        AddNewImageMessage(
                          userImage: widget.userImage,
                          username: widget.username,
                          userId: widget.userId,
                        ),
                      );
                    },
                  ),
                ),
                color: Colors.white,
              ),
              Material(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 1.0),
                  child: IconButton(
                    icon: Icon(Icons.face),
                    onPressed: () {
                      _textInputFocusNode.unfocus();
                      inputBloc.showStickerPane();
                    },
                  ),
                ),
                color: Colors.white,
              ),

              // Edit text
              Flexible(
                child: Container(
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: _inputController,
                      focusNode: _textInputFocusNode,
                      style: TextStyle(color: Colors.black, fontSize: 15.0),
                      // controller: textEditingController,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Type your message...',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      // focusNode: focusNode,
                      onSaved: (value) => _text = value,
                      validator: (value) {
                        return value.isEmpty ? '' : null;
                      },
                    ),
                  ),
                ),
              ),
              // Button send message
              Material(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        BlocProvider.of<MessageBloc>(context).add(
                          AddNewMessage(
                            Message(
                              text: _text,
                              type: TEXT_MESSAGE_TYPE,
                              userId: widget.userId,
                              username: widget.username,
                              userImage: widget.userImage,
                              createdAt: Timestamp.now(),
                            ),
                          ),
                        );
                        _inputController.clear();
                      }
                    },
                  ),
                ),
                color: Colors.white,
              ),
            ],
          ),
          width: double.infinity,
          height: 50.0,
          decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey, width: 0.5),
              ),
              color: Colors.white),
        ),
      ],
    );
  }
}
