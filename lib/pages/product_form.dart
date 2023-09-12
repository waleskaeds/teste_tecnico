import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_tecnico/model/produto.dart';
import 'package:teste_tecnico/providers/product_provider.dart';

class ProductForm extends StatefulWidget {
  final Product? product;
  const ProductForm({super.key, this.product});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, dynamic>{};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(_formData.isEmpty){
      if(widget.product != null){
      _formData['id'] = widget.product!.id;
      _formData['nome'] = widget.product!.nome;
      _formData['material'] = widget.product!.material;
      _formData['preco'] = widget.product!.preco;
      _formData['url'] = widget.product!.url;
    }
    }
  }

  void submit(){
    final isValid = _formKey.currentState?.validate() ?? false;
    if(!isValid) return;
    _formKey.currentState?.save();
    
    if(widget.product != null) _formData['id'] = widget.product!.id;

    if(_formData['id'] == null){
      Provider.of<ProductProvider>(context, listen: false)
        .addProduct(context, _formData);
    } else {
      Provider.of<ProductProvider>(context, listen: false)
        .editProduct(context, _formData);
    }
    Navigator.pop(context);
  }

  String? validator(dynamic value){
    if (value == "" || value == null || value.toString().isEmpty) {
      return "Insira um valor válido";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product != null
          ?"Editar Produto"
          :"Adicionar Produto"
        )
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _formData['nome'],
                    textInputAction: TextInputAction.next,
                    onSaved: (value) => _formData['nome'] = value,
                    validator: (value) => validator(value),
                    decoration: const InputDecoration(
                      labelText: 'Nome do produto'
                    ),
                  ),
                  TextFormField(
                    initialValue: _formData['material'],
                    textInputAction: TextInputAction.next,
                    onSaved: (value) => _formData['material'] = value,
                    validator: (value) => validator(value),
                    decoration: const InputDecoration(
                      labelText: 'Material'
                    ),
                  ),
                  TextFormField(
                    initialValue: _formData['preco'].toString(),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _formData['preco'] = value,
                    validator: (value) => validator(value),
                    decoration: const InputDecoration(
                      labelText: 'Preço'
                    ),
                  ),
                  TextFormField(
                    initialValue: _formData['url'],
                    textInputAction: TextInputAction.done,
                    onSaved: (value) => _formData['url'] = value,
                    validator: (value) => validator(value),
                    decoration: const InputDecoration(
                      labelText: 'Url da imagem'
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: (){
                submit();
              }, 
              child: const Text("Salvar")
            ),
          )
        ],
      ),
    );
  }
}