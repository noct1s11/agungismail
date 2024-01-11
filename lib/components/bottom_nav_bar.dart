import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  MyBottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.all(25),
      child: GNav(
        onTabChange: (value) => onTabChange!(value),
        mainAxisAlignment: MainAxisAlignment.center,  
        activeColor: Colors.white ,
        tabBackgroundColor: Color.fromARGB(255, 19, 73, 109),
        tabBorderRadius: 24,
        tabActiveBorder: Border.all(color: Colors.white),
        tabs: const [
        GButton(
        icon: Icons.home,
        text: 'List Team',
        ),
         GButton(
        icon: Icons.shopping_bag,
        text: 'Shoe Shop',
         ),  
      ],
      ),
    );
  }
}