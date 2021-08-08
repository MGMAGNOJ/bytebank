import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(ByteBankApp());

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(brightness: Brightness.dark, primaryColor: Colors.blueGrey),
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {

  final TextEditingController _ControllerConta = TextEditingController();
  final TextEditingController _ControllerValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferencia'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            child: TextField(
              controller: _ControllerConta,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 24.0),
              decoration: InputDecoration(
                labelText: 'Conta Corrente',
                hintText: '0000',
              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            child: TextField(
              controller: _ControllerValor,
              style: TextStyle(fontSize: 24.0),
              decoration: InputDecoration(
                icon: Icon(Icons.monetization_on),
                labelText: 'Valor',
                hintText: '000.0',
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: style,
            onPressed: () {
              debugPrint("Passei");
              final int? NConta = int.tryParse(_ControllerConta.text);
              final double? NValor = double.tryParse(_ControllerValor.text);
              if (NConta != null && NValor != null){
                final TransfCriada = Transferencia(NValor, NConta);
                debugPrint('$TransfCriada.toString' );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Transferencia em processamento!'),
/*                    action: SnackBarAction(
                      label: 'Ocultar',
                      onPressed: () {
                        // Code to execute.
                      },
                    ),*/
                  ),
                );
              }
            },
            child: const Text('Efetuar Transação'),
          ),
        ],
      ),
    );
  }
}

class ListaDePagamentos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MaterialApp Theme'),
      ),
      body: Column(
        children: [
          ItemTransferencia(Transferencia(111.0, 1000)),
          ItemTransferencia(Transferencia(200.2, 2000)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: null,
      ),
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

  @override
  String toString() {
    return 'Transferencia{valor: $valor, conta: $conta}';
  }
}
