import 'package:app_financas_ui/models/operacao.dart';
import 'package:app_financas_ui/utils/db_utils.dart';

class OperacaoService {

  void addOperacao(Operacao operacao) {
    DbUtil.insereDados("operacao", operacao.toMap());
  }
}