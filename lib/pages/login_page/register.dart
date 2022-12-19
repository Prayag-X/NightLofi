import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../constants/texts.dart';
import '../../constants/text_styles.dart';
import '../../firebase/database_users.dart';
import '../../firebase/authentication.dart';
import '../../providers/user_provider.dart';
import '../../widgets/helper.dart';

class Register extends ConsumerStatefulWidget {
  const Register({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  final DatabaseUsers _dbUser = DatabaseUsers();
  final Authentication _auth = Authentication();
  TextEditingController controller = TextEditingController(text: '');
  final formKey = GlobalKey<FormState>();
  bool showBlankError = true;

  Future<void> registerUser() async {
    ref.read(userName.notifier).state = controller.text;
    await _dbUser.registerUser(
      ref.read(userId),
      ref.read(userEmail),
      controller.text,
    );
    if (!mounted) return;
    nextScreenReplace(context, 'HomePage');
  }

  Future<void> goBack() async {
    await _auth.logout();
    ref.invalidate(userId);
    ref.invalidate(userName);
    ref.invalidate(userEmail);
    ref.invalidate(showLoginPage);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () async {
                    await goBack();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  )),
              Text(
                TextConst.loginPageRegister,
                style: textStyleBoldWhite.copyWith(fontSize: 40),
              ),
              const SizedBox(
                width: 50,
              ),
            ],
          ),
          const SizedBox(
            height: 200,
          ),
          Form(
            key: formKey,
            child: SizedBox(
              width: 280,
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 20,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffffc200), width: 1),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffff0000), width: 1)),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffffffff), width: 1),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffff0000), width: 1),
                  ),
                  hintText: TextConst.loginPageHintText,
                  hintStyle: textStyleNormal.copyWith(
                      color: Colors.white.withOpacity(0.5), fontSize: 15),
                ),
                style: textStyleNormalWhite.copyWith(fontSize: 18),
                validator: (val) {
                  return val!.isNotEmpty
                      ? (val.length <= 10 ? null : TextConst.loginPageError2)
                      : TextConst.loginPageError3;
                },
                controller: controller,
              ),
            ),
          ),
          showBlankError
              ? const SizedBox(height: 22)
              : const SizedBox(height: 0),
          const SizedBox(
            height: 70,
          ),
          TextButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                await EasyLoading.show(
                    maskType: EasyLoadingMaskType.black,
                    indicator: const CircularProgressIndicator());
                await registerUser();
                EasyLoading.dismiss();
              } else {
                setState(() => showBlankError = false);
              }
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
            ),
            child: Container(
              height: 40,
              width: 150,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  border: Border.all(color: Colors.white, width: 1.0),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    TextConst.loginPageNext,
                    style: textStyleSemiBoldWhite.copyWith(fontSize: 15),
                  ),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 20,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
