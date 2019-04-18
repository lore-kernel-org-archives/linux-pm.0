From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4/6] hwmon: (mlxreg-fan) Use devm_thermal_of_cooling_device_register
Date: Thu, 18 Apr 2019 12:58:18 -0700
Message-ID: <1555617500-10862-5-git-send-email-linux@roeck-us.net>
References: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, linux-pm@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, Kamil Debski <kamil@wypas.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-pm@vger.kernel.org

Call devm_thermal_of_cooling_device_register() to register the cooling
device. Also introduce struct device *dev = &pdev->dev; to make the code
easier to read.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/mlxreg-fan.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/mlxreg-fan.c b/drivers/hwmon/mlxreg-fan.c
index db8c6de0b6a0..a14347ea0d77 100644
--- a/drivers/hwmon/mlxreg-fan.c
+++ b/drivers/hwmon/mlxreg-fan.c
@@ -420,42 +420,42 @@ static int mlxreg_fan_config(struct mlxreg_fan *fan,
 static int mlxreg_fan_probe(struct platform_device *pdev)
 {
 	struct mlxreg_core_platform_data *pdata;
+	struct device *dev = &pdev->dev;
 	struct mlxreg_fan *fan;
 	struct device *hwm;
 	int err;
 
-	pdata = dev_get_platdata(&pdev->dev);
+	pdata = dev_get_platdata(dev);
 	if (!pdata) {
-		dev_err(&pdev->dev, "Failed to get platform data.\n");
+		dev_err(dev, "Failed to get platform data.\n");
 		return -EINVAL;
 	}
 
-	fan = devm_kzalloc(&pdev->dev, sizeof(*fan), GFP_KERNEL);
+	fan = devm_kzalloc(dev, sizeof(*fan), GFP_KERNEL);
 	if (!fan)
 		return -ENOMEM;
 
-	fan->dev = &pdev->dev;
+	fan->dev = dev;
 	fan->regmap = pdata->regmap;
-	platform_set_drvdata(pdev, fan);
 
 	err = mlxreg_fan_config(fan, pdata);
 	if (err)
 		return err;
 
-	hwm = devm_hwmon_device_register_with_info(&pdev->dev, "mlxreg_fan",
+	hwm = devm_hwmon_device_register_with_info(dev, "mlxreg_fan",
 						   fan,
 						   &mlxreg_fan_hwmon_chip_info,
 						   NULL);
 	if (IS_ERR(hwm)) {
-		dev_err(&pdev->dev, "Failed to register hwmon device\n");
+		dev_err(dev, "Failed to register hwmon device\n");
 		return PTR_ERR(hwm);
 	}
 
 	if (IS_REACHABLE(CONFIG_THERMAL)) {
-		fan->cdev = thermal_cooling_device_register("mlxreg_fan", fan,
-						&mlxreg_fan_cooling_ops);
+		fan->cdev = devm_thermal_of_cooling_device_register(dev,
+			NULL, "mlxreg_fan", fan, &mlxreg_fan_cooling_ops);
 		if (IS_ERR(fan->cdev)) {
-			dev_err(&pdev->dev, "Failed to register cooling device\n");
+			dev_err(dev, "Failed to register cooling device\n");
 			return PTR_ERR(fan->cdev);
 		}
 	}
@@ -463,22 +463,11 @@ static int mlxreg_fan_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mlxreg_fan_remove(struct platform_device *pdev)
-{
-	struct mlxreg_fan *fan = platform_get_drvdata(pdev);
-
-	if (IS_REACHABLE(CONFIG_THERMAL))
-		thermal_cooling_device_unregister(fan->cdev);
-
-	return 0;
-}
-
 static struct platform_driver mlxreg_fan_driver = {
 	.driver = {
 	    .name = "mlxreg-fan",
 	},
 	.probe = mlxreg_fan_probe,
-	.remove = mlxreg_fan_remove,
 };
 
 module_platform_driver(mlxreg_fan_driver);
-- 
2.7.4
