From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v2 1/2] thermal: rcar_gen3_thermal: fix interrupt type
Date: Tue, 23 Apr 2019 15:12:17 +0900
Message-ID: <20190423061218.29705-2-jiada_wang@mentor.com>
References: <20190423061218.29705-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423061218.29705-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, erosca@de.adit-jv.com, joshua_frkuska@mentor.com, jiada_wang@mentor.com, horms+renesas@verge.net.au, niklas.soderlund+renesas@ragnatech.se, geert+renesas@glider.be, sergei.shtylyov@cogentembedded.com, marek.vasut+renesas@gmail.com, kuninori.morimoto.gx@renesas.com, hien.dang.eb@renesas.com, fabrizio.castro@bp.renesas.com, dien.pham.ry@renesas.com, biju.das@bp.renesas.com
List-Id: linux-pm@vger.kernel.org

Currently IRQF_SHARED type interrupt line is allocated, but it
is not appropriate, as the interrupt line isn't shared between
different devices, instead IRQF_ONESHOT is the proper type.

By changing interrupt type to IRQF_ONESHOT, now irq handler is
no longer needed, as clear of interrupt status can be done in
threaded interrupt context.

Because IRQF_ONESHOT type interrupt line is kept disabled until
the threaded handler has been run, so there is no need to protect
read/write of REG_GEN3_IRQSTR with lock.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 40 ++++++++---------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 64035bcec42c..a11032e42f36 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -236,41 +236,21 @@ static void rcar_thermal_irq_set(struct rcar_gen3_thermal_priv *priv, bool on)
 static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
 {
 	struct rcar_gen3_thermal_priv *priv = data;
+	unsigned long flags;
+	int i;
 	u32 status;
-	int i, ret = IRQ_HANDLED;
 
-	spin_lock(&priv->lock);
 	for (i = 0; i < priv->num_tscs; i++) {
 		status = rcar_gen3_thermal_read(priv->tscs[i], REG_GEN3_IRQSTR);
 		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQSTR, 0);
-		if (status)
-			ret = IRQ_WAKE_THREAD;
-	}
-
-	if (ret == IRQ_WAKE_THREAD)
-		rcar_thermal_irq_set(priv, false);
-
-	spin_unlock(&priv->lock);
 
-	return ret;
-}
-
-static irqreturn_t rcar_gen3_thermal_irq_thread(int irq, void *data)
-{
-	struct rcar_gen3_thermal_priv *priv = data;
-	unsigned long flags;
-	int i;
-
-	for (i = 0; i < priv->num_tscs; i++) {
-		rcar_gen3_thermal_set_irq_temp(priv->tscs[i]);
-		thermal_zone_device_update(priv->tscs[i]->zone,
-					   THERMAL_EVENT_UNSPECIFIED);
+		if (status) {
+			rcar_gen3_thermal_set_irq_temp(priv->tscs[i]);
+			thermal_zone_device_update(priv->tscs[i]->zone,
+						   THERMAL_EVENT_UNSPECIFIED);
+		}
 	}
 
-	spin_lock_irqsave(&priv->lock, flags);
-	rcar_thermal_irq_set(priv, true);
-	spin_unlock_irqrestore(&priv->lock, flags);
-
 	return IRQ_HANDLED;
 }
 
@@ -397,9 +377,9 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		if (!irqname)
 			return -ENOMEM;
 
-		ret = devm_request_threaded_irq(dev, irq, rcar_gen3_thermal_irq,
-						rcar_gen3_thermal_irq_thread,
-						IRQF_SHARED, irqname, priv);
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+						rcar_gen3_thermal_irq,
+						IRQF_ONESHOT, irqname, priv);
 		if (ret)
 			return ret;
 	}
-- 
2.19.2
