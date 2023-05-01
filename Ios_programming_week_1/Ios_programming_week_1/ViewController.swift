//
//  ViewController.swift
//  Ios_programming_week_1
//
//  Created by Capstone on 2023/03/06.
//  Copyright © 2023 Capstone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var questions = [
            "대한민국의 수도는 무엇인가요?",
            "한국 청년들에게 가장 인기있는 대학은 무슨 대학인가요?",
            "7+21은 얼마인가요?"
        ]
        var answers = [
            "서울",
            "한성대학교",
            "28"
        ]
        var currentIndex = 0

    @IBOutlet weak var answer_label: UILabel!
    @IBOutlet weak var question_label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        question_label.text = questions[currentIndex]

    }

    @IBAction func next_question(_ sender: UIButton) {
        currentIndex = (currentIndex+1)%questions.count
        question_label.text = questions[currentIndex]

    }

    @IBAction func show_answer(_ sender: UIButton) {
        currentIndex = (currentIndex+1)%questions.count
        answer_label.text = answers[currentIndex]
    }
}

