import 'package:drone/controllers/auth_controller.dart';
import 'package:drone/pages/screens/accountscreen.dart';
import 'package:drone/pages/screens/homescreen.dart';
import 'package:drone/pages/screens/map.dart';
import 'package:drone/pages/screens/searchscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authController = Get.put(AuthController());
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<Widget> screens = <Widget>[
    Homescreen(),
    MyMap(),
    SearchScreen(),
    Accountscreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Image.asset(
              "assets/bg-n.jpg",
              height: Get.size.height,
              fit: BoxFit.fill,
            ),
            screens[_currentIndex]
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: CustomNavigationBar(
            currentIndex: _currentIndex,
            iconSize: 27,
            borderRadius: Radius.circular(10),
            onTap: (index) {
              print(index);
              setState(() {
                _currentIndex = index;
              });
            },
            isFloating: true,
            elevation: 0,
            backgroundColor: Colors.black,
            selectedColor: Colors.white,
            unSelectedColor: Colors.grey[600],
            strokeColor: Colors.white,
            items: [
              CustomNavigationBarItem(
                icon: Icons.home,
              ),
              CustomNavigationBarItem(
                icon: Icons.map,
              ),
              CustomNavigationBarItem(
                icon: Icons.upload_outlined,
              ),
              CustomNavigationBarItem(
                icon: Icons.account_circle,
              ),
            ],
          ),
        ));
  }
}
