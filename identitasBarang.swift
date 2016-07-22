//
//  identitasBarang.swift
//  Daftar_Antrian_Barang
//
//  Created by Mohammad Kukuh on 7/20/16.
//  Copyright © 2016 Mohammad Kukuh. All rights reserved.
//

import Foundation

class Barang{
    let id_barang: Int64?
    var nama_barang : String
    var jumlah_barang : String
    
    init(id_barang:Int64){
        self.id_barang = id_barang
        nama_barang=""
        jumlah_barang = ""
    }
    
    init(id_barang:Int64,nama_barang :String,jumlah_barang:String){
        self.id_barang = id_barang
        self.nama_barang = nama_barang
        self.jumlah_barang = jumlah_barang
    }
    

}