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
import '../../providers/playlist_provider.dart';
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
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final playlistIds = ref.watch(playlistIdProvider);
    return Stack(
      children: [
        const Background(
          backgroundImage: ImageConst.homePageLofiImage,
          sensitivity: BackgroundEffects.loginPageSensitivity,
          blurValue: BackgroundEffects.blurNone,
          blackValue: BackgroundEffects.blackMedium,
        ),
        Container(
          height: screenSize(context).height,
          width: screenSize(context).width,
          child: playlistIds.when(
              data: (playlistIds) {
                print('DONE');
                print(playlistIds);

                return ListView(
                  physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  children: playlistIds.map((e) => Column(
                    children: [
                      SizedBox(height: 50,),
                      Container(
                          color: Colors.blue,
                          child: Text(e)
                      ),
                    ],
                  )).toList(),
                );
              },
              error: (_, __) {
                print("Eroor");
                print(_);
                print(__);
                return Container();
              },
              loading: () => Container()
          ),
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
