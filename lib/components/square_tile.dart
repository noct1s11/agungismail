import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String ImagePath;
  final Function()? onTap;

  const SquareTile({super.key,
    required this.ImagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        child: Image.asset(ImagePath, height: 40),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example App'),
        ),
        body: Center(
          child: SquareTile(
            ImagePath: 'assets/your_image.png', // Adjust the path and file name
            onTap: () {
              // Add your action here when the tile is tapped
              print('Tile tapped');
            },
          ),
        ),
      ),
    ),
  );
}