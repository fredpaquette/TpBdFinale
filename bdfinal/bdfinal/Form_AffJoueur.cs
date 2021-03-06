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
    public partial class Form_AffJoueur : Form
    {
        public OracleConnection oracon = new OracleConnection();
        public DataSet Info = new DataSet();
        public DataSet Info2 = new DataSet();

        public Form_AffJoueur()
        {
            InitializeComponent();
        }
        public Form_AffJoueur(OracleConnection oraconn)
        {
            InitializeComponent();
            oracon = oraconn;
            RemplirCombobox();
             UpdateControl();         
           
        }
        public void RemplirGridView()
        {
            try
            {
                string commande = "select NUMEROMAILLOT, NOM, PRENOM, POSITION from joueurs inner join equipe on equipe.numequipe = joueurs.numequipe where equipe.nomequipe = '" + LBX_ChoixEquipe.SelectedItem.ToString() + "'";
                OracleDataAdapter adap = new OracleDataAdapter(commande, oracon);
                adap.Fill(Info, "ResJoueurs");
                BindingSource TheSOUSSE = new BindingSource(Info, "ResJoueurs");
                Dgv_Joueurs.DataSource = TheSOUSSE;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());

            }
        

        }
        private void RemplirCombobox()
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
                    LBX_ChoixEquipe.Items.Add(ligne);
                }
                oraread.Close();
                //LBX_ChoixEquipe.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());

            }
        }
     
        private void fillcontrol()
        {
                ClearBinding();
                //string commande = "select numjoueur,nom,prenom,Fichepersonnelle.nomequipe,nombrebuts,nombrepasses, equipe.logo  from  Fichepersonnelle inner join equipe on equipe.nomequipe = Fichepersonnelle.nomequipe where Fichepersonnelle.nomequipe ='" + LBX_ChoixEquipe.SelectedItem.ToString() + "'";
                string commande = "select joueurs.numjoueur,joueurs.nom,joueurs.prenom, equipe.nomequipe, equipe.logo, fichepersonnelle.nombrepasses, Fichepersonnelle.nombrebuts  from joueurs inner join equipe on joueurs.numequipe = equipe.numequipe left join fichepersonnelle on fichepersonnelle.numjoueur = joueurs.numjoueur where equipe.nomequipe='" + LBX_ChoixEquipe.SelectedItem.ToString() + "'";
                OracleDataAdapter orDataAdaptr = new OracleDataAdapter(commande, oracon);

                orDataAdaptr.Fill(Info, "resFiches");

                string commandephoto = "select photo from joueurs";
                OracleDataAdapter adapp = new OracleDataAdapter(commandephoto, oracon);
                adapp.Fill(Info, "ResFiches");
                BindingSource TheSOUSSE = new BindingSource(Info, "resFiches");
            
                    Lb_Num.DataBindings.Add("TEXT", Info, "resFiches.numJoueur");
                    Lb_Nom.DataBindings.Add("TEXT", Info, "resFiches.nom");
                    Lb_Prenom.DataBindings.Add("TEXT", Info, "resFiches.prenom");
                    Lb_Equipe.DataBindings.Add("TEXT", Info, "resFiches.nomequipe");
                    Lb_NbButs.DataBindings.Add("TEXT", Info, "resFiches.nombrebuts");
                    Lb_Passes.DataBindings.Add("TEXT", Info, "resFiches.nombrepasses");
                    Pb_Equipe.DataBindings.Add("image", Info, "resFiches.logo", true);
                    this.Pb_Equipe.SizeMode = PictureBoxSizeMode.StretchImage;
                    fillpicturebox();                                     
        }
        private void UpdateControl()
        {
            if (LBX_ChoixEquipe.SelectedItem == null)
            {
                Btn_Suivant.Enabled =false;
                Btn_Precendent.Enabled = false;
            }
            else
            {
                Btn_Suivant.Enabled = true;
                Btn_Precendent.Enabled = true;
            }
        }
        private void ClearBinding()
        {
            Info.Clear();
            Lb_Num.DataBindings.Clear();
            Lb_Nom.DataBindings.Clear();
            Lb_Prenom.DataBindings.Clear();
            Lb_Equipe.DataBindings.Clear();
            Lb_NbButs.DataBindings.Clear();
            Lb_Passes.DataBindings.Clear();
            Pb_Equipe.DataBindings.Clear();
        }
            
        private void Btn_Suivant_Click(object sender, EventArgs e)
        {
           
                this.BindingContext[Info, "resFiches"].Position += 1;
                fillpicturebox();
            
        }
        private void Btn_Precendent_Click(object sender, EventArgs e)
        {       
            this.BindingContext[Info, "resFiches"].Position -= 1;
            fillpicturebox();
        }

        private void Cb_Equipe_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClearBinding();         
            UpdateControl();
            fillcontrol();  
            fillpicturebox();
            RemplirGridView();

        }
        private void fillpicturebox()
        {
            try
            {
              
                    Info2.Clear();
                    Tb_Lien.DataBindings.Clear();
                    string commandephoto = "select photo from joueurs where numjoueur = " + Lb_Num.Text;
                    OracleDataAdapter adapp = new OracleDataAdapter(commandephoto, oracon);
                    adapp.Fill(Info2, "ResPhoto");
                    Tb_Lien.DataBindings.Add("text", Info2, "Resphoto.photo");

                    Pb_Joueur.ImageLocation = Tb_Lien.Text;
                    this.Pb_Joueur.SizeMode = PictureBoxSizeMode.StretchImage;
                   
            }
            catch (Exception ex)
            {
                Pb_Joueur.ImageLocation = "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSPSqBSzzwKGb16b93VeVwo5ipBbFToFwEsknOP6oFs2MpiXbNWEDbgdlTI";
                this.Pb_Joueur.SizeMode = PictureBoxSizeMode.StretchImage;
            }
            
        }
        private void Form_AffJoueur_Load(object sender, EventArgs e)
        {
            this.Location = Properties.Settings.Default.AffJoueur_Pos;
            this.Size = Properties.Settings.Default.AffJoueur_Size;
            this.ForeColor = Properties.Settings.Default.Text_Color;
            Dgv_Joueurs.AlternatingRowsDefaultCellStyle.BackColor = Properties.Settings.Default.DGV_Alt_Color;
            Dgv_Joueurs.DefaultCellStyle.BackColor = Properties.Settings.Default.DGV_Def_Color;
        }

        private void groupBox2_Enter(object sender, EventArgs e)
        {

        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {

        }

        private void Form_AffJoueur_FormClosing(object sender, FormClosingEventArgs e)
        {
            Properties.Settings.Default.AffJoueur_Pos = this.Location;
            Properties.Settings.Default.A_Propos_Size = this.Size;
            Properties.Settings.Default.Save();
        }
    }
}
