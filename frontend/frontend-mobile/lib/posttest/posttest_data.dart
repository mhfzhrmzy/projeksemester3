import '../common/models/question.dart';

/// 20 dummy questions for the Post-Test screen.
/// Several questions include a Python code snippet, rendered in a
/// monospace code block above the question text.
final List<Question> postTestQuestions = [
  const Question(
    question: 'Apakah output yang akan dihasilkan saat kode di atas dijalankan?',
    code: 'x = "10"\ny = 5\nprint(x * 2)',
    options: ['20', '1010', '105', 'TypeError (Error)'],
    correctAnswerIndex: 1,
  ),
  const Question(
    question: 'Apakah output dari kode di atas?',
    code: 'a = 5\nb = 2\nprint(a // b)',
    options: ['2.5', '2', '3', 'Error'],
    correctAnswerIndex: 1,
  ),
  const Question(
    question: 'Nilai apa yang akan dicetak oleh kode berikut?',
    code: 'for i in range(3):\n    print(i)',
    options: ['1 2 3', '0 1 2', '0 1 2 3', '1 2'],
    correctAnswerIndex: 1,
  ),
  const Question(
    question: 'Apa hasil dari kode berikut?',
    code: 'nama = "Budi"\nprint(nama[0])',
    options: ['B', 'u', 'Budi', 'Error'],
    correctAnswerIndex: 0,
  ),
  const Question(
    question: 'Apa output dari potongan kode berikut?',
    code: 'x = 10\nif x > 5:\n    print("Besar")\nelse:\n    print("Kecil")',
    options: ['Besar', 'Kecil', 'Error', 'Tidak ada output'],
    correctAnswerIndex: 0,
  ),
  const Question(
    question: 'Apa yang akan dicetak oleh kode berikut?',
    code: 'angka = [1, 2, 3]\nprint(len(angka))',
    options: ['2', '3', '1', 'Error'],
    correctAnswerIndex: 1,
  ),
  const Question(
    question: 'Berapa hasil dari kode berikut?',
    code: 'print(2 ** 3)',
    options: ['6', '8', '9', '5'],
    correctAnswerIndex: 1,
  ),
  const Question(
    question: 'Apa output dari kode berikut?',
    code: 's = "Python"\nprint(s[-1])',
    options: ['P', 'n', 'y', 'Error'],
    correctAnswerIndex: 1,
  ),
  const Question(
    question: 'Apa yang terjadi ketika kode berikut dijalankan?',
    code: 'x = 5\nx = x + "1"\nprint(x)',
    options: ['51', '6', 'TypeError (Error)', '5.1'],
    correctAnswerIndex: 2,
  ),
  const Question(
    question: 'Apa hasil akhir dari variabel total pada kode berikut?',
    code: 'total = 0\nfor i in range(1, 4):\n    total += i\nprint(total)',
    options: ['3', '6', '10', '4'],
    correctAnswerIndex: 1,
  ),
  const Question(
    question: 'Apa output dari kode berikut?',
    code: 'data = {"nama": "Ani"}\nprint(data["nama"])',
    options: ['nama', 'Ani', 'Error', '{"nama": "Ani"}'],
    correctAnswerIndex: 1,
  ),
  const Question(
    question: 'Berapa nilai yang dicetak oleh kode berikut?',
    code: 'x = True\ny = False\nprint(x and y)',
    options: ['True', 'False', '1', 'Error'],
    correctAnswerIndex: 1,
  ),
  const Question(
    question: 'Apa output dari kode berikut?',
    code: 'list1 = [1, 2, 3]\nlist1.append(4)\nprint(list1)',
    options: ['[1, 2, 3]', '[1, 2, 3, 4]', '[4, 1, 2, 3]', 'Error'],
    correctAnswerIndex: 1,
  ),
  const Question(
    question: 'Apa hasil dari kode di bawah ini?',
    code: 'def tambah(a, b):\n    return a + b\n\nprint(tambah(3, 4))',
    options: ['34', '7', 'Error', 'None'],
    correctAnswerIndex: 1,
  ),
  const Question(
    question: 'Apa output dari kode berikut?',
    code: 'x = [1, 2, 3]\nprint(x[1:])',
    options: ['[1, 2]', '[2, 3]', '[1, 2, 3]', '[3]'],
    correctAnswerIndex: 1,
  ),
  const Question(
    question: 'Berapa hasil dari kode berikut?',
    code: 'print(10 % 3)',
    options: ['3', '1', '0', '3.33'],
    correctAnswerIndex: 1,
  ),
  const Question(
    question: 'Apa output dari kode berikut?',
    code: 'nilai = "7"\nprint(int(nilai) + 3)',
    options: ['73', '10', 'Error', '7'],
    correctAnswerIndex: 1,
  ),
  const Question(
    question: 'Apa yang dicetak oleh kode berikut?',
    code: 'x = 3\nwhile x > 0:\n    print(x)\n    x -= 1',
    options: ['3 2 1', '1 2 3', '3 2 1 0', 'Error'],
    correctAnswerIndex: 0,
  ),
  const Question(
    question: 'Apa output dari kode berikut?',
    code: 'kata = "python"\nprint(kata.upper())',
    options: ['python', 'PYTHON', 'Python', 'Error'],
    correctAnswerIndex: 1,
  ),
  const Question(
    question: 'Apa hasil akhir dari kode berikut?',
    code: 'hasil = []\nfor i in range(3):\n    hasil.append(i * 2)\nprint(hasil)',
    options: ['[0, 1, 2]', '[0, 2, 4]', '[2, 4, 6]', 'Error'],
    correctAnswerIndex: 1,
  ),
];
