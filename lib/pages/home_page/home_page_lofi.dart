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

class HomePageLofi extends ConsumerStatefulWidget {
  const HomePageLofi({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomePageLofiState();
}

class _HomePageLofiState extends ConsumerState<HomePageLofi> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Background(
          backgroundImage: ImageConst.homePageLofiImage,
          sensitivity: BackgroundEffects.loginPageSensitivity,
          blurValue: BackgroundEffects.blurNone,
          blackValue: BackgroundEffects.blackMedium,
        ),
        // GestureDetector(
        //   onTap: () {
        //     print('TAPPEd');
        //   },
        //   onTapUp: (v) {
        //     print('released');
        //   },
        //   onPanStart: (v){
        //     print('TAPPEd');
        //   },
        //   onPanEnd: (v) {
        //     print('released');
        //   },
        //   child: Container(
        //     height: screenSize(context).height,
        //     width: screenSize(context).width,
        //     // color: Colors.white.withOpacity(0.4),
        //     child: Center(
        //       child: TextButton(
        //         onPressed: () {
        //           print("Pressed");
        //         },
        //         child: Text("PRESS"),
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
