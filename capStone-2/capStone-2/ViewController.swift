//
//  ViewController.swift
//  capStone-2
//
//  Created by AlenaziHazal on 13/02/1444 AH.
//

import UIKit
import CoreLocation
class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var collectionViewFlickr: UICollectionView!

    var locationManeger = CLLocationManager()
//    var myImage:Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewFlickr.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
        // Hazal test merge
        // Hazal Second
        locationManeger.delegate = self
        locationManeger.requestAlwaysAuthorization()
        locationManeger.startUpdatingLocation()
        
        print("bahbja")
    }

}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
            
        let StringUrl = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=aaa2a4aa90e3f5fb291032faa5f2c690&lat=24.774265&lon=46.738586&radius=10&format=json&nojsoncallback=1&auth_token=72157720856705390-dad22851d0976dc0&api_sig=7a8db46f8f689f8e4666b1c51a6f13b4"
        
        cell.cellImage.loadImageWithCashe(StringUrl, indexPath: indexPath.row)
        
        return cell
    }
}

var imageToCashe = NSCache<NSString, UIImage>()
extension UIImageView{
    
    func loadImageWithCashe(_ urlString: String, indexPath: Int){
        
        self.image = nil
        
        if let cacheImage = imageToCashe.object(forKey: NSString(string: urlString)) {
            self.image = cacheImage
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let Image = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error)
            }
            
            guard let json = try? JSONDecoder().decode(Welcome.self, from: data!) else {
                print("Json Error")
                return
            }
            
            let omage2 = "https://live.staticflickr.com/\(json.photos.photo[indexPath].server)/\(json.photos.photo[indexPath].id)_\(json.photos.photo[indexPath].secret).jpg"
            
            guard let url1 = NSURL(string: omage2) else {print("imageErorr")
                return}
            
            guard let data1 = try? Data(contentsOf: url1 as URL) else {return}
            
            if let downloadImage = UIImage(data: data1){
                DispatchQueue.main.async {
                    self.image = downloadImage
                    imageToCashe.setObject(downloadImage, forKey: NSString(string: urlString))
                }
            }
        }
        Image.resume()
    }
}
