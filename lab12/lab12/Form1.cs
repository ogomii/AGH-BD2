using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace lab12
{
    public partial class Form1 : Form
    {
        private EmployeeDataContext db;

        public Form1()
        {
            InitializeComponent();
            db = new EmployeeDataContext();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            //zad 2
            var query = from q in db.lab12Views
                        group q by q.DeparmentName into depGroup
                        let maxR = (from r in depGroup select r.Rate).Max()
                        orderby maxR descending
                        select new { DepartmentName = depGroup.Key, MaxRate = maxR };
            dataGridView1.DataSource = query;

            //zad 3
            var query2 = from q2 in db.lab12Views
                         join q in query
                         on q2.DeparmentName equals q.DepartmentName
                         where q2.Rate == q.MaxRate
                         select new { q.DepartmentName, q2.Name, q.MaxRate };
            dataGridView2.DataSource = query2;

            //zad 4
            var query3 = from q in db.lab12Views
                          join s in db.SalesPersons
                          on q.BusinessEntityID equals s.BusinessEntityID
                          select new { q.Name, q.DeparmentName };
            var query4 = (from q in db.lab12Views
                         select new { q.Name, q.DeparmentName }).Except(query3).OrderBy(x => x.DeparmentName);
            dataGridView3.DataSource = query4;
            
        }

            

    }
}
