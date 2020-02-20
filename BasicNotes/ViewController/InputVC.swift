//
//  InputVC.swift
//  BasicNotes
//
//  Created by NIGEL FAUSTINO on 2/19/20.
//  Copyright © 2020 NIGEL FAUSTINO. All rights reserved.
//

import UIKit

class InputVC: UIViewController, UITextViewDelegate {
    var note: Note

    @IBOutlet weak var titleTextField: UITextField!

    @IBOutlet weak var bodyTextView: UITextView!
    init(_ note: Note) {
        self.note = note
        super.init(nibName: "InputVC", bundle: nil)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.placeholder = "Enter a title"

        bodyTextView.delegate = self
        bodyTextView.text = "New Note"
        bodyTextView.textColor = .lightGray
        let tap = UITapGestureRecognizer(target: self, action: #selector(resignEditing))
        view.addGestureRecognizer(tap)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !(note.title?.isEmpty ?? true) && !(note.body?.isEmpty ?? true) {
            bodyTextView.text = note.body
            titleTextField.text = note.title
            titleTextField.textColor = .black
            bodyTextView.textColor = .black
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let title =  titleTextField.text, let noteText = bodyTextView.text {
            if !title.isEmpty && !noteText.isEmpty {
                note.title = title
                note.body = noteText
                note.date = Date()
                CoreDataManager.shared.save()
            }
        }
    }

    @objc private func resignEditing() {
        view.endEditing(true)
    }

    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == "New Note" && textView.textColor == .lightGray)
        {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder()

    }

    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            textView.text = "New Note"
            textView.textColor = .lightGray
        } else {
            textView.textColor = .black

        }
        textView.resignFirstResponder()
    }




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
