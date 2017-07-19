From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 0/2] Remove BQ27xxx platform interface
Date: Wed, 19 Jul 2017 12:04:05 -0500
Message-ID: <20170719170407.14005-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:26641 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755065AbdGSRE7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jul 2017 13:04:59 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Evgeniy Polyakov <zbr@ioremap.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>

To finish the work started in this patch[0] we needed to reorganize
the 1-wire subsystem a bit, this is done here[1]. After that is taken
this series can remove the need for a platform driver for supporting
1-wire connected BQ27xxx devices.

Thanks,
Andrew

Changes from v1:
 - Rebased on v4.13-rc1
 - [1] has been taken, this series can now be merged

[0] https://patchwork.kernel.org/patch/7684371/
[1] https://lkml.org/lkml/2017/3/16/604

Andrew F. Davis (2):
  power: supply: move HDQ interface for bq27xxx from w1 to power/supply
  power: supply: bq27xxx: move platform driver code into
    bq27xxx_battery_hdq.c

 drivers/power/supply/Kconfig               |   9 ++
 drivers/power/supply/Makefile              |   1 +
 drivers/power/supply/bq27xxx_battery.c     | 104 ----------------------
 drivers/power/supply/bq27xxx_battery_hdq.c | 135 +++++++++++++++++++++++++++++
 drivers/w1/slaves/Kconfig                  |   6 --
 drivers/w1/slaves/Makefile                 |   1 -
 drivers/w1/slaves/w1_bq27000.c             | 117 -------------------------
 include/linux/power/bq27xxx_battery.h      |  17 ----
 8 files changed, 145 insertions(+), 245 deletions(-)
 create mode 100644 drivers/power/supply/bq27xxx_battery_hdq.c
 delete mode 100644 drivers/w1/slaves/w1_bq27000.c

-- 
2.13.0
