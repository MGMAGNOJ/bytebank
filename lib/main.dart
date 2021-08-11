import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Chamada da função principal
// Este formato => é um formato reduzido de chamada.
//void main() => runApp(ByteBankApp());
// Formato Tradicional
void main() {
  runApp(ByteBankApp());
}

// Classe da função principal
class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(brightness: Brightness.dark, primaryColor: Colors.blueGrey),
      home: Scaffold(
        body: ListaDePagamentos(),
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
          Editor(
              controlador: _controllerConta,
              rotulo: "Conta",
              dica: "0000",
              icone: Icons.account_balance),
          Editor(
              controlador: _controllerValor,
              rotulo: "Valor",
              dica: "00.00",
              icone: Icons.monetization_on),
          ElevatedButton(
            style: style,
            onPressed: () {
              _criaTransferencia(context);
            },
            child: const Text('Efetuar Transação'),
          ),
        ],
      ),
    );
  }

  // Metodo que processa os dados
  void _criaTransferencia(BuildContext context) {
    debugPrint("Passei");
    final int? nConta = int.tryParse(_controllerConta.text);
    final double? nValor = double.tryParse(_controllerValor.text);
    if (nConta != null && nValor != null) {
      final transfCriada = Transferencia(nValor, nConta);
      debugPrint('Criando a Transferencia');
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
      Navigator.pop(context, transfCriada);
    }
  }
}

// Classe do campo texto
class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final IconData icone;
  final String rotulo;
  final String dica;

  const Editor(
      {required this.controlador,
      required this.rotulo,
      required this.dica,
      required this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      child: TextField(
        controller: controlador,
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          //  Testar nulo em um parametro
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
      ),
    );
  }
}

// Classe que lista os pagamentos efetuados no app
class ListaDePagamentos extends StatefulWidget {
  final List<Transferencia> _transferencias = [];

  @override
  State<StatefulWidget> createState() {
    return ListaDePagamentosState();
  }
}

class ListaDePagamentosState extends State<ListaDePagamentos> {
  @override
  Widget build(BuildContext context) {
    debugPrint("Passei no inicio do Build");
    widget._transferencias.add(Transferencia(22, 23232));
    return Scaffold(
      // Barra de Titulo
      appBar: AppBar(
        title: const Text('MaterialApp Theme'),
      ),

      // Constroi a lista dinamica de pagamentos

      body: ListView.builder(

        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {

          final transferencia = widget._transferencias[indice];
          debugPrint("Constroi a lista");
          return ItemTransferencia(transferencia);
        },
      ),

      // Botão flutuante de rodape
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Codigo que faz a navegação para o formulario
          final Future future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));
          // Faz o tratamento do Retorno
          future.then((transfCriada) {
            debugPrint("Chegou no then do future");
            debugPrint('$transfCriada');
            widget._transferencias.add(transfCriada);
            debugPrint("Devia ter atualizado a lista");
          });
        },
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
