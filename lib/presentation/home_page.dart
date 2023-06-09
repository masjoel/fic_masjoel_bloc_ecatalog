import 'package:fic_masjoel_ecatalog/bloc/products/products_bloc.dart';
import 'package:fic_masjoel_ecatalog/data/datasources/local_datasource.dart';
import 'package:fic_masjoel_ecatalog/presentation/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(GetProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        elevation: 5,
        actions: [
          IconButton(
            onPressed: () async {
              await LocalDataSource().removeToken();
              // ignore: use_build_context_synchronously
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const LoginPage();
              }));
            },
            icon: const Icon(Icons.logout),
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                    title: Text(state.data[index].title ?? '-'),
                    subtitle: Text('${state.data[index].price} \$'),
                  ));
                },
                itemCount: state.data.length,
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context){
            return AlertDialog(
              title: Text('Add Product'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(decoration: InputDecoration(labelText: 'Title'),),
                  TextField(decoration: InputDecoration(labelText: 'Price'),),
                  TextField(decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,),
                ],
              ),
              actions: [
                ElevatedButton(onPressed: (){}, child: Text('Cancel')),
                SizedBox(width: 8,),
                ElevatedButton(onPressed: (){}, child: Text('Add')),
              ],
            );
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
