From: Liu Xiang <liu.xiang6@zte.com.cn>
Subject: [PATCH] power: supply: bq27xxx: Update comments
Date: Sun, 22 Jul 2018 17:58:24 +0800
Message-ID: <1532253504-17563-1-git-send-email-liu.xiang6@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: afd@ti.com
Cc: pali.rohar@gmail.com, sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, liuxiang_1999@126.com, Liu Xiang <liu.xiang6@zte.com.cn>
List-Id: linux-pm@vger.kernel.org

The URL of bq27441-g1 and bq27426 are missing and bq27520-g4 is duplicated.

Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---
 drivers/power/supply/bq27xxx_battery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index d44ed8e..f022e1b 100644
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
@@ -40,7 +39,9 @@
  * http://www.ti.com/product/bq27545-g1
  * http://www.ti.com/product/bq27421-g1
  * http://www.ti.com/product/bq27425-g1
+ * http://www.ti.com/product/bq27426
  * http://www.ti.com/product/bq27411-g1
+ * http://www.ti.com/product/bq27441-g1
  * http://www.ti.com/product/bq27621-g1
  */
 
-- 
1.9.1
