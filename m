From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH V3 1/4] thermal/drivers/hisi: Put platform code together
Date: Sun, 22 Oct 2017 10:54:32 +0200
Message-ID: <1508662475-6763-2-git-send-email-daniel.lezcano@linaro.org>
References: <1508662475-6763-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:57056 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbdJVI4o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Oct 2017 04:56:44 -0400
Received: by mail-wm0-f66.google.com with SMTP id l68so4579472wmd.5
        for <linux-pm@vger.kernel.org>; Sun, 22 Oct 2017 01:56:44 -0700 (PDT)
In-Reply-To: <1508662475-6763-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com
Cc: daniel.lezcano@linaro.org, rui.zhang@intel.com, kevin.wangtao@linaro.org, leo.yan@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

From: Kevin Wangtao <kevin.wangtao@linaro.org>

Reorganize the code for next patches by moving the functions upper in
the file which will prevent a forward declaration. There is no functional
change here.

Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>
Tested-by: Daniel Lezcano <daniel.lezcano@linaro.org> # hikey6220
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 76 +++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index b48e47e..ffa00b4 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -201,6 +201,44 @@ static void hisi_thermal_disable_sensor(struct hisi_thermal_data *data)
 	clk_disable_unprepare(data->clk);
 }
 
+static int hisi_thermal_setup(struct hisi_thermal_data *data)
+{
+	struct hisi_thermal_sensor *sensor = &data->sensor;
+	int ret;
+
+	/* enable clock for tsensor */
+	ret = clk_prepare_enable(data->clk);
+	if (ret)
+		return ret;
+
+	/* disable module firstly */
+	hisi_thermal_reset_enable(data->regs, 0);
+	hisi_thermal_enable(data->regs, 0);
+
+	/* select sensor id */
+	hisi_thermal_sensor_select(data->regs, sensor->id);
+
+	/* setting the hdak time */
+	hisi_thermal_hdak_set(data->regs, 0);
+
+	/* setting lag value between current temp and the threshold */
+	hisi_thermal_set_lag(data->regs, HISI_TEMP_LAG);
+
+	/* enable for interrupt */
+	hisi_thermal_alarm_set(data->regs, sensor->thres_temp);
+
+	hisi_thermal_reset_set(data->regs, HISI_TEMP_RESET);
+
+	/* enable module */
+	hisi_thermal_reset_enable(data->regs, 1);
+	hisi_thermal_enable(data->regs, 1);
+
+	hisi_thermal_alarm_clear(data->regs, 0);
+	hisi_thermal_alarm_enable(data->regs, 1);
+
+	return 0;
+}
+
 static int hisi_thermal_get_temp(void *__data, int *temp)
 {
 	struct hisi_thermal_data *data = __data;
@@ -291,44 +329,6 @@ static void hisi_thermal_toggle_sensor(struct hisi_thermal_sensor *sensor,
 		on ? THERMAL_DEVICE_ENABLED : THERMAL_DEVICE_DISABLED);
 }
 
-static int hisi_thermal_setup(struct hisi_thermal_data *data)
-{
-	struct hisi_thermal_sensor *sensor = &data->sensor;
-	int ret;
-
-	/* enable clock for tsensor */
-	ret = clk_prepare_enable(data->clk);
-	if (ret)
-		return ret;
-
-	/* disable module firstly */
-	hisi_thermal_reset_enable(data->regs, 0);
-	hisi_thermal_enable(data->regs, 0);
-
-	/* select sensor id */
-	hisi_thermal_sensor_select(data->regs, sensor->id);
-
-	/* setting the hdak time */
-	hisi_thermal_hdak_set(data->regs, 0);
-
-	/* setting lag value between current temp and the threshold */
-	hisi_thermal_set_lag(data->regs, HISI_TEMP_LAG);
-
-	/* enable for interrupt */
-	hisi_thermal_alarm_set(data->regs, sensor->thres_temp);
-
-	hisi_thermal_reset_set(data->regs, HISI_TEMP_RESET);
-
-	/* enable module */
-	hisi_thermal_reset_enable(data->regs, 1);
-	hisi_thermal_enable(data->regs, 1);
-
-	hisi_thermal_alarm_clear(data->regs, 0);
-	hisi_thermal_alarm_enable(data->regs, 1);
-
-	return 0;
-}
-
 static int hisi_thermal_probe(struct platform_device *pdev)
 {
 	struct hisi_thermal_data *data;
-- 
2.7.4
