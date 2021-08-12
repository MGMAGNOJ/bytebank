
// Classe que efetua o processamento e retorna uma string.
class Transferencia {
  final double valor;
  final int conta;

  Transferencia(this.valor, this.conta);

  @override
  String toString() {
    return 'Transferencia: {valor: $valor, conta: $conta}';
  }
}