// ignore_for_file: unnecessary_brace_in_string_interps

class Contact {
  final int? id;
  final String name;
  final int? accountNumber;

  Contact(this.id, this.name, this.accountNumber);

  @override
  String toString() {
    return 'Se lascar ${name} ${accountNumber} ${id}';
  }
}
