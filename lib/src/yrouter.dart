import 'dart:math';

import 'package:flutter/material.dart';
import 'package:y_router/src/animation_enum.dart';

class YRouter {
  static Future<T?> simplePush<T extends Object?>(
      {required BuildContext context,
      required AnimationEnum type,
      required Widget target,
      Widget? currentPage,
      int durationMs = 300}) {
    return push(
        context: context,
        types: [type],
        target: target,
        currentPage: currentPage,
        durationMs: durationMs);
  }

  static Future<T?> push<T extends Object?>(
      {required BuildContext context,
      required List<AnimationEnum> types,
      required Widget target,
      Widget? currentPage,
      int durationMs = 300}) {
    return Navigator.push(
        context,
        buildRoute(
            target: target,
            animationTypes: types,
            currentPage: currentPage,
            transitionMs: durationMs,
            reverseTransitionMs: durationMs));
  }

  static Route<T> buildRoute<T extends Object?>(
      {required Widget target,
      required List<AnimationEnum> animationTypes,
      Widget? currentPage,
      Curve curve = Curves.ease,
      int transitionMs = 300,
      int reverseTransitionMs = 300}) {
    if (animationTypes.contains(AnimationEnum.cubicX) ||
        animationTypes.contains(AnimationEnum.cubicY)) {
      assert(currentPage != null);
    }

    print("types= $animationTypes");
    return PageRouteBuilder(
        transitionDuration: Duration(milliseconds: transitionMs),
        reverseTransitionDuration: Duration(milliseconds: reverseTransitionMs),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return target;
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          animation = CurvedAnimation(curve: curve, parent: animation);
          final widget =
              _buildTransitions(animationTypes, animation, target, currentPage);
          return widget;
        });
  }

  static Widget _buildTransitions(List<AnimationEnum> animationTypes,
      Animation<double> animation, Widget dest, Widget? currentPage) {
    var target = dest;
    for (var type in animationTypes) {
      target = _buildAnimationWidget(type, target, animation, currentPage);
    }
    return target;
  }

  static Widget _buildAnimationWidget(AnimationEnum type, Widget target,
      Animation<double> animation, Widget? currentPage) {
    switch (type) {
      case AnimationEnum.fade:
        target = FadeTransition(opacity: animation, child: target);
        break;
      case AnimationEnum.size:
        target = Center(
          child: SizeTransition(
            sizeFactor: animation,
            child: target,
          ),
        );
        break;
      case AnimationEnum.rotate:
        target = RotationTransition(
          turns: animation,
          child: target,
        );
        break;
      case AnimationEnum.scale:
        target = ScaleTransition(
          scale: animation,
          child: target,
        );
        break;
      case AnimationEnum.slideFromBottom:
        print("slide bottom");
        target = SlideTransition(
          position: Tween(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: target,
        );
        break;
      case AnimationEnum.slideFromLeft:
        target = SlideTransition(
          position: Tween(
            begin: const Offset(-1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: target,
        );
        break;
      case AnimationEnum.slideFromRight:
        target = SlideTransition(
          position: Tween(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: target,
        );
        break;
      case AnimationEnum.slideFromTop:
        target = SlideTransition(
          position: Tween(
            begin: const Offset(0.0, -1.0),
            end: Offset.zero,
          ).animate(animation),
          child: target,
        );
        break;
      case AnimationEnum.cubicX:
        if (currentPage == null) break;
        target = Stack(
          children: <Widget>[
            SlideTransition(
              position: Tween<Offset>(
                begin: Offset.zero,
                end: Offset(-1.0, 0.0),
              ).animate(animation),
              child: Container(
                color: Colors.white,
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.003)
                    ..rotateX(pi / 180 * (animation.value * 180)),
                  alignment: FractionalOffset.centerRight,
                  child: currentPage,
                ),
              ),
            ),
            SlideTransition(
              position: Tween<Offset>(
                begin: Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: Container(
                color: Colors.white,
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.003)
                    ..rotateX(pi / 180 * ((animation.value - 1) * 180)),
                  alignment: FractionalOffset.centerLeft,
                  child: target,
                ),
              ),
            )
          ],
        );
        break;
      case AnimationEnum.cubicY:
        if (currentPage == null) break;
        target = Stack(
          children: [
            SlideTransition(
              position: Tween(
                begin: Offset.zero,
                end: const Offset(-1.0, 0.0),
              ).animate(animation),
              child: Container(
                color: Colors.white,
                child: Transform(
                    alignment: Alignment.centerRight,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.003)
                      ..rotateY(pi / 180 * animation.value * 90),
                    child: currentPage),
              ),
            ),
            SlideTransition(
              position: Tween(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: Container(
                color: Colors.white,
                child: Transform(
                    alignment: Alignment.centerLeft,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.003)
                      ..rotateY(pi / 180 * (animation.value - 1) * 90),
                    child: target),
              ),
            )
          ],
        );
        break;
    }
    return target;
  }
}
