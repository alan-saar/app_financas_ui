import 'package:app_financas_ui/screens/conta/components/body.dart';
import 'package:flutter/material.dart';

class ContaScreen extends StatelessWidget {

  final int id;

  const ContaScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        id: id,

      ),
    );
  }
}
