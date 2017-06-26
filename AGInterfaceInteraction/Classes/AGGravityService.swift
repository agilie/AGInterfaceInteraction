//
//  AGGravityService.swift
//  Pods
//
//  Created by Michael Liptuga on 16.05.17.
//
//

import Foundation

import UIKit
import CoreMotion

struct SubviewStruct {
    
    var view                : UIView? = nil
    var originPoint         : CGPoint = CGPoint.zero
    
    init(object : UIView, origin : CGPoint) {
        view = object
        originPoint = origin
    }
}

struct ViewStruct {
    
    var view                : UIView? = nil
    var centerPoint         : CGPoint = CGPoint.zero
    var bounds              : CGRect = CGRect.zero
    var isNewView           : Bool = false
    var scrollEnabled       : Bool = true
    
    init(object : UIView, center : CGPoint, frame : CGRect, isNew : Bool, isScrollEnabled : Bool) {
        view = object
        centerPoint = center
        bounds = frame
        isNewView = isNew
        scrollEnabled = isScrollEnabled
    }
}

public class AGGravityService: NSObject {
    
    fileprivate var timer : Timer? = nil
    
    fileprivate var subviews    : [UIView] = []
    fileprivate var viewStructs : [ViewStruct] = []
    
    fileprivate var animator    : UIDynamicAnimator!
    fileprivate var gravity     : UIGravityBehavior? = nil
    
    // For getting device motion updates
    fileprivate let motionQueue     = OperationQueue()
    fileprivate let motionManager   = CMMotionManager()
    
    fileprivate var view : UIView? = nil
    
    fileprivate var viewControllerSubviews : [SubviewStruct] = []
    
    fileprivate var collisionMode : UICollisionBehaviorMode = .everything
    
    fileprivate lazy var motionHandler : CMDeviceMotionHandler = {
        (motion,error) in
        self.gravityUpdated(motion: motion, error: error)
    }
    
    public func startGravityViewController (viewController : UIViewController, duration : Float, collisionMode : UICollisionBehaviorMode)
    {
        self.collisionMode = collisionMode
        self.startGravityViewController(viewController: viewController, duration: duration)
    }
    
    
    public func startGravityView (view : UIView, duration : Float, collisionMode : UICollisionBehaviorMode)
    {
        self.collisionMode = collisionMode
        self.startGravityView(view : view, duration: duration)
    }
    
    public func startGravityViewController (viewController : UIViewController, collisionMode : UICollisionBehaviorMode)
    {
        self.collisionMode = collisionMode
        self.startGravityViewController(viewController: viewController)
    }
    
    public func startGravityView (view : UIView, collisionMode : UICollisionBehaviorMode)
    {
        self.collisionMode = collisionMode
        self.startGravityView(view : view)
    }
    
    public func startGravityViewController (viewController : UIViewController, duration : Float)
    {
        self.startGarvityTimer(duration: duration)
        self.startGravityViewController(viewController: viewController)
    }
    
    public func startGravityView (view : UIView, duration : Float)
    {
        self.startGarvityTimer(duration: duration)
        self.startGravityView(view: view)
    }
    
    public func startGravityView (view : UIView)
    {
        self.deselectTableViewRows(view : view)
        view.isUserInteractionEnabled = false
        
        self.startDeviceMotionUpdates()
        self.configureAnimatorForViewControllerView(view: view, views: [SubviewStruct.init(object: view, origin: CGPoint.zero)])
        self.configureDynamicAnimator()
    }
    
    public func startGravityViewController (viewController : UIViewController)
    {
        self.sortOutViewController(viewController: viewController, deepSorting: true)
        if let view = viewController.view {
            view.isUserInteractionEnabled = false
            self.startDeviceMotionUpdates()
            self.configureAnimatorForViewControllerView(view: view, views: self.viewControllerSubviews)
            self.configureDynamicAnimator()
        }
    }
    
    public func stopGravity ()
    {
        self.stopDeviceMotionUpdates()
        self.removeDynamicAnimator()
    }
    
    public func stopAnimationWithDuration ()
    {
        if ((self.timer) != nil) {
            self.timer?.invalidate()
            self.timer = nil
        }
        self.stopGravity()
    }
}

extension AGGravityService
{
    fileprivate func startGarvityTimer (duration : Float)
    {
        if (self.timer == nil) {
            self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(duration), target: self, selector: #selector(AGGravityService.stopAnimationWithDuration), userInfo: nil, repeats: false)
        }
    }
    
    fileprivate func deselectTableViewRows (view : UIView)
    {
        switch view {
        case is UITableView:
            let tableView : UITableView = view as! UITableView
            
            self.viewStructs.append(ViewStruct.init(object: view, center: view.center, frame: view.bounds, isNew: false, isScrollEnabled: tableView.isScrollEnabled))
            
            for cell in tableView.visibleCells {
                cell.isSelected = false
                cell.isHighlighted = false
            }
        case is UICollectionView:
            let collectionView : UICollectionView = view as! UICollectionView
            
            self.viewStructs.append(ViewStruct.init(object: view, center: view.center, frame: view.bounds, isNew: false, isScrollEnabled: collectionView.isScrollEnabled))
            
            for cell in collectionView.visibleCells {
                cell.isSelected = false
                cell.isHighlighted = false
            }
        default:
            break
        }
    }
    
    fileprivate func removeDynamicAnimator ()
    {
        self.animator.removeAllBehaviors()
        self.animator = nil
        
        for viewStruct in self.viewStructs {
            guard let currentView = viewStruct.view else {
                break
            }
            
            if (!(viewStruct.view?.isHidden)!) {
                viewStruct.view?.center = viewStruct.centerPoint
                viewStruct.view?.bounds = viewStruct.bounds
            }
            
            viewStruct.view?.isHidden = false
            viewStruct.view?.transform = CGAffineTransform.identity
            
            if (viewStruct.isNewView) {
                viewStruct.view?.removeFromSuperview()
            }
            
            switch currentView {
            case is UITableView:
                let tableView : UITableView = currentView as! UITableView
                    tableView.isScrollEnabled = viewStruct.scrollEnabled
                break
            case is UICollectionView:
                let collectionView : UICollectionView = currentView as! UICollectionView
                    collectionView.isScrollEnabled = viewStruct.scrollEnabled
                break
                
            default:
                break;
            }
        }
        self.subviews.removeAll()
        self.viewStructs.removeAll()
        self.viewControllerSubviews.removeAll()
        self.view?.isUserInteractionEnabled = true
        self.view = nil
        if (self.gravity != nil) {
            self.gravity = nil
        }
    }
    
    fileprivate func startDeviceMotionUpdates () {
        motionManager.startDeviceMotionUpdates(to: motionQueue, withHandler: motionHandler)
    }
    
    fileprivate func stopDeviceMotionUpdates () {
        motionManager.stopDeviceMotionUpdates()
    }
    
    fileprivate func gravityUpdated(motion: CMDeviceMotion?, error: Error?) {
        let grav : CMAcceleration = motion!.gravity;
        
        let x = CGFloat(grav.x);
        let y = CGFloat(grav.y);
        var p = CGPoint(x: x, y: y)
        
        if error != nil
        {
            NSLog("\(String(describing: error))")
        }
        
        // Have to correct for orientation.
        switch UIApplication.shared.statusBarOrientation {
        case .landscapeLeft:
            let t = p.x
            p.x = 0 - p.y
            p.y = t
            break
        case .landscapeRight:
            let t = p.x
            p.x = p.y
            p.y = 0 - t
            break
        case .portraitUpsideDown:
            p.x *= -1
            p.y *= -1
            break
        default:
            break
        }
        let v = CGVector(dx: p.x, dy: -p.y)
        if (gravity != nil) {
            gravity!.gravityDirection = v
        }
    }
    
    fileprivate func configureAnimatorForViewControllerView (view : UIView, views : [SubviewStruct]) {
        if (self.view == nil) {
            self.view = view
        }
        if (!(self.subviews.count > 0)) {
            self.subviews.removeAll()
            for subviewStruct in views {
                if let subview = subviewStruct.view {
                    self.createViewsArray(views: subview.subviews,
                                          needToRemove: false,
                                          viewOrigin: subviewStruct.originPoint)
                }
            }
        }
        if (self.animator == nil) {
            self.animator = UIDynamicAnimator.init(referenceView: view)
        }
    }
    
    fileprivate func configureDynamicAnimator ()
    {
        if (self.subviews.count > 0) {
            self.animator.removeAllBehaviors()
            
            self.gravity = UIGravityBehavior.init(items: self.subviews)
            
            self.animator.addBehavior(self.gravity!)
            
            let collision : UICollisionBehavior = UICollisionBehavior.init(items: self.subviews)
            collision.collisionMode = self.collisionMode
            
            collision.translatesReferenceBoundsIntoBoundary = true
            collision.collisionDelegate = nil
            self.animator.addBehavior(collision)
            
            let itemBehavior : UIDynamicItemBehavior = UIDynamicItemBehavior(items: self.subviews)
            itemBehavior.friction = 0.2
            itemBehavior.allowsRotation = true
            itemBehavior.elasticity = 0.5
            itemBehavior.resistance = 1
            
            for view in self.subviews {
                itemBehavior.addAngularVelocity(CGFloat.pi / 4, for: view)
            }
            self.animator.addBehavior(itemBehavior)
        }
    }
    
    fileprivate func sortOutViewController (viewController : UIViewController, deepSorting : Bool)
    {
        switch viewController {
        case is UINavigationController:
            let navigationController = viewController as! UINavigationController
            if let visibleViewController = navigationController.visibleViewController {
                if (deepSorting){
                    self.sortOutViewController(viewController: visibleViewController, deepSorting: deepSorting)
                }
            }
            break
        case is UITabBarController:
            let tabBarController = viewController as! UITabBarController
            if (!tabBarController.tabBar.isHidden && !(tabBarController.tabBar.alpha == 0)) {
                self.viewControllerSubviews.append(SubviewStruct.init(object: tabBarController.tabBar,
                                                                      origin: tabBarController.tabBar.frame.origin))
            }
            if let visibleViewController = tabBarController.selectedViewController {
                if (deepSorting){
                    self.sortOutViewController(viewController: visibleViewController, deepSorting: deepSorting)
                }
            }
            break
        default:
            if let navViewController = viewController.navigationController
            {
                self.sortOutViewController(viewController: navViewController, deepSorting: false)
            }
            if let tabBarController = viewController.tabBarController
            {
                self.sortOutViewController(viewController: tabBarController, deepSorting: false)
            }
            if let view = viewController.view
            {
                self.viewControllerSubviews.append(SubviewStruct.init(object: view, origin: CGPoint.zero))
                self.deselectTableViewRows(view : view)
            }
            break
        }
    }
    
    fileprivate func createViewsArray (views : [UIView], needToRemove : Bool, viewOrigin : CGPoint)
    {
        for view in views {
            self.deselectTableViewRows(view: view)
            switch view {
            case is UIButton, is UIDatePicker, is UIPageControl, is UISegmentedControl,
                 is UITextField, is UISlider, is UISwitch, is UIProgressView, is UILabel, is UIImageView, is UITextView:
                self.appendNewViewElement(view: view, viewOrigin: viewOrigin, needToRemove: needToRemove)
                break
            case is UITableView:
                let tableView : UITableView = view as! UITableView
                self.appendScrollViewElements(container: tableView.visibleCells, scrollView: tableView, viewOrigin: viewOrigin, needToRemove: true)
                self.appendCollectionViewElements(container: tableView.subviews, scrollView: tableView, viewOrigin: viewOrigin, needToRemove: true)
                break
            case is UICollectionView:
                let collectionView : UICollectionView = view as! UICollectionView
                self.appendScrollViewElements(container: collectionView.visibleCells, scrollView: collectionView, viewOrigin: viewOrigin, needToRemove: true)
                self.appendCollectionViewElements(container: collectionView.subviews, scrollView: collectionView, viewOrigin: viewOrigin, needToRemove: true)
                break
            case is UIScrollView:
                let scrollView : UIScrollView = view as! UIScrollView
                self.appendScrollViewToViewStructs(scrollView: scrollView, needToRemove: needToRemove, isNew: false)
                self.appendScrollViewElements(container: scrollView.subviews, scrollView: scrollView, viewOrigin: viewOrigin, needToRemove: true)
                break
            case is UICollectionViewCell:
                let collectionViewCell : UICollectionViewCell = view as! UICollectionViewCell
                self.createViewsArray(views: collectionViewCell.contentView.subviews, needToRemove: true, viewOrigin: collectionViewCell.frame.origin)
                if (!needToRemove) {
                    self.viewStructs.append(ViewStruct.init(object: view, center: view.center, frame: view.bounds, isNew: false, isScrollEnabled: false))
                }
                break
            case is UITableViewCell:
                let tableViewCell : UITableViewCell = view as! UITableViewCell
                if let accessoryView = tableViewCell.accessoryView {
                    self.createViewsArray(views: accessoryView.subviews, needToRemove: true, viewOrigin: tableViewCell.frame.origin)
                }
                self.createViewsArray(views: tableViewCell.contentView.subviews, needToRemove: true, viewOrigin: tableViewCell.frame.origin)
                
                if (!needToRemove) {
                    self.viewStructs.append(ViewStruct.init(object: view, center: view.center, frame: view.bounds, isNew: false, isScrollEnabled: false))
                }
                break
            default:
                if (view.subviews.count > 0) {
                    if (!needToRemove) {
                        self.viewStructs.append(ViewStruct.init(object: view, center: view.center, frame: view.bounds, isNew: false, isScrollEnabled: false))
                    }
                    
                    let point = CGPoint(x: viewOrigin.x + view.frame.origin.x,
                                        y: viewOrigin.y + view.frame.origin.y)
                    
                    self.createViewsArray(views: view.subviews, needToRemove: true, viewOrigin: point)
                    
                    if (!view.isHidden && view.clipsToBounds == true) {
                        self.appendNewSubview(view: view, viewOrigin: viewOrigin)
                    }
                    break
                }
                if (!view.isHidden && view.backgroundColor ==  nil) {
                    break
                }
                self.appendNewViewElement(view: view, viewOrigin: viewOrigin, needToRemove: needToRemove)
            }
        }
        
    }
    
    fileprivate func appendScrollViewToViewStructs (scrollView : UIScrollView, needToRemove: Bool, isNew : Bool)
    {
        if (!needToRemove) {
            self.viewStructs.append(ViewStruct.init(object: scrollView, center: scrollView.center, frame: scrollView.bounds, isNew: isNew, isScrollEnabled: scrollView.isScrollEnabled))
            scrollView.isScrollEnabled = false
        }
    }
    
    fileprivate func appendCollectionViewElements (container : [UIView], scrollView : UIScrollView, viewOrigin : CGPoint, needToRemove : Bool) {
        for view in container {
            switch view {
            case is UICollectionViewCell, is UITableViewCell:
                return
            default:
                break
            }
        }
        self.appendScrollViewElements(container: container, scrollView: scrollView, viewOrigin: viewOrigin, needToRemove: needToRemove)
    }
    
    fileprivate func appendScrollViewElements (container : [UIView], scrollView : UIScrollView, viewOrigin : CGPoint, needToRemove : Bool)
    {
        for view in container {
            let point = CGPoint(x: viewOrigin.x + scrollView.frame.origin.x + view.frame.origin.x - scrollView.contentOffset.x,
                                y: viewOrigin.y + scrollView.frame.origin.y + view.frame.origin.y - scrollView.contentOffset.y)
            
            self.createViewsArray(views: view.subviews, needToRemove:  needToRemove, viewOrigin: point)
        }
    }
    
    fileprivate func appendNewViewElement (view : UIView, viewOrigin : CGPoint, needToRemove : Bool)  {
        if (view.frame.height != 0 && view.frame.width != 0 && !view.isHidden) {
            if (needToRemove) {
                self.appendNewSubview(view: view, viewOrigin: viewOrigin)
            } else {
                self.viewStructs.append(ViewStruct.init(object: view, center: view.center, frame: view.bounds, isNew: false, isScrollEnabled: false))
                self.subviews.append(view)
            }
        }
    }
    
    fileprivate func appendNewSubview (view : UIView, viewOrigin : CGPoint)
    {
        self.viewStructs.append(ViewStruct.init(object: view, center: view.center, frame: view.bounds, isNew: false, isScrollEnabled: false))
        let origin : CGPoint = CGPoint(x: viewOrigin.x + view.frame.origin.x, y: viewOrigin.y + view.frame.origin.y)

        if let copyView = view.copyView(origin: origin) {
            view.isHidden = true
            self.view?.addSubview(copyView)
            self.viewStructs.append(ViewStruct.init(object: copyView, center: copyView.center, frame: copyView.bounds, isNew: true, isScrollEnabled: false))
            self.subviews.append(copyView)
        }
    }
}
