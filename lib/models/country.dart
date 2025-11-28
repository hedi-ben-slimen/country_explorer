class Country {
  final String name;
  final String capital;
  final String flagUrl;
  final int population;

  Country({
    required this.name,
    required this.capital,
    required this.flagUrl,
    required this.population,
  });

  // Factory constructor to create a Country from JSON
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'] ?? 'Unknown', // Handle null safety
      capital: json['capital'] ?? 'No Capital',
      flagUrl: json['flag'] ?? '', 
      population: json['population'] ?? 0,
    );
  }
}