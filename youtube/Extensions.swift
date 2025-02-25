
import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

let imageCache: AnyObject = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    var imageUrlString: String?
    
    func loadImageUingURLString(urlString: String){
        imageUrlString = urlString
     
            let url = URL(string: urlString)
        image = nil
        if let imageFromCache = imageCache.object(forKey: urlString) as? UIImage{
            
            self.image = imageFromCache
            return
        }
            URLSession.shared.dataTask(with: url!,completionHandler: { (data,responses,error) in
                if  error != nil{
                    
                    print(error!)
                    return
                }
                DispatchQueue.main.async {
                    
                   let imageToCache  = UIImage(data: data!)
                    if self.imageUrlString == urlString{
                        
                          self.image = imageToCache
                    }
                    
                    imageCache.set(imageToCache!, forKey: urlString)
                  
                }
                
                
                }).resume()
        }
        
}
