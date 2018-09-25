From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 07/14] thermal/drivers/hisi: Replace macro name with relevant sensor location
Date: Tue, 25 Sep 2018 11:03:05 +0200
Message-ID: <1537866192-12320-8-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, leo.yan@linaro.org, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Change the macro name in order to give a better indication of the
sensor location.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index a5756f6..a542cb3 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -55,8 +55,8 @@
 #define HI3660_TEMP_STEP		(205)
 #define HI3660_TEMP_LAG			(4000)
 
-#define HI6220_DEFAULT_SENSOR		2
-#define HI3660_DEFAULT_SENSOR		1
+#define HI6220_CLUSTER0_SENSOR		2
+#define HI3660_BIG_SENSOR		1
 
 struct hisi_thermal_data;
 
@@ -406,7 +406,7 @@ static int hi6220_thermal_probe(struct hisi_thermal_data *data)
 	if (!data->sensor)
 		return -ENOMEM;
 
-	data->sensor[0].id = HI6220_DEFAULT_SENSOR;
+	data->sensor[0].id = HI6220_CLUSTER0_SENSOR;
 	data->sensor[0].data = data;
 	data->nr_sensors = 1;
 
@@ -422,7 +422,7 @@ static int hi3660_thermal_probe(struct hisi_thermal_data *data)
 	if (!data->sensor)
 		return -ENOMEM;
 
-	data->sensor[0].id = HI3660_DEFAULT_SENSOR;
+	data->sensor[0].id = HI3660_BIG_SENSOR;
 	data->sensor[0].data = data;
 	data->nr_sensors = 1;
 
-- 
2.7.4
