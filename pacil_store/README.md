- Tugas 9 :
  1. Kita perlu membuat model Dart saat mengambil atau mengirim data JSON karena model menyediakan struktur yang memiliki beberapa kelebihan dan perlindungan :
     - Adanya validasi tipe data : Jika kita membuat suatu model di Dart, kita sudah mendeklarasikan tipe untuk setiap data, sehingga jika ada data JSON yang tipenya tidak sesuai, 
       maka akan menimbulkan error sehingga bisa langsung ke detect. Berbeda dengan map yang tidak bisa menjamin tipe suatu data.
     - Adanya null safety : Dengan menggunakan model, kita bisa menentukan mana data yang bisa null (nullable) dan mana yang tidak, sehingga kita punya kontrol atas null safety. Contoh 
       field data nullable yaitu final String? name;. Sedangkan penggunaan map, kita bisa saja menulis seperti String name = map["name"];. Jika map["name"] ternyata null, maka bisa menimbulkan error.
     - Maintainability : Penggunaan model membuat kode lebih mudah dibaca, refactor, dan rapi untuk project skala besar. Hal ini memberi aspek maintainability dalam jangka panjang. Tanpa model, kita
       harus mencari tempat map dipanggil yang rawan bug.
  2. Package http adalah package standar Flutter untuk melakukan request http biasa. Request http ini meliputi GET, POST, PUT, dan lain-lain. Perlu diketahui bahwa request http berdiri sendiri, artinya
     dia tidak menyimpan cookie atau session. Oleh karena itu, kita membutuhkan package kedua yaitu CookieRequest. CookieRequest adalah helper khusus Flutter jika backend Django menggunakan 
     authentication. CookieRequest akan menyimpan cookie dan mengirim cookie otomatis ke server untuk setiap request. Dengan kata lain, CookieRequest memastikan session terjaga.
  3. Kita perlu membagikan instance CookieRequest ke seluruh komponen di aplikasi Flutter karena sebenarnya setiap kita membuat instance baru, kita juga memulai sebuah session baru. Setiap instance tidak 
     menyimpan session dari instance sebelumnya sehingga saat kita pertama kali membuat instance, kita harus membagikan ke seluruh komponen untuk memastikan setiap komponen di aplikasi kita menggunakan instance 
     atau session yang sama. Hal ini dilakukan untuk menjaga status login kita tidak hilang.
  4. Agar Flutter dapat terhubung dengan backend Django, kita perlu mengatur beberapa konfigurasi terkait konektivitas. Pertama, kita harus menambahkan 10.0.2.2 ke ALLOWED_HOSTS karena emulator Android tidak bisa
     langsung mengakses localhost di perangkat kita. Alamat 10.0.2.2 bisa dilihat sebagai pintu yang menghubungkan emulator ke server lokal di komputer host. Kedua, kita harus mengaktifkan CORS (Cross-Origin Resource Sharing) 
     dan set SameSite = None serta Secure = false. Hal ini dilakukan agar Flutter dapat mengirim dan menerima request lintas origin, berhubung Flutter dan Djando ada di origin yang berbeda. Termasuk juga membawa cookie session
     ketika login. Ketiga, kita perlu menambahkan izin akses aplikasi pada AndroidManifest.xml agar aplikasi dapat mengirim request HTTP. Tanpa itu, aplikasi kita tidak bisa mengirim request sama sekali. Tanpa adanya
     konfigurasi yang tepat, maka Flutter akan gagal berkomunikasi dengan backend Django sehingga keduanya tidak terintegrasi dengan baik.
  5. Mekanisme pengiriman data di Flutter Django :
     - User input data di aplikasi Flutter : User mengisi form dan Flutter akan mengumpulkan nilai input di TextFormField. Kemudian, Flutter akan mengirimkan ke backend Django menggunakan HTTP. Jika endpoint membutuhkan autentikasi,
       maka request akan dilakukan lewat CookieRequest agar session cookie juga terkirim.
     - Django menerima request : Django menerima data dan menjalankan fungsi di view yang bersesuaian. View akan melakukan validasi dan menyimpan data ke database, lalu mengembalikan reponse JSON yang menandakan data berhasil disimpan.
       Django juga akan menangani session dan cookie jika endpoint membutuhkan autentikasi.
     - Flutter mengambil data dari Django : Setelah data tersimpan di database, Flutter akan melakukan request GET ke endpoint dan Django akan mengirimkan datanya dalam format JSON dari database. Flutter menerima JSON tersebut dan 
       mengubahnya menjadi model Dart agar bisa ditangani lebih terstruktur dan aman.
     - Data ditampilkan di Flutter : Model Dart akan dipakai untuk membangun UI atau tampilan. Setiap kali ada perubahan data, Flutter akan melakukan rebuild sehingga data yang ditampilkan adalah data terbaru.
  6. Mekanisme autentikasi di Flutter : 
     - Register : User mengisi form pendaftaran di Flutter dan Flutter mengirimkan data tersebut ke endpoint register Django menggunakan request POST. Django akan menerima, melakukan validasi, dan membuat akun baru. Terakhir Django akan
       menyimpan akun ke database. Django bisa mengirimkan response JSON untuk status keberhasilannya ke Flutter.
     - Login : User memasukkan username dan password di Flutter dan Flutter akan mengirimkan datanya lewat CookieRequest ke endpoint login Django. Django akan melakukan autentikasi dengan authenticate dan login kemudian jika benar, maka Django akan membuat 
       session baru dan mengirimkan cookie sessionID ke Flutter. CookieRequest menyimpan cookie tersebut secara otomatis. Dari sini, setiap ada request berikutnya dari Flutter akan dianggap berasal dari user yang sudah login. Setelah tahap ini berhasil, 
       Flutter akan menampilkan menu utamanya.
     - Akses halaman setelah login : Setiap request GET atau POST dari Flutter ke Django yang membutuhkan autentikasi akan membawa cookie session dari CookieRequest. Django melakukan verifikasi cookie tersebut untuk memastikan bahwa user masih memiliki session
       aktif. Jika cookie valid, Django akan memberikan response yang diminta user.
     - Logout : Saat pengguna logout, Flutter mengirim permintaan POST menggunakan CookieRequest ke endpoint logout Django. Django menjalankan logout dengan menghapus session di server dan mengirim response status keberhasilannya. CookieRequest menghapus cookie sessionID
       yang tersimpan. Flutter kemudian menampilkan halaman login kembali karena status autentikasinya sudah hilang.
  7. Step untuk menyelesaikan setiap checklist :
     - Inisiasi dan login : Buat sebuah app baru yaitu authentication di Django, kemudian kita install django-cors-headers dan atur konfigurasinya. Buat sebuah fungsi baru untuk login di app authentication khusus untuk Flutter.
       Buat urls.py dan tambahkan juga semua path di situ. Untuk bagian Flutter, kita install beberapa helper package yaitu provider dan pbp_django_auth. Kemudian, kita sesuaikan beberapa kode dart yang sudah dibuat seperti menambahkan provider yang sebelumnya tidak ada. Buat berkas login.dart yang mengatur proses login di aplikasi
       Flutternya.
     - Register : Buat sebuah fungsi register khusus di app authentication tadi bagian view.py. Tambahkan juga semua pathnya agar bisa diakses. Kemudian, buat sebuah berkas baru yaitu register.dart di folder screens. Buat tampilan register dan logicnya di berkas tersebut. Setelah itu, cobalah start server django dan coba jalankan 
       aplikasi Flutternya untuk menguji fungsionalitas login dan register.
     - Model custom : Buka endpoint JSON dari proyek django kita sebelumnya yaitu localhost:8000/json/. Dari sana, kita bisa mendapatkan atribut apa saja dalam format JSON tersebut. Kita gunakan bantuan sebuah website yaitu quicktype untuk konversi dari format JSON tersebut ke sebuah model di dart. Kita copy kode dartnya dan buat models
       di Flutter.
     - Fetch Data : Tambahkan package tambahan yaitu http untuk aplikasi bisa melakukan request. Tambahkan juga akses internet untuk aplikasi kita di bagian AndroidManifest.xml. Kita buat function proxy_image di main django bagian views.py untuk mengatasi masalah CORS pada gambar dan tambahkan pathnya di urls.py. Di flutter, kita buat berkas product_entry_card.dart 
       dan product_entry_list.dart untuk tampilin produknya di aplikasi Flutter beserta logicnya. Kita juga tambahkan di drawer untuk product list. Buat juga product_detail.dart untuk menampilkan detail produk setiap kali kita mengklik suatu card product.
     - Integrasi form : Buat sebuah fungsi baru di main bagian views.py untuk create sebuah produk baru dan tambahkan pathnya di urls.py. Hubungkan halaman form dengan CookieRequest untuk keperluan autentikasi. 
     - Logout : Buat fungsi logout di app authentication bagian views.py dan tambahkan pathnya di urls.py. Buat berkas logout.dart di Flutter yang mengurus proses logout. Tambahkan tombol logout di bagian drawer sehingga user bisa klik button tersebut.
     - Filtering : Implementasi filtering produk berdasarkan pembuatnya dan user yang sedang login dengan membuat fungsi baru di backend django. Fungsi ini yang akan melakukan filtering dan mengembalikan format data JSON ke Flutter. Di flutter, kita tinggal tampilin semua produk
       berdasarkan response hasil filtering dari django.
  
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
        
