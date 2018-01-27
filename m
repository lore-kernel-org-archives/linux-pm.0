From: Liu Xiang <liu.xiang6@zte.com.cn>
Subject: [PATCH] power: supply: bq27xxx: Update comments
Date: Sat, 27 Jan 2018 22:27:41 +0800
Message-ID: <1517063261-23296-1-git-send-email-liu.xiang6@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, sre@kernel.org, pali.rohar@gmail.com, afd@ti.com, Liu Xiang <liu.xiang6@zte.com.cn>
List-Id: linux-pm@vger.kernel.org

The URL of bq27441-g1 is missing and bq27520-g4 is duplicated.

Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---
 drivers/power/supply/bq27xxx_battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 2de378a..c0e7c5b 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -26,7 +26,6 @@
  * http://www.ti.com/product/bq27510-g1
  * http://www.ti.com/product/bq27510-g2
  * http://www.ti.com/product/bq27510-g3
- * http://www.ti.com/product/bq27520-g4
  * http://www.ti.com/product/bq27520-g1
  * http://www.ti.com/product/bq27520-g2
  * http://www.ti.com/product/bq27520-g3
@@ -40,8 +39,9 @@
  * http://www.ti.com/product/bq27545-g1
  * http://www.ti.com/product/bq27421-g1
  * http://www.ti.com/product/bq27425-g1
- * http://www.ti.com/product/bq27411-g1
+ * http://www.ti.com/product/bq27441-g1
  * http://www.ti.com/product/bq27621-g1
+ * http://www.ti.com/product/bq27411-g1
  */
 
 #include <linux/device.h>
-- 
1.9.1
