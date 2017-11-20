//
//  NoteTableViewController.swift
//  SimpleNote
//
//  Created by Macbook pro on 24/10/17.
//  Copyright © 2017 Smk IDN. All rights reserved.
//

import UIKit

class NoteTableViewController: UITableViewController {
    
    // deklarasi Variable task sebagai object
    var tasks: [Task] = []
//    var day: [Day] = []
//    var description: [Descriptions] = []
    //task ini di panggil dari entiti yg sudah di buat tadi
    
    // deklarasi context u/ persistent container
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTable", for: indexPath) as! YourTableViewCell

        // Configure the cell...
        //deklarasi dataTask sebagai index dari task
        let dataTask = tasks[indexPath.row]
        
        if let myDataTask = dataTask.name_task {
            //menampilkan data ke label
            cell.labelNameTAsk?.text = myDataTask
        }
        if let myDataTask1 = dataTask.day_task {
            //menampilkan data ke label
            cell.labelDay?.text = myDataTask1
        }
            if let myDataTask2 = dataTask.description_task {
                //menampilkan data ke label
                cell.labelDescription?.text = myDataTask2
        }
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //memanggil method getData
        getData()
        //memanggil Relodad data
        tableView.reloadData()
    }
    
    //method getData
    func getData() {
        //mengecek apakah ada eror atau tidak
        do {
            //kondisi kalo tdk ada eroe
            //maka akan request download data
            tasks = try context.fetch(Task.fetchRequest())
        }
        catch {
            print("fetching Failed")
        }
    }
    
    //menambahkan data untuk delete data
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //mengecek menu swipenapabila ada editing style nya delede
        let task = tasks[indexPath.row]
        context.delete(task)
        //delete data
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        do {
            //retrive data
            tasks = try context.fetch(Task.fetchRequest())
        }
        catch {
            print("Fetching Failed")
        }
        // load data lagi
        tableView.reloadData()
    }
   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
