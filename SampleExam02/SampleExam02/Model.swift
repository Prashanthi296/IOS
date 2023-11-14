//
//  Model.swift
//  SampleExam02
//
//  Created by Prashanthi Rayala on 11/13/23.
//

import Foundation
struct Student{
    var fullName : String
    var transferCredits : Double
    var startYear : Int
    var startMonth : Int
}
let undergrads=[
    Student(fullName: "Emma P. Lee", transferCredits: 3, startYear: 2018, startMonth: 08),

    Student(fullName: "Charlotte J. Swann", transferCredits: 6, startYear: 2019, startMonth: 08),

    Student(fullName: "Lisa K. Rock", transferCredits: 6, startYear: 2022, startMonth: 01),

    Student(fullName: "Mary G. Paula", transferCredits: 0, startYear: 2013, startMonth: 08)

]

let grads=[


    Student(fullName: "Michael P. Smith", transferCredits: 5, startYear: 2019, startMonth: 01),

    Student(fullName: "Sean N. Noah", transferCredits: 12, startYear: 2020, startMonth: 08),

    Student(fullName: "John H. Carter", transferCredits: 0, startYear: 2013, startMonth: 08)
]
struct UtilityConstants{
    static let underGradMin = 12.0
    static let underGradMax = 18.0
    static let underGradTotal = 120.0
    static let gradMin = 9.0
    static let gradMax = 12.0
    static let gradTotal = 33.0
}
