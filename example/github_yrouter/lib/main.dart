import 'package:flutter/material.dart';
import 'package:github_yrouter/second_page_widget.dart';

void main() {
  runApp(YRouterApp());
}

class YRouterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
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
      child: TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (c) {
              return SecondPageWidget();
            }));
          },
          child: Text("普通跳转")),
    );
  }
}
