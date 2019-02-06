From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: [PATCH v7 02/10] regulator: bd718x7 use chip specific and generic
 data structs
Date: Wed, 6 Feb 2019 11:38:29 +0200
Message-ID: <e0946d1b0c765d4db9d8e0806309527d0d644dde.1549444366.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1549444366.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1549444366.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, mazziesaccount@gmail.com
Cc: Guenter Roeck <linux@roeck-us.net>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Header rohm-bd718x7.h was split to generic and component specific
parts. This changed the struct bd718x7. Adapt the regulator driver to
these changes.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Acked-by: Mark Brown <broonie@kernel.org>
---

Please note that I kept the Acked-by from Mark as the change
from
struct bd718xx_pmic_inits pmic_regulators[]
to
struct bd718xx_pmic_inits pmic_regulators[ROHM_CHIP_TYPE_AMOUNT]

seemed like trivial fix to me. Please let me know if this was
not Ok.

 drivers/regulator/bd718x7-regulator.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index ccea133778c8..524a87b991f3 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -1017,12 +1017,12 @@ static int bd718xx_probe(struct platform_device *pdev)
 {
 	struct bd718xx *mfd;
 	struct regulator_config config = { 0 };
-	struct bd718xx_pmic_inits pmic_regulators[] = {
-		[BD718XX_TYPE_BD71837] = {
+	struct bd718xx_pmic_inits pmic_regulators[ROHM_CHIP_TYPE_AMOUNT] = {
+		[ROHM_CHIP_TYPE_BD71837] = {
 			.r_datas = bd71837_regulators,
 			.r_amount = ARRAY_SIZE(bd71837_regulators),
 		},
-		[BD718XX_TYPE_BD71847] = {
+		[ROHM_CHIP_TYPE_BD71847] = {
 			.r_datas = bd71847_regulators,
 			.r_amount = ARRAY_SIZE(bd71847_regulators),
 		},
@@ -1037,15 +1037,15 @@ static int bd718xx_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	if (mfd->chip_type >= BD718XX_TYPE_AMOUNT ||
-	    !pmic_regulators[mfd->chip_type].r_datas) {
+	if (mfd->chip.chip_type >= ROHM_CHIP_TYPE_AMOUNT ||
+	    !pmic_regulators[mfd->chip.chip_type].r_datas) {
 		dev_err(&pdev->dev, "Unsupported chip type\n");
 		err = -EINVAL;
 		goto err;
 	}
 
 	/* Register LOCK release */
-	err = regmap_update_bits(mfd->regmap, BD718XX_REG_REGLOCK,
+	err = regmap_update_bits(mfd->chip.regmap, BD718XX_REG_REGLOCK,
 				 (REGLOCK_PWRSEQ | REGLOCK_VREG), 0);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to unlock PMIC (%d)\n", err);
@@ -1065,7 +1065,7 @@ static int bd718xx_probe(struct platform_device *pdev)
 	 * for all reset types because OTP loading at READY will clear SEL
 	 * bit allowing HW defaults for power rails to be used
 	 */
-	err = regmap_update_bits(mfd->regmap, BD718XX_REG_TRANS_COND1,
+	err = regmap_update_bits(mfd->chip.regmap, BD718XX_REG_TRANS_COND1,
 				 BD718XX_ON_REQ_POWEROFF_MASK |
 				 BD718XX_SWRESET_POWEROFF_MASK |
 				 BD718XX_WDOG_POWEROFF_MASK |
@@ -1078,17 +1078,17 @@ static int bd718xx_probe(struct platform_device *pdev)
 		dev_dbg(&pdev->dev, "Changed all resets from SVNS to READY\n");
 	}
 
-	for (i = 0; i < pmic_regulators[mfd->chip_type].r_amount; i++) {
+	for (i = 0; i < pmic_regulators[mfd->chip.chip_type].r_amount; i++) {
 
 		const struct regulator_desc *desc;
 		struct regulator_dev *rdev;
 		const struct bd718xx_regulator_data *r;
 
-		r = &pmic_regulators[mfd->chip_type].r_datas[i];
+		r = &pmic_regulators[mfd->chip.chip_type].r_datas[i];
 		desc = &r->desc;
 
 		config.dev = pdev->dev.parent;
-		config.regmap = mfd->regmap;
+		config.regmap = mfd->chip.regmap;
 
 		rdev = devm_regulator_register(&pdev->dev, desc, &config);
 		if (IS_ERR(rdev)) {
@@ -1104,7 +1104,7 @@ static int bd718xx_probe(struct platform_device *pdev)
 		 * can now switch the control from PMIC state machine to the
 		 * register interface
 		 */
-		err = regmap_update_bits(mfd->regmap, r->init.reg,
+		err = regmap_update_bits(mfd->chip.regmap, r->init.reg,
 					 r->init.mask, r->init.val);
 		if (err) {
 			dev_err(&pdev->dev,
@@ -1113,7 +1113,7 @@ static int bd718xx_probe(struct platform_device *pdev)
 			goto err;
 		}
 		for (j = 0; j < r->additional_init_amnt; j++) {
-			err = regmap_update_bits(mfd->regmap,
+			err = regmap_update_bits(mfd->chip.regmap,
 						 r->additional_inits[j].reg,
 						 r->additional_inits[j].mask,
 						 r->additional_inits[j].val);
-- 
2.14.3


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
