From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/2] thermal: rcar: Make error and remove paths symmetrical with init
Date: Mon, 23 Feb 2015 16:37:25 +0100
Message-ID: <1424705845-17726-3-git-send-email-geert+renesas@glider.be>
References: <1424705845-17726-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424705845-17726-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Swap interrupt disable and thermal zone unregistration in the error and
remove paths, to make them more symmetrical with the initialization
path.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2:
  - Add Acked-by.
---
 drivers/thermal/rcar_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 3c2c1720ba4a4a72..fe4e767018c4cf73 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -463,9 +463,9 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 
 error_unregister:
 	rcar_thermal_for_each_priv(priv, common) {
-		thermal_zone_device_unregister(priv->zone);
 		if (rcar_has_irq_support(priv))
 			rcar_thermal_irq_disable(priv);
+		thermal_zone_device_unregister(priv->zone);
 	}
 
 	pm_runtime_put(dev);
@@ -481,9 +481,9 @@ static int rcar_thermal_remove(struct platform_device *pdev)
 	struct rcar_thermal_priv *priv;
 
 	rcar_thermal_for_each_priv(priv, common) {
-		thermal_zone_device_unregister(priv->zone);
 		if (rcar_has_irq_support(priv))
 			rcar_thermal_irq_disable(priv);
+		thermal_zone_device_unregister(priv->zone);
 	}
 
 	pm_runtime_put(dev);
-- 
1.9.1
