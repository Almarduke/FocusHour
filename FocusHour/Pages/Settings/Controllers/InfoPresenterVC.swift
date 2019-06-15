//
//  AboutInfo.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/2/12.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class InfoPresenterVC: UIViewController {

    @IBOutlet weak var textArea: UITextView!
    var navTitle: String!
    var info: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = navTitle
        textArea.text = info
        let nightMode = UserDefaults.standard.bool(forKey: "NightMode");
        let textColor = nightMode == true ? UIColor.white : UIColor.black;
        textArea.textColor = textColor;
        UITool.setBackgroundImage(view, imageName: ThemeTool.getCurrentTheme().backgroundImageName);
        self.navigationController?.navigationBar.barTintColor = UIColor.ColorHex(hex: ThemeTool.getCurrentTheme().navigationColor)
    }

//    override func viewWillAppear(_ animated: Bool) {
//        let nightMode = UserDefaults.standard.bool(forKey: "NightMode");
//        UITool.setBackgroundImage(view, random: false, nightMode: nightMode);
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let nightMode = UserDefaults.standard.bool(forKey: "NightMode");
//        UITool.setBackgroundImage(view, random: false, nightMode: nightMode);
//    }

}
