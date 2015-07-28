From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 0/6] Add support for additional bq27xxx devices
Date: Tue, 28 Jul 2015 14:39:07 -0500
Message-ID: <1438112353-19704-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58797 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751647AbbG1Tja (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 28 Jul 2015 15:39:30 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>

This series adds support for several additional bq27xxx devices and 
makes a few related fixes. v1 can be found here: [1]

Changes from v1:
 - Drop first four patches from series as they have been queued
   at git://git.infradead.org/battery-2.6.git
 - Remove MODULE_ALIAS
 - Add comment about State-of-Charge
 - Add additional links to documentation
 - Add device names to id table
 - Add unlikely to if statement
 - Change return types to bool for status check functions

Please note this series depends on the first four patches found in v1.

[1] http://www.spinics.net/lists/kernel/msg2039278.html

Andrew F. Davis (6):
  power: bq27x00_battery: Remove unneeded i2c MODULE_ALIAS
  power: bq27x00_battery: Renaming for consistency
  power: bq27xxx_battery: Platform initialization must declare a device
  power: bq27xxx_battery: Fix typos and change naming for state of
    charge functions
  power: bq27xxx_battery: Add support for additional bq27xxx family
    devices
  power: bq27xxx_battery: Cleanup health checking

 MAINTAINERS                           |    4 +-
 arch/arm/configs/omap2plus_defconfig  |    2 +-
 arch/unicore32/Kconfig                |    2 +-
 drivers/power/Kconfig                 |   22 +-
 drivers/power/Makefile                |    2 +-
 drivers/power/bq27x00_battery.c       | 1129 ---------------------------
 drivers/power/bq27xxx_battery.c       | 1360 +++++++++++++++++++++++++++++++++
 drivers/w1/slaves/w1_bq27000.c        |    5 +-
 include/linux/power/bq27x00_battery.h |   19 -
 include/linux/power/bq27xxx_battery.h |   31 +
 10 files changed, 1410 insertions(+), 1166 deletions(-)
 delete mode 100644 drivers/power/bq27x00_battery.c
 create mode 100644 drivers/power/bq27xxx_battery.c
 delete mode 100644 include/linux/power/bq27x00_battery.h
 create mode 100644 include/linux/power/bq27xxx_battery.h

-- 
1.9.1

