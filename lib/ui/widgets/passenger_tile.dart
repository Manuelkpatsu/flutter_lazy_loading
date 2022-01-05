import 'package:flutter/material.dart';
import 'package:flutterlazyloading/model/passenger.dart';
import 'package:url_launcher/url_launcher.dart';

class PassengerTile extends StatelessWidget {
  final Passenger passenger;

  const PassengerTile({Key? key, required this.passenger}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _launchUrl('https://${passenger.airline[0].website}', context),
      leading: Image.network(
        passenger.airline[0].logo,
        fit: BoxFit.cover,
        width: 100,
      ),
      title: Text(passenger.name ?? 'No name'),
      subtitle: Text(passenger.airline[0].name),
      trailing: Text(passenger.airline[0].country),
    );
  }

  void _launchUrl(String url, BuildContext context) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      final snackbar = SnackBar(
        content: Text(
          'Could not launch $url',
          style: const TextStyle(color: Colors.white),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
