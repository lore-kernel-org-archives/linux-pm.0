From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v13.2 00/11] bq27xxx_battery partial series
Date: Tue,  9 May 2017 01:21:19 -0700
Message-ID: <20170509082123.27592-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33053 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbdEIIVX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 May 2017 04:21:23 -0400
Received: by mail-pf0-f195.google.com with SMTP id a23so100528pfe.0
        for <linux-pm@vger.kernel.org>; Tue, 09 May 2017 01:21:23 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org

Hi Sebastian,

Andrew and I need your help in resolving three issues in this series.
I describe the issues in replies to the following patches. (The first
patch is included for context; there are no issues with it.)

Thanks!

  power: supply: bq27xxx_battery: Add chip data memory read/write support
  power: supply: bq27xxx_battery: Add power_supply_battery_info support
  power: supply: bq27xxx_battery: Enable data memory update for certain chips
  power: supply: bq27xxx_battery: Flag identical register maps when in debug mode

-- 
2.9.3
