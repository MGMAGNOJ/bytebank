import 'package:bytebank/screens/lista_transferencia.dart';
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
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.green.shade900,
        accentColor: Colors.blueAccent.shade700,
        // Falta descobrir como é o tema do Botão
      ),

      //ThemeData.dark(),
      home: ListaDePagamentos(),
    );
  }
}









