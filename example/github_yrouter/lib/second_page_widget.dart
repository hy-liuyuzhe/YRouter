import 'package:y_router/y_router.dart';
import 'package:flutter/material.dart';

class SecondPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var one = Calculator().addOne(1);
    print("one= $one");
    return Scaffold(
      appBar: AppBar(
        title: Text("新页面"),
      ),
      body: Container(
        child: Center(child: Text("新页面")),
      ),
    );
  }
}
