From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 09/13] thermal: convert rcar_thermal to use devm_thermal_zone_of_sensor_register
Date: Wed,  9 Mar 2016 13:35:31 -0800
Message-ID: <1457559336-17652-10-git-send-email-edubezval@gmail.com>
References: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

This changes the driver to use the devm_ version
of thermal_zone_of_sensor_register and cleans
up the  local points and unregister calls.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/rcar_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 0e735ac..a5e4181 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -493,7 +493,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 			goto error_unregister;
 
 		if (of_data == USE_OF_THERMAL)
-			priv->zone = thermal_zone_of_sensor_register(
+			priv->zone = devm_thermal_zone_of_sensor_register(
 						dev, i, priv,
 						&rcar_thermal_zone_of_ops);
 		else
-- 
2.1.4
