import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:night_lofi/constants/text_styles.dart';
import 'package:night_lofi/constants/texts.dart';
import 'package:night_lofi/providers/page_data_provider.dart';

import '../../constants/themes_default.dart';
import '../../constants/images.dart';
import '../../constants/background_effects.dart';
import '../../firebase/database_users.dart';
import '../../widgets/loaders.dart';
import '../../widgets/background.dart';
import '../../widgets/helper.dart';
import '../../providers/user_provider.dart';
import '../../firebase/authentication.dart';
import 'home_page_lofi.dart';
import 'home_page_night.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  Color colorPrimary = const Color(0x00000000);
  bool loading = true;
  int page = 0;
  int playlistPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBarShared(),
      body: SizedBox(
        height: screenSize(context).height,
        width: screenSize(context).width,
        child: LiquidSwipe(
          fullTransitionValue: 800,
          initialPage: 0,
          slideIconWidget: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            size: 20,
          ),
          onPageChangeCallback: (currentPageNumber) {
            setState(() {
              colorPrimary = currentPageNumber == 0
                  ? ref.watch(themeLofiPrimary)
                  : ref.watch(themeNightPrimary);
            });
          },
          positionSlideIcon: 0.5,
          // ignoreUserGestureWhileAnimating: true,
          enableSideReveal: true,
          waveType: WaveType.liquidReveal,
          pages: const [
            HomePageLofi(),
            HomePageNight(),
          ],
        ),
      ),
    );
  }

  AppBar appBarShared() {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(),
      elevation: 0.0,
      titleSpacing: 0,
      leadingWidth: 0,
      backgroundColor: const Color(0x00000000),
      toolbarHeight: 135,
      title: Column(
        children: [
          AnimatedContainer(
              duration: const Duration(
                  milliseconds: BackgroundEffects.appBarAnimationDuration),
              color: colorPrimary.withOpacity(0.8),
              child: SizedBox(
                height: 95 + statusBarSize(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 0,
                        ),
                        Container(
                            height: 80,
                            width: 130,
                            // decoration: BoxDecoration(
                            //   border: Border(
                            //       bottom: BorderSide(color: Colors.white, width: 2)),
                            // ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage(ref.read(userProfilePic)),
                                  radius: 25,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Welcome',
                                      style: textStyleNormalWhite.copyWith(
                                          fontSize: 12),
                                    ),
                                    Text(
                                      ref.read(userName),
                                      style: textStyleBoldWhite.copyWith(
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        const SizedBox(
                          height: 20,
                          child: Center(
                            child: VerticalDivider(
                              thickness: 1,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                            width: 130,
                            height: 80,
                            color: Colors.white.withOpacity(0.1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text('HOLA'),
                              ],
                            )),
                        const SizedBox(
                          width: 0,
                        ),
                      ],
                    ),
                    Container(
                      height: 2,
                      child: ref.watch(homeLoading)
                          ? const LinearProgressIndicator(
                              backgroundColor: Color(0x0),
                            )
                          : const Center(),
                    ),
                  ],
                ),
              )),
          AnimatedContainer(
            duration: const Duration(
                milliseconds: BackgroundEffects.appBarAnimationDuration),
            color: Colors.black54,
            child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 0,
                  ),
                  Container(
                    width: 100,
                    child: Center(
                      child: Text(
                        TextConst.homePagePlaylist,
                        style: textStyleBoldWhite.copyWith(fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 0,
                  ),
                  Container(
                    width: 100,
                    child: Center(
                      child: Text(
                        TextConst.homePageCommunity,
                        style: textStyleBoldWhite.copyWith(fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 0,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
