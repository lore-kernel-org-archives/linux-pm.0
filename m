From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v3 06/13] thermal: qoriq: Pass data to qoriq_tmu_register_tmu_zone() directly
Date: Sun, 31 Mar 2019 21:14:11 -0700
Message-ID: <20190401041418.5999-7-andrew.smirnov@gmail.com>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401041418.5999-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Pass all necessary data to qoriq_tmu_register_tmu_zone() directly
instead of passing a paltform device and then deriving it. This is
done as a first step to simplify resource deallocation code.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index deb5cb6a0baf..24a2a57f61c9 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -109,9 +109,9 @@ static const struct thermal_zone_of_device_ops tmu_tz_ops = {
 	.get_temp = tmu_get_temp,
 };
 
-static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
+static int qoriq_tmu_register_tmu_zone(struct device *dev,
+				       struct qoriq_tmu_data *qdata)
 {
-	struct qoriq_tmu_data *qdata = platform_get_drvdata(pdev);
 	int id, sites = 0;
 
 	for (id = 0; id < SITES_MAX; id++) {
@@ -120,7 +120,7 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 
 		s->id = id;
 
-		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
+		tzd = devm_thermal_zone_of_sensor_register(dev, id,
 							   s, &tmu_tz_ops);
 		if (IS_ERR(tzd)) {
 			if (PTR_ERR(tzd) == -ENODEV)
@@ -215,7 +215,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_tmu;
 
-	ret = qoriq_tmu_register_tmu_zone(pdev);
+	ret = qoriq_tmu_register_tmu_zone(dev, data);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register sensors\n");
 		ret = -ENODEV;
-- 
2.20.1
