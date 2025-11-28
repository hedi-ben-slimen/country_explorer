import 'package:flutter/material.dart';
import '../models/country.dart';
import '../screens/detail_screen.dart'; 

class CountryCard extends StatelessWidget {
  final Country country;

  const CountryCard({
    Key? key,
    required this.country,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      // 1. Navigation on tap
      child: InkWell(
        onTap: () {
          // Navigate to the Detail Screen, passing the current Country object
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(country: country),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // 2. Country Flag (Image)
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  country.flagUrl,
                  fit: BoxFit.cover,
                  // Show a simple spinner while the image loads
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: CircularProgressIndicator());
                  },
                  // Show an icon if the image fails to load
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.public, size: 40),
                ),
              ),
            ),
            // 3. Country Details (Text)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                country.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis, // Prevents text overflow
              ),
            ),
          ],
        ),
      ),
    );
  }
}