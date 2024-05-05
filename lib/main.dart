// ignore_for_file: use_key_in_widget_constructors, use_super_parameters, prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VapeStore',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VapeStoreHomePage(),
    );
  }
}

class VapeStoreHomePage extends StatefulWidget {
  VapeStoreHomePage({Key? key}) : super(key: key);

  @override
  _VapeStoreHomePageState createState() => _VapeStoreHomePageState();
}

class _VapeStoreHomePageState extends State<VapeStoreHomePage> {
  int _selectedIndex = 0;
  int _cartItemCount = 0;
  double _totalPrice = 0.0;

  // Fungsi untuk menambahkan item ke keranjang
  void _addToCart(double price) {
    setState(() {
      _cartItemCount++;
      _totalPrice += price;
    });
  }

  // Fungsi untuk navigasi ke halaman keranjang
  void _navigateToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CartPage(totalPrice: _totalPrice)),
    );
  }

  // Fungsi yang dipanggil saat item navigasi di tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _selectedIndex == 0 ? Text('VapeStore') : Text('Products'),
        actions: [
          // Menampilkan ikon keranjang belanja jika halaman utama yang dipilih
          if (_selectedIndex == 0)
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: _navigateToCart,
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$_cartItemCount',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
      // Tampilan utama bergantung pada indeks terpilih
      body: _selectedIndex == 0
          ? HomePage()
          : ProductsPage(addToCart: _addToCart),
      // Bottom navigation bar untuk navigasi antara tampilan utama dan produk
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Products',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Halaman utama dengan pesan selamat datang
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // Gambar latar belakang
        image: DecorationImage(
          image: AssetImage(
              'assets/background_image.jpeg'), // Ubah dengan path gambar latar belakang Anda
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Teks pesan selamat datang
            Text(
              'Welcome to TomVapeMaster',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Ubah warna teks sesuai kebutuhan
              ),
            ),
            SizedBox(height: 20),
            // Teks deskripsi
            Text(
              'Explore our collection of vaping products:',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white, // Ubah warna teks sesuai kebutuhan
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman produk dengan daftar produk
class ProductsPage extends StatelessWidget {
  final Function(double) addToCart;

  const ProductsPage({Key? key, required this.addToCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        _buildProductItem('Liquid 1', 95000, 'assets/product1.jpeg'),
        _buildProductItem('Liquid 2', 150000, 'assets/product2.jpeg'),
        _buildProductItem('Liquid 3', 95000, 'assets/product3.jpeg'),
        _buildProductItem('Oxva Slim SQ pro', 320000, 'assets/product4.jpeg'),
        _buildProductItem('Ursa Nano', 200000, 'assets/product5.jpeg'),
        _buildProductItem('catridge', 40000, 'assets/product6.jpeg'),
        _buildProductItem('Thelema Solo', 450000, 'assets/product7.jpeg'),
      ],
    );
  }

  // Fungsi untuk membangun item produk
  Widget _buildProductItem(String name, double price, String imagePath) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nama produk
            Text(
              name,
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 8.0),
            // Gambar produk
            Image.asset(
              imagePath,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8.0),
            // Harga produk
            Text(
              'Price: Rp. ${price.toStringAsFixed(0)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8.0),
            // Tombol "Add to Cart"
            ElevatedButton(
              onPressed: () => addToCart(price),
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman keranjang belanja dengan total harga
class CartPage extends StatelessWidget {
  final double totalPrice;

  const CartPage({Key? key, required this.totalPrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Total harga produk di keranjang
            Text(
              'Total Price: Rp. ${totalPrice.toStringAsFixed(0)}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            // Tombol kembali ke halaman utama
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Store'),
            ),
          ],
        ),
      ),
    );
  }
}
