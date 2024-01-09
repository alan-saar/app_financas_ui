import 'dart:convert';

import 'package:app_financas_ui/models/conta.dart';
import 'package:app_financas_ui/utils/rest_utils.dart';
import 'package:http/http.dart';

class ContaRestService {
  Future<void> addConta(Conta conta) async {
    final Response response = await RestUtil.addData('/contas', conta.toJson());
  }

  Future<List> getContas() async{
    final Response response =  await RestUtil.getData('/contas');
    List<dynamic> conteudo = jsonDecode(response.body);
    List<Conta> contas = conteudo.map((dynamic conta) => Conta.fromJson(conta)).toList();
    return contas;
  }

  Future<Conta> getContaId(String id) async{
    final Response response =  await RestUtil.getDataId('/contas', id);
    if(response.statusCode == 200) {
      return Conta.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Ocorreu um erro ao buscar a conta selecionada. Statuscode: ${response.statusCode}");
    }
  }

  Future<void> deleteConta(String id) async{
    final Response response =  await RestUtil.deleteDataId('/contas', id);
    if(response.statusCode == 204) {
      print('Conta removida');
    } else {
      throw Exception("Erro ao remover conta. Statuscode: ${response.statusCode}");
    }
  }
}