import 'dart:async';

import 'package:nintendo_fans/logic/viewmodel/menu_view_model.dart';
import 'package:nintendo_fans/model/menu.dart';

class MenuBloc {
  final _menuVM = MenuViewModel();
  final menuController = StreamController<List<Menu>>();

  Stream<List<Menu>> get menuItems => menuController.stream;

  MenuBloc() {
    menuController.add(_menuVM.getMenuItems());
  }
}
