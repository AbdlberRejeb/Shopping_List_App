import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';
class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  var _entedredName = '';
  var _enteredQuantity = 1;
  var _selectedCategory = categories[Categories.vegetables]!;

  void _saveItem(){
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
    Navigator.of(context).pop(GroceryItem(id: DateTime.now.toString(), name: _entedredName, quantity: _enteredQuantity, category: _selectedCategory));
    }
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
      title:Text('Add New Item')
      ),
      body:Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child:Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  label: Text('Name'),               
                ),
                maxLength:50,
                validator: (value) {
                  if(
                  value== null || value.isEmpty || 
                  value.trim().length <=1 || 
                  value.trim().length > 50){
                    return 'Must be between 1 and 50 character';
                  }
                  return null;
                 
                } ,
                 onSaved: (value){
                  _entedredName = value!;
                 },
              ),
               Row(
                crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: '1',
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text('Quantity'),
                      
                    ),
                    validator: (value) {
                  if(
                  value== null || value.isEmpty || 
                  int.tryParse(value)== null || 
                  int.tryParse(value)!<=0){
                    return 'Must be positive valid input';
                  }
                  return null;
                } ,
                onSaved: (value){
                  _enteredQuantity = int.parse(value!);
                },
                  )
                ),
                SizedBox( width: 8,),
                Expanded(
                  child: DropdownButtonFormField(
                    initialValue: _selectedCategory,
                    items: [
                      for(final category in categories.entries)
                        DropdownMenuItem(
                          value: category.value,
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                color: category.value.color,
                              ),
                              SizedBox(width: 8,),
                              Text(category.value.title)
                            ],
                          )
                        
                        )
                      
                      ], 
                      onChanged: (value){
                        setState(() {
                          _selectedCategory = value!;
                        });
                      }
                    )
                  )
            ],
            ),
            const SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: (){
                  _formKey.currentState!.reset();
                }, child: Text('Reset')),
                ElevatedButton(onPressed: _saveItem, child: Text('Add Item'))
              ],
            )
            ],
           
          )
        ),
        )

      );
    
  }
}