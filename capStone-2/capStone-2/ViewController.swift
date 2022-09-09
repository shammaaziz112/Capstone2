//
//  ViewController.swift
//  capStone-2
//
//  Created by AlenaziHazal on 13/02/1444 AH.
//

import UIKit
import CoreLocation
class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    var locationManeger = CLLocationManager()
    var myImage:Data?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Hazal test merge
        // Hazal Second
        locationManeger.delegate = self
        locationManeger.requestAlwaysAuthorization()
        locationManeger.startUpdatingLocation()
        fetchImage()
        print("bahbja")
    }
    func fetchImage(){
        //Step1
        // Take the String URl for filker
        let StringUrl = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=372018c5205cf1fca8a86006716de2f8&lat=24.774265&lon=46.738586&radius=10&format=json&nojsoncallback=1&auth_token=72157720856612035-7f702afff41e1783&api_sig=41075711e4565289e5f615392b6e0145"
        //Step2
        // Conver StringURL to URL
        guard let Url = URL(string: StringUrl) else {
            print("URl string is nil")
            return
        }
        //Step3
        //Take the URL to session
        let Image = URLSession.shared.dataTask(with: Url) { data, responce, erorr in
            guard erorr == nil else{
                print("Erorr: \(erorr!.localizedDescription)")
                return
            }
            guard let responce = responce as? HTTPURLResponse else {
                print("responce: is nil")
                return
            }
            guard responce.statusCode >= 200
                    && responce.statusCode <= 299 else {
                print("Statuse Code Should be 2xx, Butthe code is \(responce.statusCode)")
                return
            }
            //if we want to read json NOT MATTER
           // let jsonString = String(data: data!, encoding: .utf8)
           // print("Jsone:\(jsonString!)")
            
            //Step4
            //Decode json from the MODEL from the Navigator in the Left
            guard let json = try? JSONDecoder().decode(Welcome.self, from: data!) else {
                print("Json Error")
                return
            }
            //Step5
            // I Finished the Requires number 2
            let omage2 = "https://live.staticflickr.com/\(json.photos.photo[2].server)/\(json.photos.photo[2].id)_\(json.photos.photo[2].secret).jpg"
            //We need to put all the omgae2 above in array and appeaned them becosue the image dosn't have long and lat tude in the URL we take so its hard to inplement all the lat and long one by one (Think if you can do it) otherwise i do the Requires
            
            //change the stringImage to urlData
            guard let url1 = URL(string: omage2) else {print("imageErorr")
                return}
            //change the urlData to Data for present it
            guard let data1 = try? Data(contentsOf: url1) else {return}
            //Put the data we take to the varable
            self.myImage = data1
            //use Dispatch to raech main async to show th eimage we take from url 
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: self.myImage!)
            }
         
        }
        
        Image.resume()
    }

}

