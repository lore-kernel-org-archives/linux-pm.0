From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: [RFC PATCH v1 03/13] regulator: bd718x7 use chip specific and
 generic data structs
Date: Tue, 22 Jan 2019 11:43:28 +0200
Message-ID: <3fb3eab3a8a2767404588d0a0a531273fddfc659.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, linux@roeck-us.net, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-pm@vger.kernel.org

Header rohm-bd718x7.h was split to generic and component specific
parts. This changed the struct bd718x7. Adapt the regulator driver to
these changes.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/bd718x7-regulator.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index b8dcdc21dc22..dc56ca06ace2 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -1018,11 +1018,11 @@ static int bd718xx_probe(struct platform_device *pdev)
 	struct bd718xx *mfd;
 	struct regulator_config config = { 0 };
 	struct bd718xx_pmic_inits pmic_regulators[] = {
-		[BD718XX_TYPE_BD71837] = {
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
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
