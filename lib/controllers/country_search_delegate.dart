import 'package:countries_info_app/screens/connectivity/global_connectivity_scaffold.dart';
import 'package:countries_info_app/screens/custom_widgets/custom_image.dart';
import 'package:countries_info_app/screens/custom_widgets/custom_page_transition.dart';
import 'package:flutter/material.dart';
import 'package:countries_info_app/models/country_model.dart';
import 'package:countries_info_app/screens/home/country_detail_screen.dart';

class CountrySearchDelegate extends SearchDelegate<CountryModel?> {
  final List<CountryModel> countries;

  CountrySearchDelegate(this.countries);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear the search query
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Close the search without returning a result
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final theme = Theme.of(context);
    final results = countries
        .where((country) =>
            country.name!.common!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return Center(
        child: Text(
          'No country found for "$query"',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ); // Display "No Country Found" message if results are empty
    }

    return GlobalConnectivityScaffold(
      child: ListView.builder(
        itemCount: results.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final country = results[index];
          return GestureDetector(
            onTap: () {
              // Navigate to CountryDetailsScreen
              Navigator.of(context).push(
                createCustomRoute(
                  targetPage: CountryDetailsScreen(country: country),
                ),
                // MaterialPageRoute(
                //   builder: (context) => CountryDetailsScreen(
                //     country: country,
                //   ),
                // ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
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
                      child: CustomImage(imageUrl: country.flags!.png!),
                    ),
                  ),
                  title: Text(
                    country.name!.common!,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Capital: ${country.capital != null && country.capital!.isNotEmpty ? country.capital!.join(", ") : "NA"} ',
                          style: theme.textTheme.bodySmall!.copyWith(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          'Population: ${country.population}',
                          style: theme.textTheme.bodySmall!.copyWith(
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context); // Suggest similar to build results
  }
}
