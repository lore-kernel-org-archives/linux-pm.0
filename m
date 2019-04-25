From: Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 1/3] thermal: rockchip: fix up the tsadc pinctrl setting error
Date: Thu, 25 Apr 2019 18:12:27 +0800
Message-ID: <1556187154-22632-2-git-send-email-zhangqing@rock-chips.com>
References: <1556187154-22632-1-git-send-email-zhangqing@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556187154-22632-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de
Cc: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Explicitly use the pinctrl to set/unset the right mode
instead of relying on the pinctrl init mode.
And it requires setting the tshut polarity before select pinctrl.

When the temperature sensor mode is set to 0, it will automatically
reset the board via the Clock-Reset-Unit (CRU) if the over temperature
threshold is reached. However, when the pinctrl initializes, it does a
transition to "otp_out" which may lead the SoC restart all the time.

"otp_out" IO may be connected to the RESET circuit on the hardware.
If the IO is in the wrong state, it will trigger RESET.
(similar to the effect of pressing the RESET button)
which will cause the soc to restart all the time.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/thermal/rockchip_thermal.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 9c7643d62ed7..03ff494f2864 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -172,6 +172,9 @@ struct rockchip_thermal_data {
 	int tshut_temp;
 	enum tshut_mode tshut_mode;
 	enum tshut_polarity tshut_polarity;
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *gpio_state;
+	struct pinctrl_state *otp_state;
 };
 
 /**
@@ -1242,6 +1245,8 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 		return error;
 	}
 
+	thermal->chip->control(thermal->regs, false);
+
 	error = clk_prepare_enable(thermal->clk);
 	if (error) {
 		dev_err(&pdev->dev, "failed to enable converter clock: %d\n",
@@ -1267,6 +1272,31 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 	thermal->chip->initialize(thermal->grf, thermal->regs,
 				  thermal->tshut_polarity);
 
+	if (thermal->tshut_mode == TSHUT_MODE_GPIO) {
+		thermal->pinctrl = devm_pinctrl_get(&pdev->dev);
+		if (IS_ERR(thermal->pinctrl)) {
+			dev_err(&pdev->dev, "failed to find thermal pinctrl\n");
+			panic("panic_on_find thermal pinctrl...\n");
+			return PTR_ERR(thermal->pinctrl);
+		}
+
+		thermal->gpio_state = pinctrl_lookup_state(thermal->pinctrl,
+							   "gpio");
+		if (IS_ERR_OR_NULL(thermal->gpio_state)) {
+			dev_err(&pdev->dev, "failed to find thermal gpio state\n");
+			return -EINVAL;
+		}
+
+		thermal->otp_state = pinctrl_lookup_state(thermal->pinctrl,
+							  "otpout");
+		if (IS_ERR_OR_NULL(thermal->otp_state)) {
+			dev_err(&pdev->dev, "failed to find thermal otpout state\n");
+			return -EINVAL;
+		}
+
+		pinctrl_select_state(thermal->pinctrl, thermal->otp_state);
+	}
+
 	for (i = 0; i < thermal->chip->chn_num; i++) {
 		error = rockchip_thermal_register_sensor(pdev, thermal,
 						&thermal->sensors[i],
@@ -1337,8 +1367,8 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
 
 	clk_disable(thermal->pclk);
 	clk_disable(thermal->clk);
-
-	pinctrl_pm_select_sleep_state(dev);
+	if (thermal->tshut_mode == TSHUT_MODE_GPIO)
+		pinctrl_select_state(thermal->pinctrl, thermal->gpio_state);
 
 	return 0;
 }
@@ -1383,7 +1413,8 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
 	for (i = 0; i < thermal->chip->chn_num; i++)
 		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
 
-	pinctrl_pm_select_default_state(dev);
+	if (thermal->tshut_mode == TSHUT_MODE_GPIO)
+		pinctrl_select_state(thermal->pinctrl, thermal->otp_state);
 
 	return 0;
 }
-- 
1.9.1
