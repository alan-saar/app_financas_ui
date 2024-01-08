import 'package:app_financas_ui/screens/cadastrar_conta/cadastrar_conta_screen.dart';
import 'package:app_financas_ui/screens/cadastrar_operacao/cadastrar_operacao_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

SpeedDial buildSpeedDial(BuildContext context) {
  return SpeedDial(
    animatedIcon: AnimatedIcons.menu_close,
    animatedIconTheme: const IconThemeData(size: 22),
    children: [
      SpeedDialChild(
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.green,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (_) => const CadastrarOperacaoScreen(tipoOperacao: 'entrada'),
            ),
          );
        },
        label: 'Entrada',
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        labelBackgroundColor: Colors.green,
      ),
      SpeedDialChild(
        child: const Icon(Icons.remove, color: Colors.white),
        backgroundColor: Colors.red,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const CadastrarOperacaoScreen(tipoOperacao: 'saida'),
            ),
          );
        },
        label: 'Saída',
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        labelBackgroundColor: Colors.red,
      ),
      SpeedDialChild(
        child: const Icon(Icons.account_balance, color: Colors.white),
        backgroundColor: Colors.blue,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CadastroContaScreen(),
            ),
          );
        },
        label: 'Conta',
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        labelBackgroundColor: Colors.blue,
      )
    ],
  );
}