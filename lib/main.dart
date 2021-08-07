import 'package:flutter/material.dart';

void main() => runApp(
      Column(
        children: const <Widget>[
          Text('', textDirection: TextDirection.ltr),
          Text('Deliver features faster', textDirection: TextDirection.ltr),
          Expanded(
            child: FittedBox(
              fit: BoxFit.contain, // otherwise the logo will be tiny
              child: const FlutterLogo(),
            ),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.contain, // otherwise the logo will be tiny
              child: FlutterLogo(),
            ),
          ),
          Text(
            'Craft beautiful UIs',
            textDirection: TextDirection.ltr,
          ),
        ],
      ),
    );
