import 'dart:ui';
import 'package:flutter/material.dart';
import 'bottom_bar_shape.dart';
import '../../../../constants/background_effects.dart';

class SlidableBottomAppBar extends StatefulWidget {
  const SlidableBottomAppBar({
    Key? key,
    required this.body,
    this.bottomBarExpandedBody,
    this.bottomBarBody,
    this.minHeight = 120,
    this.maxHeight = 250,
    this.onButtonPressed,
    this.buttonChild,
    this.color = Colors.blue,
    this.colorSecondary = Colors.blue,
    this.buttonColor = Colors.blue,
    this.animationDuration = const Duration(seconds: 1),
    this.animationCurve = Curves.easeIn,
  }) : super(key: key);

  final Widget body;
  final Widget? bottomBarExpandedBody;
  final Widget? bottomBarBody;
  final Widget? buttonChild;
  final Color? color;
  final Color? colorSecondary;
  final Color? buttonColor;
  final double minHeight;
  final double maxHeight;
  final Duration animationDuration;
  final Curve animationCurve;
  final void Function()? onButtonPressed;

  @override
  State<SlidableBottomAppBar> createState() => _NotechedResponsiveAppBarState();
}

class _NotechedResponsiveAppBarState extends State<SlidableBottomAppBar> {
  bool _isShown = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    double containerHeight = _isShown ? widget.maxHeight : widget.minHeight;

    return Stack(
      fit: StackFit.expand,
      children: [
        widget.body,
        AnimatedPositioned(
          duration: widget.animationDuration,
          curve: widget.animationCurve,
          bottom: 0,
          left: 0,
          height: containerHeight,
          child: Container(
            width: screenSize.width,
            height: widget.maxHeight,
            color: Colors.transparent,
            child: GestureDetector(
              onPanUpdate: (details) {
                if (!_isShown) {
                  if (details.delta.direction < 0) _isShown = true;
                } else {
                  if (details.delta.direction > 0) _isShown = false;
                }

                setState(() {});
              },
              child: Stack(
                children: [
                  ClipPath(
                    clipper: NotechedRoundedPainter(
                      widget.color!,
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaX: BackgroundEffects.blurMedium,
                          sigmaY: BackgroundEffects.blurMedium),
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                              0,
                              widget.minHeight,
                              0,
                              0,
                            ),
                            child: AnimatedContainer(
                              duration: const Duration(
                                  milliseconds: BackgroundEffects
                                      .appBarAnimationDuration),
                              width: screenSize.width,
                              height: widget.maxHeight,
                              child: widget.bottomBarExpandedBody,
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(
                                milliseconds:
                                    BackgroundEffects.appBarAnimationDuration),
                            color: widget.color,
                          ),
                          SizedBox(
                            width: screenSize.width,
                            height: widget.minHeight,
                            child: widget.bottomBarBody,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    heightFactor: 0.25,
                    child: FloatingActionButton(
                      onPressed: () {
                        widget.onButtonPressed!();
                      },
                      backgroundColor: Colors.transparent,
                      elevation: 0.1,
                      child: widget.buttonChild,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
