# Standarisasi Coding

*Choirul Huda, S.Kom., M.Kom.*

Dokumen ini berisi tiga materi:

1. [Pengenalan Standarisasi Coding](#bagian-1--pengenalan-standarisasi-coding)
2. [Clean Code](#bagian-2--clean-code)
3. [Dokumentasi Standar Penulisan Kode Program](#bagian-3--dokumentasi-standar-penulisan-kode-program)

---

# Bagian 1 — Pengenalan Standarisasi Coding

## Tujuan Pembelajaran

Setelah mengikuti pembelajaran, mahasiswa diharapkan mampu:

- Menjelaskan konsep dan tujuan standarisasi coding dalam pengembangan perangkat lunak.
- Mengidentifikasi karakteristik kode program yang baik, konsisten, mudah dibaca, dan mudah dipelihara.
- Menjelaskan pentingnya coding standard dalam kerja individu maupun pengembangan perangkat lunak secara tim.

## Apa Itu Standarisasi Coding?

Standarisasi coding (Coding Standard) adalah sekumpulan aturan, pedoman, dan konvensi yang digunakan untuk mengatur bagaimana kode program ditulis dalam suatu proyek perangkat lunak.

Standar tersebut dapat mengatur berbagai aspek, seperti:

- Penamaan variabel dan fungsi
- Struktur kode
- Format dan indentasi
- Struktur folder
- Penggunaan fungsi dan class
- Penanganan error
- Keamanan kode
- Dokumentasi kode
- Penggunaan library
- Struktur commit pada version control

### Contoh

**Tanpa standar:**

```php
$x=10;
$y=20;
$z=$x+$y;
echo $z;
```

**Dengan standar:**

```php
$firstNumber = 10;
$secondNumber = 20;

$total = $firstNumber + $secondNumber;

echo $total;
```

### Perbedaan?

- Kode kedua lebih mudah dipahami.
- Penamaan yang deskriptif dan format yang konsisten.

## Mengapa Diperlukan?

Dalam pengembangan perangkat lunak, kode tidak hanya ditulis untuk **komputer**, tetapi juga akan dibaca dan dikembangkan oleh **manusia**.

- **Meningkatkan Readability** — Kode yang memiliki format konsisten lebih mudah dibaca.
- **Mempermudah Maintenance** — Developer lain dapat memahami kode tanpa harus mempelajari gaya penulisan setiap programmer.
- **Mengurangi Kesalahan** — Membantu developer menghindari pola coding yang berpotensi menyebabkan bug.
- **Meningkatkan Konsistensi** — Seluruh anggota tim menggunakan aturan penulisan yang sama.
- **Mempermudah Code Review** — Reviewer dapat lebih fokus pada logika program daripada memperdebatkan gaya penulisan.
- **Mendukung Kolaborasi** — Coding standard sangat penting ketika sebuah proyek dikerjakan oleh banyak programmer.

## Coding Style vs Coding Standard

Keduanya sering dianggap sama, tetapi terdapat perbedaan.

| Coding Style | Coding Standard |
|---|---|
| Gaya penulisan programmer | Aturan yang disepakati |
| Cenderung bersifat personal | Bersifat proyek/tim/organisasi |
| Contoh penggunaan spasi | Aturan penamaan variabel |
| Contoh indentasi | Aturan struktur kode |
| Preferensi pribadi | Pedoman yang harus diikuti |

Perhatikan contoh berikut:

**Programmer A**

```php
$userName = "Budi";
```

**Programmer B**

```php
$user_name = "Budi";
```

Keduanya bisa benar secara sintaks, tetapi dalam sebuah proyek harus ditentukan satu standar yang digunakan bersama.

## Aspek Standarisasi

### Naming Convention

Pemberian nama variabel sesuai fungsinya.

✅ Benar:

```php
$studentName;
$totalScore;
$birthDate;
```

❌ Salah:

```php
$a;
$x1;
$data1;
```

### Indentation

Indentasi digunakan untuk menunjukkan struktur kode.

✅ Benar:

```php
if ($score >= 80) {
    echo "Grade A";
} else {
    echo "Grade B";
}
```

❌ Salah:

```php
if ($score >= 80) {
echo "Grade A";
}else{
echo "Grade B";
}
```

### Spacing

Standar dapat menentukan penggunaan spasi.

✅ Benar:

```php
$total = $price + $tax;
```

❌ Salah:

```php
$total=$price+$tax;
```

### Comments

Komentar digunakan untuk menjelaskan bagian kode yang membutuhkan konteks.

✅ Benar:

```php
// Menghitung total harga setelah pajak
$totalPrice = $price + $tax;
```

❌ Salah:

```php
// Menambahkan 1 ke counter
$counter++;
```

### Method Structure

- Suatu method seharusnya memiliki tugas yang jelas dan spesifik.
- Menerapkan Clean Code.

✅ Benar:

```php
function validateStudent()
{
    // validasi
}

function saveStudent()
{
    // simpan data
}

function sendNotification()
{
    // kirim notifikasi
}
```

❌ Salah:

```php
function processStudent()
{
    // validasi
    // simpan database
    // kirim email
    // generate laporan
    // update dashboard
}
```

> *"Code is written once, but read and maintained many times."*

---

# Bagian 2 — Clean Code

## Apa Itu Clean Code?

Clean Code adalah kode program yang ditulis dengan struktur, penamaan, dan logika yang jelas sehingga mudah dibaca, dipahami, diuji, diperbaiki, dan dikembangkan.

- Clean Code bukan berarti kode yang paling pendek atau paling kompleks.
- Tujuan utamanya adalah membuat kode yang: **Readable, Understandable, Maintainable, Testable, dan Reliable.**

Perhatikan kode berikut:

**Kode 1**

```php
$a = 10;
$b = 20;
$c = $a + $b;

echo $c;
```

**Kode 2**

```php
$firstNumber = 10;
$secondNumber = 20;

$total = $firstNumber + $secondNumber;

echo $total;
```

- **Kode ke-1** dapat berjalan dengan baik, tetapi nama variabel tidak memberikan informasi yang cukup.
- **Kode ke-2** lebih mudah dipahami tanpa perlu membaca penjelasan tambahan.

## Mengapa Clean Code Penting?

Dalam proyek perangkat lunak, kode biasanya tidak hanya dibuat dan digunakan sekali:

- Dibaca kembali oleh programmer.
- Dikembangkan oleh programmer lain.
- Diperbaiki ketika terjadi bug.
- Ditambahkan fitur baru.
- Diintegrasikan dengan sistem lain.
- Diuji secara berkala.
- Dipelihara dalam jangka panjang.

## Karakteristik Clean Code

- **Readable** — Kode mudah dibaca manusia.
- **Understandable** — Tujuan kode mudah dipahami.
- **Simple** — Tidak memiliki kompleksitas yang tidak diperlukan.
- **Consistent** — Menggunakan pola penulisan yang konsisten.
- **Maintainable** — Mudah diperbaiki dan dikembangkan.
- **Testable** — Mudah dilakukan pengujian.
- **Minimal Duplication** — Menghindari pengulangan kode yang tidak diperlukan.

## Prinsip Clean Code

### Meaningful Naming

Nama variabel, fungsi, class, dan parameter harus memberikan informasi tentang tujuan penggunaannya.

❌ Kurang baik:

```php
$a = 100;
$b = 10;
$c = $a - $b;
```

Apa arti `$a`, `$b`, dan `$c`?

✅ Lebih baik:

```php
$productPrice = 100;
$discount = 10;
$finalPrice = $productPrice - $discount;
```

### Naming Function

- Nama fungsi sebaiknya menggambarkan **task/aksi** yang dilakukan.
- Manakah yang tepat dari method berikut?

```php
function data($id)
{
    // ...
}
```

```php
function getStudentById($id)
{
    // ...
}
```

### Function Satu Tugas

Salah satu prinsip penting Clean Code adalah **Single Responsibility**.

❌ Salah:

```php
function processStudent($student)
{
    // Validasi mahasiswa
    // Simpan ke database
    // Kirim email
    // Buat laporan
    // Kirim notifikasi
}
```

✅ Benar:

```php
function validateStudent($student)
{
    // Validasi
}

function saveStudent($student)
{
    // Simpan database
}
```

### Hindari Magic Number

- **Magic number** adalah angka yang **muncul** secara langsung dalam kode tanpa penjelasan yang jelas.
- Angka 17 tidak terlihat artinya, jika butuh konstanta gunakan `const MINIMUM_ADULT_AGE = 17;`

❌ Salah:

```php
if ($age >= 17) {
    echo "Adult";
}
```

✅ Benar:

```php
$minimumAdultAge = 17;

if ($age >= $minimumAdultAge) {
    echo "Adult";
}
```

### Hindari Duplikasi Kode

- Terdapat pola perhitungan yang sama.
- Buatkan fungsi baru yang lebih jelas.

❌ Salah:

```php
$totalStudent = $studentPrice + $studentTax;

$totalTeacher = $teacherPrice + $teacherTax;

$totalStaff = $staffPrice + $staffTax;
```

✅ Benar:

```php
function calculateTotal($price, $tax)
{
    return $price + $tax;
}

$totalStudent = calculateTotal($studentPrice, $studentTax);
$totalTeacher = calculateTotal($teacherPrice, $teacherTax);
$totalStaff = calculateTotal($staffPrice, $staffTax);
```

### Hindari Nested Condition yang Berlebihan

- Penggunaan nested seperti ini membuat sulit dibaca.
- Menyebabkan programmer berpikir berulang kali untuk menggambarkan hasil.

❌ Salah:

```php
if ($user) {
    if ($user->isActive()) {
        if ($user->hasPermission()) {
            if ($user->isVerified()) {
                // Process
            }
        }
    }
}
```

Solusi:

- Gunakan **early return**.
- Tambahkan process yang diperlukan di bawahnya.

✅ Benar:

```php
if (!$user) {
    return;
}

if (!$user->isActive()) {
    return;
}

if (!$user->hasPermission()) {
    return;
}

if (!$user->isVerified()) {
    return;
}
```

### Conditional Expression yang Jelas

Gunakan pendekatan yang lebih ekspresif.

❌ Salah:

```php
if ($status == 1) {
    // ...
}
```

✅ Benar:

```php
const STATUS_ACTIVE = 1;

if ($status == STATUS_ACTIVE) {
    // ...
}
```

atau:

```php
if ($user->isActive()) {
    // ...
}
```

## Error Handling

- Error handling perlu ditangani dengan khusus.
- Cara penulisan kode jelas dan ada informasi yang disampaikan oleh sistem.
- Biasanya menggunakan **try-catch**.

Perhatikan kode berikut ini:

❌ Salah:

- Kode terlalu umum.
- Tidak ada penanganan khusus jika terjadi error.
- Biasanya sering menyebabkan **force close** pada aplikasi.

```php
$result = saveStudent($student);

if (!$result) {
    echo "Error";
}
```

✅ Benar:

- Kode lebih spesifik.
- Terdapat **try-catch**.
- Jika terjadi error ada pesan yang disampaikan (Log Error).
- Tidak menyebabkan **force close** aplikasi.

```php
try {
    saveStudent($student);
} catch (Exception $exception) {
    logError($exception);
}
```

## Clean Code dan Security

### Contoh Kode Berbahaya

❌ Salah:

```php
$query = "SELECT * FROM users WHERE username = '$username'";
```

- Input pengguna langsung dimasukkan ke query.
- Mudah diretas (hasil eksekusinya dapat dimanipulasi).

### Contoh Kode yang Aman

✅ Benar:

- Gunakan **prepared statement**.
- Kode yang bersih bukan hanya mudah dibaca, tetapi juga harus memperhatikan **security** dan **reliability**.

```php
$stmt = $pdo->prepare(
    "SELECT * FROM users WHERE username = :username"
);

$stmt->execute([
    'username' => $username
]);
```

## Refactoring

- Proses memperbaiki struktur internal kode tanpa mengubah perilaku atau output program.
- Kode menjadi mudah dibaca dan bersih.

```
Kode Lama
   ↓
Identifikasi masalah
   ↓
Refactoring
   ↓
Kode Lebih Bersih
   ↓
Testing
   ↓
Kode Siap Digunakan
```

### Composing Methods

- Berupa **Extract Method** dan **Replace Temp with Query**.
- Memecah fungsi yang panjang dan menghilangkan variabel sementara dengan getter atau fungsi query.

**Sebelum:**

```dart
class Order {
  final List<double> itemPrices;
  final double taxRate;

  Order(this.itemPrices, this.taxRate);

  void printReceipt(String customerName) {
    // Print Header
    print('*** STRUK PEMBAYARAN ***');
    print('Pelanggan: $customerName');

    // Hitung Subtotal (Temp variable)
    double subtotal = 0;
    for (var price in itemPrices) {
      subtotal += price;
    }

    // Hitung Pajak & Total
    double tax = subtotal * taxRate;
    double total = subtotal + tax;

    // Print Rincian
    print('Subtotal: Rp$subtotal');
    print('Pajak: Rp$tax');
    print('Total Bayar: Rp$total');
  }
}
```

**Sesudah:**

```dart
class Order {
  final List<double> itemPrices;
  final double taxRate;

  Order(this.itemPrices, this.taxRate);

  // Replace Temp with Query (menggunakan getter bawaan Dart)
  double get subtotal => itemPrices.fold(0, (sum, price) => sum + price);
  double get tax => subtotal * taxRate;
  double get total => subtotal + tax;

  void printReceipt(String customerName) {
    _printHeader(customerName);
    _printDetails();
  }

  // Extract Method untuk mencetak header
  void _printHeader(String customerName) {
    print('*** STRUK PEMBAYARAN ***');
    print('Pelanggan: $customerName');
  }

  // Extract Method untuk mencetak rincian
  void _printDetails() {
    print('Subtotal: Rp$subtotal');
    print('Pajak: Rp$tax');
    print('Total Bayar: Rp$total');
  }
}
```

### Simplifying Conditionals

- Berupa **Guard Clauses**.
- Menghilangkan nesting if-else yang dalam agar alur logika lebih linear dan mudah dibaca.

**Sebelum:**

```dart
String processPayment(double? amount, bool isUserActive, bool hasDiscount) {
  if (amount != null) {
    if (amount > 0) {
      if (isUserActive) {
        if (hasDiscount) {
          return 'Pembayaran Rp${amount * 0.9} berhasil (Diskon 10%)';
        } else {
          return 'Pembayaran Rp$amount berhasil';
        }
      } else {
        return 'Gagal: Akun pengguna tidak aktif';
      }
    } else {
      return 'Gagal: Nominal harus lebih dari 0';
    }
  } else {
    return 'Gagal: Nominal tidak boleh kosong';
  }
}
```

**Sesudah:**

```dart
String processPayment(double? amount, bool isUserActive, bool hasDiscount) {
  // Pengecekan awal (early exit)
  if (amount == null) return 'Gagal: Nominal tidak boleh kosong';
  if (amount <= 0) return 'Gagal: Nominal harus lebih dari 0';
  if (!isUserActive) return 'Gagal: Akun pengguna tidak aktif';

  // Alur utama tanpa nesting if-else bertumpuk
  if (hasDiscount) {
    return 'Pembayaran Rp${amount * 0.9} berhasil (Diskon 10%)';
  }

  return 'Pembayaran Rp$amount berhasil';
}
```

### Simplifying Method Calls

- Berupa **Preserve Whole Object**.
- Menerapkan class sebagai objek pada parameter fungsi.
- Agar lebih ringkas, hanya tulis satu kali saja.

**Sebelum:**

```dart
class TemperatureRange {
  final double low;
  final double high;

  TemperatureRange(this.low, this.high);
}

class Room {
  void checkStatus(double lowTemp, double highTemp) {
    if (lowTemp < 18.0 || highTemp > 30.0) {
      print('Suhu ruangan di luar batas normal!');
    }
  }
}

// Pemanggilan yang merepotkan:
void main() {
  final range = TemperatureRange(16.5, 32.0);
  final room = Room();

  // Harus mengekstrak properti objek satu per satu
  room.checkStatus(range.low, range.high);
}
```

**Sesudah:**

```dart
class TemperatureRange {
  final double low;
  final double high;

  TemperatureRange(this.low, this.high);
}

class Room {
  // Meneruskan seluruh objek TemperatureRange
  void checkStatus(TemperatureRange range) {
    if (range.low < 18.0 || range.high > 30.0) {
      print('Suhu ruangan di luar batas normal!');
    }
  }
}

// Pemanggilan yang jauh lebih bersih:
void main() {
  final range = TemperatureRange(16.5, 32.0);
  final room = Room();

  room.checkStatus(range);
}
```

## Bad Code & Clean Code (Perbandingan)

| No | Aspek | Bad Code | Clean Code |
|---|---|---|---|
| 1 | Nama variabel | Tidak jelas | Deskriptif |
| 2 | Function | Terlalu panjang | Fokus |
| 3 | Duplikasi | Banyak | Minimal |
| 4 | Komentar | Berlebihan | Kontekstual |
| 5 | Struktur | Kompleks | Sederhana |
| 6 | Konsistensi | Tidak konsisten | Konsisten |
| 7 | Testing | Sulit | Lebih mudah |
| 8 | Maintenance | Sulit | Mudah |
| 9 | Readability | Rendah | Tinggi |

## Kesimpulan

- Clean Code membuat kode mudah dibaca.
- Naming harus jelas dan bermakna.
- Function sebaiknya memiliki tanggung jawab yang jelas.
- Hindari duplikasi, kompleksitas, dan kode yang tidak diperlukan.
- Refactoring digunakan untuk meningkatkan kualitas struktur kode.

**Prinsip Utama:**

> Good Code ≠ Code That Works

**Prinsip Tepat:**

> Good Code = Code That Works + Readable + Maintainable + Testable + Consistent

---

# Bagian 3 — Dokumentasi Standar Penulisan Kode Program

## Capaian Pembelajaran

- Menjelaskan fungsi dokumentasi standar penulisan kode.
- Identifikasi komponen Coding Standard Document.
- Menyusun aturan penulisan kode secara sistematis.
- Mendokumentasikan standard agar dapat digunakan seluruh tim.
- Menerapkan dan mengevaluasi standard melalui review dan tools.

## Mengapa Coding Standard Perlu Didokumentasikan?

- Aturan coding tidak cukup hanya disampaikan secara lisan.
- Developer membutuhkan satu pedoman resmi yang dapat dirujuk.
- Dokumen menjadi acuan developer baru dan code review.
- Perubahan aturan dapat dilacak dan dikelola bersama source code.
- Standard dapat diterapkan secara otomatis melalui tools.

## Apa itu Coding Standard Document?

- Dokumen yang berisi aturan, konvensi, prosedur, dan pedoman penulisan serta pengelolaan kode.
- Menjadi pedoman resmi bagi seluruh developer dalam proyek.
- Menentukan bagaimana kode dibuat, didokumentasikan, diperiksa, dan dikelola.

```
Coding Standard
      ↓
Aturan Penulisan Kode
      ↓
Dokumentasi Resmi
      ↓
Implementasi Tim
      ↓
Review + Automation
```

## Komponen Utama Dokumentasi

- General Coding Rules
- Naming, File & Folder Convention
- Formatting Rules
- Comment & Documentation Standard
- Error Handling & Security
- Database & API Convention
- Git, Commit & Branch Convention
- Pull Request & Code Review
- Tools dan Automation

## Struktur CODING_STANDARD.md

```
# Coding Standard

1. Introduction
2. Scope
3. General Rules
4. Naming Convention
5. File & Folder Convention
6. Formatting Rules
7. Documentation
8. Error Handling
9. Security
10. Database & API
11. Git Convention
12. Code Review
13. Tools
14. Examples
```

## 1. Introduction & Scope

- Jelaskan nama proyek, tujuan dokumen, bahasa/framework, dan pihak yang wajib mengikuti standard.
- Scope menentukan bagian sistem dan aktivitas yang tercakup.
- Dokumen berlaku untuk source code baru maupun perubahan terhadap kode lama.

```
Project: Student Management System
Language: PHP 8.x
Framework: Laravel
Scope: seluruh source code dan seluruh developer proyek.
```

## 2. General Coding Rules

- Gunakan encoding UTF-8.
- Gunakan bahasa Inggris untuk identifier.
- Hindari credential di source code.
- Gunakan Git untuk setiap perubahan.
- Perubahan ke main branch harus melalui code review.
- Dokumentasi diperbarui jika aturan atau API berubah.

## 3. Naming Convention

- Dokumen harus menjelaskan aturan, bukan hanya memberikan contoh.
- Variable dan function: `camelCase`.
- Class: `PascalCase`.
- Constant: `UPPER_SNAKE_CASE`.
- Database table/field: `snake_case`.

```
Variable → $studentName
Function → getStudent()
Class    → StudentService
Constant → MAX_LOGIN_ATTEMPT
Database → student_profiles
```

## 4. File Naming Convention

Nama file mengikuti jenis komponen.

- Controller → `[Name]Controller.php`
- Service → `[Name]Service.php`
- Repository → `[Name]Repository.php`
- Request → `[Name]Request.php`
- Test → `[Name]Test.php`

## 5. Folder Structure Standard

- Dokumentasikan struktur folder dan fungsi setiap folder.
- Developer dapat mengetahui lokasi komponen tanpa bertanya kepada anggota tim lain.
- Struktur harus konsisten untuk seluruh proyek.

```
app/
├── Controllers/
├── Models/
├── Services/
├── Repositories/
└── Requests/

tests/
├── Unit/
└── Feature/
```

## 6. Formatting Rules

- Indentasi: 4 spaces.
- Opening brace pada baris yang sama.
- Gunakan blank line antar blok yang berbeda.
- Tentukan maximum line length jika diperlukan.
- Gunakan formatter yang sama untuk seluruh tim.

```php
if ($student->isActive()) {
    $student->update([
        'status' => 'active'
    ]);
}
```

## 7. Comment & Documentation Standard

- Tentukan kapan komentar diperlukan.
- Gunakan komentar untuk konteks atau alasan, bukan mengulang kode.
- Public function/class dapat diwajibkan menggunakan PHPDoc.
- Dokumentasi harus diperbarui ketika interface berubah.

```php
/**
 * Retrieves an active student by ID.
 *
 * @param int $studentId
 * @return Student|null
 */
```

## 8. API Documentation Standard

- Dokumentasikan endpoint dan HTTP method.
- Jelaskan parameter, request, response, dan error response.
- Gunakan format dokumentasi yang konsisten untuk seluruh API.

```
Endpoint : /api/students
Method   : GET
Parameter: faculty_id, page
Response : { "status": "success", "data": [] }
Error    : { "status": "error", "message": "..." }
```

## 9. Error Handling Standard

- Gunakan exception untuk unexpected error.
- Catat error penting pada log.
- Gunakan HTTP status code yang sesuai untuk API.
- Jangan menampilkan stack trace kepada end user.
- Pesan error tidak boleh membocorkan informasi sensitif.

## 10. Security Coding Standard

- Validasi input pengguna.
- Gunakan prepared statement.
- Gunakan hashing untuk password.
- Credential/API key disimpan melalui environment variable.
- Jangan menampilkan informasi sensitif.

```php
// Jangan
$password = "admin123";

// Gunakan configuration / environment
DB_PASSWORD=********
```

## 11. Database Coding Standard

- Table menggunakan `snake_case` dan bentuk plural.
- Field menggunakan `snake_case`.
- Primary key menggunakan `id`.
- Foreign key menggunakan pola `[entity]_id`.
- Timestamp menggunakan `created_at` dan `updated_at`.

```
student_profiles
student_name
student_id
course_id
created_at
updated_at
```

## 12. Git & Commit Convention

- Tentukan format commit yang digunakan seluruh developer.
- Gunakan type yang konsisten: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`.
- Commit message harus singkat dan menjelaskan perubahan.

```
<type>: <description>

feat: add student registration
fix: resolve login validation error
docs: update API documentation
refactor: simplify student service
test: add student service test
```

## 13. Branch Naming Convention

- Branch harus menunjukkan jenis pekerjaan.
- Gunakan format yang konsisten.
- Nama branch sebaiknya singkat tetapi informatif.

```
feature/[name]
bugfix/[name]
hotfix/[name]
refactor/[name]

Contoh:
feature/student-registration
bugfix/login-validation
```

## 14. Pull Request & Code Review

- Dokumentasikan syarat sebelum kode di-merge.
- Pastikan coding standard dan testing telah dipenuhi.
- Dokumentasi diperbarui jika diperlukan.
- Pastikan tidak ada credential atau debugging code.
- Reviewer memberikan approval sesuai aturan proyek.

```
Pull Request Checklist

[ ] Coding standard dipenuhi
[ ] Test tersedia/lulus
[ ] Dokumentasi diperbarui
[ ] Tidak ada credential
[ ] Tidak ada debugging code
[ ] Reviewer approval
```

## 15. Versioning Coding Standard

- Coding standard dapat berubah mengikuti kebutuhan proyek.
- Setiap perubahan aturan harus memiliki riwayat.
- Versioning membantu tim mengetahui kapan dan mengapa aturan berubah.

```
Version 1.0 → Initial rules
Version 1.1 → Added API documentation
Version 1.2 → Added Git convention
Version 2.0 → Changed formatting standard
```

## 16. Single Source of Truth

- Tetapkan satu lokasi resmi untuk aturan coding.
- Hindari aturan yang hanya tersimpan di chat atau catatan pribadi.
- Dokumen resmi harus mudah ditemukan seluruh anggota tim.

```
project/
├── CODING_STANDARD.md
├── README.md
├── CONTRIBUTING.md
└── .editorconfig
```

## 17. Dari Dokumentasi ke Automation

- Aturan yang terdokumentasi dapat diterjemahkan menjadi konfigurasi tools.
- Formatter, linter, static analysis, dan CI membantu menegakkan standard secara otomatis.
- Automation mengurangi ketergantungan pada pemeriksaan manual.

```
CODING_STANDARD.md
        ↓
Configuration
        ↓
Formatter / Linter
        ↓
Static Analysis
        ↓
Testing
        ↓
Code Review
        ↓
Merge
```

## Studi Kasus — Student Management System

- Mahasiswa membuat `CODING_STANDARD.md` untuk proyek PHP.
- Minimal 10 aturan harus dapat diterapkan pada source code.
- Setiap aturan memiliki: Rule → Description → Example.
- Dokumen digunakan sebagai acuan peer code review.

## Format Rule yang Baik

- Setiap aturan harus spesifik dan dapat diverifikasi.
- Gunakan format Rule, Description, Example, dan Incorrect Example.
- Format yang konsisten membuat audit lebih mudah.

```
## Rule 04 — Function Naming

Description:
Nama function menggunakan camelCase.

Example:
getStudentById()

Incorrect:
get_student_by_id()
GetStudentById()
```

## Aktivitas Praktikum

- Buat `CODING_STANDARD.md` untuk proyek PHP.
- Tentukan minimal 10 aturan.
- Buat contoh benar dan salah untuk setiap aturan.
- Terapkan aturan pada source code.
- Lakukan peer review.
- Perbaiki dokumen berdasarkan hasil review.

## Output Tugas

```
project/
├── CODING_STANDARD.md
├── README.md
├── source-code/
├── documentation/
└── review/
```

## Kesimpulan

- Dokumentasi coding standard membuat aturan penulisan kode menjadi formal dan konsisten.
- Dokumen dapat mencakup kode, file/folder, API, database, security, Git, dan review.
- Standard yang baik dapat diterapkan secara manual maupun otomatis.
- Target akhir: seluruh anggota tim menulis dan mengelola kode dengan aturan yang sama.

```
Define → Document → Apply → Review → Automate → Maintain
```
