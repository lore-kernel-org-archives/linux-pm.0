From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v4 03/12] thermal: qoriq: Don't store struct thermal_zone_device reference
Date: Sat, 13 Apr 2019 01:27:39 -0700
Message-ID: <20190413082748.29990-4-andrew.smirnov@gmail.com>
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190413082748.29990-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Eduardo Valentin <edubezval@gmail.com>, Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Struct thermal_zone_device reference stored as sensor's private data
isn't really used anywhere in the code. Drop it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index c3ed6ed81dfb..c041d1ae3500 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -65,7 +65,6 @@ struct qoriq_tmu_data;
  * Thermal zone data
  */
 struct qoriq_sensor {
-	struct thermal_zone_device	*tzd;
 	struct qoriq_tmu_data		*qdata;
 	int				id;
 };
@@ -114,6 +113,8 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 	int id, sites = 0;
 
 	for (id = 0; id < SITES_MAX; id++) {
+		struct thermal_zone_device *tzd;
+
 		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
 				sizeof(struct qoriq_sensor), GFP_KERNEL);
 		if (!qdata->sensor[id])
@@ -121,13 +122,15 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 
 		qdata->sensor[id]->id = id;
 		qdata->sensor[id]->qdata = qdata;
-		qdata->sensor[id]->tzd = devm_thermal_zone_of_sensor_register(
-				&pdev->dev, id, qdata->sensor[id], &tmu_tz_ops);
-		if (IS_ERR(qdata->sensor[id]->tzd)) {
-			if (PTR_ERR(qdata->sensor[id]->tzd) == -ENODEV)
+
+		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
+							   qdata->sensor[id],
+							   &tmu_tz_ops);
+		if (IS_ERR(tzd)) {
+			if (PTR_ERR(tzd) == -ENODEV)
 				continue;
 			else
-				return PTR_ERR(qdata->sensor[id]->tzd);
+				return PTR_ERR(tzd);
 		}
 
 		sites |= 0x1 << (15 - id);
-- 
2.20.1
