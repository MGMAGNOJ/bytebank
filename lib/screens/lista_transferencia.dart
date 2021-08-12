import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

import 'formulario_transferencia.dart';

class ListaDePagamentosState extends State<ListaDePagamentos> {
  @override
  Widget build(BuildContext context) {
    debugPrint("Passei no inicio do Build");
    // Para teste da lista
    // widget._transferencias.add(Transferencia(22, 23232));
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
            //debugPrint('$transfCriada');

            // Sempre é necessario verificar se o retorno não é nulo para o
            // caso de retorno pelo botao voltar.
            if (transfCriada != null) {
              setState(() {
                widget._transferencias.add(transfCriada);
                debugPrint("Atualiza a lista");
              });
            }
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
// Classe que lista os pagamentos efetuados no app
class ListaDePagamentos extends StatefulWidget {
  final List<Transferencia> _transferencias = [];

  @override
  State<StatefulWidget> createState() {
    return ListaDePagamentosState();
  }
}