From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH RFC 2/2] thermal/drivers/qoriq: Use the get_temp_id()
Date: Thu,  4 Apr 2019 10:06:47 +0200
Message-ID: <20190404080647.8173-2-daniel.lezcano@linaro.org>
References: <00a5711b-5120-9e77-91a0-e0cbab456d92@linaro.org>
 <20190404080647.8173-1-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190404080647.8173-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andrew.smirnov@gmail.com
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Currently the code is adding extra back pointer to find out the general
structure for the driver from the sensor data.

Use the get_temp_id() which pass the sensor id when registering the callback.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/qoriq_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 3b5f5b3fb1bc..405d1fbdd0cb 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -92,20 +92,20 @@ static u32 tmu_read(struct qoriq_tmu_data *p, void __iomem *addr)
 		return ioread32be(addr);
 }
 
-static int tmu_get_temp(void *p, int *temp)
+static int tmu_get_temp(int id, void *p, int *temp)
 {
 	struct qoriq_sensor *qsensor = p;
 	struct qoriq_tmu_data *qdata = qsensor->qdata;
 	u32 val;
 
-	val = tmu_read(qdata, &qdata->regs->site[qsensor->id].tritsr);
+	val = tmu_read(qdata, &qdata->regs->site[id].tritsr);
 	*temp = (val & 0xff) * 1000;
 
 	return 0;
 }
 
 static const struct thermal_zone_of_device_ops tmu_tz_ops = {
-	.get_temp = tmu_get_temp,
+	.get_temp_id = tmu_get_temp,
 };
 
 static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
-- 
2.17.1
