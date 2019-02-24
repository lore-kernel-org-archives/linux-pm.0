From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] of: thermal: Improve print information
Date: Sun, 24 Feb 2019 02:10:58 -0500
Message-ID: <20190224071058.18329-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

Define pr_fmt macro to add a prefix to the message,
this can make the thermal log better recognized.

Before:

[    0.602672] nfc: nfc_init: NFC Core ver 0.1
[    0.602828] NET: Registered protocol family 39
[    0.603435] clocksource: Switched to clocksource mct-frc
[    0.746216] failed to build thermal zone cpu-thermal: -22
[    0.746451] NET: Registered protocol family 2

After:

[    0.602804] NET: Registered protocol family 39
[    0.603463] clocksource: Switched to clocksource mct-frc
[    0.746309] thermal_sys: failed to build thermal zone cpu-thermal: -22
[    0.746545] NET: Registered protocol family 2

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/thermal/of-thermal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 4bfdb4a1e47d..02b5e78f027b 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -5,6 +5,9 @@
  *  Copyright (C) 2013 Texas Instruments
  *  Copyright (C) 2013 Eduardo Valentin <eduardo.valentin@ti.com>
  */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/thermal.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-- 
2.17.0
