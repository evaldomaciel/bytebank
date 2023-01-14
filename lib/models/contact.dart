// ignore_for_file: unnecessary_brace_in_string_interps

class Contact {
  final int? id;
  final String nome;
  final int? numeroDaConta;

  Contact(this.id, this.nome, this.numeroDaConta);

  @override
  String toString() {
    return 'Se lascar ${nome} ${numeroDaConta} ${id}';
  }
}
