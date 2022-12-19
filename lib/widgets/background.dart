import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/accelerometer_provider.dart';
import '../constants/background_effects.dart';

class Background extends ConsumerWidget {
  const Background({
    Key? key,
    required this.backgroundImage,
    required this.sensitivity,
    required this.blurValue,
    required this.blackValue,
  }) : super(key: key);

  final String backgroundImage;
  final int sensitivity;
  final double blurValue;
  final double blackValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedPositioned(
      duration:
          const Duration(milliseconds: BackgroundEffects.animationDuration),
      top: BackgroundEffects.accelerometerF(
          ref.watch(accelerometerEvent).y, sensitivity),
      bottom: BackgroundEffects.accelerometerR(
          ref.watch(accelerometerEvent).y, sensitivity),
      right: BackgroundEffects.accelerometerF(
          ref.watch(accelerometerEvent).x, sensitivity),
      left: BackgroundEffects.accelerometerR(
          ref.watch(accelerometerEvent).x, sensitivity),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurValue, sigmaY: blurValue),
          child: Container(
            decoration: BoxDecoration(color: Colors.black.withOpacity(blackValue)),
          ),
        ),
      ),
    );
  }
}
