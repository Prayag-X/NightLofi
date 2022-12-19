import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../constants/themes_default.dart';
import '../../constants/texts.dart';
import '../../constants/images.dart';
import '../../constants/text_styles.dart';
import '../../widgets/helper.dart';
import '../../firebase/authentication.dart';
import '../../providers/user_provider.dart';

class Login extends ConsumerStatefulWidget {
  const Login({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final Authentication _auth = Authentication();

  Future<void> nextPageDecider(User? user) async {
    if (user != null) {
      ref.read(userId.notifier).state = user.uid;
      ref.read(userEmail.notifier).state = user.email!;
      bool isUserRegistered = await _auth.isUserRegistered(user.uid);
      if (isUserRegistered) {
        if (!mounted) return;
        nextScreenReplace(context, 'HomePage');
      } else {
        ref.read(showLoginPage.notifier).state = false;
      }
    }
  }

  Future<void> signIn() async {
    try {
      User? user = await _auth.signInWithGoogle();
      await nextPageDecider(user);
    } catch (e) {
      showSnackBar(context, e.toString(), 4);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            TextConst.loginPageWelcome,
            style: textStyleBoldWhite.copyWith(fontSize: 40),
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
            onPressed: () async {
              await EasyLoading.show(
                maskType: EasyLoadingMaskType.black,
                indicator: const CircularProgressIndicator()
              );
              await signIn();
              EasyLoading.dismiss();
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
            ),
            child: Container(
              height: 40,
              width: 220,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  border: Border.all(color: Colors.white, width: 1.0),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    )),
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
                        style: textStyleSemiBoldWhite.copyWith(fontSize: 15),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
