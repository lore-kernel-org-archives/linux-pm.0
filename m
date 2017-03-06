From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 3/7] thermal: rcar_gen3_thermal: remove unneeded mutex
Date: Mon,  6 Mar 2017 21:03:57 +0100
Message-ID: <20170306200401.29923-4-niklas.soderlund+renesas@ragnatech.se>
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

There is no point in protecting a register read with a lock. This is
most likely a leftover from when the driver was reworked before submitted
for upstream.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 97958f91047b4c3a..5d4a5483eb13e796 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -20,7 +20,6 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -72,7 +71,6 @@ struct rcar_gen3_thermal_tsc {
 	void __iomem *base;
 	struct thermal_zone_device *zone;
 	struct equation_coefs coef;
-	struct mutex lock;
 };
 
 struct rcar_gen3_thermal_priv {
@@ -163,16 +161,12 @@ static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
 	u32 reg;
 
 	/* Read register and convert to mili Celsius */
-	mutex_lock(&tsc->lock);
-
 	reg = rcar_gen3_thermal_read(tsc, REG_GEN3_TEMP) & CTEMP_MASK;
 
 	val1 = FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b1, tsc->coef.a1);
 	val2 = FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b2, tsc->coef.a2);
 	mcelsius = FIXPT_TO_MCELSIUS((val1 + val2) / 2);
 
-	mutex_unlock(&tsc->lock);
-
 	/* Make sure we are inside specifications */
 	if ((mcelsius < MCELSIUS(-40)) || (mcelsius > MCELSIUS(125)))
 		return -EIO;
@@ -301,7 +295,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		}
 
 		priv->tscs[i] = tsc;
-		mutex_init(&tsc->lock);
 
 		match_data->thermal_init(tsc);
 		rcar_gen3_thermal_calc_coefs(&tsc->coef, ptat, thcode[i]);
-- 
2.12.0
