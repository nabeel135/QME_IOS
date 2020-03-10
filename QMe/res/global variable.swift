//
//  global variable.swift
//  QMe
//
//  Created by Mr. Nabeel on 2/5/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import Foundation




// for userdefault saved data
let loginAstitle = "loginAskey"
let isUser = "isUser"

let followbtnkey = "followbtnkey"

let userIDkey = "id"
let userNamekey = "name"
let userPhonekey = "phone"
let userEmailkey = "email"
let userImagkey = "photo"
let userpasskey = "password"
let accTypekey = "accountType"
let logedinkey = "logedinkey"




// Admin Shop
var adminShopListobj:[ASL] = []
class ASL{
    var shopid = String()
    var queues_count = String()
    var shop_code = String()
    var shop_name = String()
    var shopimag = String()
    var admin_id = String()
    var admin_name = String()
    var fromday = String()
    var today = String()
    var fromtime = String()
    var totime = String()
    var status = String()
}


var Selectedshopindex = Int()


// Admin Queue
var QueueListobj:[QL] = []
class QL{
    var queue_id = String()
    var queue_name = String()
    var queue_person = String()
    var status = String()
    var admin_id = String()
    var shop_id = String()
    var shop_name = String()
    var shop_code = String()
    var fromTime = String()
    var toTime = String()
    var clerk_id = String()
    var clerk_name = String()
    
}

// unassigned Queue

var unAssignedQueueList:[UQL] = []
class UQL {
    var queue_id = String()
    var queue_name = String()
    var clerk_id = String()
    var clerk_name = String()
    var shop_id = String()
    var shop_name = String()
    var shop_code = String()
    var number_of_persons = String()
    var admin_id = String()
    var opening_time = String()
    var closing_time = String()
    var opening_day = String()
    var closing_day = String()
    var status = String()


}



// Subscriber Request List

var adminrequestlistobj:[ARL] = []
class ARL{
    var userid = String()
    var userimag = String()
    var userName = String()
}



// Clerk List
var clerkNamelist:[String] = []
var clerkListobj:[CL] = []
class CL{
    var clerkId = String()
    var clerkip = String()
    var name = String()
    var email = String()
    var phone = String()
    var status = String()
}


// User Shop List

var userShopListobj:[USL] = []
class USL{
    var shop_id = String()
    var shop_code = String()
    var shop_name = String()
    var queue_count = String()
    var admin_id = String()
    var admin_name = String()
    var image = String()
    var fromDay = String()
    var toDay = String()
    var fromTime = String()
    var toTime = String()
    var status = String()
    
}



var notificationObj:[N] = []
class N {
    var id = String()
    var userid = String()
    var shopid = String()
    var message = String()
    var createdAt = String()
}
