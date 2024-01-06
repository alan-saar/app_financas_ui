import 'package:app_financas_ui/models/conta.dart';
import 'package:app_financas_ui/utils/db_utils.dart';

class ContaService {

  void adicionarConta(Conta conta) {
    DbUtil.insereDados('conta', conta.toMap());
  }

}