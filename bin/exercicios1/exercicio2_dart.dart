import 'dart:io';

void main(List<String> arguments) {
  // Variável fortemente tipada como String
  String opcao;

  do {
    opcao = mostrarMenu();

    switch (opcao) {
      case "1":
        print("\n[OK] Refrigerante → 5,50 reais\n");
        break;
      case "2":
        print("\n[OK] Salgadinho → 6,20 reais\n");
        break;
      case "3":
        print("\n[OK] Chocolate → 8,70 reais\n");
        break;
      case "S":
        print("\nSaindo do programa...\n");
        break;
      default:
        print("\n[Aviso] Opção inválida. Tente novamente.\n");
        break;
    }

  } while (opcao != "S");
}

// A função garante o retorno de uma String limpa e em maiúscula
String mostrarMenu() {
  print("=================================");
  print("         MÁQUINA DE VENDAS        ");
  print(" 01 - Refrigerante → 5,50 reais");
  print(" 02 - Salgadinho → 6,20 reais");
  print(" 03 - Chocolate → 8,70 reais");
  print(" S - Sair");
  print("=================================");

  stdout.write("Escolha seu produto/opção: ");
  String entrada = stdin.readLineSync() ?? ""; 
  
  return entrada.trim().toUpperCase();
}