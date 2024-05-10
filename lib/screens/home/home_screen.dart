import 'package:countries_info_app/controllers/country_search_delegate.dart';
import 'package:countries_info_app/models/country_model.dart';
import 'package:countries_info_app/providers/countries_provider.dart';
import 'package:countries_info_app/screens/connectivity/global_connectivity_scaffold.dart';
import 'package:countries_info_app/screens/custom_widgets/custom_image.dart';
import 'package:countries_info_app/screens/custom_widgets/custom_page_transition.dart';
import 'package:countries_info_app/screens/home/country_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GlobalConnectivityScaffold(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Countries by Continent'),
          backgroundColor: Colors.deepPurple, // Modern color scheme
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                final countriesProvider =
                    Provider.of<CountriesProvider>(context, listen: false);
                showSearch(
                  context: context,
                  delegate: CountrySearchDelegate(countriesProvider.countries!),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final countriesProvider =
                Provider.of<CountriesProvider>(context, listen: false);
            countriesProvider.fetchCountries(); // Trigger data fetch
          },
          backgroundColor: Colors.deepPurple,
          child: const Icon(Icons.refresh), // Match app's color scheme
        ),
        body: Consumer<CountriesProvider>(
          builder: (context, countriesProvider, child) {
            if (countriesProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (countriesProvider.errorMessage != null) {
              return Center(
                child: Text(
                  countriesProvider.errorMessage!,
                  style:
                      theme.textTheme.bodyMedium!.copyWith(color: Colors.red),
                ),
              );
            } else {
              final countries = countriesProvider.countries!;
              final continentsMap = _groupByContinent(countries);

              return ListView.builder(
                padding: const EdgeInsets.all(10), // Padding for the list
                physics: const BouncingScrollPhysics(),
                itemCount: continentsMap.length,
                itemBuilder: (context, index) {
                  final continentName = continentsMap.keys.elementAt(index);
                  final countriesInContinent = continentsMap[continentName]!;

                  return Card(
                    elevation: 6, // Increased elevation for better shadow
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16), // More rounded corners
                    ),
                    child: ExpansionTile(
                      leading: const Icon(
                        Icons.public,
                        color: Colors.deepPurpleAccent,
                        size: 28, // Larger icon size for visual impact
                      ),
                      title: Text(
                        continentName,
                        style: theme.textTheme.titleLarge!.copyWith(
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: const Icon(Icons.expand_more),
                      children: List.generate(
                        countriesInContinent.length,
                        (countryIndex) {
                          final country = countriesInContinent[countryIndex];
                          return GestureDetector(
                            onTap: () {
                              // Navigate to CountryDetailsScreen
                              Navigator.of(context).push(
                                createCustomRoute(
                                  targetPage:
                                      CountryDetailsScreen(country: country),
                                ), // Use custom transition
                                // MaterialPageRoute(
                                // builder: (context) => CountryDetailsScreen(
                                //   country: country,
                                // ),
                                // ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                // Modern touch with a background and shadow
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 3,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey, // Border color
                                          width: 2, // Border thickness
                                        ),
                                      ),
                                      child: CustomImage(
                                          imageUrl: country.flags!.png!),
                                    ),
                                  ),
                                  title: Text(
                                    country.name!.common!,
                                    style:
                                        theme.textTheme.titleMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Capital: ${country.capital != null && country.capital!.isNotEmpty ? country.capital!.join(", ") : "NA"} ',
                                          style: theme.textTheme.bodySmall!
                                              .copyWith(
                                                  color: Colors.grey[700],
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.0),
                                        ),
                                        const SizedBox(height: 2.0),
                                        Text(
                                          'Population: ${country.population}',
                                          style: theme.textTheme.bodySmall!
                                              .copyWith(
                                            // color: Colors.grey[700],
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Map<String, List<CountryModel>> _groupByContinent(
      List<CountryModel> countries) {
    final map = <String, List<CountryModel>>{};

    for (var country in countries) {
      final region = country.region;
      if (!map.containsKey(region)) {
        map[region!] = [];
      }
      map[region]!.add(country);
    }

    return map;
  }
}
