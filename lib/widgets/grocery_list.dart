import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';
class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {

  final List<GroceryItem> _groceryItems = [];
 void _addItem() async{
    
     final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (ctx)=> NewItem())
    );
  if(newItem ==null){
    return;
  }
  setState(() {
    _groceryItems.add(newItem);
  });
 }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No Item Added Yet'),);
    if(_groceryItems.isNotEmpty){
      content = ListView.builder(
          itemCount: _groceryItems.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: ValueKey(_groceryItems[index].id),
              onDismissed: (direction) {
              setState(() {
                _groceryItems.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(' dismissed')),
              );
              },
              background: Container(
                color: Colors.red,
                
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),

                child: const Icon(Icons.delete),),
                
              child: ListTile(
                title: Text(_groceryItems[index].name),
                leading:Container(
                  width: 25,
                  height: 25,
                  color: _groceryItems[index].category.color,
              
                ),
                trailing: Text(_groceryItems[index].quantity.toString()),
                ),
                
            );
          },
        );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries List'),
        actions: [
          IconButton(
            onPressed:_addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content
      
    );
  }
}
