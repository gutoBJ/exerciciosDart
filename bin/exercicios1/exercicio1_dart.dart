// import 'package:exercicios_dart/exercicios_dart.dart' as exercicios_dart;
import 'dart:io';

void main(List<String> arguments) {
  stdout.write("Digite a quantidade de dias trabalhados: ");
  int quantDias = int.parse(stdin.readLineSync()!);

  double salarioDia = 800;

  double bruto = salarioDia * quantDias;

  double desconto = bruto * 0.15;

  double liquido = bruto - desconto;
  
  print('O valor do desconto é: $desconto');
  print('O valor bruto é: $bruto');
  print('O valor liquido do salario é: $liquido');
}
