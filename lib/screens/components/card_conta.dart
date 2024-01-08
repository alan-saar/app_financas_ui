import 'package:app_financas_ui/models/conta.dart';
import 'package:app_financas_ui/screens/conta/conta_screen.dart';
import 'package:flutter/material.dart';

Widget cardConta(BuildContext context, Conta conta) {

  return InkWell(
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => ContaScreen(id: conta.id!)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        width: 250,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blueAccent,
            boxShadow: const [
              BoxShadow(
                // cor hexadecimal
                color: Color(0x00100000),
                // color: Color.fromRGBO(0, 0, 0, 1.0),
                blurRadius: 8,
                spreadRadius: 4,
                offset: Offset(0.0, 0.7),
              )
            ]
        ),
        child: Stack(
            children: [
              Positioned(
                top: 14,
                right: 12,
                child: Text(
                    conta.nome,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                    )
                ),
              ),
              const Positioned(
                top: 65,
                right: 12,
                child: Text(
                  'Saldo em conta',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                  ),
                ),
              ),
              Positioned(
                top: 81,
                right: 16,
                child: Text(
                  "R\$ ${conta.valor}",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.white
                  ),
                ),
              ),
            ]
        ),
      )
  );
}