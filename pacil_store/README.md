- Tugas 8 : 
  1. Baik Navigator.push() maupun Navigator.pushReplacement() sama-sama menambahkan halaman baru ke stack navigasi. Perbedaan keduanya terletak pada
     bagaimana cara mereka handle halaman sebelumnya. Untuk Navigator.push(), dia menambah halaman baru dan menyimpan halaman sebelumnya di bawah, menggunakan
     konsep stack. Biasa digunakan saat kita ingin user bisa kembali ke halaman sebelumnya menggunakan tombol back, seperti dari detail produk ke halaman daftar produk.
     Sedangkan Navigator.pushReplacement(), dia mengganti halaman sebelumnya dengan halaman baru. Jadi, halaman sebelumnya benar-benar dihapus dari stack navigasi sehingga
     user tidak bisa kembali ke halaman sebelumnya. Kita bisa menggunakan ini saat kita tidak ingin user balik ke halaman sebelumnya seperti setelah user login, dia akan pindah
     ke HomePage tapi mereka tidak bisa kembali ke halaman login lagi.

  2. Secara umum di flutter, struktur setiap halaman dibangun pakai hierarki widget utama seperti Scaffold, AppBar, dan Drawer. Scaffold bisa kita anggap sebagai
     kerangka halaman atau wadah utama. Sedangkan AppBaar dipakai untuk header halaman yang berisi judul halaman atau berbagai tombol. Terakhir, drawer berperan sebagai navigasi global,
     jadi user bisa akses cepat ke berbagai halaman aplikasi tanpa harus melakukannya secara manual. Nah kita bisa bikin sebuah layout custom dan memakainya di setiap halaman yang kita mau
     agar konsisten. Contohnya seperti LeftDrawer dalam projek ini yang di reuse untuk halaman lain.
  
  3. Dalam konteks desain di flutter, widget layout seperti Padding, SingleChildScrollView, dan ListView punya peran penting dalam menciptakan tampilan form yang rapi, responsif, dan user-friendly.
     Berikut uraiannya : 
     - Padding : Memberi jarak atau ruang kosong di sekitar elemen agar tampilan lebih rapi dan tidak saling menempel. Biasa digunakan untuk menambahkan jarak antara
                 widget dengan tepi layar atau dengan widget lain. Tanpa adanya padding, maka tampilan bisa kelihatan padat dan susah dibaca karena tidak adanya jarak antar komponen.
                 Contoh di project ini :
                   child: Container(
                       padding: const EdgeInsets.all(8),
                       child: Center(
                           child: Column(
                           // Menyusun ikon dan teks di tengah kartu.
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                               Icon(
                                   item.icon,
                                   color: Colors.white,
                                   size: 30.0,
                               ),
                               const Padding(padding: EdgeInsets.all(3)),
                               Text(
                                   item.name,
                                   textAlign: TextAlign.center,
                                   style: const TextStyle(color: Colors.white),
                               ),
                           ],
                           ),
                       ),
                   ),
       - SingleChildScrollView : Memungkinkan scroll seluruh isi halaman jika kontennya melebihi tinggi layar. Widget ini cocok digunakan untuk form panjang yang berisi beberapa elemen statis. Tanpa adanya
                                 adanya widget ini, maka terdapat bagian form yang ketutup atau tidak terlihat untuk ukuran layar kecil. 
                                 Contoh di project ini :
                                     return AlertDialog(
                                         title: const Text('Produk berhasil disimpan!'),
                                         content: SingleChildScrollView(
                                             child: Column(
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                     Text('Nama Produk: $_name'),
                                                     Text('Harga: Rp${_price.toStringAsFixed(2)}'),
                                                     Text('Deskripsi: $_description'),
                                                     Text('Kategori: $_category'),
                                                     Text('Thumbnail: $_thumbnail'),
                                                     Text('Stok: $_stock'),
                                                     Text('Produk Unggulan: ${_isFeatured ? "Ya" : "Tidak"}'),
                                                 ],
                                             ),
                                         ),
                                         actions: [
                                             TextButton(
                                                 child: const Text('OK'),
                                                 onPressed: () {
                                                     Navigator.pop(context);
                                                     _formKey.currentState!.reset();
                                                 },
                                             ),
                                         ],
                                     );
         - ListView : Widget ini mirip dengan SingleChildScrollView karena menyediakan fitur scroll. Namun, widget ini lebih efisien karena hanya elemen yang muncul di layar yang dirender. Jadi, dia 
                      render semua elemen secara langsung, melainkan hanya yang terlihat di layar. Ini berguna jika input produk atau ada elemen yang jumlahnya bisa berubah.
                      Contoh di project ini :
                           return Drawer(
                               child: ListView(
                                   children: [
                                       const DrawerHeader(
                                           decoration: BoxDecoration(
                                               color: Colors.blue,
                                       ),
                           ...

  4. Kita bisa menyesuaikan warna tema aplikasi agar konsisten dengan brand toko dengan mengaturnya di tema global. Jadi di main.dart, kita bisa set beberapa warna yang kita inginkan sesuai brand
     kita dalam ThemeData. Lalu, untuk setiap komponen widgets, kita gunakan warna yang sudah kita set tersebut di ThemeData sehingga semua komponen bisa konsisten. Hal ini penting karena jika nanti
     kita ingin mengubah tema warna aplikasi, kita tinggal ubah di satu tempat yaitu ThemeData. Usahakan untuk tidak set warna secara manual di widgets karena hal itu bisa menyebabkan inkonsistensi
     dan sulit di maintain.

- Tugas 7 :
  1. Di flutter, setiap komponen di tampilan atau UI adalah widget. Terdapat hubungan hierarkis antar widget, dimana satu widget menjadi parent dan widget lain menjadi child. 
     Hubungan inilah yang membentuk sebuah struktur seperti pohon yang disebut widget tree. Dalam tree, setiap widget akan ditampilkan sebagai sebuah node.
     Parent widget menentukan bagaimana childnya ditampilkan seperti posisi, ukuran, dan lain-lain. Sedangkan setiap child widget, akan memberikan konten atau isi kepada parentnya.
  
  2. Widget yang digunakan dalam proyek ini : 
     - MaterialApp : sebagai root widget yang mengatur tema, navigasi, dan gaya Material Design
     - Scaffold : Memberikan struktur dasar halaman
     - AppBar : Menampilkan bagian atas halaman, biasanya berisi judul
     - Padding : Memberikan jarak di sekeliling konten dalam body
     - Column : Menyusun widget secara vertikal
     - Row : Menyusun widget secara horizontal
     - Center : Meletakkan elemen di tengah halaman
     - SizedBox : Memberikan jarak vertikal antara row dengan teks
     - GridView.count : Membuat layout grid untuk menampilkan daftar ItemCard
     - Container : Sebagai wadah
     - Card : Menampilkan elemen dalam bentuk kartu
     - Text : Menampilkan text
     - Icon : Menampilkan icon
     - Material : Memberikan gaya Material Design pada ItemCard
     - InkWell : Mendeteksi saat user klik dan memberikan efek ripple
     - SnackBar : Pesan notifikasi sementara di bawah layar saat user menekan salah satu ItemCard
     - MediaQuery : Menyesuaikan lebar kartu sesuai ukuran layar
    
  3. MaterialApp adalah widget utama di flutter yang berperan sebagai kerangka dasar aplikasi berbasis Material Design. Widget ini memiliki beberapa fungsi utama yaitu :
     - Menyediakan banyak widget turunan seperti Scaffold, Navigator, Theme dan lain-lain
     - Menyediakan environment Material Design
     - Mengatur tema global aplikasi
     - Menangani konfigurasi lokal dan bahasa
     Karena beberapa kelebihan utama tersebut, banyak aplikasi yang menjadikan MaterialApp sebagai root widget.
     
  4. - Stateless Widget : widget yang tampilannya tidak berubah selama aplikasi berjalan atau statis. Semua datanya juga bersifat tetap.
       Ciri : tidak punya state, hanya dibuild sekali
       Kondisi : Gunakan saat kita ingin isi tampilan tetap dan tidak butuh interaksi yang mengubah data
       Contoh : Text, Icon, Container, dan lain-lain
       
     - Stateful Widget : widget yang bisa berubah sesuai interaksi dan datanya bersifat dinamis
     - Ciri : Punya kelas state terpisah dan rebuild UI setiap kali state berubah
     - Kondisi : Gunakan saat kita ingin adanya interaksi antara data dengan pengguna
     - Contoh : TextField, Checkbox, Slider, dan lain-lain
  
  5. BuildContext adalah sebuah objek yang menyimpan posisi suatu widget dalam struktur widget tree. Hal ini penting karena flutter menggunakan informasi posisi tersebut
     untuk menentukan hubungan antar widget seperti siapa parent dan child, serta mengakses data atau fungsi yang dimiliki oleh widget lain.
     Penggunaan dalam metode build : Setiap kali flutter memanggil metode build, dia juga memberikan parameter context yang merepresentasikan posisi widget tersebut. Melalui context
     inilah sebuah widget dapat berkomunikasi dengan widget lain.
     Contoh :
  
     Widget build(BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
        return Scaffold(
           appBar: AppBar(title: const Text('Contoh BuildContext')),
           body: Center(
             child: Text(
               'Lebar layar: $screenWidth px',
                style: const TextStyle(fontSize: 20),
             ),
           ),
        );
     }
  
  6. Fitur hot reload adalah fitur yang memungkinkan kita untuk melihat hasil perubahan kode secara instan tanpa kehilangan state aplikasi
     yang sedang berjalan. Misal, ketika kita mengubah warna teks lalu menggunakan hot reload, flutter hanya memperbarui bagian kode yang kita ubah 
     dan merender ulang tampilan. Sedangkan hot restart akan memuat ulang seluruh aplikasi dari awal dan menghapus semua state aplikasi. Dengan kata lain,
     hot restart membuat aplikasi dijalankan seperti saat pertama kali dibuka.
        
