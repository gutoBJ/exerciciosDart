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
  String op = "";
  List<Colaborador> colaboradores = []; 

  do {
    menu();
    op = stdin.readLineSync()!.toUpperCase();

    print('');

    switch (op) {
      case '1':
        try {
          Colaborador c = cadastrarFuncionario();
          colaboradores.add(c);
          print('Funcionário cadastrado com sucesso!');
        } catch (e) {
          print('[ERRO] Erro ao cadastrar funcionário: $e');
        }
        break;

      case '2':
        print('=== EXIBIR FUNCIONARIOS ===');
        if (colaboradores.isEmpty) {
          print('Nenhum funcionário cadastrado.');
        } else {
          for (var colab in colaboradores) {
            colab.consultarDados();
          }
        }
        break;

      case '3':
        print('=== AUMENTO PARA FUNCIONARIO ===');
        if (colaboradores.isEmpty) {
          print('Nenhum funcionário disponível para aumento.');
          break;
        }

        stdout.write('Pesquisar funcionário pelo nome: ');
        String nomePesquisa = stdin.readLineSync()!;
        
        Colaborador? funcionarioEncontrado;
        try {
          funcionarioEncontrado = colaboradores.firstWhere(
            (colab) => colab.nome.toUpperCase() == nomePesquisa.toUpperCase()
          );
        } catch (e) {
          funcionarioEncontrado = null; // Caso não encontre nenhum
        }

        // Validação do resultado da busca
        if (funcionarioEncontrado == null) {
          print('[ERRO]: Funcionário não encontrado.');
          break;
        }

        try {
          stdout.write("Insira o aumento em percentual para ${funcionarioEncontrado.nome}: ");
          double aumento = double.parse(stdin.readLineSync()!);
          
          funcionarioEncontrado.aumento(aumento);
          print('Aumento aplicado com sucesso!');
        } catch (e) {
          print('[ERRO]: Digite um valor numérico válido para o aumento.');
        }
        break;

      case 'S':
        print('Saindo do programa... ');
        print('');
        break;

      default:
        print('[ERRO]: Opção inválida.');
        break;
    }
  } while (op != "S");
}

void menu() {
  print('');
  print('-----------------------------------------');
  print('=== SISTEMA DE GESTAO DE FUNCIONARIOS ===');
  print('1. Cadastrar novo funcionário');
  print('2. Exibir informações dos funcionários');
  print('3. Acrescentar aumento');
  print('S. Sair');
  stdout.write('Escolha uma opção: ');
}

Colaborador cadastrarFuncionario() {
  print("=== CADASTRAR FUNCIONARIO ===");
  stdout.write("Insira o nome do funcionário: ");
  String nome = stdin.readLineSync()!;
  stdout.write("Insira o salário do funcionário: ");
  double salario = double.parse(stdin.readLineSync()!);
  return Colaborador(nome, salario);
}