import 'package:app_financas_ui/models/conta.dart';
import 'package:app_financas_ui/screens/home/home_screen.dart';
import 'package:app_financas_ui/services/conta_rest_service.dart';
import 'package:app_financas_ui/services/conta_sqliteandroid_service.dart';
import 'package:flutter/material.dart';

class CadastroContaScreen extends StatelessWidget {

  final _nomeController = TextEditingController();
  final _valorController = TextEditingController();
  final ContaService cs = ContaService();
  final ContaRestService crs = ContaRestService();
  final _formKey = GlobalKey<FormState>();

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
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nomeController,
                  keyboardType: TextInputType.text,
                  // label
                  decoration: const InputDecoration(labelText: "Nome"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Preencha o campo nome";
                      } else {
                        return null;
                      }
                    }),
                TextFormField(
                  controller: _valorController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Valor"),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Preencha o campo valor";
                    } else {
                      return null;
                    }
                  }
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: style,
                      onPressed: (){
                        if(_formKey.currentState!.validate()) {
                          print("valor: ${_valorController.text}");
                          Conta novaConta = Conta(
                              nome: _nomeController.text,
                              valor: double.parse(_valorController.text)
                          );
                          // cs.adicionarConta(novaConta);
                          crs.addConta(novaConta);
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const HomeScreen())
                          );
                        }
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
