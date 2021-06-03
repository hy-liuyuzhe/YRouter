import 'package:y_router/y_router.dart';

class ItemCheckTitleModel {
  String title;

  List<AnimationEnum> types;

  bool checked;

  ItemCheckTitleModel.create(
      {required this.title, required this.types, this.checked = false});

  @override
  String toString() {
    return 'ItemCheckTitleModel{title: $title, type: $types, checked: $checked}';
  }
}
