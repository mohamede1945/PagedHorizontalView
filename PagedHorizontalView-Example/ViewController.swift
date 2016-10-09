//
//  ViewController.swift
//  PagedHorizontalView
//
//  Created by Mohamed Afifi on 06/27/2015.
//  Copyright (c) 06/27/2015 Mohamed Afifi. All rights reserved.
//

import UIKit
import PagedHorizontalView

class ViewController: UIViewController {
    
    @IBOutlet weak var horizontalView: PagedHorizontalView!

    let items: [(image: String, label: String)] = [
        ("1", "The first image from space"),
        ("2", "The second image from space"),
        ("3", "The third image from space"),
        ("4", "The fourth image from space"),
        ("5", "The fifth image from space")]

    override func viewDidLoad() {
        super.viewDidLoad()

//        horizontalView.pageControl?.numberOfPages = items.count
    }
}

extension ViewController : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        let item = items[(indexPath as NSIndexPath).item]
        cell.imageView.image = UIImage(named: item.image)
        cell.label.text = item.label
        return cell
    }
}
