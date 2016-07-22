//
//  AntrianDb.swift
//  Daftar_Antrian_Barang
//
//  Created by Mohammad Kukuh on 7/20/16.
//  Copyright © 2016 Mohammad Kukuh. All rights reserved.
//

import Foundation
import SQLite


class AntrianDb{
    
    static let instance = AntrianDb()
    private let db: Connection?
    
    private let antrian = Table("antrian")
    private let id_barang = Expression<Int64>("id_barang")
    private let nama_barang = Expression<String>("nama_barang")
    private let jumlah_barang = Expression<String>("jumlah_barang")
    
    
    private init(){
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        
        do{
            db = try Connection("\(path)/AntrianDb.sqlite3")
        }
        catch{
            db=nil
            print("database gak ketemu")
        }
        createTable()
    }
    
    func createTable(){
    
        //delete dulu
      do{
            try db?.run(antrian.drop())
       }
        catch{print("table tidak bisa drop")}
        
        do{
            try db!.run(antrian.create (ifNotExists: true){t in
                t.column(id_barang, primaryKey: true)
                t.column(nama_barang)
                t.column(jumlah_barang)
            })
        }
        catch { print("table tidak bisa dibikin")}
    }
    
    func tambahBarang(nb :String, jb:String) -> Int64? {
        do{
            let insert = antrian.insert(nama_barang <- nb , jumlah_barang <- jb)
            let id = try db!.run(insert)
            
            return id
        }catch{
            print("insert gagal")
            return -1
        }
    }
    
   
    
    func getAntrian() -> [Barang] {
        var barang = [Barang]()
        
        do{
            for lb in try db!.prepare(antrian){
                barang.append(Barang(
                    id_barang: lb[id_barang],
                    nama_barang:lb[nama_barang],
                    jumlah_barang:lb[jumlah_barang]))
            }
        }catch{
            print("gagal select")
        }
        
        return barang
    }
    
}
