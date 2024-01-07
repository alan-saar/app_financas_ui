import 'package:app_financas_ui/models/conta.dart';
import 'package:app_financas_ui/services/conta_service.dart';
import 'package:flutter/material.dart';

class CadastrarOperacaoScreen extends StatefulWidget {
  final String tipoOperacao;

  // const CadastrarOperacao({super.key});
  const CadastrarOperacaoScreen({super.key, required this.tipoOperacao});

  @override
  State<CadastrarOperacaoScreen> createState() => _CadastrarOperacaoScreenState();
}

class _CadastrarOperacaoScreenState extends State<CadastrarOperacaoScreen> {

  final _nomeController = TextEditingController();
  final _resumoController = TextEditingController();
  final _custoController = TextEditingController();
  final _tipoController = TextEditingController();
  final _dataController = TextEditingController();
  ContaService cs = ContaService();
  Conta? contaSelecionada;

  late Future<List> _carregaContas;
  late List _contas;

  @override
  void initState() {
    _carregaContas = _getContas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastro de Operação',
        ),
        backgroundColor: widget.tipoOperacao == 'entrada' ? Colors.blue : Colors.red,
      ),
      body: FutureBuilder(
          future: _carregaContas,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData) {
              _contas = snapshot.data;
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _nomeController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(labelText: 'Nome'),
                        ),
                        TextFormField(
                          controller: _resumoController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(labelText: 'Resumo'),
                        ),
                        TextFormField(
                          controller: _custoController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Custo'),
                        ),
                        TextFormField(
                          controller: _dataController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(labelText: 'Data'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Container(
                            height: 40,
                            width: double.infinity, // máximo que ele conseguir de largura
                              child: ElevatedButton( onPressed: (){},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: widget.tipoOperacao == 'entrada' ? Colors.blue : Colors.red,
                                  ),
                                  child: const Text(
                                      'Cadastrar'
                                  )
                            )
                          )
                        )
                      ],
                    ),
                  )
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
      ),
    );
  }

  Future<List> _getContas() async {
    return await cs.listaTodasContas();
  }
}
