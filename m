From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [RFC PATCH 0/3] power: Generic interface to get battery specification.
Date: Tue, 07 Oct 2014 19:58:35 +0900
Message-ID: <1412679518-21499-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:14259 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830AbaJGK6r (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Oct 2014 06:58:47 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org, pavel@ucw.cz, jenny.tc@intel.com, Jonghwa Lee <jonghwa3.lee@samsung.com>

This patches contains supporting generic interface to get battery specification
and of-based battery driver which use the interface.

Up to now, power supply subsystem assumes that battery's charartric data is
static and also often left as fuelgauge's role. However, fuelgauge driver or
any power_supply driver can be worked with different battery with different
implementation and battery also can be changed even in runtime.
If so, it needs to notify its change to all related power_supply drivers not
let them notice all with private way. Thus, it tries to introduce generic
interface for management of the battery specification.

In addition to, for the smart battery, this'll help to abstract battery
interface which can be varied with different batteries. (SDQ, MIPI BIF..)

Jonghwa Lee (3):
  power: core: Add generic interface to get battery specification.
  power: core: Add variables related temperature to power_supply_info.
  power: of_battery: Initial support for of-based battery specification
    driver.

 .../bindings/power_supply/of_battery.txt           |   34 +++++++
 drivers/power/Kconfig                              |    7 ++
 drivers/power/Makefile                             |    1 +
 drivers/power/of_battery.c                         |  100 ++++++++++++++++++++
 drivers/power/power_supply_core.c                  |   91 ++++++++++++++++++
 include/linux/power_supply.h                       |    9 ++
 6 files changed, 242 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power_supply/of_battery.txt
 create mode 100644 drivers/power/of_battery.c

-- 
1.7.9.5

