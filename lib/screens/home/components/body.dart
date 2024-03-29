import 'package:app_financas_ui/screens/components/card_conta.dart';
import 'package:app_financas_ui/screens/components/card_operacao.dart';
import 'package:app_financas_ui/screens/operacao/operacao_screen.dart';
import 'package:app_financas_ui/services/conta_rest_service.dart';
import 'package:app_financas_ui/services/conta_sqliteandroid_service.dart';
import 'package:app_financas_ui/services/operacao_sqliteandroid_service.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ContaService cs = ContaService();
  ContaRestService csr = ContaRestService();
  OperacaoService os = OperacaoService();

  late Future<List> _carregaContas;
  late Future<List> _carregaOperacoes;
  late List _contas;
  late List _operacoes;

  @override
  void initState() {
    _carregaContas = _getContas();
    _carregaOperacoes = _getOperacoes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 175,
              child: FutureBuilder(
                future: _carregaContas,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData) {
                    _contas = snapshot.data;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: _contas.length,
                      padding: const EdgeInsets.only(left: 16, right: 8),
                      itemBuilder: (context, index) {
                        return cardConta(context, _contas[index]);
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 30, bottom: 15, right: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                   'Ultimas Operações',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    )
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const OperacaoScreen(),
                        )
                      );
                    },
                    child: const Text(
                      'Ver Todos',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue,
                        )
                    ),
                  )
                ],
              )
            ),
            FutureBuilder(
              future: _carregaOperacoes,
              builder: (BuildContext context, AsyncSnapshot snapshot ) {
                if(snapshot.hasData) {
                  _operacoes = snapshot.data;
                  return Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: _operacoes.length > 4 ? 4 : _operacoes.length,
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
            )
          ],
        )
    );
  }

  Future<List> _getContas() async {
    // return await cs.getAllContas(); // androidSqlite
    return await csr.getContas();
  }

  Future<List> _getOperacoes() async {
    return await os.getAllOperacoes();
  }

}
