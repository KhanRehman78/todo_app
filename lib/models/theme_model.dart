import 'package:todo_rebuild/utills/libraries.dart';
class themeChanger extends ChangeNotifier{
  bool _isdarkMode = true;
  bool get isDarkMode => _isdarkMode;
  ThemeData get currentTheme => _isdarkMode? ThemeData.dark() :ThemeData.light();
  void toogleTheme(){
    _isdarkMode = !_isdarkMode;
    notifyListeners();
  }
}