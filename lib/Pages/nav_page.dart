import 'package:flutter/material.dart';
import 'package:my_flutter_project/Pages/home_page.dart';
import 'package:my_flutter_project/Pages/image_page.dart';
import 'package:my_flutter_project/Pages/settings_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BottomNavigationState();
}

class _BottomNavigationState
    extends State<BottomNavigation> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _kTabPages = <Widget>[
      const MyHomePage(),
      const ImagePage(),
      const SettingsPage(),
    ];
    final _kBottmonNavBarItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Dairy'),
      const BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Memory'),
      const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
    ];
    assert(_kTabPages.length == _kBottmonNavBarItems.length);
    final bottomNavBar = BottomNavigationBar(
      items: _kBottmonNavBarItems,
      currentIndex: _currentTabIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentTabIndex = index;
        });
      },
    );
    return Scaffold(
      body: _kTabPages[_currentTabIndex],
      bottomNavigationBar: bottomNavBar,
    );
  }
}
