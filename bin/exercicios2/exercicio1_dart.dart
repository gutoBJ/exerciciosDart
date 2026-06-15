import 'dart:io';

void main() {
  final List<double> mediasAlunos = [];
  bool continuar = true;

  print('=== SISTEMA DE CLASSIFICAÇÃO DE ALUNOS ===');

  while (continuar) {
    exibirMenu();
    final String? opcao = stdin.readLineSync();

    switch (opcao) {
      case '1':
        inserirMedia(mediasAlunos);
        break;
      case '2':
        gerarResumo(mediasAlunos);
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

void exibirMenu() {
  print('------------------------------------');
  print('1. Inserir nova média');
  print('2. Exibir resumo e conceitos');
  print('3. Sair');
  stdout.write('Escolha uma opção: ');
}

void inserirMedia(List<double> mediasAlunos) {
  stdout.write('Digite a média final do aluno: ');
  final String? entrada = stdin.readLineSync();

  if (entrada == null || entrada.isEmpty) return;

  final double? nota = double.tryParse(entrada.replaceAll(',', '.'));
  
  if (nota != null) {
    mediasAlunos.add(nota);
    print('Média $nota adicionada com sucesso!\n');
  } else {
    print('Erro: Por favor, digite um número válido.\n');
  }
}

String converterMediaParaConceito(double media) {
  if (media < 0.0 || media > 10.0) return 'Inválido';
  if (media >= 9.0) return 'A';
  if (media >= 7.0) return 'B';
  if (media >= 5.0) return 'C';
  return 'D';
}

void gerarResumo(List<double> listaDeMedias) {
  if (listaDeMedias.isEmpty) {
    print('Nenhuma média foi cadastrada ainda.\n');
    return;
  }

  int totalA = 0;
  int totalB = 0;
  int totalC = 0;
  int totalD = 0;
  int totalInvalidas = 0;

  for (final media in listaDeMedias) {
    switch (converterMediaParaConceito(media)) {
      case 'A': totalA++; break;
      case 'B': totalB++; break;
      case 'C': totalC++; break;
      case 'D': totalD++; break;
      default: totalInvalidas++;
    }
  }

  print('\n====================================');
  print('          RESUMO PARCIAL            ');
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