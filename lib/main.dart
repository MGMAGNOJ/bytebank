import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Chamada da função principal
// Este formato => é um formato reduzido de chamada.
void main() => runApp(ByteBankApp());

// Classe da função principal
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

// Formulario que efetua a coleta dos valores e confirma a transferencia.
class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controllerConta = TextEditingController();
  final TextEditingController _controllerValor = TextEditingController();

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
          Editor(_controllerConta, "Conta", "0000",Icons.account_balance),
          Editor(_controllerConta, "Valor", "00.00",Icons.monetization_on),

          ElevatedButton(
            style: style,
            onPressed: () {
              debugPrint("Passei");
              final int? nConta = int.tryParse(_controllerConta.text);
              final double? nValor = double.tryParse(_controllerValor.text);
              if (nConta != null && nValor != null) {
                final transfCriada = Transferencia(nValor, nConta);
                debugPrint('$transfCriada.toString');
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

// Classe do campo texto
class Editor extends StatelessWidget {

  final TextEditingController _controlador;
  final IconData _icone;
  final String _rotulo;
  final String _dica;

  const Editor(this._controlador, this._rotulo, this._dica, this._icone);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      child: TextField(
        controller: _controlador,
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: Icon(_icone),
          labelText: _rotulo,
          hintText: _dica,
        ),
      ),
    );
  }
}

// Classe que lista os pagamentos efetuados no app
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

// Representa um ítem a ser transferido.
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

// Classe que efetua o processamento e retorna uma string.
class Transferencia {
  final double valor;
  final int conta;

  Transferencia(this.valor, this.conta);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, conta: $conta}';
  }
}
