import 'package:countries_info_app/screens/connectivity/global_connectivity_scaffold.dart';
import 'package:countries_info_app/screens/custom_widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:countries_info_app/models/country_model.dart';

class CountryDetailsScreen extends StatelessWidget {
  final CountryModel country;

  const CountryDetailsScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Retrieve the flag URL and handle null case
    final flagUrl = country.flags?.png ?? '';

    return GlobalConnectivityScaffold(
      child: Scaffold(
        appBar: AppBar(
          // title: Text(country.name?.common ?? "Country Details"),
          title: const Text("Country Details"),
          backgroundColor: Colors.deepPurple,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the flag as a banner at the top
              flagUrl.isNotEmpty
                  ? Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey, // Border color
                          width: 2, // Border thickness
                        ),
                      ),
                      child: CustomImage(
                          imageUrl: country.flags!.png!,
                          imgWidth: double.infinity,
                          imgHeight: 200.0,
                          imgPlaceholderWidth: double.infinity,
                          imgPlaceholderHeight: 200.0,
                          imgFit: BoxFit.cover),
                    )
                  : Container(
                      height: 200), // Placeholder if no flag is available
              const SizedBox(height: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Basic country information
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16), // Rounded corners
                    ),
                    elevation: 4, // Shadow for depth
                    child: Padding(
                      padding:
                          const EdgeInsets.all(16), // Padding inside the card
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // '${country.name?.common}',
                            country.name!.common!,
                            style: theme.textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                          const Divider(),
                          // const SizedBox(height: 10),
                          Text(
                            'Capital: ${country.capital != null && country.capital!.isNotEmpty ? country.capital!.join(", ") : "NA"}',
                            style: theme.textTheme.bodyLarge,
                          ),
                          const Divider(),
                          // const SizedBox(height: 10),
                          Text(
                            'Population: ${country.population?.toString() ?? "NA"}',
                            style: theme.textTheme.bodyLarge,
                          ),
                          // const SizedBox(height: 10),
                          const Divider(),
                          Text(
                            'Region: ${country.region ?? "NA"}',
                            style: theme.textTheme.bodyLarge,
                          ),
                          // const SizedBox(height: 10),
                          const Divider(),
                          Text(
                            'Sub-Region: ${country.subregion ?? "NA"}',
                            style: theme.textTheme.bodyLarge,
                          ),
                          // const SizedBox(height: 10),
                          const Divider(),
                          Text(
                            'Area: ${country.area?.toString() ?? "NA"} sq. km.',
                            style: theme.textTheme.bodyLarge,
                          ),
                          // const SizedBox(height: 10),
                          const Divider(),
                          Text(
                            'Borders: ${country.borders != null && country.borders!.isNotEmpty ? country.borders!.join(", ") : "NA"}',
                            style: theme.textTheme.bodyLarge,
                          ),
                          // const SizedBox(height: 10),
                          const Divider(),
                          Text(
                            'Timezones: ${country.timezones?.join(", ") ?? "NA"}',
                            style: theme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10), // Spacing between sections

                  // Optional coat of arms section
                  if (country.coatOfArms != null &&
                      country.coatOfArms!.png != null) ...[
                    const SizedBox(height: 10),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Coat of Arms',
                              style: theme.textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CustomImage(
                                  imageUrl: country.coatOfArms!.png!,
                                  imgWidth: 200.0,
                                  imgHeight: 200.0,
                                  imgPlaceholderWidth: 200.0,
                                  imgPlaceholderHeight: 200.0,
                                  imgFit: BoxFit.contain),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
