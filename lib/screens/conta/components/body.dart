import 'package:app_financas_ui/models/conta.dart';
import 'package:app_financas_ui/models/operacao.dart';
import 'package:app_financas_ui/screens/components/card_conta.dart';
import 'package:app_financas_ui/screens/components/card_operacao.dart';
import 'package:app_financas_ui/services/conta_sqliteandroid_service.dart';
import 'package:app_financas_ui/services/operacao_sqliteandroid_service.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {

  final int id;

  const Body({super.key, required this.id});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  OperacaoService os = OperacaoService();
  ContaService cs = ContaService();
  late Future<List> _carregaOperacoes;
  late Future<Conta> _carregaConta;
  late Conta _conta;
  late List<Operacao> _operacoes;

  @override
  void initState() {
    _carregaConta = _getConta(widget.id);
    _carregaOperacoes = _getOperacoes(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 70, bottom: 20),
          child: Container(
            height: 176,
            width: double.infinity,
            child: FutureBuilder(
              future: _carregaConta,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  _conta = snapshot.data;
                  return cardConta(context, _conta);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),

        const Padding(
            padding: EdgeInsets.only(left: 24, top: 30, bottom: 15, right: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Todas as operações',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    )
                ),
              ],
            )
        ),
        FutureBuilder(
          future: _carregaOperacoes,
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasData) {
              _operacoes = snapshot.data;
              return Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _operacoes.length,
                  padding: EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    return cardOperacao(context, index, _operacoes[index]);
                  },
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    );
  }

  Future<Conta> _getConta(int id) async {
    return await cs.getConta(id);
  }

  Future<List> _getOperacoes(int id) async {
    return await os.getOperacoesConta(id);
  }


}
