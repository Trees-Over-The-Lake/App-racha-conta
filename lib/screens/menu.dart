import 'package:flutter/material.dart';
import 'resultado.dart';

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
  int numPessoas = 1;
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
                  decoration: InputDecoration(
                      labelText: 'Número de pessoas para dividir a conta: '),
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
                    title: Text('Alguém bebendo?'),
                    onChanged: (value) {
                      setState(() {
                        ehAlcool = value;
                      });
                    }),
                if (ehAlcool) ...buildEhAlcoolTextFormField(),
                ElevatedButton(
                  onPressed: () => calcular(context),
                  child: Text('Calcular'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildEhAlcoolTextFormField() {
    return [
      Text('Número de pessoas bebendo:'),
      TextFormField(
        enabled: ehAlcool,
        initialValue: numPessoasBebendo.toString(),
        decoration: InputDecoration(border: OutlineInputBorder()),
        keyboardType: TextInputType.number,
        onSaved: (value) {
          numPessoasBebendo = int.parse(value);
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'O número de pessoas não pode ser vazio!';
          } else if (int.tryParse(value) == null) {
            return 'O valor precisa ser numérico!';
          }

          return null;
        },
      ),
      Text('Valor gasto pelas pessoas que estão bebendo:'),
      TextFormField(
        enabled: ehAlcool,
        initialValue: precoBebida.toStringAsFixed(2),
        decoration:
            InputDecoration(border: OutlineInputBorder(), prefix: Text('R\$')),
        keyboardType: TextInputType.number,
        onSaved: (value) {
          precoBebida = double.parse(value);
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'O valor da conta não pode ser vazio!';
          } else if (double.tryParse(value) == null) {
            return 'O valor precisa ser numérico!';
          }

          return null;
        },
      )
    ];
  }

  calcular(BuildContext context) {
    if (globalKey.currentState.validate()) {
      globalKey.currentState.save();

      if (numPessoasBebendo > numPessoas) {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Erro'),
                  content: Text(
                      'O número de pessoas bebendo não pode ser maior que o número total de pessoas!'),
                ));
        return;
      }

      if (precoTotal < precoBebida) {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Erro'),
                  content: Text(
                      'O preço das bebidas não pode ser superior ao preço do total da conta!'),
                ));
        return;
      }

      if (!ehAlcool) {
        numPessoasBebendo = 0;
        precoBebida = 0;
      }

      double valorGarcom = (porcentagemGarcom / 100) * precoTotal;
      precoTotal += valorGarcom;

      double precoIndividual = (precoTotal - precoBebida) / numPessoas;

      double precoAlcool = 0;
      if (numPessoasBebendo > 0)
        precoAlcool = precoIndividual + (precoBebida / numPessoasBebendo);

      Navigator.of(context).pushNamed(Resultado.routeName, arguments: {
        'precoIndividual': precoIndividual,
        'precoAlcool': precoAlcool
      });
    }
  }
}
