import 'dart:io';

class Colaborador {
  String nome;
  double salario;

  Colaborador(this.nome, this.salario);

  void aumento(double aumento) {
    double percentual = aumento / 100;
    salario += salario * percentual;
  }

  void consultarDados() {
    print("O funcionário $nome tem salário de $salario reais.");
  }
}

void main() {
  stdout.write("Insira o nome do funcionário: ");
  String nome = stdin.readLineSync()!;

  stdout.write("Insira o salário do funcionário: ");
  double salario = double.parse(stdin.readLineSync()!);

  Colaborador c = Colaborador(nome, salario);

  c.consultarDados();

  print("Insira o aumento em percentual: ");
  double aumento = double.parse(stdin.readLineSync()!);

  c.aumento(aumento);

  c.consultarDados();
}
