//
//  ShoppingAppTesting.swift
//  Sprint2Tests
//
//  Created by Capgemini-DA073 on 9/28/22.
//

import XCTest
@testable import Sprint2

class ShoppingAppTesting: XCTestCase {

    
    var loginVc: LoginViewController!
    var signUpVc: SignUpViewController!
    var cartVc: CartViewController!
    var mapVc: MapForLocationViewController!
    var notificationVc: NotificationViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        signUpVc = SignUpViewController.getVC()
        signUpVc.loadViewIfNeeded()
        
        loginVc = LoginViewController.getVC()
        loginVc.loadViewIfNeeded()
        
        //cartVc = CartViewController.getVC()
        //cartVc.loadViewIfNeeded()
        
        mapVc = MapForLocationViewController.getVC()
        mapVc.loadViewIfNeeded()
        
        notificationVc = NotificationViewController.getVC()
        notificationVc.loadViewIfNeeded()
    }
    
    func test_checkButtonAction() throws{
        let signUpBtn : UIButton = try XCTUnwrap(signUpVc.SignupButton,"SignUp does not have referencing outlet")
        let signAct = try XCTUnwrap(signUpBtn.actions(forTarget:signUpVc, forControlEvent: .touchUpInside),"No action")
        XCTAssertEqual(signAct.count,1)
        
        let loginBtn : UIButton = try XCTUnwrap(loginVc.LoginButton,"Login does not have referencing outlet")
        let loginAct = try XCTUnwrap(loginBtn.actions(forTarget:loginVc, forControlEvent: .touchUpInside),"No action")
        XCTAssertEqual(loginAct.count,1)
        
     //   let cartBtn : UIButton = try XCTUnwrap(cartVc.SignupButton,"SignUp does not have referencing outlet")
       // let cartAct = try XCTUnwrap(signUpBtn.actions(forTarget:signUpVc, forControlEvent: .touchUpInside),"No action")
      //  XCTAssertEqual(signAct.count,1)
        
        let mapBtn : UIButton = try XCTUnwrap(mapVc.ConfirmOrderButton,"MapButton does not have referencing outlet")
        let mapAct = try XCTUnwrap(mapBtn.actions(forTarget:mapVc, forControlEvent: .touchUpInside),"No action")
        XCTAssertEqual(mapAct.count,1)
        
        let notificationBtn : UIButton = try XCTUnwrap(notificationVc.getNotificationButton,"Notification does not have referencing outlet")
        let notificationAct = try XCTUnwrap(notificationBtn.actions(forTarget:notificationVc, forControlEvent: .touchUpInside),"No action")
        XCTAssertEqual(notificationAct.count,1)
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
