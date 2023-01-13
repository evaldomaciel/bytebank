class Contact {
  final String nome;
  final int? numeroDaConta;

  Contact(
    this.nome,
    this.numeroDaConta
  );

  @override
  String toString(){
    return 'Se lascar ${nome} ${numeroDaConta}';
  }

}