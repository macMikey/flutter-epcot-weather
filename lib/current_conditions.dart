import 'dart:ui';
import 'package:flutter/material.dart';

class CurrentConditions extends StatelessWidget {
  const CurrentConditions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: const Column(
              children: [
                Text('80 °F', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                Icon(Icons.cloud, size: 64),
                SizedBox(height: 16),
                Text('Cloudy', style: TextStyle(fontSize: 20)),
              ], // children
            ),
          ),
        ),
      ),
    );
  }
}
