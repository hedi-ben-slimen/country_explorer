import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/country_provider.dart';
import '../widgets/country_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Use initState to trigger the data fetch only once when the screen is created
  @override
  void initState() {
    super.initState();
    // Use `listen: false` because we are outside the build method; 
    // we just want to call a method, not listen for changes yet.
    Provider.of<CountryProvider>(context, listen: false).fetchCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Country Explorer')),
      // 1. Use Consumer to listen for changes from the Provider
      body: Consumer<CountryProvider>(
        builder: (context, provider, child) {
          // A. Handle Loading State
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          // B. Handle Error State
          if (provider.errorMessage.isNotEmpty) {
            return Center(child: Text(provider.errorMessage, textAlign: TextAlign.center));
          }
          // C. Handle Empty State
          if (provider.countries.isEmpty) {
            return const Center(child: Text('No countries found.'));
          }
          
          // D. Display the Data (Success State)
          return RefreshIndicator(
            // 2. Pull-to-Refresh implementation
            onRefresh: () => provider.fetchCountries(),
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columns
                childAspectRatio: 3 / 2.8, // Adjust card size (width/height ratio)
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: provider.countries.length,
              itemBuilder: (context, index) {
                // 3. Pass the data to the reusable Card Widget
                return CountryCard(country: provider.countries[index]);
              },
            ),
          );
        },
      ),
    );
  }
}