import 'dart:io';

class Produto {
  int codigoProduto;
  double precoUnitario;
  bool disponivel;
  int quantidadeVendida;

  Produto({
    required this.codigoProduto,
    required this.precoUnitario,
    this.disponivel = true,
    this.quantidadeVendida = 0,
  });
}

void main() {
  final List<Produto> produtos = [
    Produto(codigoProduto: 1001, precoUnitario: 5.32),
    Produto(codigoProduto: 1324, precoUnitario: 6.45),
    Produto(codigoProduto: 6548, precoUnitario: 2.37),
    Produto(codigoProduto: 987, precoUnitario: 5.32),
    Produto(codigoProduto: 7623, precoUnitario: 6.45),
  ];

  print('=== SISTEMA DE CONTROLE DE VENDAS ===');

  String? op = "";

  do {
    exibirMenu();
    op = stdin.readLineSync();

    switch (op) {
      case "1":
        cadastrarProduto(produtos);
        break;
      case "2":
        listarProdutos(produtos);
        break;
      case "3":
        informarQuantidade(produtos);
        break;
      case "4":
        gerarRelatorio(produtos);
        break;
      case "5":
        print("Saindo do programa...");
        break;
      default:
        print('Opção inválida! Tente novamente.\n');
        break;
    }
  } while (op != "5");
}

void exibirMenu() {
  print('------------------------------------');
  print('1. Cadastrar novo produto');
  print('2. Listar produtos cadastrados');
  print('3. Informar quantidade vendida');
  print('4. Gerar relatório de vendas');
  print('5. Sair');
  stdout.write('Escolha uma opção: ');
}

void cadastrarProduto(List<Produto> produtos) {
  try {
    print("\n---- Cadastro de Produto ----");
    stdout.write('Código do Produto: ');
    int codigoProduto = int.parse(stdin.readLineSync()!);

    stdout.write('Preço unitário: ');
    double precoUnitario = double.parse(stdin.readLineSync()!);

    produtos.add(Produto(codigoProduto: codigoProduto, precoUnitario: precoUnitario));
    print("Produto cadastrado com sucesso!");
  } catch (e) {
    print("[ERRO]: Não foi possível cadastrar o produto! Dados inválidos.");
  }
}

void listarProdutos(List<Produto> produtos) {
  if (produtos.isEmpty) {
    print("\nNenhum produto cadastrado.");
    return;
  }
  print("\n---- Lista de Produtos ----");
  for (var i = 0; i < produtos.length; i++) {
    Produto p = produtos[i];
    print("Item ${i + 1} | Código: ${p.codigoProduto} | Preço: R\$ ${p.precoUnitario.toStringAsFixed(2)} | Qtd Vendida: ${p.quantidadeVendida} | Disponivel: ${p.disponivel}");
  }
}

void informarQuantidade(List<Produto> produtos) {
  if (produtos.isEmpty) {
    print("\nNenhum produto disponível para registrar vendas.");
    return;
  }

  print("\n---- Informar Quantidade Vendida ----");
  for (Produto produto in produtos) {
    int quantidade = -1;

    while (quantidade < 0) {
      try {
        stdout.write('Insira a quantidade vendida do produto [Código ${produto.codigoProduto}]: ');
        quantidade = int.parse(stdin.readLineSync()!);

        if (quantidade >= 0) {
          produto.quantidadeVendida = quantidade;
          produto.disponivel = false;
        } else {
          print("[ERRO]: Inválido! Não é permitido valores negativos. Tente novamente.");
        }
      } catch (e) {
        print("[ERRO]: Entrada inválida. Digite um número inteiro.");
        quantidade = -1;
      }
    }
  }
  print("Todas as quantidades foram registradas com sucesso!");
}

void gerarRelatorio(List<Produto> produtos) {
  if (produtos.isEmpty) {
    print("\nNão há dados para gerar o relatório.");
    return;
  }

  int totalItensVendidos = 0;
  double valorTotalLoja = 0.0;
  Produto produtoMaisVendido = produtos.first;

  print("\n==============================================");
  print("            RELATÓRIO DE VENDAS               ");
  print("==============================================");
  print("Cód. Prod | Preço Unit. | Qtd Vendida | Total");
  print("----------------------------------------------");

  for (Produto produto in produtos) {
    double totalProduto = produto.quantidadeVendida * produto.precoUnitario;
    
    totalItensVendidos += produto.quantidadeVendida;
    valorTotalLoja += totalProduto;

    if (produto.quantidadeVendida > produtoMaisVendido.quantidadeVendida) {
      produtoMaisVendido = produto;
    }

    print("${produto.codigoProduto.toString().padRight(9)} | "
          "R\$ ${produto.precoUnitario.toStringAsFixed(2).padRight(8)} | "
          "${produto.quantidadeVendida.toString().padRight(11)} | "
          "R\$ ${totalProduto.toStringAsFixed(2)}");
  }

  double ticketMedio = totalItensVendidos > 0 ? valorTotalLoja / produtos.length : 0.0;

  print("----------------------------------------------");
  print("Quantidade total de itens vendidos: $totalItensVendidos");
  print("Valor total arrecadado pela loja: R\$ ${valorTotalLoja.toStringAsFixed(2)}");
  print("Produto mais vendido: Código ${produtoMaisVendido.codigoProduto} (${produtoMaisVendido.quantidadeVendida} unidades)");
  print("Ticket médio por produto cadastrado: R\$ ${ticketMedio.toStringAsFixed(2)}");
  print("==============================================\n");
}