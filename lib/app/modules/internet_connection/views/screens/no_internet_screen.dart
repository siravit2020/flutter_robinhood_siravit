import 'package:flutter/material.dart';
import 'package:flutter_robinhood_siravit/app/modules/internet_connection/controllers/internet_connection_controller.dart';
import 'package:flutter_robinhood_siravit/core/gen/assets.gen.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.lotties.internet.lottie(
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 32,
            ),
            const Text('No Internet'),
            const SizedBox(
              height: 32,
            ),
            SizedBox(
              width: 120,
              child: OutlinedButton(
                onPressed: () => InternetConnectionController.to.retryConnec(),
                child: const Text('Retry'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
