﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Oracle.DataAccess.Client;

namespace bdfinal
{
    public partial class Form_Ajout_joueur : Form
    {
        public OracleConnection oracon = new OracleConnection();
        public Form_Ajout_joueur()
        {
            InitializeComponent();
        }

        public Form_Ajout_joueur(OracleConnection oraconn)
        {
            InitializeComponent();
            oracon = oraconn;
            FillComboBox();
        }
        private void Form_Ajout_joueur_Load(object sender, EventArgs e)
        {
            this.Location = Properties.Settings.Default.A_Joueur_Pos;
            this.Size = Properties.Settings.Default.A_Joueur_Size;
            this.ForeColor = Properties.Settings.Default.Text_Color;
        }

        private void FillComboBox()
        {
            try
            {
                string commande = "SELECT NOMEQUIPE FROM EQUIPE";

                OracleCommand oraclecomm = new OracleCommand(commande, oracon);
                oraclecomm.CommandType = CommandType.Text;
                OracleDataReader oraread = oraclecomm.ExecuteReader();
                while (oraread.Read())
                {
                    string ligne = oraread.GetString(0);
                    Cb_Equipe.Items.Add(ligne);
                }
                oraread.Close();
                Cb_Equipe.SelectedIndex = 0;
                Cb_Position.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());

            }
        }

        private void Fb_Accept_Click(object sender, EventArgs e)
        {
            try
            {
                string commande = "Insert into Joueurs(Nom,Prenom,Datenaissance,NumeroMaillot ,Position,NumEquipe, Photo)" +
                " values(:nom,:prenom,:datenaissance,:numeroMaillot, :position,(SELECT NUMEQUIPE FROM EQUIPE WHERE NOMEQUIPE = :nomE), :pic)";
                OracleCommand oranIns = new OracleCommand(commande, oracon);


                OracleParameter Nomparam = new OracleParameter(":nom", OracleDbType.Varchar2, 30);
                OracleParameter Prenomparam = new OracleParameter(":prenom", OracleDbType.Varchar2, 30);
                OracleParameter Dateparam = new OracleParameter(":dateNaissance", OracleDbType.Date);
                OracleParameter Numparam = new OracleParameter(":numeromaillot", OracleDbType.Int32);
                OracleParameter Posparam = new OracleParameter(":position", OracleDbType.Varchar2, 10);
                OracleParameter NomEparam = new OracleParameter(":nomE", OracleDbType.Varchar2,20);
                OracleParameter lienPhoto = new OracleParameter(":pic", OracleDbType.Varchar2, 400);

                Nomparam.Value = Tb_Nom.Text;
                Prenomparam.Value = Tb_Prenom.Text;
                Dateparam.Value = Dt_Fete.Value;
                Numparam.Value = Tb_Num.Text;
                Posparam.Value = Cb_Position.SelectedItem.ToString();
                NomEparam.Value = Cb_Equipe.SelectedItem.ToString();
                lienPhoto.Value = tb_Lien.Text;


                oranIns.Parameters.Add(Nomparam);
                oranIns.Parameters.Add(Prenomparam);
                oranIns.Parameters.Add(Dateparam);
                oranIns.Parameters.Add(Numparam);
                oranIns.Parameters.Add(Posparam);
                oranIns.Parameters.Add(NomEparam);
                oranIns.Parameters.Add(lienPhoto);
             
                int laligne = oranIns.ExecuteNonQuery();
                MessageBox.Show(laligne.ToString());

                tb_Lien.Clear();
                Tb_Prenom.Clear();
                Tb_Num.Clear();
                Tb_Nom.Clear();
                 

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
        }

        private void flashButton1_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            //Pb_Photo.ImageLocation = Tb_Lien.Text;
            //this.Pb_Photo.SizeMode = PictureBoxSizeMode.StretchImage;
        }

        private void tb_Lien_TextChanged(object sender, EventArgs e)
        {
            try
            {
                pictureBox1.ImageLocation = tb_Lien.Text;
                this.pictureBox1.SizeMode = PictureBoxSizeMode.StretchImage;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());

            }
        }

        private void Form_Ajout_joueur_FormClosing(object sender, FormClosingEventArgs e)
        {
            Properties.Settings.Default.A_Joueur_Pos = this.Location;
            Properties.Settings.Default.A_Joueur_Size = this.Size;
            Properties.Settings.Default.Save();
        }     
    }
}

