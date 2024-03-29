class Operacao {
  late int? id;
  late String nome, resumo, tipo, data;
  late int conta;
  late double custo;

  Operacao({
    this.id,
    required this.nome,
    required this.resumo,
    required this.tipo,
    required this.data,
    required this.conta,
    required this.custo
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'resumo': resumo,
      'tipo': tipo,
      'data': data,
      'conta': conta,
      'custo': custo,
    };
  }

  Operacao.fromMap(Map map) {
    id = map['id'];
    nome = map['nome'];
    resumo = map[ 'resumo'];
    tipo = map[ 'tipo'];
    data = map['data'];
    conta = map['conta'];
    custo = map['custo'];
  }
}