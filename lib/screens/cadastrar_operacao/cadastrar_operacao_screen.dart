import 'package:app_financas_ui/models/conta.dart';
import 'package:app_financas_ui/models/operacao.dart';
import 'package:app_financas_ui/screens/home/home_screen.dart';
import 'package:app_financas_ui/services/conta_sqliteandroid_service.dart';
import 'package:app_financas_ui/services/operacao_sqliteandroid_service.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

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
  // final _tipoController = TextEditingController();
  final _dataController = TextEditingController();
  ContaService cs = ContaService();
  OperacaoService os = OperacaoService();
  DateTime selectDate = DateTime.now();

  late Future<List> _carregaContas;
  late List _contas;
  Conta? _contaSelecionada;

  @override
  void initState() {
    _carregaContas = _getContas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.tipoOperacao == 'entrada' ? 'Nova Entrada' : 'Nova Saída',
        ),
        backgroundColor: widget.tipoOperacao == 'entrada' ? Colors.green : Colors.red,
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
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: _dataController,
                              decoration: InputDecoration(
                                labelText: formatDate(selectDate, [dd,'/',mm,'/',yyyy])
                              ),

                            ),
                          ),
                        ),
                        DropdownButtonFormField(
                          value: _contaSelecionada,
                          onChanged: (conta){
                            setState(() {
                              _contaSelecionada = conta as Conta?;
                            });
                          },
                          items: _contas.map((conta){
                            return DropdownMenuItem(
                              value: conta,
                              child: Text(conta.nome),
                            );
                          }).toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Container(
                            height: 40,
                              width: double.infinity, // máximo que ele conseguir de largura
                              child: ElevatedButton(
                                  onPressed: (){
                                    Operacao novaOperacao = Operacao(
                                        nome: _nomeController.text,
                                        resumo: _resumoController.text,
                                        tipo: widget.tipoOperacao,
                                        data: selectDate.toString(),
                                        conta: _contaSelecionada!.id!,
                                        custo: double.parse(_custoController.text)
                                    );
                                    os.addOperacao(novaOperacao);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (_) => const HomeScreen())
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: widget.tipoOperacao == 'entrada' ? Colors.green : Colors.red,
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
    return await cs.getAllContas();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectDate,
        firstDate: DateTime(2024,01),
        lastDate: DateTime(2025,12)
    );
    if (picked != null && picked != selectDate) {
      setState(() {
        selectDate = picked;
      });
    }
  }
}
