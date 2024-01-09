import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'detail.dart';

void main() {
  runApp(MyApp());
}

class Product {
  final int id;
  final String name;
  final String price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Product List'),
        ),
        body: Products(),
      ),
    );
  }
}

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List<Product> products = [];
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    fetchProducts();
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  Future<void> fetchProducts() async {
    try {
      final response =
      await http.get(Uri.parse('https://nyeinchanava.com/wp-json/wc/v3/products'));

      if (response.statusCode == 200 && _isMounted) {
        final List<dynamic> data = json.decode(response.body);
        products = data.map((item) {
          return Product(
            id: item["id"],
            name: item['name'],
            price: item['price'] ?? '',
            imageUrl: item['images'][0]['src'],
          );
        }).toList();

        if (_isMounted) {
          setState(() {});
        }
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching products: $error');
      // Handle error gracefully
    }
  }

  Future<void> _refresh() async {
    try {
      // Simulate fetching new data
      await Future.delayed(Duration(seconds: 2));
      await fetchProducts();
    } catch (error) {
      print('Error refreshing products: $error');
      // Handle error gracefully
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductItem(product: products[index]);
        },
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailProduct(id: product.id),
            ),
          );
        },
        child: Card(
          elevation: 2,
          child: Container(
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  height: 110,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                SizedBox(height: 8),
                Text(
                  product.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13),
                ),
                SizedBox(height: 8),
                Text(
                  product.price != null && product.price.isNotEmpty
                      ? '${product.price} Ks'
                      : 'Price not available',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: product.price != null && product.price.isNotEmpty
                        ? Colors.black
                        : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

