From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2] thermal: rcar_gen3_thermal: fix initialization sequence for H3 ES2.0
Date: Mon, 16 Oct 2017 16:52:59 +0200
Message-ID: <20171016145259.27897-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-3.sys.kth.se ([130.237.48.192]:58464 "EHLO
        smtp-3.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752196AbdJPOxu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2017 10:53:50 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>

The initialization sequence for H3 (r8a7795) ES1.x and ES2.0 is
different. H3 ES2.0 and later uses the same sequence as M3 (r8a7796)
ES1.0. Fix this by not looking at compatible strings and instead
defaulting to the r8a7796 initialization sequence and use
soc_device_match() to check for H3 ES1.x.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 203aca44a2bb4bdf..288104440226d90f 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
+#include <linux/sys_soc.h>
 #include <linux/thermal.h>
 
 #include "thermal_core.h"
@@ -90,10 +91,6 @@ struct rcar_gen3_thermal_priv {
 	struct rcar_gen3_thermal_tsc *tscs[TSC_MAX_NUM];
 	unsigned int num_tscs;
 	spinlock_t lock; /* Protect interrupts on and off */
-	const struct rcar_gen3_thermal_data *data;
-};
-
-struct rcar_gen3_thermal_data {
 	void (*thermal_init)(struct rcar_gen3_thermal_tsc *tsc);
 };
 
@@ -278,7 +275,12 @@ static irqreturn_t rcar_gen3_thermal_irq_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void r8a7795_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
+static const struct soc_device_attribute r8a7795es1[] = {
+	{ .soc_id = "r8a7795", .revision = "ES1.*" },
+	{ /* sentinel */ }
+};
+
+static void rcar_gen3_thermal_init_r8a7795es1(struct rcar_gen3_thermal_tsc *tsc)
 {
 	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  CTSR_THBGR);
 	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  0x0);
@@ -303,7 +305,7 @@ static void r8a7795_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
 	usleep_range(1000, 2000);
 }
 
-static void r8a7796_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
+static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
 {
 	u32 reg_val;
 
@@ -324,17 +326,9 @@ static void r8a7796_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
 	usleep_range(1000, 2000);
 }
 
-static const struct rcar_gen3_thermal_data r8a7795_data = {
-	.thermal_init = r8a7795_thermal_init,
-};
-
-static const struct rcar_gen3_thermal_data r8a7796_data = {
-	.thermal_init = r8a7796_thermal_init,
-};
-
 static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
-	{ .compatible = "renesas,r8a7795-thermal", .data = &r8a7795_data},
-	{ .compatible = "renesas,r8a7796-thermal", .data = &r8a7796_data},
+	{ .compatible = "renesas,r8a7795-thermal", },
+	{ .compatible = "renesas,r8a7796-thermal", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
@@ -371,7 +365,9 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->data = of_device_get_match_data(dev);
+	priv->thermal_init = &rcar_gen3_thermal_init;
+	if (soc_device_match(r8a7795es1))
+		priv->thermal_init = &rcar_gen3_thermal_init_r8a7795es1;
 
 	spin_lock_init(&priv->lock);
 
@@ -423,7 +419,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 
 		priv->tscs[i] = tsc;
 
-		priv->data->thermal_init(tsc);
+		priv->thermal_init(tsc);
 		rcar_gen3_thermal_calc_coefs(&tsc->coef, ptat, thcode[i]);
 
 		zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
@@ -476,7 +472,7 @@ static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
 	for (i = 0; i < priv->num_tscs; i++) {
 		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
 
-		priv->data->thermal_init(tsc);
+		priv->thermal_init(tsc);
 		rcar_gen3_thermal_set_trips(tsc, tsc->low, tsc->high);
 	}
 
-- 
2.14.2
