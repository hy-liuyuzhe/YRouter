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
      onGenerateRoute: (settings) {
        return YRouter.buildRoute(child: SecondPageWidget(), animationTypes: [
          AnimationEnum.fade,
          AnimationEnum.slideFromBottom,
        ]);
      },
      home: Scaffold(
        appBar: AppBar(
          title: Text("YRouterApp"),
        ),
        body: ListViewWidget(),
      ),
    );
  }
}

class ListViewWidget extends StatefulWidget {
  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    YRouter.buildRoute(
                        child: SecondPageWidget(),
                        animationTypes: [
                          AnimationEnum.size,
                        ]));
              },
              child: Text("push跳转")),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/simple");
              },
              child: Text("pushNamed跳转")),
        ],
      ),
    );
  }
}
