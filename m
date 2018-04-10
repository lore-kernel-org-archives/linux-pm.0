From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 2/3] thermal: armada_thermal: Replace mdelay with msleep in armada375_init_sensor
Date: Tue, 10 Apr 2018 16:13:16 +0800
Message-ID: <1523347996-29417-1-git-send-email-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: linux-pm@vger.kernel.org

armada375_init_sensor() is never called in atomic context.

armada375_init_sensor() is set as ".init_sensor" in
struct armada_thermal_data.
".init_sensor" is called armada_thermal_probe().
armada_thermal_probe() is set as ".probe" in struct platform_driver.
This function is not called in atomic context.

Despite never getting called from atomic context, armada375_init_sensor()
calls mdelay() to busily wait.
This is not necessary and can be replaced with msleep() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/thermal/armada_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index ae75328..0825a7a 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -127,11 +127,11 @@ static void armada375_init_sensor(struct platform_device *pdev,
 	reg &= ~A375_HW_RESETn;
 
 	writel(reg, priv->control + 4);
-	mdelay(20);
+	msleep(20);
 
 	reg |= A375_HW_RESETn;
 	writel(reg, priv->control + 4);
-	mdelay(50);
+	msleep(50);
 }
 
 static void armada380_init_sensor(struct platform_device *pdev,
-- 
1.9.1
