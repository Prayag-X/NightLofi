import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import '../../constants/text_styles.dart';
import '../../constants/texts.dart';
import '../../providers/page_data_provider.dart';
import '../../constants/themes_default.dart';
import '../../constants/images.dart';
import '../../constants/background_effects.dart';
import '../../firebase/database_users.dart';
import '../../widgets/loaders.dart';
import '../../widgets/background.dart';
import '../../widgets/helper.dart';
import '../../widgets/bottom_bar/bottom_bar.dart';
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
  Color colorSecondary = const Color(0x00000000);
  Color statusBarColor = const Color(0x00000000);
  bool loading = true;
  int page = 0;
  int playlistPage = 0;
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  createStatusBarAnimation() {
    _controller = AnimationController(
      duration: const Duration(
          milliseconds: BackgroundEffects.appBarAnimationDuration),
      vsync: this,
    );

    _colorAnimation = ColorTween(
            begin: ref.read(themeNightPrimary), end: ref.read(themeLofiPrimary))
        .animate(_controller);

    _controller.addListener(() {
      setState(() {
        statusBarColor = _colorAnimation.value!;
      });
    });

    _controller.addStatusListener((status) {});
    _controller.forward();
  }

  @override
  void initState() {
    colorPrimary = ref.read(themeLofiPrimary);
    colorSecondary = ref.read(themeLofiSecondary);
    createStatusBarAnimation();
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Color colorPrimaryPrevious = const Color(0x00000000);
    // Color statusBarColor = const Color(0x00000000);

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: appBarShared(),
      body: SlidableBottomAppBar(
        //appearance parameters
        animationCurve: Curves.bounceOut,
        color: colorPrimary.withOpacity(BackgroundEffects.appBarOpacityPrimary),
        colorSecondary:
            colorPrimary.withOpacity(BackgroundEffects.appBarOpacitySecondary),
        buttonColor:
            colorSecondary.withOpacity(BackgroundEffects.appBarOpacityPrimary),
        maxHeight: screenSize(context).height / 2,
        bottomBarExpandedBody: Column(
          children: const [
            Center(
              child: Text(''),
            ),
          ],
        ),
        buttonChild: AnimatedContainer(
          duration: const Duration(
              milliseconds: BackgroundEffects.appBarAnimationDuration),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: colorSecondary.withOpacity(BackgroundEffects.appBarOpacitySecondary),
            border: Border.all(color: colorSecondary.withOpacity(BackgroundEffects.appBarOpacityPrimary), width: 1),
          ),
          child: Center(
            child: Icon(
              Icons.play_arrow_rounded,
              size: 40,
            ),
          ),
        ),

        onButtonPressed: () {
          //do some thing
        },
        bottomBarBody: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [],
        ),
        body: SizedBox(
          height: screenSize(context).height,
          width: screenSize(context).width,
          child: LiquidSwipe(
            fullTransitionValue: 1000,
            initialPage: 0,
            slideIconWidget: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 20,
            ),
            onPageChangeCallback: (currentPageNumber) {
              if (currentPageNumber == 0) {
                setState(() {
                  colorPrimary = ref.watch(themeLofiPrimary);
                  colorSecondary = ref.watch(themeLofiSecondary);
                  playlistPage = 0;
                });
                _controller.forward();
              } else {
                setState(() {
                  colorPrimary = ref.watch(themeNightPrimary);
                  colorSecondary = ref.watch(themeNightSecondary);
                  playlistPage = 1;
                });
                _controller.reverse();
              }
            },
            positionSlideIcon: 0.5,
            ignoreUserGestureWhileAnimating: true,
            enableSideReveal: true,
            waveType: WaveType.liquidReveal,
            pages: const [
              HomePageLofi(),
              HomePageNight(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBarShared() {
    return AppBar(
      // systemOverlayStyle: SystemUiOverlayStyle(
      //     statusBarColor: statusBarColor
      //         .withOpacity(BackgroundEffects.appBarOpacityPrimary)),
      elevation: 0.0,
      titleSpacing: 0,
      leadingWidth: 0,
      backgroundColor: const Color(0x00000000),
      toolbarHeight: 115,
      // flexibleSpace: ClipRect(
      //   child: BackdropFilter(
      //     filter: ImageFilter.blur(sigmaX: BackgroundEffects.blurLight, sigmaY: BackgroundEffects.blurLight),
      //     child: AnimatedContainer(
      //       height: statusBarSize(context),
      //       duration: const Duration(
      //           milliseconds: BackgroundEffects.appBarAnimationDuration),
      //       color: colorPrimary
      //           .withOpacity(BackgroundEffects.appBarOpacityPrimary),
      //     ),
      //   ),
      // ),
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: BackgroundEffects.blurMedium,
                  sigmaY: BackgroundEffects.blurMedium),
              child: AnimatedContainer(
                  duration: const Duration(
                      milliseconds: BackgroundEffects.appBarAnimationDuration),
                  color: colorPrimary
                      .withOpacity(BackgroundEffects.appBarOpacityPrimary),
                  child: SizedBox(
                    height: 75 + statusBarSize(context),
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
                            SizedBox(
                                height: 70,
                                width: 100,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          AssetImage(ref.read(userProfilePic)),
                                      radius: 20,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Welcome',
                                          style: textStyleNormalWhite.copyWith(
                                              fontSize: 10),
                                        ),
                                        Text(
                                          ref.read(userName),
                                          style: textStyleBoldWhite.copyWith(
                                              fontSize: 12),
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
                              height: 70,
                              width: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedCrossFade(
                                    duration: const Duration(
                                        milliseconds: BackgroundEffects
                                            .appBarAnimationDuration),
                                    firstChild: AnimatedOpacity(
                                      duration: const Duration(
                                          milliseconds: BackgroundEffects
                                              .appBarAnimationDuration),
                                      opacity: playlistPage == 0 ? 1 : 0,
                                      child: Text(
                                        'Lofi',
                                        style: textStyleBold.copyWith(
                                            fontSize: 15,
                                            color: colorSecondary),
                                      ),
                                    ),
                                    secondChild: AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 2000),
                                      opacity: playlistPage == 1 ? 1 : 0,
                                      child: Text(
                                        'Nightcore',
                                        style: textStyleBold.copyWith(
                                            fontSize: 15,
                                            color: colorSecondary),
                                      ),
                                    ),
                                    crossFadeState: playlistPage == 0
                                        ? CrossFadeState.showFirst
                                        : CrossFadeState.showSecond,
                                  ),
                                  // AnimatedSwitcher(
                                  //   duration: const Duration(
                                  //       milliseconds: BackgroundEffects.appBarAnimationDuration),
                                  //   child: playlistPage==1 ? Text(
                                  //     'Lofi',
                                  //     style: textStyleBold.copyWith(
                                  //         fontSize: 8,
                                  //         color: Colors.white.withOpacity(0.7)
                                  //     ) ,
                                  //   ) : Text(
                                  //     'Nightcore',
                                  //     style: textStyleBold.copyWith(
                                  //         fontSize: 8,
                                  //         color: Colors.white.withOpacity(0.7)
                                  //     ) ,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 0,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2,
                          child: ref.watch(homeLoading)
                              ? LinearProgressIndicator(
                                  backgroundColor: colorPrimary.withOpacity(
                                      BackgroundEffects.appBarOpacityPrimary),
                                )
                              : const Center(),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: BackgroundEffects.blurLight,
                  sigmaY: BackgroundEffects.blurLight),
              child: AnimatedContainer(
                duration: const Duration(
                    milliseconds: BackgroundEffects.appBarAnimationDuration),
                color: colorPrimary
                    .withOpacity(BackgroundEffects.appBarOpacitySecondary),
                height: 35,
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(
                        width: 0,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            page = 0;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(
                              milliseconds:
                                  BackgroundEffects.appBarAnimationDuration),
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 2.0,
                                  color: page == 0
                                      ? colorSecondary.withOpacity(
                                          BackgroundEffects
                                              .appBarOpacityPrimary)
                                      : const Color(0x00000000)),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              TextConst.homePagePlaylist,
                              style: textStyleBoldWhite.copyWith(fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 0,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            page = 1;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(
                              milliseconds:
                                  BackgroundEffects.appBarAnimationDuration),
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 2.0,
                                  color: page == 1
                                      ? colorSecondary.withOpacity(
                                          BackgroundEffects
                                              .appBarOpacityPrimary)
                                      : const Color(0x00000000)),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              TextConst.homePageCommunity,
                              style: textStyleBoldWhite.copyWith(fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
