From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 03/12] thermal: qoriq: Add local struct device pointer in qoriq_tmu_probe()
Date: Mon, 18 Feb 2019 11:11:32 -0800
Message-ID: <20190218191141.3729-4-andrew.smirnov@gmail.com>
References: <20190218191141.3729-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190218191141.3729-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Use a local "struct device *dev" for brevity. No functional change
intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 3e147f856bf5..c24629b1b8c2 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -187,9 +187,10 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	int ret;
 	struct qoriq_tmu_data *data;
 	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
 	u32 site;
 
-	data = devm_kzalloc(&pdev->dev, sizeof(struct qoriq_tmu_data),
+	data = devm_kzalloc(dev, sizeof(struct qoriq_tmu_data),
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -200,14 +201,14 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	data->sensor_id = qoriq_tmu_get_sensor_id();
 	if (data->sensor_id < 0) {
-		dev_err(&pdev->dev, "Failed to get sensor id\n");
+		dev_err(dev, "Failed to get sensor id\n");
 		ret = -ENODEV;
 		goto err_iomap;
 	}
 
 	data->regs = of_iomap(np, 0);
 	if (!data->regs) {
-		dev_err(&pdev->dev, "Failed to get memory region\n");
+		dev_err(dev, "Failed to get memory region\n");
 		ret = -ENODEV;
 		goto err_iomap;
 	}
@@ -218,13 +219,13 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_tmu;
 
-	data->tz = devm_thermal_zone_of_sensor_register(&pdev->dev,
+	data->tz = devm_thermal_zone_of_sensor_register(dev,
 							data->sensor_id,
 							data, &tmu_tz_ops);
 	if (IS_ERR(data->tz)) {
 		ret = PTR_ERR(data->tz);
-		dev_err(&pdev->dev,
-			"Failed to register thermal zone device %d\n", ret);
+		dev_err(dev, "Failed to register thermal zone device %d\n",
+			ret);
 		goto err_tmu;
 	}
 
-- 
2.20.1
