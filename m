From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6/6] hwmon: (pwm-fan) Use devm_thermal_of_cooling_device_register
Date: Thu, 18 Apr 2019 12:58:20 -0700
Message-ID: <1555617500-10862-7-git-send-email-linux@roeck-us.net>
References: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, linux-pm@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, Kamil Debski <kamil@wypas.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Use devm_thermal_of_cooling_device_register() to register the cooling
device. Also use devm_add_action_or_reset() to stop the fan on device
removal, and to disable the pwm. Introduce a local 'dev' variable in
the probe function to make the code easier to read.

As a side effect, this fixes a bug seen if pwm_fan_of_get_cooling_data()
returned an error. In that situation, the pwm was not disabled, and
the fan was not stopped. Using devm functions also ensures that the
pwm is disabled and that the fan is stopped only after the hwmon device
has been unregistered.

Cc: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pwm-fan.c | 73 ++++++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 44 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 167221c7628a..0243ba70107e 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -207,33 +207,44 @@ static int pwm_fan_of_get_cooling_data(struct device *dev,
 	return 0;
 }
 
+static void pwm_fan_regulator_disable(void *data)
+{
+	regulator_disable(data);
+}
+
+static void pwm_fan_pwm_disable(void *data)
+{
+	pwm_disable(data);
+}
+
 static int pwm_fan_probe(struct platform_device *pdev)
 {
 	struct thermal_cooling_device *cdev;
+	struct device *dev = &pdev->dev;
 	struct pwm_fan_ctx *ctx;
 	struct device *hwmon;
 	int ret;
 	struct pwm_state state = { };
 
-	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
 	mutex_init(&ctx->lock);
 
-	ctx->pwm = devm_of_pwm_get(&pdev->dev, pdev->dev.of_node, NULL);
+	ctx->pwm = devm_of_pwm_get(dev, dev->of_node, NULL);
 	if (IS_ERR(ctx->pwm)) {
 		ret = PTR_ERR(ctx->pwm);
 
 		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Could not get PWM: %d\n", ret);
+			dev_err(dev, "Could not get PWM: %d\n", ret);
 
 		return ret;
 	}
 
 	platform_set_drvdata(pdev, ctx);
 
-	ctx->reg_en = devm_regulator_get_optional(&pdev->dev, "fan");
+	ctx->reg_en = devm_regulator_get_optional(dev, "fan");
 	if (IS_ERR(ctx->reg_en)) {
 		if (PTR_ERR(ctx->reg_en) != -ENODEV)
 			return PTR_ERR(ctx->reg_en);
@@ -242,10 +253,11 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	} else {
 		ret = regulator_enable(ctx->reg_en);
 		if (ret) {
-			dev_err(&pdev->dev,
-				"Failed to enable fan supply: %d\n", ret);
+			dev_err(dev, "Failed to enable fan supply: %d\n", ret);
 			return ret;
 		}
+		devm_add_action_or_reset(dev, pwm_fan_regulator_disable,
+					 ctx->reg_en);
 	}
 
 	ctx->pwm_value = MAX_PWM;
@@ -257,62 +269,36 @@ static int pwm_fan_probe(struct platform_device *pdev)
 
 	ret = pwm_apply_state(ctx->pwm, &state);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to configure PWM\n");
-		goto err_reg_disable;
+		dev_err(dev, "Failed to configure PWM\n");
+		return ret;
 	}
+	devm_add_action_or_reset(dev, pwm_fan_pwm_disable, ctx->pwm);
 
-	hwmon = devm_hwmon_device_register_with_groups(&pdev->dev, "pwmfan",
+	hwmon = devm_hwmon_device_register_with_groups(dev, "pwmfan",
 						       ctx, pwm_fan_groups);
 	if (IS_ERR(hwmon)) {
-		dev_err(&pdev->dev, "Failed to register hwmon device\n");
-		ret = PTR_ERR(hwmon);
-		goto err_pwm_disable;
+		dev_err(dev, "Failed to register hwmon device\n");
+		return PTR_ERR(hwmon);
 	}
 
-	ret = pwm_fan_of_get_cooling_data(&pdev->dev, ctx);
+	ret = pwm_fan_of_get_cooling_data(dev, ctx);
 	if (ret)
 		return ret;
 
 	ctx->pwm_fan_state = ctx->pwm_fan_max_state;
 	if (IS_ENABLED(CONFIG_THERMAL)) {
-		cdev = thermal_of_cooling_device_register(pdev->dev.of_node,
-							  "pwm-fan", ctx,
-							  &pwm_fan_cooling_ops);
+		cdev = devm_thermal_of_cooling_device_register(dev,
+			dev->of_node, "pwm-fan", ctx, &pwm_fan_cooling_ops);
 		if (IS_ERR(cdev)) {
-			dev_err(&pdev->dev,
+			dev_err(dev,
 				"Failed to register pwm-fan as cooling device");
-			ret = PTR_ERR(cdev);
-			goto err_pwm_disable;
+			return PTR_ERR(cdev);
 		}
 		ctx->cdev = cdev;
 		thermal_cdev_update(cdev);
 	}
 
 	return 0;
-
-err_pwm_disable:
-	state.enabled = false;
-	pwm_apply_state(ctx->pwm, &state);
-
-err_reg_disable:
-	if (ctx->reg_en)
-		regulator_disable(ctx->reg_en);
-
-	return ret;
-}
-
-static int pwm_fan_remove(struct platform_device *pdev)
-{
-	struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
-
-	thermal_cooling_device_unregister(ctx->cdev);
-	if (ctx->pwm_value)
-		pwm_disable(ctx->pwm);
-
-	if (ctx->reg_en)
-		regulator_disable(ctx->reg_en);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -380,7 +366,6 @@ MODULE_DEVICE_TABLE(of, of_pwm_fan_match);
 
 static struct platform_driver pwm_fan_driver = {
 	.probe		= pwm_fan_probe,
-	.remove		= pwm_fan_remove,
 	.driver	= {
 		.name		= "pwm-fan",
 		.pm		= &pwm_fan_pm,
-- 
2.7.4
