import 'package:flutter/material.dart';
import 'package:flutter_template/ui/components/bottom_navigation.dart';
import 'package:flutter_template/ui/screens/home/home.dart';
import 'package:flutter_template/ui/screens/profile/profile.dart';

class HomeNavigatorWidget extends StatefulWidget {
  const HomeNavigatorWidget({Key? key}) : super(key: key);

  @override
  State<HomeNavigatorWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeNavigatorWidget> {
  int _selectedIndex = 0;
  final List _children = [
    const HomeWidget(),
    const ProfileWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      left: false,
      right: false,
      bottom: Theme.of(context).platform == TargetPlatform.android,
      child: Scaffold(
        body: _children[_selectedIndex],
        bottomNavigationBar: BottomNavigation(
            selectedIndex: _selectedIndex,
            onItemTapped: (index) => _onItemTapped(index)),
      ),
    );
  }
}
