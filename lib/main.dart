import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './blocs/authentication/authentication.dart';
import './repositories/user_repository.dart';
import './screens/splash_screen.dart';
import './screens/chat_screen/chat_screen.dart';
import './screens/login_screen/login_screen.dart';
import './blocs/simple_bloc_delegate.dart';
import './screens/not_found_screen.dart';
import './blocs/message/message.dart';
import './blocs/sticker/sticker.dart';
import './repositories/firebase_message_repository.dart';
import './repositories/firebase_sticker_repository.dart';
import './models/message.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) =>
          AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        accentColor: Colors.redAccent,
        appBarTheme: AppBarTheme(
          color: Colors.redAccent,
        ),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return SplashScreen();
          }
          if (state is Unauthenticated) {
            return LoginScreen(userRepository: _userRepository);
          }
          if (state is Authenticated) {
            return MultiBlocProvider(
              providers: [
                state.verified
                    ? BlocProvider(
                        create: (context) => MessageBloc(
                            userRepository: _userRepository,
                            messageRepository: FirebaseMessageRepository())
                          ..add(
                            LoadMessage(),
                          ),
                      )
                    : BlocProvider(
                        create: (context) => MessageBloc(
                            userRepository: _userRepository,
                            messageRepository: FirebaseMessageRepository())
                          ..add(
                            AddNewJoinRoomMessage(
                              Message(
                                userId: state.userId,
                                username: state.username,
                                userImage: state.userImage,
                                type: 'JOIN_ROOM_MESSAGE_TYPE',
                                text: '${state.username} joined the chat!',
                                createdAt: Timestamp.now(),
                              ),
                            ),
                          )
                          ..add(
                            LoadMessage(),
                          ),
                      ),
                BlocProvider(
                  create: (context) => StickerBloc(
                      stickerRepository: FirebaseStickerRepository())
                    ..add(
                      LoadSticker(),
                    ),
                )
              ],
              child: ChatScreen(
                userId: state.userId,
                username: state.username,
                userImage: state.userImage,
              ),
            );
          }
          return NotFoundScreen();
        },
      ),
    );
  }
}
