From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] power: supply: adp5061: Fix a couple off by ones
Date: Wed, 11 Jul 2018 10:58:13 +0300
Message-ID: <20180711075808.gpa3362vbins7crx@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Popa <stefan.popa@analog.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

We end up reading one element beyond the end of the adp5061_vmax[] array
here.

Fixes: fe8e81b7e899 ("adp5061: New driver for ADP5061 I2C battery charger")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/power/supply/adp5061.c b/drivers/power/supply/adp5061.c
index c00a02ef7424..939fd3d8fb1a 100644
--- a/drivers/power/supply/adp5061.c
+++ b/drivers/power/supply/adp5061.c
@@ -266,8 +266,8 @@ static int adp5061_get_max_voltage(struct adp5061_state *st,
 		return ret;
 
 	regval = ((regval & ADP5061_TERM_SET_VTRM_MSK) >> 2) - 0x0F;
-	if (regval > ARRAY_SIZE(adp5061_vmax))
-		regval = ARRAY_SIZE(adp5061_vmax);
+	if (regval >= ARRAY_SIZE(adp5061_vmax))
+		regval = ARRAY_SIZE(adp5061_vmax) - 1;
 
 	val->intval = adp5061_vmax[regval] * 1000;
 
@@ -344,8 +344,8 @@ static int adp5061_get_const_chg_current(struct adp5061_state *st,
 		return ret;
 
 	regval = ((regval & ADP5061_CHG_CURR_ICHG_MSK) >> 2);
-	if (regval > ARRAY_SIZE(adp5061_const_ichg))
-		regval = ARRAY_SIZE(adp5061_const_ichg);
+	if (regval >= ARRAY_SIZE(adp5061_const_ichg))
+		regval = ARRAY_SIZE(adp5061_const_ichg) - 1;
 
 	val->intval = adp5061_const_ichg[regval] * 1000;
 
