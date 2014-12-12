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
            string commande = "select NUMEROMAILLOT, NOM, PRENOM, POSITION from joueurs inner join equipe on equipe.numequipe = joueurs.numequipe where equipe.nomequipe = '" + LBX_ChoixEquipe.SelectedItem.ToString() + "'";
            OracleDataAdapter adap = new OracleDataAdapter(commande, oracon);
            adap.Fill(Info, "ResJoueurs");
            BindingSource TheSOUSSE = new BindingSource(Info,"ResJoueurs");
            Dgv_Joueurs.DataSource = TheSOUSSE;     
        }
        private void RemplirCombobox()
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
        }
     
        private void fillcontrol()
        {
            ClearBinding();
            string commande = "select * from  Fichepersonnelle where nomequipe = '" + LBX_ChoixEquipe.SelectedItem.ToString() + "'";
                OracleDataAdapter orDataAdaptr = new OracleDataAdapter(commande, oracon);

                orDataAdaptr.Fill(Info, "resFiches");
                BindingSource TheSOUSSE = new BindingSource(Info, "resFiches");

                Lb_Num.DataBindings.Add("TEXT", Info, "resFiches.numJoueur");
                Lb_Nom.DataBindings.Add("TEXT", Info, "resFiches.nom");
                Lb_Prenom.DataBindings.Add("TEXT", Info, "resFiches.prenom");
                Lb_Equipe.DataBindings.Add("TEXT", Info, "resFiches.nomequipe");
                Lb_NbButs.DataBindings.Add("TEXT", Info, "resFiches.nombrebuts");
                Lb_Passes.DataBindings.Add("TEXT", Info, "resFiches.nombrepasses");       
            
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
        }
        private void Btn_Suivant_Click(object sender, EventArgs e)
        {
            this.BindingContext[Info, "resFiches"].Position += 1;
        }
        private void Btn_Precendent_Click(object sender, EventArgs e)
        {
            this.BindingContext[Info, "resFiches"].Position -= 1;
        }

        private void Cb_Equipe_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClearBinding();
             UpdateControl();
            fillcontrol();
            RemplirGridView();
        }

        private void Form_AffJoueur_Load(object sender, EventArgs e)
        {

        }

        private void groupBox2_Enter(object sender, EventArgs e)
        {

        }
    }
}
