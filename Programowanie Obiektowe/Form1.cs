using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Hasla
{

    public partial class Form1 : Form
    {
        // --- Poczatkowe zachowanie programu ---
        public Form1()
        {
            InitializeComponent();
            textBox3.Enabled = false; //na poczatku wylaczenie opcji wpisania klucza
            textBox6.Enabled = false;
            textBox2.Enabled = false; //na poczatku wylaczenie Outputa
            textBox4.Enabled = false;
            textBox5.Enabled = false;

        }

        // --- Przycisk "Kliknij, aby zaszyfrowac!" ---
        private void button1_Click_1(object sender, EventArgs e)
        {

            int x = Convert.ToInt32(textBox3.Text);
            string y = Convert.ToString(textBox6.Text);
            string message = textBox1.Text;

            // wyswietlenie tylko jednej opcji - jesli pole jest aktywne - wyswietl odpowiedni rezultat algorytmu
            if (textBox2.Enabled == true)   
            textBox2.Text = ceasercipher.Encipher(message, x); // funkcja szyfrowania Cezara
            else if (textBox5.Enabled == true)
                textBox5.Text = beaufort.Encipher(message, y); // funkcja szyfrowania Beauforta
            else if (textBox4.Enabled == true)
                textBox4.Text = vigenere.Encipher(message, y); // funkcja szyfrowania Vigenere'a
            else
                textBox5.Text = "ERROR";

        }

        // --- Przycisk "Wyczysc wszystko!" ---
        private void button2_Click_1(object sender, EventArgs e) 
        {
            textBox1.Clear(); // wyczyszczenie pola tekstowego
            textBox2.Clear();
            textBox3.Clear();
            textBox4.Clear();
            textBox5.Clear();
            textBox6.Clear();
            checkBox1.Checked = false; // odznaczenie przycisku
            checkBox2.Checked = false;
            checkBox3.Checked = false;
            textBox3.Enabled = false; // wylaczenie opcji wpisania klucza
            textBox6.Enabled = false;
            textBox2.Enabled = false; // wylaczenie Outputa
            textBox4.Enabled = false;
            textBox5.Enabled = false;
            textBox3.PasswordChar = '\0'; // reset pola z klucz-liczba
        }

        // --- CheckBox1 "Szyfr Cezara" - po kliknieciu ---
        private void checkBox1_Click(object sender, EventArgs e)
        {
            checkBox2.Checked = false;
            checkBox3.Checked = false;
            textBox3.Enabled = (checkBox1.CheckState == CheckState.Checked); // wlaczenie pola z kluczem-liczba
            textBox2.Enabled = (checkBox1.CheckState == CheckState.Checked);
            textBox4.Enabled = false;
            textBox5.Enabled = false;
        }

        // --- CheckBox2 "Szyfr Vigenere'a" - po kliknieciu ---
        private void checkBox2_Click(object sender, EventArgs e)
        {
            checkBox1.Checked = false;
            checkBox3.Checked = false;
            textBox3.Text = "1"; // ustawienie domyslnego klucz-liczba
            textBox3.PasswordChar = ' '; // ukrywanie pola z klucz-liczba
            textBox6.Enabled = (checkBox2.CheckState == CheckState.Checked); // wlaczenie pola z kluczem-text
            textBox4.Enabled = (checkBox2.CheckState == CheckState.Checked);
        }

        // --- CheckBox3 "Szyfr Beauforta" - po kliknieciu ---
        private void checkBox3_Click(object sender, EventArgs e) // wlaczenie pola z kluczem-text
        {
            checkBox1.Checked = false;
            checkBox2.Checked = false;
            textBox3.Text = "1"; // ustawienie domyslnego klucz-liczba
            textBox3.PasswordChar = ' '; // ukrywanie pola z klucz-liczba
            textBox6.Enabled = (checkBox3.CheckState == CheckState.Checked); // wlaczenie pola z kluczem-text
            textBox5.Enabled = (checkBox3.CheckState == CheckState.Checked);
        }

        private void deszyfrowanieToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Form2 to = new Form2();
            to.Show(); // otworz nowe okno
            this.Hide(); // zamknij to okno
        }



        // --- Menu - otworzenie nowego okna ---

    }

    // --- Algorytm szyfrowania Cezara ---
    public class ceasercipher
    {
        private static char Cipher(char ch, int key)
        {
            if (!char.IsLetter(ch))
                return ch;

            char offset = char.IsUpper(ch) ? 'A' : 'a';
            return (char)((((ch + key) - offset) % 26) + offset);
        }

        public static string Encipher(string input, int key)
        {
            string output = string.Empty;

            foreach (char ch in input)
                output += Cipher(ch, key);

            return output;
        }

        public static string Decipher(string input, int key)
        {
            return Encipher(input, 26 - key);
        }
    }

    // --- Algorytm szyfrowania Vigenere'a ---
    // Link: https://www.programmingalgorithms.com/algorithm/caesar-cipher/
    public class vigenere
    {
        private static int Mod(int a, int b)
        {
            return (a % b + b) % b;
        }

        private static string Cipher(string input, string key, bool encipher)
        {
            for (int i = 0; i < key.Length; ++i)
                if (!char.IsLetter(key[i]))
                    return null; // Error

            string output = string.Empty;
            int nonAlphaCharCount = 0;

            for (int i = 0; i < input.Length; ++i)
            {
                if (char.IsLetter(input[i]))
                {
                    bool cIsUpper = char.IsUpper(input[i]);
                    char offset = cIsUpper ? 'A' : 'a';
                    int keyIndex = (i - nonAlphaCharCount) % key.Length;
                    int k = (cIsUpper ? char.ToUpper(key[keyIndex]) : char.ToLower(key[keyIndex])) - offset;
                    k = encipher ? k : -k;
                    char ch = (char)((Mod(((input[i] + k) - offset), 26)) + offset);
                    output += ch;
                }
                else
                {
                    output += input[i];
                    ++nonAlphaCharCount;
                }
            }
            return output;
        }

        public static string Encipher(string input, string key)
        {
            return Cipher(input, key, true);
        }

        public static string Decipher(string input, string key)
        {
            return Cipher(input, key, false);
        }
    }

    // --- Algorytm szyfrowania Beauforta ---
    // Link: https://www.programmingalgorithms.com/algorithm/vigenere-cipher/ 
    public class beaufort
    {
        private static int Mod(int a, int b)
        {
            return (a % b + b) % b;
        }

        private static string Cipher(string input, string key, bool encipher)
        {
            for (int i = 0; i < key.Length; ++i)
                if (!char.IsLetter(key[i]))
                    return null; // Error

            string output = string.Empty;
            int nonAlphaCharCount = 0;

            for (int i = 0; i < input.Length; ++i)
            {
                if (char.IsLetter(input[i]))
                {
                    bool cIsUpper = char.IsUpper(input[i]);
                    char offset = cIsUpper ? 'A' : 'a';
                    int keyIndex = (i - nonAlphaCharCount) % key.Length;
                    int k = (cIsUpper ? char.ToUpper(key[keyIndex]) : char.ToLower(key[keyIndex])) - offset;
                    k = encipher ? k : -k;
                    char ch = (char)((Mod(((k - input[i]) - offset), 26)) + offset);
                    output += ch;
                }
                else
                {
                    output += input[i];
                    ++nonAlphaCharCount;
                }
            }
            return output;
        }

        public static string Encipher(string input, string key)
        {
            return Cipher(input, key, true);
        }

        public static string Decipher(string input, string key)
        {
            return Cipher(input, key, true);
        }
    }
}
