import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  final  user; // You should define the User class as per your authentication provider

  const UserProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'User Profile Information:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('Name: ${user.displayName}'),
            Text('Email: ${user.email}'),
            // Add more user profile information as needed
          ],
        ),
      ),
    );
  }
}