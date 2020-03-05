import UIKit

class ViewController: UIViewController {

    private var model = CalculatorModel()
    
    private var isUserTyping: Bool = false
    
    // MARK: - Display Lable in the current screen
    @IBOutlet weak var labelText: UILabel!
    
    private var currentDisplay : Double{
        get{
            return Double(labelText.text ?? "0") ?? 0
        }
        set{
            labelText.text = "\(newValue)"
        }
    }
    
    // MARK: - Super controller
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }

    // MARK: - Digit pressed by user
    @IBAction func pressDigit(_ sender: UIButton) {
        let digit = sender.currentTitle ?? ""
        if isUserTyping {
            let currentScr = labelText.text!
            labelText.text = currentScr + digit
        } else {
            labelText.text = digit
            isUserTyping = true
        }
    }
    
    // MARK: -  Operation key pressed by user
    @IBAction func operacionBtn(_ sender: UIButton) {
        if isUserTyping {
            model.set(operand: currentDisplay)
            isUserTyping = false
        }
        if let mathSymbol = sender.currentTitle {
            print(mathSymbol)
            model.performance(mathSymbol)
        }
        currentDisplay = model.result
    }
    
}

