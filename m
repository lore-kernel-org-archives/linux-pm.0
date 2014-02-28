From: Patrick Titiano <ptitiano@baylibre.com>
Subject: [PATCH 2/2] thermal: rcar-thermal: update thermal zone only when temperature changes
Date: Fri, 28 Feb 2014 14:10:04 +0100
Message-ID: <1393593004-16285-3-git-send-email-ptitiano@baylibre.com>
References: <1393593004-16285-1-git-send-email-ptitiano@baylibre.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1393593004-16285-1-git-send-email-ptitiano@baylibre.com>
Sender: linux-sh-owner@vger.kernel.org
To: magnus.damm@gmail.com, kuninori.morimoto.gx@renesas.com, eduardo.valentin@ti.com
Cc: bcousson@baylibre.com, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, Patrick Titiano <ptitiano@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Avoid updating the thermal zone in case an IRQ was triggered but the
temperature didn't effectively change.
Note this is not a driver issue.
Below is a captured debug trace illustrating the purpose of this patch:
out of 8 thermal zone updates, only 2 are actually necessary.

[   41.120000] rcar_thermal_work(): cctemp=25000
[   41.120000] rcar_thermal_work(): nctemp=30000
[   41.120000] rcar_thermal_work(): temp is now 30000C, update thermal zone
[   58.990000] rcar_thermal_work(): cctemp=30000
[   58.990000] rcar_thermal_work(): nctemp=30000
[   58.990000] rcar_thermal_work(): same temp, do not update thermal zone
[   59.290000] rcar_thermal_work(): cctemp=30000
[   59.290000] rcar_thermal_work(): nctemp=30000
[   59.290000] rcar_thermal_work(): same temp, do not update thermal zone
[   59.590000] rcar_thermal_work(): cctemp=30000
[   59.590000] rcar_thermal_work(): nctemp=30000
[   59.590000] rcar_thermal_work(): same temp, do not update thermal zone
[   59.890000] rcar_thermal_work(): cctemp=30000
[   59.890000] rcar_thermal_work(): nctemp=30000
[   59.890000] rcar_thermal_work(): same temp, do not update thermal zone
[   60.190000] rcar_thermal_work(): cctemp=30000
[   60.190000] rcar_thermal_work(): nctemp=30000
[   60.190000] rcar_thermal_work(): same temp, do not update thermal zone
[   60.490000] rcar_thermal_work(): cctemp=30000
[   60.490000] rcar_thermal_work(): nctemp=30000
[   60.490000] rcar_thermal_work(): same temp, do not update thermal zone
[   60.790000] rcar_thermal_work(): cctemp=30000
[   60.790000] rcar_thermal_work(): nctemp=35000
[   60.790000] rcar_thermal_work(): temp is now 35000C, update thermal zone

I suspect this may be due to sensor sampling accuracy / fluctuation,
but no formal proof.

Signed-off-by: Patrick Titiano <ptitiano@baylibre.com>
---
 drivers/thermal/rcar_thermal.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 6ea8c5c..187693c 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -302,12 +302,17 @@ static void _rcar_thermal_irq_ctrl(struct rcar_thermal_priv *priv, int enable)
 static void rcar_thermal_work(struct work_struct *work)
 {
 	struct rcar_thermal_priv *priv;
+	unsigned long cctemp, nctemp;
 
 	priv = container_of(work, struct rcar_thermal_priv, work.work);
 
+	rcar_thermal_get_temp(priv->zone, &cctemp);
 	rcar_thermal_update_temp(priv);
 	rcar_thermal_irq_enable(priv);
-	thermal_zone_device_update(priv->zone);
+
+	rcar_thermal_get_temp(priv->zone, &nctemp);
+	if (nctemp != cctemp)
+		thermal_zone_device_update(priv->zone);
 }
 
 static u32 rcar_thermal_had_changed(struct rcar_thermal_priv *priv, u32 status)
-- 
1.8.3.2

