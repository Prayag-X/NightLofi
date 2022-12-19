import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'firebase_options.dart';
import 'providers/accelerometer_provider.dart';
import 'pages/chat_page/chat_page.dart';
import 'pages/home_page/home_page.dart';
import 'pages/login_page/login_page.dart';
import 'pages/play_page/play_page.dart';
import 'pages/profile_self_page/profile_self_page.dart';
import 'pages/profile_other_page/profile_other_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const ProviderScope(child: Routes()));
  });
}

class Routes extends ConsumerStatefulWidget {
  const Routes({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _RoutesState();
}

class _RoutesState extends ConsumerState<Routes> {
  late StreamSubscription<AccelerometerEvent> _eventListener;

  @override
  void initState() {
    _eventListener = accelerometerEvents.listen((AccelerometerEvent event) {
      ref.read(accelerometerEvent.notifier).state = event;
    });
    super.initState();
  }

  @override
  void dispose() {
    _eventListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Lofi Night',
        builder: EasyLoading.init(),
        routes: {
          '/': (context) => const LoginPage(),
          '/HomePage': (context) => const HomePage(),
          '/ChatPage': (context) => const ChatPage(),
          '/PlayPage': (context) => const PlayPage(),
          '/ProfileSelfPage': (context) => const ProfileSelfPage(),
          '/ProfileOtherPage': (context) => const ProfileOtherPage(),
        });
  }
}
