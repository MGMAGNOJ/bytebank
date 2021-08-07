import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        theme: ThemeData(
            brightness: Brightness.dark, primaryColor: Colors.blueGrey),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('MaterialApp Theme'),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: null,
          ),
          body: ListaDePagamentos(),
        ),
      ),
    );

class ListaDePagamentos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        ItemTransferencia(Transferencia(111, 1000)),
        ItemTransferencia(Transferencia(200, 2000)),
      ],
    );
  }
}

class ItemTransferencia extends StatelessWidget {

  final Transferencia _transferencia;
  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(Icons.account_balance_outlined),
      title: Text(this._transferencia.valor.toString()),
      subtitle: Text(this._transferencia.conta.toString()),
    ));
  }
}

class Transferencia {

  final double valor;
  final int conta;

  Transferencia(this.valor, this.conta);

}
