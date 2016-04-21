From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH] thermal: rcar_thermal: Fix priv->zone error handling
Date: Thu, 21 Apr 2016 12:24:55 +0200
Message-ID: <1461234295-30521-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, linux-renesas-soc@vger.kernel.org, kuninori.morimoto.gx@renesas.com
Cc: Dirk Behme <dirk.behme@de.bosch.com>
List-Id: linux-pm@vger.kernel.org

In case thermal_zone_xxx_register() returns an error, priv->zone
isn't NULL any more, but contains the error code.

This is passed to thermal_zone_device_unregister(), then. This checks
for priv->zone being NULL, but the error code is != NULL. So it works
with the error code as a pointer. Crashing immediately.

To fix this, reset priv->zone to NULL before entering
rcar_gen3_thermal_remove().

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 drivers/thermal/rcar_thermal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 71a3392..5f81792 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -504,6 +504,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 		if (IS_ERR(priv->zone)) {
 			dev_err(dev, "can't register thermal zone\n");
 			ret = PTR_ERR(priv->zone);
+			priv->zone = NULL;
 			goto error_unregister;
 		}
 
-- 
2.8.0
