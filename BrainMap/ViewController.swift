//
//  ViewController.swift
//  BrainMap
//
//  Created by 上田　護 on 2018/08/21.
//  Copyright © 2018年 mamoru.ueda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    var i: Int = 0
    
    // Screen Size の取得
    var screenWidth:CGFloat!
    var screenHeight:CGFloat!
    
    var circleArray:[Draw] = []
    var draw: [Draw] = []
//    var location: CGPoint!
    var touchCheck: Bool = false
    var position: CGPoint = CGPoint(x:0.0,y:0.0)
    var oldPosition: CGPoint = CGPoint(x:0.0,y:0.0)
    var newPosition: CGPoint = CGPoint(x:0.0,y:0.0)
    var circle: UIView?
    
    let line = UIBezierPath();


    override func viewDidLoad() {
        super.viewDidLoad()
        screenWidth = view.frame.size.width
        screenHeight = view.frame.size.height
        //Drawインスタンス作成
        draw.append(Draw(frame: CGRect(x: screenWidth/2, y: screenHeight/2, width: 70, height: 70)))
        draw[0].center = self.view.center
        draw[0].layer.cornerRadius = 35
        draw[0].layer.masksToBounds = true
        draw[0].backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.view.addSubview(draw[0])


        // 画面背景を設定
        self.view.backgroundColor = UIColor(red:0.85,green:1.0,blue:0.95,alpha:1.0)
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(ViewController.tapped(_:)))
        
        // デリゲートをセット
        tapGesture.delegate = self
        
        self.view.addGestureRecognizer(tapGesture)
        
        // ロングプレス
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPress(_:)))
        
        longPressGesture.delegate = self
        
        // Viewに追加.
        self.view.addGestureRecognizer(longPressGesture)
        //            createCircle(x: 100, y: 100) //タッチした座標にしたい
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.timerUpdate), userInfo: nil, repeats: true)
        
//        // 起点
//        line.move(to: frame.origin);
//        // 帰着点
//        line.addLine(to: CGPoint(x: 0, y: 0));
//        // ライン幅
//        line.lineWidth = 4
//        // 描画
//        line.stroke();

    }
    
    // 画面にタッチで呼ばれる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchCheck = false

        let touchEvent = touches.first! //このタッチイベントの場合確実に1つ以上タッチ点があるので`!`つけてOKです
//        let location = touchEvent.location(in: self.view) //in: には対象となるビューを入れます
    }
    
    //　ドラッグ時に呼ばれる
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // タッチイベントを取得
        let touchEvent = touches.first!
        
        // ドラッグ前の座標, Swift 1.2 から
        let preDx = touchEvent.previousLocation(in: self.view).x
        let preDy = touchEvent.previousLocation(in: self.view).y
        
        // ドラッグ後の座標
        let newDx = touchEvent.location(in: self.view).x
        let newDy = touchEvent.location(in: self.view).y
        
//        // ドラッグしたx座標の移動距離
        let dx = newDx - preDx
//
//        // ドラッグしたy座標の移動距離
        let dy = newDy - preDy
        
    }

    
    func updateCircle() {
        view.setNeedsDisplay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func createCircle(){
        i += 1
        //Drawインスタンス作成
        draw.append(Draw(frame: CGRect(x:position.x, y:position.y-10, width: 70, height: 70)))
        //        draw.center = CGPoint(x: location.x, y: location.y)
        draw[i].layer.cornerRadius = 35
        draw[i].layer.masksToBounds = true
        draw[i].backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.view.addSubview(draw[i])
        
        touchCheck = false
//        oldPosition = position
        circle = draw[i]
    }
    
    // Tap イベント
    @objc func tapped(_ sender: UITapGestureRecognizer){
        if sender.state == .ended {
//            print("Tap")
        }
    }
    
    // Long Press イベント
    @objc func longPress(_ sender: UILongPressGestureRecognizer){
//                print("\(sender.state == .began) && \(draw.inside)")
        if sender.state == .began && touchCheck{
            // 開始は認知される
            createCircle()

        }else if sender.state == .changed {
//            print("change")
//            let location = sender.location(in: view)
//            print(location.x)
//            print(location.y)
            let location = sender.location(in: view)
            var frame = circle?.frame
            frame?.origin = CGPoint(x: location.x-35, y: location.y-35)
            circle?.frame = frame!
            newPosition = (frame?.origin)!
        }else if sender.state == .ended {
            print("end-----")
            for i in 0 ..< draw.count{
//                print(draw[i].frame.origin)
            }
            print("\(oldPosition)---\(newPosition)")
        }
    }
    
    @objc func timerUpdate() {
//        print(touchCheck)
    }
}
