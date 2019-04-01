From: Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v1 1/3] thermal: rockchip: add pinctrl control
Date: Mon,  1 Apr 2019 14:43:03 +0800
Message-ID: <1554100985-11385-2-git-send-email-zhangqing@rock-chips.com>
References: <1554100985-11385-1-git-send-email-zhangqing@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1554100985-11385-1-git-send-email-zhangqing@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: heiko@sntech.de
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Elaine Zhang <zhangqing@rock-chips.com>, huangtao@rock-chips.com, linux-pm@vger.kernel.org, xxx@rock-chips.com, daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, xf@rock-chips.com, edubezval@gmail.com, linux-rockchip@lists.infradead.org, robh+dt@kernel.org, rui.zhang@intel.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Based on the TSADC Tshut mode to select pinctrl,
instead of setting pinctrl based on architecture
(Not depends on pinctrl setting by "init" or "default").
And it requires setting the tshut polarity before select pinctrl.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/thermal/rockchip_thermal.c | 61 +++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 9c7643d62ed7..faa6c7792155 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -34,7 +34,7 @@
  */
 enum tshut_mode {
 	TSHUT_MODE_CRU = 0,
-	TSHUT_MODE_GPIO,
+	TSHUT_MODE_OTP,
 };
 
 /**
@@ -172,6 +172,9 @@ struct rockchip_thermal_data {
 	int tshut_temp;
 	enum tshut_mode tshut_mode;
 	enum tshut_polarity tshut_polarity;
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *gpio_state;
+	struct pinctrl_state *otp_state;
 };
 
 /**
@@ -807,7 +810,7 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
 	u32 val;
 
 	val = readl_relaxed(regs + TSADCV2_INT_EN);
-	if (mode == TSHUT_MODE_GPIO) {
+	if (mode == TSHUT_MODE_OTP) {
 		val &= ~TSADCV2_SHUT_2CRU_SRC_EN(chn);
 		val |= TSADCV2_SHUT_2GPIO_SRC_EN(chn);
 	} else {
@@ -822,7 +825,7 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
 	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
 	.chn_num = 1, /* one channel for tsadc */
 
-	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
+	.tshut_mode = TSHUT_MODE_OTP, /* default TSHUT via GPIO give PMIC */
 	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
 	.tshut_temp = 95000,
 
@@ -846,7 +849,7 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
 	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
 	.chn_num = 1, /* one channel for tsadc */
 
-	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
+	.tshut_mode = TSHUT_MODE_OTP, /* default TSHUT via GPIO give PMIC */
 	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
 	.tshut_temp = 95000,
 
@@ -871,7 +874,7 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
 	.chn_id[SENSOR_GPU] = 2, /* gpu sensor is channel 2 */
 	.chn_num = 2, /* two channels for tsadc */
 
-	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
+	.tshut_mode = TSHUT_MODE_OTP, /* default TSHUT via GPIO give PMIC */
 	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
 	.tshut_temp = 95000,
 
@@ -919,7 +922,7 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
 	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
 	.chn_num = 2, /* two channels for tsadc */
 
-	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
+	.tshut_mode = TSHUT_MODE_OTP, /* default TSHUT via GPIO give PMIC */
 	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
 	.tshut_temp = 95000,
 
@@ -944,7 +947,7 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
 	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
 	.chn_num = 2, /* two channels for tsadc */
 
-	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
+	.tshut_mode = TSHUT_MODE_OTP, /* default TSHUT via GPIO give PMIC */
 	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
 	.tshut_temp = 95000,
 
@@ -969,7 +972,7 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
 	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
 	.chn_num = 2, /* two channels for tsadc */
 
-	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
+	.tshut_mode = TSHUT_MODE_OTP, /* default TSHUT via GPIO give PMIC */
 	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
 	.tshut_temp = 95000,
 
@@ -1080,6 +1083,20 @@ static int rockchip_thermal_get_temp(void *_sensor, int *out_temp)
 	.set_trips = rockchip_thermal_set_trips,
 };
 
+static void thermal_pinctrl_select_otp(struct rockchip_thermal_data *thermal)
+{
+	if (!IS_ERR(thermal->pinctrl) && !IS_ERR_OR_NULL(thermal->otp_state))
+		pinctrl_select_state(thermal->pinctrl,
+				     thermal->otp_state);
+}
+
+static void thermal_pinctrl_select_gpio(struct rockchip_thermal_data *thermal)
+{
+	if (!IS_ERR(thermal->pinctrl) && !IS_ERR_OR_NULL(thermal->gpio_state))
+		pinctrl_select_state(thermal->pinctrl,
+				     thermal->gpio_state);
+}
+
 static int rockchip_configure_from_dt(struct device *dev,
 				      struct device_node *np,
 				      struct rockchip_thermal_data *thermal)
@@ -1103,7 +1120,7 @@ static int rockchip_configure_from_dt(struct device *dev,
 	if (of_property_read_u32(np, "rockchip,hw-tshut-mode", &tshut_mode)) {
 		dev_warn(dev,
 			 "Missing tshut mode property, using default (%s)\n",
-			 thermal->chip->tshut_mode == TSHUT_MODE_GPIO ?
+			 thermal->chip->tshut_mode == TSHUT_MODE_OTP ?
 				"gpio" : "cru");
 		thermal->tshut_mode = thermal->chip->tshut_mode;
 	} else {
@@ -1242,6 +1259,8 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 		return error;
 	}
 
+	thermal->chip->control(thermal->regs, false);
+
 	error = clk_prepare_enable(thermal->clk);
 	if (error) {
 		dev_err(&pdev->dev, "failed to enable converter clock: %d\n",
@@ -1267,6 +1286,24 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 	thermal->chip->initialize(thermal->grf, thermal->regs,
 				  thermal->tshut_polarity);
 
+	if (thermal->tshut_mode == TSHUT_MODE_OTP) {
+		thermal->pinctrl = devm_pinctrl_get(&pdev->dev);
+		if (IS_ERR(thermal->pinctrl))
+			dev_err(&pdev->dev, "failed to find thermal pinctrl\n");
+
+		thermal->gpio_state = pinctrl_lookup_state(thermal->pinctrl,
+							   "gpio");
+		if (IS_ERR_OR_NULL(thermal->gpio_state))
+			dev_err(&pdev->dev, "failed to find thermal gpio state\n");
+
+		thermal->otp_state = pinctrl_lookup_state(thermal->pinctrl,
+							  "otpout");
+		if (IS_ERR_OR_NULL(thermal->otp_state))
+			dev_err(&pdev->dev, "failed to find thermal otpout state\n");
+
+		thermal_pinctrl_select_otp(thermal);
+	}
+
 	for (i = 0; i < thermal->chip->chn_num; i++) {
 		error = rockchip_thermal_register_sensor(pdev, thermal,
 						&thermal->sensors[i],
@@ -1338,7 +1375,8 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
 	clk_disable(thermal->pclk);
 	clk_disable(thermal->clk);
 
-	pinctrl_pm_select_sleep_state(dev);
+	if (thermal->tshut_mode == TSHUT_MODE_OTP)
+		thermal_pinctrl_select_gpio(thermal);
 
 	return 0;
 }
@@ -1383,7 +1421,8 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
 	for (i = 0; i < thermal->chip->chn_num; i++)
 		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
 
-	pinctrl_pm_select_default_state(dev);
+	if (thermal->tshut_mode == TSHUT_MODE_OTP)
+		thermal_pinctrl_select_otp(thermal);
 
 	return 0;
 }
-- 
1.9.1
