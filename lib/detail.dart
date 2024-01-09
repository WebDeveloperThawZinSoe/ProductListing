import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailProduct extends StatefulWidget {
  final int id;

  const DetailProduct({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  late Product product;
  bool _isMounted = false;
  late List<Product> similarProducts;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    similarProducts = [];
    fetchProductDetails();
    fetchSimilarProducts();
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  Future<void> fetchProductDetails() async {
    try {
      final response = await http.get(Uri.parse('https://nyeinchanava.com/wp-json/wc/v3/products/${widget.id}'));

      if (response.statusCode == 200 && _isMounted) {
        final dynamic data = json.decode(response.body);
        product = Product(
          id: data["id"],
          name: data['name'],
          price: data['price'] ?? '',
          imageUrl: data['images'][0]['src'],
          postLink: data["permalink"],
          category_id: data["categories"][0]["id"],
          category_name: data["categories"][0]["name"],
          short_description: data["short_description"],
        );

        if (_isMounted) {
          setState(() {});
        }
      } else {
        throw Exception('Failed to load product details: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching product details: $error');
      // Handle error gracefully
    }
  }



  void _launchWebsite() async {
    if (await canLaunch(product.postLink)) {
      await launch(product.postLink);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Could not launch ${product.postLink}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
  void _launchFacebook() async {
    if (await canLaunch("https://www.facebook.com/nyeinchanava.tech")) {
      await launch("https://www.facebook.com/nyeinchanava.tech");
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Could not launch Facebook'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
  void _launchMessanger() async {
    if (await canLaunch("https://m.me/nyeinchanava.tech")) {
      await launch("https://m.me/nyeinchanava.tech");
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Could not launch Messanger'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product Detail",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: _isMounted
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Image.network(
                product.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                product.name,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                product.price.isNotEmpty ? 'Price: ${product.price} Ks' : 'Price not available',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: product.price.isNotEmpty ? Colors.black : Colors.red,
                  fontSize: 17,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                product.price.isNotEmpty
                    ? 'Category: ${product.category_name} '
                    : 'Price not available',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: product.price.isNotEmpty ? Colors.black : Colors.red,
                  fontSize: 17,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Html(
                data: product.short_description,
                style: {
                  'p': Style(fontSize: FontSize(16.0), fontWeight: FontWeight.normal),
                  // Add more styles as needed
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.language),
                      onPressed: _launchWebsite,
                      label: Text("View On Website"),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.phone),
                      onPressed: () {
                        // Implement your "Buy Now" logic here
                        launch("tel://09962008826");
                      },
                      label: Text("Buy Now"),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.tag_faces),
                      onPressed: _launchFacebook,
                      label: Text("Go To Facebook"),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.message),
                      onPressed: () {
                        // Implement your "Buy Now" logic here
                        _launchMessanger();
                      },
                      label: Text("Messanger"),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Center(
                child: Text(
                  "Similar Products",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Display similar products using ListView.builder
            similarProducts.isNotEmpty
                ? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: similarProducts.length,
              itemBuilder: (context, index) {
                final similarProduct = similarProducts[index];
                return ListTile(
                  title: Text(similarProduct.name),
                  subtitle: Text(
                    similarProduct.price.isNotEmpty
                        ? 'Price: ${similarProduct.price} Ks'
                        : 'Price not available',
                  ),
                  onTap: () {
                    // Handle similar product tap, e.g., navigate to its details screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailProduct(id: similarProduct.id),
                      ),
                    );
                  },
                );
              },
            )
                : Center(
              child: Text("No similar products found."),
            ),
          ],
        )
            : Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Future<void> fetchSimilarProducts() async {
    try {
      final responseCategory = await http.get(
        Uri.parse('https://nyeinchanava.com/wp-json/wc/v3/products?category=${product.category_id}'),
      );

      if (responseCategory.statusCode == 200 && _isMounted) {
        final List<dynamic> data = json.decode(responseCategory.body);
        similarProducts = data.map((item) {
          return Product(
            id: item["id"],
            name: item['name'],
            price: item['price'] ?? '',
            imageUrl: item['images'][0]['src'],
            postLink: item["permalink"],
            category_id: item["categories"][0]["id"],
            category_name: item["categories"][0]["name"],
            short_description: item["short_description"],
          );
        }).toList();

        if (_isMounted) {
          setState(() {});
        }
      } else {
        throw Exception('Failed to load similar products: ${responseCategory.statusCode}');
      }
    } catch (error) {
      print('Error fetching similar products: $error');
      // Handle error gracefully
    }
  }
}

class Product {
  final int id;
  final String name;
  final String price;
  final String imageUrl;
  final String postLink;
  final String category_name;
  final String short_description;
  final int category_id;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.postLink,
    required this.category_name,
    required this.short_description,
    required this.category_id,
  });
}
