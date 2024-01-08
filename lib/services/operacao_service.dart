import 'package:app_financas_ui/models/operacao.dart';
import 'package:app_financas_ui/utils/db_utils.dart';

class OperacaoService {

  List<Operacao> _operacaoList = [];

  void addOperacao(Operacao operacao) {
    DbUtil.insereDados("operacao", operacao.toMap());
  }

  Future<List> getAllOperacoes() async{
    final dataList = await DbUtil.getDados('operacao');
    _operacaoList = dataList.map((operacoes) => Operacao.fromMap(operacoes)).toList();
    return _operacaoList;
  }

  Future<List> getOperacoesConta(int contaId) async {
    String whereString = "conta = ?";
    List<dynamic> whereArgs = [contaId];
    final dataList = await DbUtil.getDataWhere('operacao', whereString, whereArgs);
    return dataList.map((operacoes) => Operacao.fromMap(operacoes)).toList();
  }
}