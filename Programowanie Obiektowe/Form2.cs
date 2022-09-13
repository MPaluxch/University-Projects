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
    public partial class Form2 : Form
    {
        public Form2()
        {
            InitializeComponent();
            textBox3.Enabled = false; //na poczatku wylaczenie opcji wpisania klucza
            textBox6.Enabled = false;
            textBox2.Enabled = false; //na poczatku wylaczenie Outputa
            textBox4.Enabled = false;
            textBox5.Enabled = false;
        }

        // --- Przycisk "Kliknij, aby odszyfrowac" ---
        private void button1_Click(object sender, EventArgs e)
        {
            int x = Convert.ToInt32(textBox3.Text);
            string y = Convert.ToString(textBox6.Text);
            string message = textBox1.Text;

            // wyswietlenie tylko jednej opcji - jesli pole jest aktywne - wyswietl odpowiedni rezultat algorytmu
            if (textBox2.Enabled == true)
                textBox2.Text = ceasercipher.Decipher(message, x); // funkcja deszyfrowania Cezara
            else if (textBox5.Enabled == true)
                textBox5.Text = beaufort.Decipher(message, y); // funkcja deszyfrowania Beauforta
            else if (textBox4.Enabled == true)
                textBox4.Text = vigenere.Decipher(message, y); // funkcja deszyfrowania Vigenere'a
            else
                textBox5.Text = "ERROR";
        }


        // --- Przycisk "Wyczysc wszystko!" ---
        private void button2_Click(object sender, EventArgs e)
        {
            textBox3.PasswordChar = '\0'; // reset pola z klucz-liczba
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
        }

        // --- CheckBox1 "Szyfr Cezara" - po kliknieciu ---
        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            checkBox2.Checked = false;
            checkBox3.Checked = false;
            textBox3.Enabled = (checkBox1.CheckState == CheckState.Checked); // wlaczenie pola z kluczem-liczba
            textBox2.Enabled = (checkBox1.CheckState == CheckState.Checked);
            textBox4.Enabled = false;
            textBox5.Enabled = false;
        }

        // --- CheckBox2 "Szyfr Vigenere'a" - po kliknieciu ---
        private void checkBox2_CheckedChanged(object sender, EventArgs e)
        {
            checkBox1.Checked = false;
            checkBox3.Checked = false;
            textBox3.Text = "1"; // ustawienie domyslnego klucz-liczba
            textBox3.PasswordChar = ' '; // ukrywanie pola z klucz-liczba
            textBox6.Enabled = (checkBox2.CheckState == CheckState.Checked); // wlaczenie pola z kluczem-text
            textBox4.Enabled = (checkBox2.CheckState == CheckState.Checked);
        }

        // --- CheckBox3 "Szyfr Beauforta" - po kliknieciu ---
        private void checkBox3_CheckedChanged(object sender, EventArgs e)
        {
            checkBox1.Checked = false;
            checkBox2.Checked = false;
            textBox3.Text = "1"; // ustawienie domyslnego klucz-liczba
            textBox3.PasswordChar = ' '; // ukrywanie pola z klucz-liczba
            textBox6.Enabled = (checkBox3.CheckState == CheckState.Checked); // wlaczenie pola z kluczem-text
            textBox5.Enabled = (checkBox3.CheckState == CheckState.Checked);
        }

        // --- Menu - otworzenie nowego okna ---
        private void szyfrowanieToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Form1 to = new Form1();
            to.Show(); // pokaz nowe okno
            this.Hide(); // zamknij to okno
        }

    }
}

