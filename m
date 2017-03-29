From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v3 6/7] thermal: rcar_gen3_thermal: store device match data in private structure
Date: Wed, 29 Mar 2017 20:43:55 +0200
Message-ID: <20170329184356.8610-7-niklas.soderlund+renesas@ragnatech.se>
References: <20170329184356.8610-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-3.sys.kth.se ([130.237.48.192]:55228 "EHLO
        smtp-3.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752809AbdC2SpV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Mar 2017 14:45:21 -0400
In-Reply-To: <20170329184356.8610-1-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>

The device match data needs to be accessible outside the probe function,
store it in the private data structure.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index d37c7d8f8fcd6619..f259a995c66c976a 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -88,6 +88,7 @@ struct rcar_gen3_thermal_priv {
 	struct rcar_gen3_thermal_tsc *tscs[TSC_MAX_NUM];
 	unsigned int num_tscs;
 	spinlock_t lock; /* Protect interrupts on and off */
+	const struct rcar_gen3_thermal_data *data;
 };
 
 struct rcar_gen3_thermal_data {
@@ -351,8 +352,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	struct thermal_zone_device *zone;
 	int ret, irq, i;
 	char *irqname;
-	const struct rcar_gen3_thermal_data *match_data =
-		of_device_get_match_data(dev);
 
 	/* default values if FUSEs are missing */
 	/* TODO: Read values from hardware on supported platforms */
@@ -367,6 +366,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->data = of_device_get_match_data(dev);
+
 	spin_lock_init(&priv->lock);
 
 	platform_set_drvdata(pdev, priv);
@@ -417,7 +418,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 
 		priv->tscs[i] = tsc;
 
-		match_data->thermal_init(tsc);
+		priv->data->thermal_init(tsc);
 		rcar_gen3_thermal_calc_coefs(&tsc->coef, ptat, thcode[i]);
 
 		zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
-- 
2.12.1
