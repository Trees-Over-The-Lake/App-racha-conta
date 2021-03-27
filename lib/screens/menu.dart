import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  static const routeName = 'menu_principal';

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final GlobalKey<FormState> globalKey = GlobalKey();

  // Valores do programa
  double precoTotal = 0.0;
  double precoBebida = 0;
  double porcentagemGarcom = 10;
  int numPessoas = 0;
  int numPessoasBebendo = 0;
  bool ehAlcool = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu do Racha Conta'),
      ),
      body: Form(
        key: globalKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  initialValue: precoTotal.toStringAsFixed(2),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), prefix: Text('R\$')),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    precoTotal = double.parse(value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'O valor da conta não pode ser vazio!';
                    } else if (double.tryParse(value) == null) {
                      return 'O valor precisa ser numérico!';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  initialValue: numPessoas.toString(),
                  decoration: InputDecoration(labelText: 'Número de pessoas: '),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    numPessoas = int.parse(value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'O valor da conta não pode ser vazio!';
                    } else if (int.tryParse(value) == null) {
                      return 'O valor precisa ser um número inteiro!';
                    }

                    return null;
                  },
                ),
                Text('Porcetagem do garçom: ' +
                    porcentagemGarcom.toStringAsFixed(0) +
                    '%'),
                Slider(
                  value: porcentagemGarcom,
                  onChanged: (value) {
                    setState(() {
                      porcentagemGarcom = value;
                    });
                  },
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: porcentagemGarcom.toStringAsFixed(0),
                ),
                CheckboxListTile(
                    value: ehAlcool,
                    title: Text('É uma bebida alcoolica:'),
                    onChanged: (value) {
                      setState(() {
                        ehAlcool = value;
                      });
                    }),
                if (ehAlcool) buildEhAlcoolTextFormField()
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildEhAlcoolTextFormField() {
    TextFormField(
      initialValue: precoTotal.toStringAsFixed(2),
      decoration:
          InputDecoration(border: OutlineInputBorder(), prefix: Text('R\$')),
      keyboardType: TextInputType.number,
      onSaved: (value) {
        precoTotal = double.parse(value);
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'O valor da conta não pode ser vazio!';
        } else if (double.tryParse(value) == null) {
          return 'O valor precisa ser numérico!';
        }

        return null;
      },
    );

    TextFormField(
      initialValue: precoTotal.toStringAsFixed(2),
      decoration:
          InputDecoration(border: OutlineInputBorder(), prefix: Text('R\$')),
      keyboardType: TextInputType.number,
      onSaved: (value) {
        precoTotal = double.parse(value);
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'O valor da conta não pode ser vazio!';
        } else if (double.tryParse(value) == null) {
          return 'O valor precisa ser numérico!';
        }

        return null;
      },
    );
  }
}
