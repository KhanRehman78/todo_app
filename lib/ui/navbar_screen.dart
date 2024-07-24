import 'package:simple_floating_bottom_nav_bar/floating_bottom_nav_bar.dart';
import 'package:simple_floating_bottom_nav_bar/floating_item.dart';
import 'package:todo_rebuild/ui/navbar_screens/account_setting.dart';
import 'package:todo_rebuild/ui/navbar_screens/add_task.dart';
import 'package:todo_rebuild/ui/navbar_screens/home_screen.dart';
import 'package:todo_rebuild/utills/libraries.dart';
class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key, this.text});
final String? text;
  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  List<FloatingBottomNavItem> bottomNavItems = const [
    FloatingBottomNavItem(
      inactiveIcon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: "Home",
    ),
    FloatingBottomNavItem(
      inactiveIcon: Icon(Icons.add_circle_outline),
      activeIcon: Icon(Icons.add_circle),
      label: "Add",
    ),
    FloatingBottomNavItem(
      inactiveIcon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: "Profile",
    ),
  ];

  List<Widget> pages = [
    HomeScreen(),
    AddTask(),
    AccountSetting()
  ];
  @override
  Widget build(BuildContext context) {
    return FloatingBottomNavBar(
      pages: pages,
      items: bottomNavItems,
      initialPageIndex: 0,
      backgroundColor: mainColor,
      elevation:0,
      radius: 20,
      width: 250,
      height: 65,
    );
  }
}
