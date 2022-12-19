import 'package:flutter_riverpod/flutter_riverpod.dart';

StateProvider<String> userId = StateProvider((ref) => '');
StateProvider<String> userName = StateProvider((ref) => '');
StateProvider<String> userEmail = StateProvider((ref) => '');
StateProvider<String> userProfilePic = StateProvider((ref) => 'assets/profile/default_female.jpg');
StateProvider<bool> showLoginPage = StateProvider((ref) => true);