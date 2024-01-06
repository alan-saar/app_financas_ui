import 'package:app_financas_ui/models/conta.dart';
import 'package:app_financas_ui/utils/db_utils.dart';

class ContaService {

  List<Conta>  _contaList = [];

  void adicionarConta(Conta conta) {
    DbUtil.insereDados('conta', conta.toMap());
  }

  Future<List> listaTodasContas() async {
    final dataList = await DbUtil.getDados('conta');
    _contaList = dataList.map((contas) => Conta.fromMap(contas)).toList();
    return _contaList;
  }

}