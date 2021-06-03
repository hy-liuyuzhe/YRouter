import 'package:flutter/material.dart';
import 'package:github_yrouter/src/item_check_title_model.dart';

class ItemCheckTitleWidget extends StatefulWidget {
  final ItemCheckTitleModel model;

  const ItemCheckTitleWidget(this.model, {Key? key}) : super(key: key);

  @override
  _ItemCheckTitleWidgetState createState() => _ItemCheckTitleWidgetState();
}

class _ItemCheckTitleWidgetState extends State<ItemCheckTitleWidget> {

  @override
  Widget build(BuildContext context) {
    var model = (context.widget as ItemCheckTitleWidget).model;
    return Container(
      child: CheckboxListTile(
        title: Text(model.title),
        onChanged: (bool? value) {
          setState(() {
            model.checked = value ??= false;
          });
        },
        value: model.checked,
      ),
    );
  }
}
