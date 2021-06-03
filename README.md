```
一个用于帮助 flutter APP widget间跳转的工具
```

# y_router

🧑‍💻 Route animation by using flutter's transition widget

## Getting Started

Your can use YRouter to push route

```
    YRouter.push(
        context: context,
        type: AnimationEnum.cubicY,
        target: SecondPageWidget(),
    );
```

or use Navigator to push route

```
    fianl route = YRouter.buildRoute(target: SecondPageWidget(), animationTypes: [
              AnimationEnum.size,
              AnimationEnum.fade,
              AnimationEnum.cubicY],
                currentPage: settings.arguments as Widget,
                transitionMs: 2000);
    
    Navigator.push(context, route);

```

or

```
  onGenerateRoute: (settings) {
        return YRouter.buildRoute(target: SecondPageWidget(), animationTypes: [
          AnimationEnum.size,
          AnimationEnum.fade,
          AnimationEnum.cubicY],
            currentPage: settings.arguments as Widget,
            transitionMs: 2000);
      },
```

You can choose the following types:

```
enum AnimationEnum {
  fade,
  size,
  rotate,
  scale,
  cubicX,
  cubicY,
  slideFromLeft,
  slideFromRight,
  slideFromTop,
  slideFromBottom
}

```

Are you're done 👍 
