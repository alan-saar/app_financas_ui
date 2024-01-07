import 'package:app_financas_ui/screens/cadastrar_conta/cadastrar_conta_screen.dart';
import 'package:app_financas_ui/screens/cadastrar_operacao/cadastrar_operacao_screen.dart';
import 'package:app_financas_ui/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Main());

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: HomeScreen(),
      // home: CadastroContaScreen(),
      // home: CadastrarOperacaoScreen(tipoOperacao: 'saida'),
    );
  }
}
