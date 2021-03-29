import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  static const routeName = 'resultado';

  @override
  Widget build(BuildContext context) {
    final resultados =
        ModalRoute.of(context).settings.arguments as Map<String, double>;
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Valor total da conta: ' +
                  resultados['precoTotal'].toStringAsFixed(2),
              style: TextStyle(fontSize: 32),
            ),
            Text(''),
            Text(
              'Valor para o garçom: ' +
                  resultados['precoGarcom'].toStringAsFixed(2),
              style: TextStyle(fontSize: 32),
            ),
            Text(''),
            Text(
              'Preço para quem não bebeu: R\$' +
                  resultados['precoIndividual'].toStringAsFixed(2),
              style: TextStyle(fontSize: 32),
            ),
            Text(''),
            if (resultados['precoAlcool'].toInt() != 0)
              Text(
                'Preço para quem bebeu: R\$' +
                    resultados['precoAlcool'].toStringAsFixed(2),
                style: TextStyle(fontSize: 32),
              )
          ],
        ),
      ),
    );
  }
}
