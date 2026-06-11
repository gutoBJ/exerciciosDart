import 'dart:io';

void main() {
  List<double> mediasAlunos = [];
  bool continuar = true;

  print('=== SISTEMA DE CLASSIFICAÇÃO DE ALUNOS ===');

  while (continuar) {
    exibirMenu();
    String? opcao = stdin.readLineSync();

    switch (opcao) {
      case '1':
        // Solicita a nota ao usuário
        stdout.write('Digite a média final do aluno: ');
        String? entrada = stdin.readLineSync();
        
        // Tenta converter a entrada de texto para double
        if (entrada != null && entrada.isNotEmpty) {
          double? nota = double.tryParse(entrada.replaceAll(',', '.')); // Aceita vírgula ou ponto
          
          if (nota != null) {
            mediasAlunos.add(nota);
            print('Média $nota adicionada com sucesso!\n');
          } else {
            print('Erro: Por favor, digite um número válido.\n');
          }
        }
        break;

      case '2':
        // Gera o relatório se houver notas na lista
        if (mediasAlunos.isEmpty) {
          print('Nenhuma média foi cadastrada ainda.\n');
        } else {
          gerarResumo(mediasAlunos);
        }
        break;

      case '3':
        print('Saindo do sistema. Até logo!');
        continuar = false;
        break;

      default:
        print('Opção inválida! Tente novamente.\n');
    }
  }
}

/// Função para exibir o menu de opções
void exibirMenu() {
  print('------------------------------------');
  print('1. Inserir nova média');
  print('2. Exibir resumo e conceitos');
  print('3. Sair');
  stdout.write('Escolha uma opção: ');
}

/// Função que recebe a média final e retorna o conceito correspondente.
String converterMediaParaConceito(double media) {
  if (media < 0.0 || media > 10.0) {
    return 'Inválido';
  }

  if (media >= 9.0) {
    return 'A';
  } else if (media >= 7.0) {
    return 'B';
  } else if (media >= 5.0) {
    return 'C';
  } else {
    return 'D';
  }
}

/// Função que processa a lista de médias e exibe o resumo final
void gerarResumo(List<double> listaDeMedias) {
  int totalA = 0;
  int totalB = 0;
  int totalC = 0;
  int totalD = 0;
  int totalInvalidas = 0;

  for (double media in listaDeMedias) {
    String conceito = converterMediaParaConceito(media);

    switch (conceito) {
      case 'A': totalA++; break;
      case 'B': totalB++; break;
      case 'C': totalC++; break;
      case 'D': totalD++; break;
      default: totalInvalidas++;
    }
  }

  print('\n====================================');
  print('          RESUMO PARCIAL              ');
  print('====================================');
  print('Total de notas digitadas: ${listaDeMedias.length}');
  print('------------------------------------');
  print('Alunos com Conceito A: $totalA');
  print('Alunos com Conceito B: $totalB');
  print('Alunos com Conceito C: $totalC');
  print('Alunos com Conceito D: $totalD');
  print('------------------------------------');
  print('Médias inválidas encontradas: $totalInvalidas');
  print('====================================\n');
}