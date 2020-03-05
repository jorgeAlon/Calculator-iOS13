import Foundation

struct CalculatorModel {
    // MARK: - Valores
    private var acumulador : Double?
    
    var result: Double{
        return acumulador ?? 0
    }
    
    // MARK: - Operandos
    
    mutating func set(operand:Double){
        self.acumulador = operand
    }
    
    // MARK: - Operaciones
    
    private enum Operacion{
        case constante(Double)
        case operacionUnaria( (Double)->Double )
        case operacionBinaria( (Double,Double)->Double )
        case igual
    }
    
    private var operaciones: [String:Operacion] = [
        "𝜋" : .constante(Double.pi),
        "√" : .operacionUnaria(sqrt),
        "＋" : .operacionBinaria{$0 + $1},
        "−" : .operacionBinaria{$0 - $1},
        "×" : .operacionBinaria{$0 * $1},
        "÷" : .operacionBinaria{$0 / $1},
        "AC" : .constante(0),
        "＝" : .igual
    ]
    // MARK: - Representacion de operaciones
    mutating func performance(_ symbol:String){
        if let operacion = operaciones[symbol]{
            switch operacion {
                case .constante(let value):
                    self.acumulador = value
                    break
                case .operacionUnaria(let function):
                    if self.acumulador != nil{
                        self.acumulador = function(acumulador!)
                    }
                    break
                case .operacionBinaria(let function):
                    if self.acumulador != nil{
                        pbo = Pendiente(arg1: acumulador!, function: function)
                        acumulador = nil
                    }
                    break
                case .igual:
                    perfomBO()
                    break
            }
        }
    }
    
    private mutating func perfomBO(){
        if pbo != nil, acumulador != nil{
            self.acumulador = pbo?.perfom(arg2: acumulador!)
            self.pbo = nil
        }
    }
    
    private var pbo:Pendiente?
    
    // MARK: - Guardar la primera parte de una operacion binaria
    private struct Pendiente{
        let arg1 : Double
        let function:(Double,Double)->Double
        
        func perfom(arg2:Double) -> Double {
            return function(arg1,arg2)
        }
    }
}
