import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../constants/background_effects.dart';
import 'shape_painters/noteched_rounded_painter.dart';
import 'shape_painters/noteched_wave_painter.dart';
import 'shape_painters/rounded_curved_painter.dart';
import 'slidable_bottom_app_bar_shape.dart';

///bottom app bar can silde to the position of the screen that spicefied in maxHeight property
///
class SlidableBottomAppBar extends StatefulWidget {
  const SlidableBottomAppBar({
    Key? key,
    required this.body,
    this.bottomBarExpandedBody,
    this.bottomBarBody,
    this.shape = SlidableBottomAppBarShape.rounded,
    this.minHeight = 120,
    this.maxHeight = 250,
    this.hasCenterButton = true,
    this.onButtonPressed,
    this.onButtonPressedToggle = true,
    this.buttonChild,
    this.allowShadow = false,
    this.color = Colors.blue,
    this.colorSecondary = Colors.blue,
    this.buttonColor = Colors.blue,
    this.shadowColor = Colors.black,
    this.animationDuration = const Duration(seconds: 1),
    this.animationCurve = Curves.easeIn,
  }) : super(key: key);

  ///important pageBody property is used to Declare the page contents.
  final Widget body;

  final bool onButtonPressedToggle;

  ///body property is used to Declare the body of the app bar the will appear after clicking the button or silding if the haseCenterButton property is set to false.
  final Widget? bottomBarExpandedBody;

  ///child property is used to declare the appearance content of the app bar.
  final Widget? bottomBarBody;

  ///the appearance child of the center button
  final Widget? buttonChild;

  ///the color of the bottom app bar including the background color of the body property.
  final Color? color;
  final Color? colorSecondary;

  ///the color of the button if the haseCenterButton property is set to false the button will not appear.
  final Color? buttonColor;

  ///the color of the shadow that appeare ander the app bar over the app bar content body.
  final Color shadowColor;

  final bool allowShadow;
  final bool hasCenterButton;

  ///the maximum height that app bar will slide to it.
  final double minHeight;
  final double maxHeight;

  ///the slide show animation duration.
  final Duration animationDuration;

  /// the slide show animation curve.
  final Curve animationCurve;

  ///the shape of the app bar.
  final SlidableBottomAppBarShape shape;

  ///onButtonPressed event this Function will run after pressing the button and starting the slide show.
  final void Function()? onButtonPressed;

  @override
  State<SlidableBottomAppBar> createState() => _NotechedResponsiveAppBarState();
}

class _NotechedResponsiveAppBarState extends State<SlidableBottomAppBar> {
  bool _isShown = false;

  late Map<SlidableBottomAppBarShape, CustomPainter> _shapes;

  @override
  void initState() {
    _shapes = {
      // SlidableBottomAppBarShape.rounded: NotechedRoundedPainter(
      //   widget.color!,
      //   widget.allowShadow,
      //   widget.shadowColor,
      //   widget.hasCenterButton,
      // ),
      SlidableBottomAppBarShape.wave: NotechedWavePainter(
        widget.color!,
        widget.allowShadow,
        widget.shadowColor,
        widget.hasCenterButton,
      ),
      SlidableBottomAppBarShape.roundedCurved: RoundedCurvedPainter(
        widget.color!,
        widget.allowShadow,
        widget.shadowColor,
        widget.hasCenterButton,
      ),
    };

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    double containerHeight = _isShown ? widget.maxHeight : widget.minHeight;

    var shape = _shapes[widget.shape];

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
                        widget.allowShadow,
                        widget.shadowColor,
                        widget.hasCenterButton,
                        screenSize.width,
                        widget.minHeight
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
                                  milliseconds: BackgroundEffects.appBarAnimationDuration),
                              width: screenSize.width,
                              height: widget.maxHeight,
                              child: widget.bottomBarExpandedBody,
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(
                                milliseconds: BackgroundEffects.appBarAnimationDuration),
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
                    child: widget.hasCenterButton
                        ? FloatingActionButton(
                            onPressed: () {
                              if(widget.onButtonPressedToggle) {
                                setState(() {
                                  _isShown = !_isShown;
                                });
                              }
                              widget.onButtonPressed!();
                            },
                            backgroundColor: Colors.transparent,
                            elevation: 0.1,
                            child: widget.buttonChild,
                          )
                        : null,
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
