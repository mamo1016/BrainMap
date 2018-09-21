////
////  Line.swift
////  BrainMap
////
////  Created by 上田　護 on 2018/09/21.
////  Copyright © 2018年 mamoru.ueda. All rights reserved.
////
//
//import Foundation
//import  UIKit
//
//class Line{
//    weak var shapeLayer: CAShapeLayer?
//
//    func cleateLine(){
//        self.shapeLayer?.removeFromSuperlayer()
//
//        // create whatever path you want
//
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 10, y: 50))
//        path.addLine(to: CGPoint(x: 200, y: 50))
//        path.addLine(to: CGPoint(x: 200, y: 240))
//
//        // create shape layer for that path
//
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
//        shapeLayer.strokeColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1).cgColor
//        shapeLayer.lineWidth = 4
//        shapeLayer.path = path.cgPath
//
//
//    }
//    func animetion(){
//        // animate it
//
//        //        view.layer.addSublayer(shapeLayer)
//        let animation = CABasicAnimation(keyPath: "strokeEnd")
//        animation.fromValue = 0
//        animation.duration = 2
//        shapeLayer.add(animation, forKey: "MyAnimation")
//
//        // save shape layer
//
//        self.shapeLayer = shapeLayer
//
//    }
//}
