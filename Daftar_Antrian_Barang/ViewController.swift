//
//  ViewController.swift
//  Daftar_Antrian_Barang
//
//  Created by Mohammad Kukuh on 7/19/16.
//  Copyright © 2016 Mohammad Kukuh. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var namaBarangText: UITextField!

    @IBOutlet weak var jumlahBarangText: UITextField!
    
    
    @IBOutlet weak var antrianBarangTableView: UITableView!
    
    private var listBarang = [Barang]()
    private var indexBarang : Int?
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        listBarang = AntrianDb.instance.getAntrian()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //informasi yang di klik di tableview
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //namaBarangText.text = listBarang[indexPath.row].nama_barang;
        //jumlahBarangText.text = listBarang[indexPath.row].jumlah_barang;
        
        print("baris ke \(indexPath.row)")
        indexBarang = indexPath.row
    }
    
    //banyak cell yang di load
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listBarang.count
    }
    
    //menampilkan barang ke table view
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       // let cellIdentifier = "cellbarang"
        let cell = tableView.dequeueReusableCellWithIdentifier("cellBarang")!
        var label : UILabel
        label = cell.viewWithTag(1) as! UILabel //label nama barang
        label.text = self.listBarang[indexPath.row].nama_barang + "   id." + String(self.listBarang[indexPath.row].id_barang)
        
        
        label = cell.viewWithTag(2) as! UILabel //label jumlah barang
        label.text = self.listBarang[indexPath.row].jumlah_barang
        
        return cell
    }
    
    //button
    @IBAction func tambahBarangButton(){
        
        let namaBarang = namaBarangText.text ?? ""
        let jumlahBarang = jumlahBarangText.text ?? ""
        
        if AntrianDb.instance.tambahBarang(namaBarang, jb: jumlahBarang) != nil{
        let barang = Barang(id_barang : 0,nama_barang:namaBarang,jumlah_barang:jumlahBarang)
        listBarang.append(barang)
        
            antrianBarangTableView.insertRowsAtIndexPaths([NSIndexPath(forRow:listBarang.count-1, inSection : 0)], withRowAnimation: .Fade)
        }
        namaBarangText.text = ""
        jumlahBarangText.text = ""
    }
    
    //untuk swipe delete
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //hapus data pada row tsb
            listBarang.removeAtIndex(indexPath.row)
            antrianBarangTableView.deleteRowsAtIndexPaths([NSIndexPath(forRow : indexPath.row, inSection: 0)], withRowAnimation: .Fade)
            
            //hapus row di database
            var label : UILabel
            
        }
        else{
            print("tidak ada yang dihapus")
        }
    }
}

    
    

    


