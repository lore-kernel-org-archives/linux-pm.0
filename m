From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v4 02/10] thermal: rockchip: better to compatible the driver
 for different SoCs
Date: Mon,  9 Nov 2015 12:48:54 +0800
Message-ID: <1447044542-30859-3-git-send-email-wxt@rock-chips.com>
References: <1447044542-30859-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1447044542-30859-1-git-send-email-wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The current driver is default to register the two thermal sensors
in probe since some SoCs maybe only have one sensor for thermal.

In some cases, the channel 0 is not always the cpu or gpu sensor.
So add the channel can be configured for sensors.

Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

---

Changes in v4: None
Changes in v3: None
Changes in v2: None
Changes in v1:
- add a new patch for thermal driver to support more SoCs.

 drivers/thermal/rockchip_thermal.c | 86 +++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 38 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 9787e8a..e72a69d 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -45,15 +45,25 @@ enum tshut_polarity {
 };
 
 /**
- * The system has three Temperature Sensors.  channel 0 is reserved,
- * channel 1 is for CPU, and channel 2 is for GPU.
+ * The system has two Temperature Sensors.
+ * sensor0 is for CPU, and sensor1 is for GPU.
  */
 enum sensor_id {
-	SENSOR_CPU = 1,
+	SENSOR_CPU = 0,
 	SENSOR_GPU,
 };
 
+/**
+ * The max sensors is two in rockchip SoCs.
+ * Two sensors: CPU and GPU sensor.
+ */
+#define SOC_MAX_SENSORS	2
+
 struct rockchip_tsadc_chip {
+	/* The sensor id of chip correspond to the ADC channel */
+	int chn_id[SOC_MAX_SENSORS];
+	int chn_num;
+
 	/* The hardware-controlled tshut property */
 	long tshut_temp;
 	enum tshut_mode tshut_mode;
@@ -73,17 +83,15 @@ struct rockchip_tsadc_chip {
 struct rockchip_thermal_sensor {
 	struct rockchip_thermal_data *thermal;
 	struct thermal_zone_device *tzd;
-	enum sensor_id id;
+	int id;
 };
 
-#define NUM_SENSORS	2 /* Ignore unused sensor 0 */
-
 struct rockchip_thermal_data {
 	const struct rockchip_tsadc_chip *chip;
 	struct platform_device *pdev;
 	struct reset_control *reset;
 
-	struct rockchip_thermal_sensor sensors[NUM_SENSORS];
+	struct rockchip_thermal_sensor sensors[SOC_MAX_SENSORS];
 
 	struct clk *clk;
 	struct clk *pclk;
@@ -95,7 +103,7 @@ struct rockchip_thermal_data {
 	enum tshut_polarity tshut_polarity;
 };
 
-/* TSADC V2 Sensor info define: */
+/* TSADC Sensor info define: */
 #define TSADCV2_AUTO_CON			0x04
 #define TSADCV2_INT_EN				0x08
 #define TSADCV2_INT_PD				0x0c
@@ -318,6 +326,10 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
 }
 
 static const struct rockchip_tsadc_chip rk3288_tsadc_data = {
+	.chn_id[SENSOR_CPU] = 1, /* cpu sensor is channel 1 */
+	.chn_id[SENSOR_GPU] = 2, /* gpu sensor is channel 2 */
+	.chn_num = 2, /* two channels for tsadc */
+
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
 	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
 	.tshut_temp = 95000,
@@ -357,7 +369,7 @@ static irqreturn_t rockchip_thermal_alarm_irq_thread(int irq, void *dev)
 
 	thermal->chip->irq_ack(thermal->regs);
 
-	for (i = 0; i < ARRAY_SIZE(thermal->sensors); i++)
+	for (i = 0; i < thermal->chip->chn_num; i++)
 		thermal_zone_device_update(thermal->sensors[i].tzd);
 
 	return IRQ_HANDLED;
@@ -442,7 +454,7 @@ static int
 rockchip_thermal_register_sensor(struct platform_device *pdev,
 				 struct rockchip_thermal_data *thermal,
 				 struct rockchip_thermal_sensor *sensor,
-				 enum sensor_id id)
+				 int id)
 {
 	const struct rockchip_tsadc_chip *tsadc = thermal->chip;
 	int error;
@@ -481,7 +493,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	struct resource *res;
 	int irq;
-	int i;
+	int i, j;
 	int error;
 
 	match = of_match_node(of_rockchip_thermal_match, np);
@@ -556,22 +568,19 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 
 	thermal->chip->initialize(thermal->regs, thermal->tshut_polarity);
 
-	error = rockchip_thermal_register_sensor(pdev, thermal,
-						 &thermal->sensors[0],
-						 SENSOR_CPU);
-	if (error) {
-		dev_err(&pdev->dev,
-			"failed to register CPU thermal sensor: %d\n", error);
-		goto err_disable_pclk;
-	}
-
-	error = rockchip_thermal_register_sensor(pdev, thermal,
-						 &thermal->sensors[1],
-						 SENSOR_GPU);
-	if (error) {
-		dev_err(&pdev->dev,
-			"failed to register GPU thermal sensor: %d\n", error);
-		goto err_unregister_cpu_sensor;
+	for (i = 0; i < thermal->chip->chn_num; i++) {
+		error = rockchip_thermal_register_sensor(pdev, thermal,
+						&thermal->sensors[i],
+						thermal->chip->chn_id[i]);
+		if (error) {
+			dev_err(&pdev->dev,
+				"failed to register sensor[%d] : error = %d\n",
+				i, error);
+			for (j = 0; j < i; j++)
+				thermal_zone_of_sensor_unregister(&pdev->dev,
+						thermal->sensors[j].tzd);
+			goto err_disable_pclk;
+		}
 	}
 
 	error = devm_request_threaded_irq(&pdev->dev, irq, NULL,
@@ -581,22 +590,23 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 	if (error) {
 		dev_err(&pdev->dev,
 			"failed to request tsadc irq: %d\n", error);
-		goto err_unregister_gpu_sensor;
+		goto err_unregister_sensor;
 	}
 
 	thermal->chip->control(thermal->regs, true);
 
-	for (i = 0; i < ARRAY_SIZE(thermal->sensors); i++)
+	for (i = 0; i < thermal->chip->chn_num; i++)
 		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
 
 	platform_set_drvdata(pdev, thermal);
 
 	return 0;
 
-err_unregister_gpu_sensor:
-	thermal_zone_of_sensor_unregister(&pdev->dev, thermal->sensors[1].tzd);
-err_unregister_cpu_sensor:
-	thermal_zone_of_sensor_unregister(&pdev->dev, thermal->sensors[0].tzd);
+err_unregister_sensor:
+	while (i--)
+		thermal_zone_of_sensor_unregister(&pdev->dev,
+						  thermal->sensors[i].tzd);
+
 err_disable_pclk:
 	clk_disable_unprepare(thermal->pclk);
 err_disable_clk:
@@ -610,7 +620,7 @@ static int rockchip_thermal_remove(struct platform_device *pdev)
 	struct rockchip_thermal_data *thermal = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(thermal->sensors); i++) {
+	for (i = 0; i < thermal->chip->chn_num; i++) {
 		struct rockchip_thermal_sensor *sensor = &thermal->sensors[i];
 
 		rockchip_thermal_toggle_sensor(sensor, false);
@@ -631,7 +641,7 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
 	struct rockchip_thermal_data *thermal = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(thermal->sensors); i++)
+	for (i = 0; i < thermal->chip->chn_num; i++)
 		rockchip_thermal_toggle_sensor(&thermal->sensors[i], false);
 
 	thermal->chip->control(thermal->regs, false);
@@ -663,8 +673,8 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
 
 	thermal->chip->initialize(thermal->regs, thermal->tshut_polarity);
 
-	for (i = 0; i < ARRAY_SIZE(thermal->sensors); i++) {
-		enum sensor_id id = thermal->sensors[i].id;
+	for (i = 0; i < thermal->chip->chn_num; i++) {
+		int id = thermal->sensors[i].id;
 
 		thermal->chip->set_tshut_mode(id, thermal->regs,
 					      thermal->tshut_mode);
@@ -674,7 +684,7 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
 
 	thermal->chip->control(thermal->regs, true);
 
-	for (i = 0; i < ARRAY_SIZE(thermal->sensors); i++)
+	for (i = 0; i < thermal->chip->chn_num; i++)
 		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
 
 	pinctrl_pm_select_default_state(dev);
-- 
1.9.1
