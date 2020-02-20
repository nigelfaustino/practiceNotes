//
//  Day.swift
//  BasicNotes
//
//  Created by NIGEL FAUSTINO on 2/19/20.
//  Copyright © 2020 NIGEL FAUSTINO. All rights reserved.
//

import Foundation

class Day {
    var date: Date
    var notes: [Note] = []

    init(_ date: Date) {
        self.date = date
    }
}
