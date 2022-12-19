import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

StateProvider<bool> homeLoading = StateProvider((ref) => false);
StateProvider<Color> themeNightPrimary = StateProvider((ref) => const Color(0xFFfaff00));
StateProvider<Color> themeNightSecondary = StateProvider((ref) => const Color(0xFFfaff00));
StateProvider<Color> themeLofiPrimary = StateProvider((ref) => const Color(0xFF4200ff));
StateProvider<Color> themeLofiSecondary = StateProvider((ref) => const Color(0xFF4200ff));

