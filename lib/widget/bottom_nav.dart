import 'package:flutter/material.dart';
import '/screens/home.dart';
import '/screens/setting_screen.dart';
import '../screens/upload_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

int _currentIndex = 0;
Widget _body = Home();

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.upload_sharp), label: 'Upload'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'setting'),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(
            () {
              _currentIndex = index;
              if (index == 0) {
                _body = Home();
              } else if (index == 1) {
                _body = const UploadScreen();
              } else if (index == 2) {
                _body = const SettingScreen();
              }
            },
          );
        },
      ),
    );
  }
}
