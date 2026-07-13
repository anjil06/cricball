import 'package:flutter/material.dart';

class AppLogoWidget extends StatelessWidget {
  final double size;

  const AppLogoWidget({super.key, this.size = 60});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.sports_cricket,
              color: Colors.white,
              size: size * 0.6,
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'cricball',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}

class AppHeader extends StatelessWidget {
  final String title;
  final double logoSize;

  const AppHeader({
    super.key,
    required this.title,
    this.logoSize = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            width: logoSize,
            height: logoSize,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.sports_cricket,
                color: Colors.white,
                size: logoSize * 0.6,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
