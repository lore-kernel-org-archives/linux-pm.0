From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH 1/1] thermal: rcar_gen3_thermal: Fix to show correct trip points number
Date: Thu, 9 May 2019 18:09:17 +0900
Message-ID: <20190509090917.26982-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com
List-Id: linux-pm@vger.kernel.org

Currently after store trip points number in 'ret', it is overwritten
afterwards, this cause incorrect trip point number always be shown in
the debug information after register of each thermal zone.

This patch fix this issue by moving get of trip number to
end of thermal zone registration.

Fixes: 6269e9f790e8d ("thermal: rcar_gen3_thermal: Register hwmon sysfs interface")
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 88fa41cf16e8..5083e602935c 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -433,10 +433,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		}
 		tsc->zone = zone;
 
-		ret = of_thermal_get_ntrips(tsc->zone);
-		if (ret < 0)
-			goto error_unregister;
-
 		tsc->zone->tzp->no_hwmon = false;
 		ret = thermal_add_hwmon_sysfs(tsc->zone);
 		if (ret)
@@ -448,6 +444,10 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 			goto error_unregister;
 		}
 
+		ret = of_thermal_get_ntrips(tsc->zone);
+		if (ret < 0)
+			goto error_unregister;
+
 		dev_info(dev, "TSC%d: Loaded %d trip points\n", i, ret);
 	}
 
-- 
2.19.2
