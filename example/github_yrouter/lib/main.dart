import 'package:flutter/material.dart';
import 'package:github_yrouter/second_page_widget.dart';
import 'package:y_router/y_router.dart';

void main() {
  runApp(YRouterApp());
}

class YRouterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {

        return YRouter.buildRoute(target: SecondPageWidget(), animationTypes: [
          AnimationEnum.size,
          AnimationEnum.fade,
          AnimationEnum.cubicY],
            currentPage: settings.arguments as Widget,
            transitionMs: 2000);
      },
      home: ListViewWidget(),
    );
  }
}

class ListViewWidget extends StatefulWidget {
  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("YRouterApp"),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    YRouter.push(
                        context: context,
                        type: AnimationEnum.cubicY,
                        target: SecondPageWidget(),
                        durationMs: 1000,
                        currentPage: context.widget);
                  },
                  child: Text("push跳转")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/simple", arguments: context.widget);
                  },
                  child: Text("pushNamed跳转")),
            ],
          ),
        ));
  }
}
