
import 'package:flutter/material.dart';
import '../models/country.dart';
class DetailScreen extends StatefulWidget {
  final Country country;

  const DetailScreen({Key? key, required this.country}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // Use widget.country to access data here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.country.name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
             Image.network(widget.country.flagUrl),
             Text("Capital: ${widget.country.capital}"),
             // Add more details here
          ],
        ),
      ),
    );
  }
}