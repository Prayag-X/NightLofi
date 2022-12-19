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
import 'login.dart';
import 'register.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage>
    with TickerProviderStateMixin {

  final Authentication _auth = Authentication();
  final DatabaseUsers _dbUser = DatabaseUsers();
  bool loading = true;

  Future<void> nextPageDecider(User? user) async {
    if (user != null) {
      bool isUserRegistered = await _auth.isUserRegistered(user.uid);
      if (isUserRegistered) {
        ref.read(userId.notifier).state = user.uid;
        ref.read(userEmail.notifier).state = user.email!;
        ref.read(userName.notifier).state = await _dbUser.getUserName(user.uid);
        // await _auth.logout();
        if (!mounted) return;
        nextScreenReplace(context, 'HomePage');
      } else {
        ref.read(showLoginPage.notifier).state = false;
      }
    }
  }

  void checkUserAlreadyLoggedIn() async {
    User? user = await _auth.isUserLoggedIn();
    await nextPageDecider(user);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      setState(() => loading = false);
    }
  }

  @override
  void initState() {
    checkUserAlreadyLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool showLogin = ref.watch(showLoginPage);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: screenSize(context).height,
        width: screenSize(context).width,
        child: !loading
            ? Stack(
                children: [
                  const Background(
                    backgroundImage: ImageConst.loginPageImage,
                    sensitivity: BackgroundEffects.loginPageSensitivity,
                    blurValue: BackgroundEffects.blurVeryLight,
                    blackValue: BackgroundEffects.blackMedium,
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: SizedBox(
                      height: screenSize(context).height,
                      width: screenSize(context).width,
                      child: Center(
                        child: AnimatedSwitcher(
                          switchInCurve: Curves.easeIn,
                          switchOutCurve: Curves.easeOut,
                          duration: const Duration(milliseconds: 500),
                          child: showLogin ? const Login() : const Register(),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Container(color: Themes.themeDark, child: const LoaderCircular()),
      ),
    );
  }
}
