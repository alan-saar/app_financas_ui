import 'package:app_financas_ui/screens/home/components/body.dart';
import 'package:app_financas_ui/screens/home/components/speed_dial.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Body(),
      floatingActionButton: buildSpeedDial(context),
    );
  }
}
