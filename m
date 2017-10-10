From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 19/25] thermal/drivers/hisi: Put platform code together
Date: Tue, 10 Oct 2017 20:02:44 +0200
Message-ID: <1507658570-32675-19-git-send-email-daniel.lezcano@linaro.org>
References: <79a5f10c-0fb7-3e4f-caac-c1625904b137@linaro.org>
 <1507658570-32675-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507658570-32675-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kevin.wangtao@linaro.org
List-Id: linux-pm@vger.kernel.org

From: Kevin Wangtao <kevin.wangtao@linaro.org>

Reorganize the code for next patches by moving the functions upper in
the file which will prevent a forward declaration. There is no functional
change here.

Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 76 +++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index befdb28..ff9055a 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -201,6 +201,44 @@ static void hisi_thermal_disable_sensor(struct hisi_thermal_data *data)
 	clk_disable_unprepare(data->clk);
 }
 
+
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
