import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:countries_info_app/providers/connectivity_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GlobalConnectivityScaffold extends StatelessWidget {
  final Widget child;

  const GlobalConnectivityScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          child, // The main content of the screen
          // Global connectivity status indicator
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Consumer<ConnectivityProvider>(
              builder: (context, connectivityProvider, child) {
                final isConnected = connectivityProvider.connectivityResult !=
                    ConnectivityResult.none;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  color: isConnected ? Colors.green : Colors.red,
                  padding: const EdgeInsets.all(10.0),
                  // Show or hide based on connectivity status
                  height: isConnected ? 0 : 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isConnected ? Icons.wifi : Icons.signal_wifi_off,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        isConnected
                            ? "Connected to the Internet"
                            : "No Internet Connection",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
