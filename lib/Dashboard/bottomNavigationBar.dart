import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavigation({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);

    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/images/home.png",
            width: mQuery.size.width * 0.075,
            color: selectedIndex == 0 ? const Color(0xff29b2fe) : Colors.black,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/images/drawer-images/shopping-bag.png",
            width: mQuery.size.width * 0.075,
            color: selectedIndex == 1 ? const Color(0xff29b2fe) : Colors.black,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/images/drawer-images/bell.png",
            width: mQuery.size.width * 0.075,
            color: selectedIndex == 2 ? const Color(0xff29b2fe) : Colors.black,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/images/drawer-images/heart.png",
            width: mQuery.size.width * 0.075,
            color: selectedIndex == 3 ? const Color(0xff29b2fe) : Colors.black,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/images/drawer-images/wallet.png",
            width: mQuery.size.width * 0.075,
            color: selectedIndex == 4 ? const Color(0xff29b2fe) : Colors.black,
          ),
          label: "",
        ),
      ],
    );
  }
}
