import 'package:flutter/material.dart';
import '../providers/country_provider.dart';
import '../widgets/country_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Trigger data fetch when screen builds (simplest approach for this level)
    // Note: In production, we might do this in a StatefulWidget's initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
       if (Provider.of<CountryProvider>(context, listen: false).countries.isEmpty) {
         Provider.of<CountryProvider>(context, listen: false).fetchCountries();
       }
    });

    return Scaffold(
      appBar: AppBar(title: Text('Country Explorer')),
      body: Consumer<CountryProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (provider.errorMessage.isNotEmpty) {
            return Center(child: Text(provider.errorMessage));
          }
          
          return RefreshIndicator(
            onRefresh: () => provider.fetchCountries(),
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columns
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: provider.countries.length,
              itemBuilder: (context, index) {
                return CountryCard(country: provider.countries[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
