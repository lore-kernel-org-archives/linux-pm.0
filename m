From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 05/12] thermal: qoriq: Convert driver to use devm_ioremap()
Date: Mon, 18 Feb 2019 11:11:34 -0800
Message-ID: <20190218191141.3729-6-andrew.smirnov@gmail.com>
References: <20190218191141.3729-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190218191141.3729-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Convert driver to use devm_ioremap() to simplify memory deallocation
and error handling code. No functional change intended.

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
 drivers/thermal/qoriq_thermal.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 9bae001e8264..472594fca03b 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -188,6 +188,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	struct qoriq_tmu_data *data;
 	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
+	struct resource *io;
 	u32 site;
 
 	data = devm_kzalloc(dev, sizeof(struct qoriq_tmu_data),
@@ -203,7 +204,13 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	data->regs = of_iomap(np, 0);
+	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!io) {
+		dev_err(dev, "Failed to get memory region\n");
+		return -ENODEV;
+	}
+
+	data->regs = devm_ioremap(dev, io->start, resource_size(io));
 	if (!data->regs) {
 		dev_err(dev, "Failed to get memory region\n");
 		return -ENODEV;
@@ -213,7 +220,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
 	if (ret < 0)
-		goto err_tmu;
+		return ret;
 
 	data->tz = devm_thermal_zone_of_sensor_register(dev,
 							data->sensor_id,
@@ -222,7 +229,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 		ret = PTR_ERR(data->tz);
 		dev_err(dev, "Failed to register thermal zone device %d\n",
 			ret);
-		goto err_tmu;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, data);
@@ -232,11 +239,6 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	tmu_write(data, site | TMR_ME | TMR_ALPF, &data->regs->tmr);
 
 	return 0;
-
-err_tmu:
-	iounmap(data->regs);
-
-	return ret;
 }
 
 static int qoriq_tmu_remove(struct platform_device *pdev)
@@ -246,7 +248,6 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
 	/* Disable monitoring */
 	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
 
-	iounmap(data->regs);
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
-- 
2.20.1
