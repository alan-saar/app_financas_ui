import 'package:app_financas_ui/screens/operacao/components/body.dart';
import 'package:flutter/material.dart';

class OperacaoScreen extends StatelessWidget {
  const OperacaoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 1,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Body(),
    );
  }
}
