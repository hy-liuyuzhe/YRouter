import 'package:y_router/y_router.dart';
import 'package:flutter/material.dart';

class SecondPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("第二个页面"),
      ),
      body: Container(
        color: Colors.red.shade50,
        child: Center(
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                  child: Center(child: Text("第二个页面"))),
            )),
      ),
    );
  }
}
