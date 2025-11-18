import 'package:flutter/material.dart';
import 'package:pacil_store/models/product_entry.dart';
import 'package:pacil_store/widgets/left_drawer.dart';
import 'package:pacil_store/screens/product_detail.dart';
import 'package:pacil_store/widgets/product_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductEntryListPage extends StatefulWidget {
  final bool isMyProducts;
  const ProductEntryListPage({super.key, this.isMyProducts = false});

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  Future<List<ProductEntry>> fetchProduct(CookieRequest request) async {
    String url;

    if (widget.isMyProducts) {
      url = "http://localhost:8000/my-products-flutter/";
    } else {
      url = "http://localhost:8000/json/";
    }

    final response = await request.get(url);

    List<ProductEntry> listProduct = [];
    for (var d in response) {
      if (d != null) {
        listProduct.add(ProductEntry.fromJson(d));
      }
    }
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1B263B),      // Biru tua seperti Drawer
        surfaceTintColor: Colors.blue,     // Hilangkan efek M3
        iconTheme: const IconThemeData(
          color: Colors.white,             // Icon drawer putih
        ),
        title: const Text(
          'Product Entry List',
          style: TextStyle(
            color: Colors.white,           // Teks putih
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      drawer: const LeftDrawer(),

      body: FutureBuilder(
        future: fetchProduct(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    'There are no product in pacil store yet.',
                    style: TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => ProductEntryCard(
                  product: snapshot.data![index],
                  onTap: () {
                    // Navigate to product detail page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(
                          product: snapshot.data![index],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}
