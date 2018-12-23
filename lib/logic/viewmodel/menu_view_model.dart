import 'package:flutter/material.dart';
import 'package:nintendo_fans/model/menu.dart';
import 'package:nintendo_fans/utils/uidata.dart';

class MenuViewModel {
  List<Menu> menuItems;

  MenuViewModel({this.menuItems});

  getMenuItems() {
    return menuItems = <Menu>[
      Menu(title: "Profile", menuColor: Color(0xff050505), icon: Icons.person, image: UIData.profileImage, url: "/profile"),
      Menu(title: "Nintendo Switch Store", menuColor: Color(0xffc8c4bd), icon: Icons.store, image: UIData.shoppingImage, url: UIData.storeRoute),
      Menu(title: "Nintendo News", menuColor: Color(0xffc7d8f4), icon: Icons.message, image: UIData.loginImage, url: "/news"),
      // Menu(title: "Timeline", menuColor: Color(0xff7f5741), icon: Icons.timeline, image: UIData.timelineImage, items: ["Feed", "Tweets", "Timeline 3", "Timeline 4"]),
      // Menu(title: "Dashboard", menuColor: Color(0xff261d33), icon: Icons.dashboard, image: UIData.dashboardImage, items: ["Dashboard 1", "Dashboard 2", "Dashboard 3", "Dashboard 4"]),
      Menu(title: "Settings", menuColor: Color(0xff2a8ccf), icon: Icons.settings, image: UIData.settingsImage, url: "/settings"),
      // Menu(title: "No Item", menuColor: Color(0xffe19b6b), icon: Icons.not_interested, image: UIData.blankImage, items: ["No Search Result", "No Internet", "No Item 3", "No Item 4"]),
      // Menu(title: "Payment", menuColor: Color(0xffddcec2), icon: Icons.payment, image: UIData.paymentImage, items: ["Credit Card", "Payment Success", "Payment 3", "Payment 4"]),
    ];
  }
}
