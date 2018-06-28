//
//  Log.swift
//  STRVWeather
//
//  Created by yusuf_kildan on 27.06.2018.
//  Copyright © 2018 yusuf_kildan. All rights reserved.
//

import SwiftyBeaver

let log = SwiftyBeaver.self

func setupLogger() {
    log.addDestination(ConsoleDestination())
}
