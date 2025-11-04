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
        
