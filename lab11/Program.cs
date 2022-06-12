using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace lab11
{
    class Samochod
    {
        public int ID { get; set; }
        public int IDMarka { get; set; }
        public int IDNadwozie { get; set; }
        public String Kolor { get; set; }
        public int pojemnoscSilnik { get; set; }
    }
    class Marka
    {
        public int ID { get; set; }
        public String Nazwa { get; set; }
    }
    class Nadwozie
    {
        public int ID { get; set; }
        public String Nazwa { get; set; }
    }

    class ModelParam
    {
        public int Id { get; set; }
        public String fuelType { get; set; }
        public Int32 enginePower { get; set; }
        public Int32 engineTorque { get; set; }
    }

    class Model
    {
        public int Id
        {
            get { return rId; }
            set { rId = value; }
        }
        public String name { get; set; }
        public Int32 refMarka { get; set; }
        public List<ModelParam> prop { get; set; }
        private int rId;
    }

    class Program
    {
        static void Main(string[] args)
        {

            List<Samochod> samochody = new List<Samochod> {
            new Samochod() {ID = 1,IDMarka = 1,IDNadwozie = 1,Kolor = "Czarny",pojemnoscSilnik = 1600},
            new Samochod() {ID = 2,IDMarka = 2,IDNadwozie = 2,Kolor = "Niebieski",pojemnoscSilnik = 2000},
            new Samochod() {ID = 3,IDMarka = 3,IDNadwozie = 3,Kolor = "Czarny",pojemnoscSilnik = 2000},
            new Samochod() {ID = 4,IDMarka = 4,IDNadwozie = 1,Kolor = "Czarny",pojemnoscSilnik = 1600},
            new Samochod() {ID = 5,IDMarka = 5,IDNadwozie = 2,Kolor = "Niebieski",pojemnoscSilnik = 1600},
            new Samochod() {ID = 5,IDMarka = 5,IDNadwozie = 3,Kolor = "Czerwony",pojemnoscSilnik = 2000}
            };

            List<Marka> marki = new List<Marka> {
            new Marka { ID = 1, Nazwa = "Fiat" },
            new Marka { ID = 2, Nazwa = "BMW" },
            new Marka { ID = 3, Nazwa = "Peugeot"},
            new Marka { ID = 4, Nazwa = "Volkswagen"},
            new Marka { ID = 5, Nazwa = "Toyota"},
            new Marka { ID = 6, Nazwa = "Mazda"},
            new Marka { ID = 7, Nazwa = "Seat"}
            };

            List<Nadwozie> nadwozie = new List<Nadwozie> {
            new Nadwozie { ID = 1, Nazwa = "sedan" },
            new Nadwozie { ID = 2, Nazwa = "hatchback" },
            new Nadwozie { ID = 3, Nazwa = "SUV"}
            };

            ModelParam par1 = new ModelParam() { Id =1, fuelType = "Petrol", enginePower =110, engineTorque = 130 };
            ModelParam par2 = new ModelParam() { Id = 2, fuelType = "Petrol", enginePower = 170, engineTorque = 290 };
            ModelParam par3 = new ModelParam() { Id = 3, fuelType = "Diesel", enginePower = 140, engineTorque = 280 };
            ModelParam par4 = new ModelParam() { Id = 4, fuelType = "Diesel", enginePower = 190, engineTorque = 320 };
            
            List<Model> models = new List<Model> {
            new Model { Id = 1, name = "CX5", refMarka = 6, prop = new List<ModelParam> {par1, par3} },
            new Model { Id = 2, name = "Corolla", refMarka = 5, prop = new List<ModelParam> {par2, par3} },
            new Model { Id = 3, name = "Leon", refMarka = 7, prop = new List<ModelParam> {par2, par4} },
            new Model { Id = 3, name = "Ibiza", refMarka = 7, prop = new List<ModelParam> {par3, par4} }
            };


            //zad 1
            var zad1 = from m in marki join md in models on m.ID equals md.refMarka select new {m.Nazwa, md.prop};
            
            foreach(var q in zad1){
                foreach (var qq in q.prop)
                {
                    Console.WriteLine(q.Nazwa + ":" + qq.engineTorque + ":" + qq.fuelType);
                }                
            }
            Console.ReadKey();
            

            //zad 2
            var zad2 = from m in marki join md in models on m.ID equals md.refMarka orderby m.Nazwa, md.name select new { m.Nazwa, md.name, md.prop };

            foreach(var q in zad2){
                foreach (var qq in q.prop)
                {
                    Console.WriteLine(q.Nazwa + ":" + ":" + q.name + ":" + qq.fuelType + ":" + qq.enginePower);
                }                
            }
            Console.ReadKey();

            //zad 3
            var zad3 = from m in marki join md in models on m.ID equals md.refMarka group md.prop[0].fuelType by m.Nazwa into modelGroup select new { marka = modelGroup.Key, c = modelGroup.Count() };
            
            foreach (var q in zad3)
            {
                Console.WriteLine(q.marka, q.c);
            }
            Console.ReadKey();
        
        }
    }
}
