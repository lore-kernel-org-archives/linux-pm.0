From: Matt Ranostay <mranostay@gmail.com>
Subject: [RFC 0/2] power_supply: add new POWER_SUPPLY_PROP_POLL_INTERVAL property
Date: Wed, 21 Sep 2016 22:52:22 -0700
Message-ID: <1474523544-3064-1-git-send-email-matt@ranostay.consulting>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <len.brown@intel.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Matt Ranostay <matt@ranostay.consulting>
List-Id: linux-pm@vger.kernel.org

Some drivers should report and allow changes to the device polling interval of
new stats.

Matt Ranostay (2):
  power: power_supply: add new property POWER_SUPPLY_PROP_POLL_INTERVAL
  power: bq27xxx_battery: add poll interval property query

 Documentation/power/power_supply_class.txt |  1 +
 drivers/power/bq27xxx_battery.c            | 37 ++++++++++++++++++++++++++++++
 drivers/power/power_supply_sysfs.c         |  1 +
 include/linux/power_supply.h               |  1 +
 4 files changed, 40 insertions(+)

-- 
2.7.4
