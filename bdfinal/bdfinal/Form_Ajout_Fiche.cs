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
    public partial class Form_Ajout_Fiche : Form
    {
        public OracleConnection oracon = new OracleConnection();
        public Form_Ajout_Fiche(OracleConnection oraconm)
        {
            InitializeComponent();
            oracon = oraconm;
            fillbox1();
            fillbox2();
        }

        private void fillbox1()
        {
            try
            {
                string commande = "SELECT nummatch from match";

                OracleCommand oraclecomm = new OracleCommand(commande, oracon);
                oraclecomm.CommandType = CommandType.Text;
                OracleDataReader oraread = oraclecomm.ExecuteReader();
                while (oraread.Read())
                {
                    int ligne = oraread.GetInt32(0);
                    Cb_Numatch.Items.Add(ligne.ToString());
                }
                oraread.Close();
                Cb_Numatch.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());

            }
            
        
        }
        private void fillbox2()
        {
            try
            {
                string commande = "SELECT nom from joueurs";

                OracleCommand oraclecomm = new OracleCommand(commande, oracon);
                oraclecomm.CommandType = CommandType.Text;
                OracleDataReader oraread = oraclecomm.ExecuteReader();
                while (oraread.Read())
                {
                    string ligne = oraread.GetString(0);

                    Cb_Numjoueur.Items.Add(ligne.ToString());
                }
                oraread.Close();
                Cb_Numjoueur.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());

            }

        }

        private void Btn_Ajouter_Click(object sender, EventArgs e)
        {
            try
            {
                string commande = "INSERT INTO FICHEMATCHJOUEUR (NUMMATCH,NUMJOUEUR,NBPASSES,NBBUTS)" +
                                     "values (:lenumM,(select numjoueur from joueurs where nom = :lenumJ),:passes,:buts) ";
                OracleCommand oraclecomm = new OracleCommand(commande, oracon);
                OracleParameter numM = new OracleParameter(":lenumM", OracleDbType.Int32);
                OracleParameter numJ = new OracleParameter(":lenumJ", OracleDbType.Varchar2);
                OracleParameter passe = new OracleParameter(":passes", OracleDbType.Int32);
                OracleParameter but = new OracleParameter(":buts", OracleDbType.Int32);
                numM.Value = Cb_Numatch.SelectedItem.ToString();
                numJ.Value = Cb_Numjoueur.SelectedItem.ToString();
                passe.Value = Tb_nbpasse.Text;
                but.Value = tb_Nbut.Text;
                oraclecomm.Parameters.Add(numM);
                oraclecomm.Parameters.Add(numJ);
                oraclecomm.Parameters.Add(passe);
                oraclecomm.Parameters.Add(but);

                int i = oraclecomm.ExecuteNonQuery();
                MessageBox.Show(i.ToString() + " Ligne Inserer");

                tb_Nbut.Clear();
                Tb_nbpasse.Clear();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());

            }
        }

        private void Btn_cancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void Form_Ajout_Fiche_Load(object sender, EventArgs e)
        {
            this.Location = Properties.Settings.Default.A_Fiche_Pos;
            this.Size = Properties.Settings.Default.A_Fiche_Size;
            this.ForeColor = Properties.Settings.Default.Text_Color;
        }

        private void Form_Ajout_Fiche_FormClosing(object sender, FormClosingEventArgs e)
        {
            Properties.Settings.Default.A_Fiche_Pos = this.Location;
            Properties.Settings.Default.A_Fiche_Size = this.Size;
            Properties.Settings.Default.Save();
        }
    }
}
