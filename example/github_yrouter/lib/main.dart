import 'package:flutter/material.dart';
import 'package:github_yrouter/src/second_page_widget.dart';
import 'package:y_router/y_router.dart';

import 'src/item_check_title_model.dart';
import 'src/item_check_title_widget.dart';

void main() {
  runApp(YRouterApp());
}

const DEFAULT_DURATION = 500;

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
            transitionMs: DEFAULT_DURATION);
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
    _initDataList();
  }

  void _initDataList() {
    dataList.add(ItemCheckTitleModel.create(
        title: "size fade cubicY",
        checked: true,
        types: [AnimationEnum.size, AnimationEnum.fade, AnimationEnum.cubicY]));

    dataList.add(ItemCheckTitleModel.create(
        title: "size fade cubicX",
        types: [AnimationEnum.size, AnimationEnum.fade, AnimationEnum.cubicX]));

    dataList.add(ItemCheckTitleModel.create(title: "scale fade cubicX", types: [
      AnimationEnum.fade,
      AnimationEnum.scale,
      AnimationEnum.cubicX,
    ]));

    for (AnimationEnum type in AnimationEnum.values) {
      dataList.add(
          ItemCheckTitleModel.create(title: type.toString(), types: [type]));
    }
  }

  List<AnimationEnum> get _checkedTypeList {
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
                types: _checkedTypeList,
                target: SecondPageWidget(),
                durationMs: DEFAULT_DURATION,
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
                    types: _checkedTypeList,
                    target: SecondPageWidget(),
                    durationMs: DEFAULT_DURATION,
                    currentPage: context.widget);
              },
              child: Text("push??????")),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/simple",
                    arguments: context.widget);
              },
              child: Text("pushNamed??????")),
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
