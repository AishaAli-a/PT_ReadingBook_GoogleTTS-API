
import UIKit

class PALongTextView: UILabel , UIScrollViewDelegate{
  
  private var sectionViews: [AnyObject]?
  
  var scrollView =  UIScrollView()
  var pageControl = UIPageControl ()
  var myCustomeLable = UILabel ()
  var texts: [String] = []
  var voiceType: VoiceType?
  var textViews = [AnyHashable]()
  var myPersonalTest: [UILabel] = []

  



  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    baseInit()
  }
  
  
  func baseInit() {
    
    print("- - - - baseInit")

    var scrollFrame:CGRect = self.bounds
    print("- -scrollView.bounds - - \(scrollView.bounds)")

    scrollFrame.size.height -= 40
    
    var pageControlFrame:CGRect = self.bounds
    
    pageControlFrame.size.height = 40 // place
    
    pageControlFrame.origin.y = scrollFrame.origin.y + scrollFrame.size.height
    
    
    // Here main view
    scrollView = UIScrollView(frame: scrollFrame)
    scrollView.isPagingEnabled = true
    scrollView.delegate = self
    scrollView.backgroundColor = .lightGray
    
//    UILabel.backgroundColor = .cmOrange3
    
    // Indicators
    pageControl = UIPageControl(frame: pageControlFrame)
    pageControl.pageIndicatorTintColor = .blue
    pageControl.currentPageIndicatorTintColor = UIColor.red
    

    // Adding the Two Views
    addSubview(scrollView)
    addSubview(pageControl)
    
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }
  
  
  func setText(_ text: String) {
    self.text = text
    calculate()
  }
  
  func calculate() {
    if (sectionViews != nil) {
      for view in sectionViews! {
        view.removeFromSuperview()
      }
      sectionViews = nil
    }


    let words:[String] = text!.components(separatedBy: " ")
    
    let testLabel = UILabel(frame: scrollView.bounds)
    
    testLabel.numberOfLines = 60
    testLabel.text = "Hello"
    var currentSize = testLabel.frame.size
    currentSize.width -= 1004
    
    let bestSize = testLabel.sizeThatFits(currentSize)
    let lineHeight = Int(bestSize.height)
    
    var pages: Int = 0
    var cursur = 0
    var section: String = ""
    
    
    
    while cursur < words.count {
      
      let word = words[cursur]
      section.append(" "+word)
      testLabel.text = section
      let bestSize = testLabel.sizeThatFits(currentSize)
      if bestSize.height + CGFloat(lineHeight) >= currentSize.height {
        
        texts.append(section)
        section = ""
      }
      cursur += 1
    }

    texts.append(section)
    pages = texts.count

    
    
    var resultString = "  "
    for section in texts {
      resultString.append(section)
//      print("\n\n# # #\n\(resultString) \n###############\n")


  
    }

    
    
    //MARK: - Here i am

    var i = 0
    
    for text in texts {

      let frame: CGRect = CGRect(origin: CGPoint(x: scrollView.frame.size.width * CGFloat(i),
                                                 y: 0), size: scrollView.frame.size)
      let view = UIView(frame: frame)
//      print("\n\n- - - -view :\(view)\n\n")


      //Widths HERE
      var labelFrame = self.scrollView.bounds
      labelFrame.origin.x += 25
      labelFrame.size.width -= 1004// may be here the solution of your problem
      labelFrame.size.height -= 1255
      
      //TODO: -  My custome Label
      
      myCustomeLable = UILabel(frame: labelFrame) // هنا آنشأت الفريم sol must be here
      myCustomeLable.backgroundColor = .blue
      
      myCustomeLable.numberOfLines = 100
      
      // here should print the text
      myCustomeLable.text = "\(text)"
//      print("====")

//      print("\n\n- - - -label.text :\(myCustomeLable.text!)\n\n")
//      SpeechService.shared.speak(text: myCustomeLable.text!, voiceType: .standardFemale){
//      }
      myCustomeLable.sizeToFit()
      myPersonalTest.append(myCustomeLable)
      view.addSubview(myCustomeLable)
      scrollView.addSubview(view)
      textViews.append(view)
      i += 1
    }
    
    
    scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(texts.count), height: scrollView.frame.size.height)
    pageControl.numberOfPages = texts.count
    pageControl.currentPage = 0
    print("\n\n# # #\n\(myPersonalTest.count)\n\n")

  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {

    let pageWidth: CGFloat = self.scrollView.frame.size.width;
    let page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = Int(page)
    let b = myPersonalTest[Int(page)].text!
    print("\n\n# # #\n\(myPersonalTest[Int(page)].text!)\n\n")
    SpeechService.shared.speak(text: b , voiceType: .standardMale){
    }
  }
  
  // MARK: - It Takes the priveous text
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

  }
  
  



}



