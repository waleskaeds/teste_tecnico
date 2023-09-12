import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_tecnico/model/produto.dart';
import 'package:teste_tecnico/providers/product_provider.dart';

class DialogConfirmDelete extends StatefulWidget {
  final Product product;
  const DialogConfirmDelete({super.key, required this.product});

  @override
  State<DialogConfirmDelete> createState() => _DialogConfirmDeleteState();
}

class _DialogConfirmDeleteState extends State<DialogConfirmDelete> {

  delete(){
    Provider.of<ProductProvider>(context, listen: false).
      removeProduct(widget.product, context);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15),
          const Text(
            "Deseja excluir este produto?",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Text(widget.product.nome)
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: const Text('Cancelar')
        ),
        TextButton(
          onPressed: () => delete(), 
          child: const Text('Sim, excluir')
        ),
      ],
    );
  }
}