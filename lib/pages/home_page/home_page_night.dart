import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../constants/themes_default.dart';
import '../../constants/images.dart';
import '../../constants/background_effects.dart';
import '../../firebase/database_users.dart';
import '../../widgets/loaders.dart';
import '../../widgets/background.dart';
import '../../widgets/helper.dart';
import '../../providers/user_provider.dart';
import '../../firebase/authentication.dart';

class HomePageNight extends ConsumerStatefulWidget {
  const HomePageNight({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomePageNightState();
}

class _HomePageNightState extends ConsumerState<HomePageNight> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Background(
          backgroundImage: ImageConst.homePageNightImage,
          sensitivity: BackgroundEffects.loginPageSensitivity,
          blurValue: BackgroundEffects.blurVeryLight,
          blackValue: BackgroundEffects.blackMedium,
        ),
      ],
    );
  }
}
