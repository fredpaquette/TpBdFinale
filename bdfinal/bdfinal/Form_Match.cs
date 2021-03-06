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
    public partial class Form_Match : Form
    {
        OracleConnection orac = new OracleConnection();
        public Form_Match()
        {
            InitializeComponent();
        }
        public Form_Match(OracleConnection orc)
        {
            InitializeComponent();
            orac = orc;
            Combo_box();
        }

        private void Combo_box()
        {
            try
            {
                string commande = "select nummatch from match";
                OracleCommand oraclecomm = new OracleCommand(commande, orac);
                oraclecomm.CommandType = CommandType.Text;
                OracleDataReader oraread = oraclecomm.ExecuteReader();
                while (oraread.Read())
                {
                    int ligne = oraread.GetInt32(0);
                    Cb_NumMatch.Items.Add(ligne.ToString());
                }
                oraread.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());

            }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //commande = "select DATEHEURE from match";
            //try
            //{
            //    OracleCommand oraclecom = new OracleCommand(commande, orac);
            //    oraclecom.CommandType = CommandType.Text;
            //    OracleDataReader orareadd = oraclecom.ExecuteReader();
            //    while (orareadd.Read())
            //    {
            //        DateTime ligne = DateTime.Parse(orareadd.GetDateTime(0).ToShortDateString());
            //        Cb_Date.Items.Add(ligne);
            //    }
            //    orareadd.Close();
            //}
            //catch (Exception ex)
            //{
            //    MessageBox.Show(ex.ToString());
            //}        
        }

        private void Cb_Date_SelectedIndexChanged(object sender, EventArgs e)
        {
           // string commande = "select * from match where Dateheure = ' " + Convert.ToDateTime(Cb_Date.SelectedItem.ToString()).ToShortDateString() +"'"; // where DateHeure = '" + Cb_Date.SelectedItem.ToString() + "'";

           
           // OracleDataAdapter adap = new OracleDataAdapter(commande, orac);            
           // DataSet Mels= new DataSet();
           // adap.Fill(Mels, "ResMatch");
           // BindingSource TheSOUSSE = new BindingSource(Mels, "Resmatch");
           //DGV_Match.DataSource = TheSOUSSE;
        }


        private void Cb_NumMatch_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
               // string commande = "select *  from joueurs where numjoueur in (select numjoueur from FICHEMATCHJOUEUR where nummatch =" + Cb_NumMatch.SelectedItem.ToString() + ")";
                string commande = "select * from fichematchjoueur where nummatch = " + Cb_NumMatch.SelectedItem.ToString();
                OracleDataAdapter adap = new OracleDataAdapter(commande, orac);
                DataSet Mels = new DataSet();
                adap.Fill(Mels, "ResMatch");
                BindingSource TheSOUSSE = new BindingSource(Mels, "ResMatch");
                DGV_Joueurs.DataSource = TheSOUSSE;

                commande = "select * from match where nummatch =" + Cb_NumMatch.SelectedItem.ToString();
                OracleDataAdapter adapp = new OracleDataAdapter(commande, orac);
                DataSet leset = new DataSet();
                adapp.Fill(leset, "resMatchs");
                BindingSource data = new BindingSource(leset, "resMatchs");
                DGV_Match.DataSource = data;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());

            }
        }

        private void Dtp_Match_ValueChanged(object sender, EventArgs e)
        {
            try
            {
                string commande = "Select * from match where dateheure >= :ladate";
                OracleCommand com = new OracleCommand(commande, orac);
                OracleParameter ladate = new OracleParameter(":ladate", OracleDbType.Date);
                ladate.Value = Dtp_Match.Value;
                com.Parameters.Add(ladate);
                OracleDataAdapter adapp = new OracleDataAdapter(com);
                DataSet leset = new DataSet();
                adapp.Fill(leset, "resMatchs");
                BindingSource data = new BindingSource(leset, "resMatchs");
                DGV_Match.DataSource = data;



                commande = "select *  from joueurs where numjoueur in (select numjoueur from FICHEMATCHJOUEUR where nummatch in (select nummatch from match where dateheure >=:ladate))";
                OracleCommand lacom = new OracleCommand(commande, orac);
                OracleParameter theDate = new OracleParameter(":ladate", OracleDbType.Date);
                theDate.Value = Dtp_Match.Value;
                lacom.Parameters.Add(theDate);
                OracleDataAdapter adap = new OracleDataAdapter(lacom);
                DataSet Mels = new DataSet();
                adap.Fill(Mels, "ResMatch");
                BindingSource TheSOUSSE = new BindingSource(Mels, "ResMatch");
                DGV_Joueurs.DataSource = TheSOUSSE;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());

            }
        }

        private void Form_Match_Load(object sender, EventArgs e)
        {
            this.Location = Properties.Settings.Default.Match_Pos;
            this.Size = Properties.Settings.Default.Match_Size;
            this.ForeColor = Properties.Settings.Default.Text_Color;
            DGV_Joueurs.AlternatingRowsDefaultCellStyle.BackColor = Properties.Settings.Default.DGV_Alt_Color;
            DGV_Joueurs.DefaultCellStyle.BackColor = Properties.Settings.Default.DGV_Def_Color;

            DGV_Match.AlternatingRowsDefaultCellStyle.BackColor = Properties.Settings.Default.DGV_Alt_Color;
            DGV_Match.DefaultCellStyle.BackColor = Properties.Settings.Default.DGV_Def_Color;
            PN_Head.BackColor = Properties.Settings.Default.Header_Color;

            //.AlternatingRowsDefaultCellStyle.BackColor = Properties.Settings.Default.DGV_Alt_Color;
            //.DefaultCellStyle.BackColor = Properties.Settings.Default.DGV_Def_Color;
        }

        private void Form_Match_FormClosing(object sender, FormClosingEventArgs e)
        {
            Properties.Settings.Default.Match_Pos = this.Location;
            Properties.Settings.Default.Match_Size = this.Size;
            Properties.Settings.Default.Save();
        }
    }
}
