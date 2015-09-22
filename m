From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v5 0/6] Add support for additional bq27xxx devices
Date: Tue, 22 Sep 2015 14:35:05 -0500
Message-ID: <1442950511-16122-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>
List-Id: linux-pm@vger.kernel.org

This series adds support for several additional bq27xxx devices and
makes a few related fixes. v1 can be found here: [1] v2: [2] v3: [3]
v4: [4]

Changes from v4:
 - Changed if-then chains into lookups
 - Rebased onto git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git (branch "next")

Changes from v3:
 - Added interrupt handling patch to series
 - Rebased on v4.3-rc1

Changes from v2:
 - Fix alignment issue
 - Fix commit message typo
 - Use INVALID_REG_ADDR in register mappings

Changes from v1:
 - Drop first four patches from series as they have been queued
   at git://git.infradead.org/battery-2.6.git
 - Remove MODULE_ALIAS
 - Add comment about State-of-Charge
 - Add additional links to documentation
 - Add device names to id table
 - Add unlikely to if statement
 - Change return types to bool for status check functions

[1] http://www.spinics.net/lists/kernel/msg2039278.html
[2] http://www.spinics.net/lists/kernel/msg2043759.html
[3] http://www.spinics.net/lists/kernel/msg2050196.html
[4] http://www.spinics.net/lists/kernel/msg2074530.html

Andrew F. Davis (6):
  power: bq27x00_battery: Renaming for consistency
  power: bq27xxx_battery: Platform initialization must declare a device
  power: bq27xxx_battery: Fix typos and change naming for state of
    charge functions
  power: bq27xxx_battery: Add support for additional bq27xxx family
    devices
  power: bq27xxx_battery: Cleanup health checking
  power: bq27xxx_battery: Add interrupt handling support

 MAINTAINERS                           |    4 +-
 arch/arm/configs/omap2plus_defconfig  |    2 +-
 arch/unicore32/Kconfig                |    2 +-
 drivers/power/Kconfig                 |   22 +-
 drivers/power/Makefile                |    2 +-
 drivers/power/bq27x00_battery.c       | 1125 ---------------------------
 drivers/power/bq27xxx_battery.c       | 1374 +++++++++++++++++++++++++++++++++
 drivers/w1/slaves/w1_bq27000.c        |    5 +-
 include/linux/power/bq27x00_battery.h |   19 -
 include/linux/power/bq27xxx_battery.h |   31 +
 10 files changed, 1424 insertions(+), 1162 deletions(-)
 delete mode 100644 drivers/power/bq27x00_battery.c
 create mode 100644 drivers/power/bq27xxx_battery.c
 delete mode 100644 include/linux/power/bq27x00_battery.h
 create mode 100644 include/linux/power/bq27xxx_battery.h

-- 
1.9.1
