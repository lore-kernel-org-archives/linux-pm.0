From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 0/8] Add support for additional bq27xxx devices
Date: Wed, 22 Jul 2015 16:51:52 -0500
Message-ID: <1437601920-13045-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60269 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbbGVWAo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2015 18:00:44 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>

This series adds support for several additional bq27xxx devices and 
makes a few related fixes.

Andrew F. Davis (8):
  power: bq27x00_battery: Add manufacturer property
  power: bq27x00_battery: Fix lines over 80 characters long
  power: bq27x00_battery: Fix function parameter alignment
  power: bq27x00_battery: Checkpatch fixes
  power: bq27x00_battery: Renaming for consistency
  power: bq27xxx_battery: Fix typos and change naming for state of
    charge functions
  power: bq27xxx_battery: Add support for additional bq27xxx family
    devices
  power: bq27xxx_battery: Cleanup health checking

 MAINTAINERS                                        |    4 +-
 arch/arm/configs/omap2plus_defconfig               |    2 +-
 arch/unicore32/Kconfig                             |    2 +-
 drivers/power/Kconfig                              |   22 +-
 drivers/power/Makefile                             |    2 +-
 drivers/power/bq27x00_battery.c                    | 1122 ----------------
 drivers/power/bq27xxx_battery.c                    | 1350 ++++++++++++++++++++
 drivers/w1/slaves/w1_bq27000.c                     |    2 +-
 .../power/{bq27x00_battery.h => bq27xxx_battery.h} |    6 +-
 9 files changed, 1370 insertions(+), 1142 deletions(-)
 delete mode 100644 drivers/power/bq27x00_battery.c
 create mode 100644 drivers/power/bq27xxx_battery.c
 rename include/linux/power/{bq27x00_battery.h => bq27xxx_battery.h} (82%)

-- 
1.9.1

