import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:night_lofi/constants/themes_default.dart';
import '../../constants/texts.dart';
import '../../constants/images.dart';
import '../../constants/background_effects.dart';
import '../../constants/text_styles.dart';
import '../../widgets/background.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              const Background(
                backgroundImage: ImageConst.loginPageImage,
                sensitivity: BackgroundEffects.loginPageSensitivity,
                blurValue: BackgroundEffects.blurLight,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      TextConst.loginPageWelcome,
                      style: textStyleBoldWhite.copyWith(
                          fontSize: 40),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: 'LOFI ',
                          style: textStyleExtraBold.copyWith(
                            fontSize: 30,
                            color: Themes.themeBlue,
                          ),
                          children: [
                            TextSpan(
                              text: 'NIGHT',
                              style: textStyleExtraBold.copyWith(
                                fontSize: 30,
                                color: Themes.themeYellow,
                              ),
                            )
                          ]),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        TextConst.loginPageAppDescription,
                        textAlign: TextAlign.center,
                        style: textStyleNormalWhite.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 90,
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                      ),
                      child: Container(
                        height: 40,
                        width: 220,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            border:
                                Border.all(color: Colors.white, width: 1.0)),
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              color: Colors.white,
                              child: Center(
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(ImageConst.googleLogo),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 178,
                              child: Center(
                                child: Text(
                                  TextConst.loginPageSignIn,
                                  style: textStyleSemiBoldWhite.copyWith(
                                    fontSize: 15
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
