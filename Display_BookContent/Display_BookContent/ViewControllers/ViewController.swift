//
//  ViewController.swift
//  Google TTS Demo
//
//  Created by Alejandro Cotilla on 5/30/18.
//  Copyright © 2018 Alejandro Cotilla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var booksArray:[Books] = [Books]()

//  @IBOutlet weak var textView: PALongTextView!
  @IBOutlet weak var speakButton: UIButton!
  @IBOutlet weak var textView: PALongTextView!
  
  @IBOutlet weak var voiceCategoryControl: UISegmentedControl!
  @IBOutlet weak var voiceGenderControl: UISegmentedControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    ReadFromURL(url: "http://skunkworks.ignitesol.com:8000/books")

  }
  
  @IBAction func didPressSpeakButton(_ sender: Any) {
    speakButton.setTitle("Speaking...", for: .normal)
    speakButton.isEnabled = false
    speakButton.alpha = 0.6

    var voiceType: VoiceType = .undefined
    let category = voiceCategoryControl.titleForSegment(at: voiceCategoryControl.selectedSegmentIndex)
    let gender = voiceGenderControl.titleForSegment(at: voiceGenderControl.selectedSegmentIndex)
    if category == "WaveNet" && gender == "Female" {
      voiceType = .waveNetFemale
    }
    else if category == "WaveNet" && gender == "Male" {
      voiceType = .waveNetMale
    }
    else if category == "Standard" && gender == "Female" {
      voiceType = .standardFemale
    }
    else if category == "Standard" && gender == "Male" {
      voiceType = .standardMale
    }

    SpeechService.shared.speak(text: textView.text!, voiceType: voiceType) {
      self.speakButton.setTitle("Speak", for: .normal)
      self.speakButton.isEnabled = true
      self.speakButton.alpha = 1
    }
  }
  
  
  
  
  func ReadFromURL(url : String)   {
    
    DispatchQueue.main.async {
      
      do{
        // load json server
        let booksURL=URL(string: url)!
        let data=try Data(contentsOf: booksURL)
        let json=try JSONSerialization.jsonObject(with: data ) as! [String:Any]
        let booksJSON = json["results"] as! [[String : Any]]
        //              print("json loaded ======= { \(json) }")
        DispatchQueue.global().sync {
          for book in booksJSON {
            
            self.booksArray.append(Books(id: book["id"]! as! Int,
                                         authors: book["authors"]! as! [[String:Any]],
                                         bookshelves: book["bookshelves"]! as! [String],
                                         download_count: book["download_count"]! as! Int,
                                         formats: book["formats"]! as! [String:String],
                                         languages: book["languages"]! as! [String],
                                         media_type: book["media_type"]! as! String,
                                         subjects: book["subjects"]! as! [String],
                                         title: book["title"]! as! String))
            
          }
        }
        
        print("~~ Array Count = \(self.booksArray.count)")
        print("~~ Formats text/plain URL \(self.booksArray[0].formats["text/plain; charset=utf-8"]!)")
        
        
        let textURL=URL(string: self.booksArray[0].formats["text/plain; charset=utf-8"]!)!
        let textData=try Data(contentsOf: textURL)
        
        let textFromURL = String(data: textData, encoding: .utf8)!
        self.textView.text = textFromURL
        self.textView.setText(textFromURL)

        
        
        
      }
      catch {
        print("cannot load from server")
      }
      
    }
  }
}
  
