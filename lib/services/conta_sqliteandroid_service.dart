import 'package:app_financas_ui/models/conta.dart';
import 'package:app_financas_ui/utils/db_utils.dart';

class ContaService {

  List<Conta>  _contaList = [];

  void adicionarConta(Conta conta) {
    DbUtil.insereDados('conta', conta.toMap());
  }

  Future<List> getAllContas() async {
    final dataList = await DbUtil.getDados('conta');
    _contaList = dataList.map((contas) => Conta.fromMap(contas)).toList();
    return _contaList;
  }

  Future<Conta> getConta(int id) async {
    String whereString = "id = ?";
    List<dynamic> whereArgs = [id];
    final dataList = await DbUtil.getDataWhere('conta', whereString, whereArgs);
    return Conta.fromMap(dataList.first);
  }

  void atualizaValorConta(int? id, double custo, String tipoOperacao) {
    String sql;
    if(tipoOperacao == 'entrada') {
      sql = "UPDATE conta SET valor = valor + ? where id = ?";
    } else {
      sql = "UPDATE conta SET valor = valor - ? where id = ?";
    }
    List<dynamic> args = [custo, id];
    DbUtil.executaSQL(sql, args);
  }

}