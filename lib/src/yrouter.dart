import 'package:flutter/material.dart';
import 'package:y_router/src/animation_enum.dart';

class YRouter {

  static Route buildRoute(
      {required Widget child,
      required List<AnimationEnum> animationTypes,
      Curve curve = Curves.linear,
      int durationMs = 300}) {

    return PageRouteBuilder(
        transitionDuration: Duration(milliseconds: durationMs),
        reverseTransitionDuration: Duration(milliseconds: durationMs),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return child;
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {

          animation = CurvedAnimation(curve: curve, parent: animation);
          final widget = _buildTransitions(animationTypes, animation, child);
          return widget;
        });
  }

  static Widget _buildTransitions(List<AnimationEnum> animationTypes,
      Animation<double> animation, Widget child) {
    var widget = child;
    for (var type in animationTypes) {
      widget = _buildAnimationWidget(type, widget, animation);
    }
    return widget;
  }

  static Widget _buildAnimationWidget(
      AnimationEnum type, Widget widget, Animation<double> animation) {
    print("type= $type");
    switch (type) {
      case AnimationEnum.fade:
        widget = FadeTransition(opacity: animation, child: widget);
        break;
      case AnimationEnum.size:
        widget = Center(
          child: SizeTransition(
            sizeFactor: animation,
            child: widget,
          ),
        );
        break;
      case AnimationEnum.rotate:
        widget = RotationTransition(
          turns: animation,
          child: widget,
        );
        break;
      case AnimationEnum.scale:
        widget = ScaleTransition(
          scale: animation,
          child: widget,
        );
        break;
      case AnimationEnum.slideFromBottom:
        print("slide bottom");
        widget = SlideTransition(
          position: Tween(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: widget,
        );
        break;
      case AnimationEnum.slideFromLeft:
        widget = SlideTransition(
          position: Tween(
            begin: const Offset(-1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: widget,
        );
        break;
      case AnimationEnum.slideFromRight:
        widget = SlideTransition(
          position: Tween(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: widget,
        );
        break;
      case AnimationEnum.slideFromTop:
        widget = SlideTransition(
          position: Tween(
            begin: const Offset(0.0, -1.0),
            end: Offset.zero,
          ).animate(animation),
          child: widget,
        );
        break;
    }
    return widget;
  }
}
