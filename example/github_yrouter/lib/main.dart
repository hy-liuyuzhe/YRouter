import 'package:flutter/material.dart';
import 'package:github_yrouter/src/second_page_widget.dart';
import 'package:y_router/y_router.dart';

import 'src/item_check_title_model.dart';
import 'src/item_check_title_widget.dart';

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
        return YRouter.buildRoute(
            target: SecondPageWidget(),
            animationTypes: [
              AnimationEnum.size,
              AnimationEnum.fade,
              AnimationEnum.cubicY
            ],
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

  List<ItemCheckTitleModel> dataList = [];

  @override
  void initState() {
    super.initState();
    dataList.add(ItemCheckTitleModel.create(
        title: "size fade cubicY",
        checked: true,
        types: [AnimationEnum.size, AnimationEnum.fade, AnimationEnum.cubicY]));

    dataList.add(ItemCheckTitleModel.create(
        title: "size fade cubicX",
        types: [AnimationEnum.size, AnimationEnum.fade,AnimationEnum.cubicX]));

    dataList.add(ItemCheckTitleModel.create(title: "scale fade cubicY", types: [
      AnimationEnum.fade,
      AnimationEnum.scale,
      AnimationEnum.cubicX,
    ]));

    for (AnimationEnum type in AnimationEnum.values) {
      dataList.add(
          ItemCheckTitleModel.create(title: type.toString(), types: [type]));
    }
  }

  List<AnimationEnum> get checkedTypeList {
    Set<AnimationEnum> types = {};
    for (var model in dataList) {
      if (model.checked) types.addAll(model.types);
    }
    return types.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("YRouterApp"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            YRouter.push(
                context: context,
                types: checkedTypeList,
                target: SecondPageWidget(),
                durationMs: 2000,
                currentPage: context.widget);
          },
          elevation: 8,
          child: Icon(Icons.next_plan),
        ),
        persistentFooterButtons: [
          ElevatedButton(
              onPressed: () {
                YRouter.push(
                    context: context,
                    types: checkedTypeList,
                    target: SecondPageWidget(),
                    durationMs: 1000,
                    currentPage: context.widget);
              },
              child: Text("push跳转")),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/simple",
                    arguments: context.widget);
              },
              child: Text("pushNamed跳转")),
        ],
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemBuilder: (c, index) {
              return ItemCheckTitleWidget(dataList[index]);
            },
            itemCount: dataList.length,
          ),
        ));
  }
}
