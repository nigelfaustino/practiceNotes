//
//  NotesVC.swift
//  BasicNotes
//
//  Created by NIGEL FAUSTINO on 2/19/20.
//  Copyright © 2020 NIGEL FAUSTINO. All rights reserved.
//

import UIKit
import CoreData

class NotesVC: UITableViewController {
    var notes: [Note] = []
    var dates: [Day] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addNewNote))
        navigationItem.rightBarButtonItem = addButton
        tableView.register(NoteCell.self, forCellReuseIdentifier: "reuse")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchNotes()
    }

    private func fetchNotes() {
        for date in dates {
            date.notes = []
        }
        if let fetchedNotes = CoreDataManager.shared.fetch() {
            for note in fetchedNotes {
                if let date = dates.filter({
                    return Calendar.current.isDate($0.date, inSameDayAs: note.date ?? Date())
                }).first {

                        date.notes.append(note)

                } else {
                    let date = Day(note.date ?? Date())
                    date.notes.append(note)
                    dates.append(date)
                }
            }
            notes = fetchedNotes.sorted { return $0.date ?? Date() > $1.date ?? Date() }
            tableView.reloadData()
        }

    }

    @objc private func addNewNote() {
        guard let newNote = CoreDataManager.shared.create() else { return }
        let newVC = InputVC(newNote)
        navigationController?.pushViewController(newVC, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return dates.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dates[section].notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuse") as! NoteCell
        let note = dates[indexPath.section].notes[indexPath.row]
        cell.configure(note)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        let inputVC = InputVC(note)
        navigationController?.pushViewController(inputVC, animated: true)
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium


        return dateFormatter.string(from: dates[section].date)
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
