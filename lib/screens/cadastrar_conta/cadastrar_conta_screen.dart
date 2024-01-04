import 'package:flutter/material.dart';

class CadastroContaScreen extends StatelessWidget {

  final _nomeController = TextEditingController();
  final _valorController = TextEditingController();

  CadastroContaScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 16), backgroundColor: Colors.blueAccent);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro de Conta"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          // seta um espaçamento top/left/right/bottom de 10
          padding: const EdgeInsets.all(10),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nomeController,
                  keyboardType: TextInputType.text,
                  // label
                  decoration: const InputDecoration(labelText: "Nome")
                ),
                TextFormField(
                  controller: _valorController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Valor"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: style,
                      onPressed: (){
                        print(_valorController.text);
                      },
                      child: const Text(
                        'Cadastrar',
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 16
                         ),
                      )
                    )
                  )
                )
              ],
            )
          )
        )
      )
    );
  }
}
