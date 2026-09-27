import '../models/question.dart';

/// 20 dummy questions for the Pre-Test screen.
/// Frontend-only: no backend, no persistence.
final List<Question> preTestQuestions = [
  const Question(
    question:
        'Manakah perintah Python yang benar untuk menampilkan teks '
        '"Hello World" ke layar?',
    options: [
      'echo "Hello World"',
      'print("Hello World")',
      'System.out.println("Hello World");',
      'console.log("Halo Dunia")',
    ],
    correctAnswerIndex: 1,
  ),
  const Question(
    question: 'Ekstensi file untuk skrip Python adalah?',
    options: ['.py', '.java', '.js', '.cpp'],
    correctAnswerIndex: 0,
  ),
  const Question(
    question: 'Fungsi bawaan Python untuk mengetahui panjang sebuah list disebut?',
    options: ['size()', 'length()', 'len()', 'count()'],
    correctAnswerIndex: 2,
  ),
  const Question(
    question: 'Tipe data manakah yang digunakan untuk menyimpan nilai benar/salah di Python?',
    options: ['int', 'bool', 'str', 'float'],
    correctAnswerIndex: 1,
  ),
  const Question(
    question: 'Simbol yang digunakan untuk memberi komentar satu baris di Python adalah?',
    options: ['//', '#', '/* */', '--'],
    correctAnswerIndex: 1,
  ),
  const Question(
    question: 'Manakah cara yang benar untuk membuat list kosong di Python?',
    options: ['list = ()', 'list = {}', 'list = []', 'list = ""'],
    correctAnswerIndex: 2,
  ),
  const Question(
    question: 'Kata kunci yang digunakan untuk mendefinisikan sebuah fungsi di Python adalah?',
    options: ['function', 'def', 'func', 'define'],
    correctAnswerIndex: 1,
  ),
  const Question(
    question: 'Operator yang digunakan untuk pembagian bilangan bulat (hasil tanpa desimal) di Python adalah?',
    options: ['/', '//', '%', '**'],
    correctAnswerIndex: 1,
  ),
  const Question(
    question: 'Manakah struktur perulangan yang tersedia di Python?',
    options: ['for dan while', 'repeat dan until', 'loop dan foreach', 'do dan while'],
    correctAnswerIndex: 0,
  ),
  const Question(
    question: 'Fungsi untuk mengubah tipe data string menjadi integer di Python adalah?',
    options: ['str()', 'int()', 'float()', 'bool()'],
    correctAnswerIndex: 1,
  ),
  const Question(
    question: 'Bagaimana cara mengimpor modul math di Python?',
    options: ['include math', 'using math', 'import math', 'require math'],
    correctAnswerIndex: 2,
  ),
  const Question(
    question: 'Manakah penulisan dictionary yang benar di Python?',
    options: [
      '{"nama": "Budi", "umur": 20}',
      '["nama": "Budi", "umur": 20]',
      '("nama": "Budi", "umur": 20)',
      '<nama: "Budi", umur: 20>',
    ],
    correctAnswerIndex: 0,
  ),
  const Question(
    question: 'Apa hasil dari operasi 7 % 2 di Python?',
    options: ['3', '0', '1', '3.5'],
    correctAnswerIndex: 2,
  ),
  const Question(
    question: 'Manakah nama variabel yang valid di Python?',
    options: ['2var', 'my-var', '_my_var', 'my var'],
    correctAnswerIndex: 2,
  ),
  const Question(
    question: 'Fungsi bawaan untuk membaca input dari pengguna di Python adalah?',
    options: ['input()', 'scan()', 'read()', 'get()'],
    correctAnswerIndex: 0,
  ),
  const Question(
    question: 'Manakah pernyataan kondisional yang benar setelah "if" pertama di Python?',
    options: ['elseif', 'elif', 'else if', 'elsif'],
    correctAnswerIndex: 1,
  ),
  const Question(
    question: 'Apa fungsi dari kata kunci "return" dalam sebuah fungsi Python?',
    options: [
      'Menghentikan program sepenuhnya',
      'Mengembalikan nilai dari fungsi',
      'Mencetak nilai ke layar',
      'Membuat variabel baru',
    ],
    correctAnswerIndex: 1,
  ),
  const Question(
    question: 'Manakah cara yang benar untuk membuat komentar banyak baris (multi-line) di Python?',
    options: [
      'Menggunakan // di setiap baris',
      'Menggunakan tanda kutip tiga ("""...""")',
      'Menggunakan <!-- -->',
      'Menggunakan /* ... */',
    ],
    correctAnswerIndex: 1,
  ),
  const Question(
    question: 'Apa yang akan terjadi jika kita menjalankan kode "print(5 + "5")" di Python?',
    options: [
      'Hasilnya 10',
      'Hasilnya "55"',
      'Akan terjadi TypeError',
      'Hasilnya 5',
    ],
    correctAnswerIndex: 2,
  ),
  const Question(
    question: 'Manakah tipe data yang bersifat immutable (tidak dapat diubah) di Python?',
    options: ['list', 'dictionary', 'set', 'tuple'],
    correctAnswerIndex: 3,
  ),
];
