// Formulario que efetua a coleta dos valores e confirma a transferencia.

import 'package:bytebank/coponents/editor.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

class FormularioTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //Retorna o Estado do Formulario para manter os dados.
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
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
      body: SingleChildScrollView(
        child: Column(
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
