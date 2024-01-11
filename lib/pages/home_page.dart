import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/bottom_nav_bar.dart';
import 'calculator.dart';
import 'bmi_calculator.dart';
import 'cart_page.dart';
import 'const.dart';
import 'setting_page.dart';
import 'shop_page.dart';
import 'user_profile.dart';

class HomePage extends StatefulWidget {
  final User user = FirebaseAuth.instance.currentUser!;

  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _SelectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _SelectedIndex = index;
    });
  }

  final List<Widget> _HomePage = [
    ShopPage(), // Uncomment this line to include the ShopPage
    CartPage(), // Uncomment this line to include the CartPage
  ];

 @override
Widget build(BuildContext context) {
  return Scaffold(
    extendBodyBehindAppBar: false,
    backgroundColor: backgroundColor,
    bottomNavigationBar: MyBottomNavBar(
      onTabChange: (index) => navigateBottomBar(index),
    ),
    body: _HomePage[_SelectedIndex],
    appBar: AppBar(
      backgroundColor: Color.fromARGB(255, 19, 73, 109),
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Icon(
              Icons.menu,
              color: Color.fromARGB(255, 255, 0, 0),
            ),
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      title: Center(
        child: Text(
          'NBA TEAM ',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 0, 0),
          ),
        ),
      ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color: Color.fromARGB(255, 255, 0, 0),
            onPressed: () {
              // Handle search action
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            color: Color.fromARGB(255, 255, 0, 0),
            onPressed: () {
              // Handle notifications action
            },
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor:Color.fromARGB(255, 19, 73, 109),
        child: Column(
          children: [
            DrawerHeader(child: Image.asset('lib/images/airjordanlogo.png')),
            Divider(
              color: Colors.grey[800],
            ),
            const ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.info,
                color: Colors.white,
              ),
              title: Text(
                'About',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                navigateToUserProfile(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              title: Text(
                'Settings',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                signUserOut();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.book,
                color: Colors.white,
              ),
              title: Text(
                'Calculator',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                navigateToCalculator(context);
              },
            ),
            ListTile(
  leading: Icon(
    Icons.calculate,
    color: Colors.white,
  ),
  title: Text(
    'BMI Calculator',
    style: TextStyle(color: Colors.white),
  ),
  onTap: () {
    navigateToBMICalculator(context);
    },
),
          ],
        ),
      ),
      
    );
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void navigateToCalculator(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Calculator()),
    );
  }

  void navigateToUserProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return UserProfilePage(user: widget.user);
        },
      ),
    );
  }
  void navigateToBMICalculator(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => BMICalculator()),
  );
}
}