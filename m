From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 6/7] thermal: rcar_gen3_thermal: store device match data in private structure
Date: Mon,  6 Mar 2017 21:04:00 +0100
Message-ID: <20170306200401.29923-7-niklas.soderlund+renesas@ragnatech.se>
References: <20170306200401.29923-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170306200401.29923-1-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
List-Id: linux-pm@vger.kernel.org

The device match data needs to be accessible outside the probe function,
store it in the private data structure.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index e52181015e589a7f..9168ac538f3b8cf5 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -87,6 +87,7 @@ struct rcar_gen3_thermal_tsc {
 };
 
 struct rcar_gen3_thermal_priv {
+	const struct rcar_gen3_thermal_data *data;
 	spinlock_t lock;
 	struct rcar_gen3_thermal_tsc *tscs[TSC_MAX_NUM];
 };
@@ -363,8 +364,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct thermal_zone_device *zone;
 	int ret, i;
-	const struct rcar_gen3_thermal_data *match_data =
-		of_device_get_match_data(dev);
 
 	/* default values if FUSEs are missing */
 	/* TODO: Read values from hardware on supported platforms */
@@ -379,6 +378,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->data = of_device_get_match_data(dev);
+
 	spin_lock_init(&priv->lock);
 
 	platform_set_drvdata(pdev, priv);
@@ -433,7 +434,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 
 		priv->tscs[i] = tsc;
 
-		match_data->thermal_init(tsc);
+		priv->data->thermal_init(tsc);
 		rcar_gen3_thermal_calc_coefs(&tsc->coef, ptat, thcode[i]);
 
 		zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
-- 
2.12.0
