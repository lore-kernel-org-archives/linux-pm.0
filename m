From: Tao Wang <kevin.wangtao@hisilicon.com>
Subject: [PATCH 3/9] thermal/drivers/hisi: put platform code together
Date: Fri, 22 Sep 2017 17:42:06 +0800
Message-ID: <1506073332-92438-4-git-send-email-kevin.wangtao@hisilicon.com>
References: <1506073332-92438-1-git-send-email-kevin.wangtao@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1506073332-92438-1-git-send-email-kevin.wangtao@hisilicon.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: devicetree@vger.kernel.org, vincent.guittot@linaro.org, gengyanping@hisilicon.com, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, lonela.Voinescu@arm.com, linux-kernel@vger.kernel.org, Kevin Wangtao <kevin.wangtao@linaro.org>, leo.yan@linaro.org, sunzhaosheng@hisilicon.com, Valentin.Schneider@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

From: Kevin Wangtao <kevin.wangtao@linaro.org>

reorganize code for follow-up patch, there is no functional change here.

Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 76 +++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index c8b651d..96904b4 100644
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
2.8.1
