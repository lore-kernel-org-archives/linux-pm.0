From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 3/3] thermal: armada_thermal: Replace mdelay with usleep_range in armada380_init_sensor
Date: Tue, 10 Apr 2018 16:13:28 +0800
Message-ID: <1523348008-29461-1-git-send-email-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: linux-pm@vger.kernel.org

armada380_init_sensor() is never called in atomic context.

armada380_init_sensor() is set as ".init_sensor" in
struct armada_thermal_data.
".init_sensor" is called armada_thermal_probe().
armada_thermal_probe() is set as ".probe" in struct platform_driver.
This function is not called in atomic context.

Despite never getting called from atomic context, armada380_init_sensor()
calls mdelay() to busily wait.
This is not necessary and can be replaced with usleep_range() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/thermal/armada_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index ae75328..c289ae4 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -143,7 +143,7 @@ static void armada380_init_sensor(struct platform_device *pdev,
 	if (!(reg & A380_HW_RESET)) {
 		reg |= A380_HW_RESET;
 		writel(reg, priv->control);
-		mdelay(10);
+		usleep_range(10000, 11000);
 	}
 }
 
-- 
1.9.1
