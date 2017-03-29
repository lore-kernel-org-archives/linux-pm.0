From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v3 5/7] thermal: rcar_gen3_thermal: enable hardware interrupts for trip points
Date: Wed, 29 Mar 2017 20:43:54 +0200
Message-ID: <20170329184356.8610-6-niklas.soderlund+renesas@ragnatech.se>
References: <20170329184356.8610-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-3.sys.kth.se ([130.237.48.192]:55227 "EHLO
        smtp-3.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752656AbdC2SpV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Mar 2017 14:45:21 -0400
In-Reply-To: <20170329184356.8610-1-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>

Enable hardware trip points by implementing the set_trips callback. The
thermal core will take care of setting the initial trip point window and
to update it once the driver reports a TSC has moved outside it.

The interrupt structure for this device is a bit odd. There is not a
dedicated IRQ for each TSC, instead the interrupts are shared between
all TSCs. IRQn is fired if the temp monitored in IRQTEMPn is reached in
any of the TSCs, example IRQ3 is fired if temperature in IRQTEMP3 is
reached in either TSC0, TSC1 or TSC2.

For this reason the usage of interrupts in this driver is an all-on or
all-off design. When an interrupt happens all TSCs are checked and all
thermal zones are updated. This could be refined to be more fine grained
but the thermal core takes care of only updating the thermal zones that
have left their trip point window.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 132 +++++++++++++++++++++++++++++++++++-
 1 file changed, 131 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 4a08b35533dcc3a9..d37c7d8f8fcd6619 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -23,8 +23,11 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/spinlock.h>
 #include <linux/thermal.h>
 
+#include "thermal_core.h"
+
 /* Register offsets */
 #define REG_GEN3_IRQSTR		0x04
 #define REG_GEN3_IRQMSK		0x08
@@ -40,6 +43,14 @@
 #define REG_GEN3_THCODE2	0x54
 #define REG_GEN3_THCODE3	0x58
 
+/* IRQ{STR,MSK,EN} bits */
+#define IRQ_TEMP1		BIT(0)
+#define IRQ_TEMP2		BIT(1)
+#define IRQ_TEMP3		BIT(2)
+#define IRQ_TEMPD1		BIT(3)
+#define IRQ_TEMPD2		BIT(4)
+#define IRQ_TEMPD3		BIT(5)
+
 /* CTSR bits */
 #define CTSR_PONM	BIT(8)
 #define CTSR_AOUT	BIT(7)
@@ -76,6 +87,7 @@ struct rcar_gen3_thermal_tsc {
 struct rcar_gen3_thermal_priv {
 	struct rcar_gen3_thermal_tsc *tscs[TSC_MAX_NUM];
 	unsigned int num_tscs;
+	spinlock_t lock; /* Protect interrupts on and off */
 };
 
 struct rcar_gen3_thermal_data {
@@ -113,6 +125,7 @@ static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
 
 #define FIXPT_SHIFT 7
 #define FIXPT_INT(_x) ((_x) << FIXPT_SHIFT)
+#define INT_FIXPT(_x) ((_x) >> FIXPT_SHIFT)
 #define FIXPT_DIV(_a, _b) DIV_ROUND_CLOSEST(((_a) << FIXPT_SHIFT), (_b))
 #define FIXPT_TO_MCELSIUS(_x) ((_x) * 1000 >> FIXPT_SHIFT)
 
@@ -178,10 +191,87 @@ static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
 	return 0;
 }
 
+static int rcar_gen3_thermal_mcelsius_to_temp(struct rcar_gen3_thermal_tsc *tsc,
+					      int mcelsius)
+{
+	int celsius, val1, val2;
+
+	celsius = DIV_ROUND_CLOSEST(mcelsius, 1000);
+	val1 = celsius * tsc->coef.a1 + tsc->coef.b1;
+	val2 = celsius * tsc->coef.a2 + tsc->coef.b2;
+
+	return INT_FIXPT((val1 + val2) / 2);
+}
+
+static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
+{
+	struct rcar_gen3_thermal_tsc *tsc = devdata;
+
+	low = clamp_val(low, -40000, 125000);
+	high = clamp_val(high, -40000, 125000);
+
+	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP1,
+				rcar_gen3_thermal_mcelsius_to_temp(tsc, low));
+
+	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP2,
+				rcar_gen3_thermal_mcelsius_to_temp(tsc, high));
+
+	return 0;
+}
+
 static struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops = {
 	.get_temp	= rcar_gen3_thermal_get_temp,
+	.set_trips	= rcar_gen3_thermal_set_trips,
 };
 
+static void rcar_thermal_irq_set(struct rcar_gen3_thermal_priv *priv, bool on)
+{
+	unsigned int i;
+	u32 val = on ? IRQ_TEMPD1 | IRQ_TEMP2 : 0;
+
+	for (i = 0; i < priv->num_tscs; i++)
+		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQMSK, val);
+}
+
+static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
+{
+	struct rcar_gen3_thermal_priv *priv = data;
+	u32 status;
+	int i, ret = IRQ_HANDLED;
+
+	spin_lock(&priv->lock);
+	for (i = 0; i < priv->num_tscs; i++) {
+		status = rcar_gen3_thermal_read(priv->tscs[i], REG_GEN3_IRQSTR);
+		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQSTR, 0);
+		if (status)
+			ret = IRQ_WAKE_THREAD;
+	}
+
+	if (ret == IRQ_WAKE_THREAD)
+		rcar_thermal_irq_set(priv, false);
+
+	spin_unlock(&priv->lock);
+
+	return ret;
+}
+
+static irqreturn_t rcar_gen3_thermal_irq_thread(int irq, void *data)
+{
+	struct rcar_gen3_thermal_priv *priv = data;
+	unsigned long flags;
+	int i;
+
+	for (i = 0; i < priv->num_tscs; i++)
+		thermal_zone_device_update(priv->tscs[i]->zone,
+					   THERMAL_EVENT_UNSPECIFIED);
+
+	spin_lock_irqsave(&priv->lock, flags);
+	rcar_thermal_irq_set(priv, true);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
 static void r8a7795_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
 {
 	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  CTSR_THBGR);
@@ -190,7 +280,11 @@ static void r8a7795_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
 	usleep_range(1000, 2000);
 
 	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR, CTSR_PONM);
+
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0x3F);
+	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
+	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN, IRQ_TEMPD1 | IRQ_TEMP2);
+
 	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,
 				CTSR_PONM | CTSR_AOUT | CTSR_THBGR | CTSR_VMEN);
 
@@ -214,6 +308,9 @@ static void r8a7796_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
 	usleep_range(1000, 2000);
 
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0x3F);
+	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
+	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN, IRQ_TEMPD1 | IRQ_TEMP2);
+
 	reg_val = rcar_gen3_thermal_read(tsc, REG_GEN3_THCTR);
 	reg_val |= THCTR_THSST;
 	rcar_gen3_thermal_write(tsc, REG_GEN3_THCTR, reg_val);
@@ -252,7 +349,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	struct thermal_zone_device *zone;
-	int ret, i;
+	int ret, irq, i;
+	char *irqname;
 	const struct rcar_gen3_thermal_data *match_data =
 		of_device_get_match_data(dev);
 
@@ -269,8 +367,32 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	spin_lock_init(&priv->lock);
+
 	platform_set_drvdata(pdev, priv);
 
+	/*
+	 * Request 2 (of the 3 possible) IRQs, the driver only needs to
+	 * to trigger on the low and high trip points of the current
+	 * temp window at this point.
+	 */
+	for (i = 0; i < 2; i++) {
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0)
+			return irq;
+
+		irqname = devm_kasprintf(dev, GFP_KERNEL, "%s:ch%d",
+					 dev_name(dev), i);
+		if (!irqname)
+			return -ENOMEM;
+
+		ret = devm_request_threaded_irq(dev, irq, rcar_gen3_thermal_irq,
+						rcar_gen3_thermal_irq_thread,
+						IRQF_SHARED, irqname, priv);
+		if (ret)
+			return ret;
+	}
+
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
@@ -306,6 +428,12 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 			goto error_unregister;
 		}
 		tsc->zone = zone;
+
+		ret = of_thermal_get_ntrips(tsc->zone);
+		if (ret < 0)
+			goto error_unregister;
+
+		dev_info(dev, "TSC%d: Loaded %d trip points\n", i, ret);
 	}
 
 	priv->num_tscs = i;
@@ -315,6 +443,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		goto error_unregister;
 	}
 
+	rcar_thermal_irq_set(priv, true);
+
 	return 0;
 
 error_unregister:
-- 
2.12.1
