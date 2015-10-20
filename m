From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 2/4] thermal: rockchip: ensure the otp state before resetting
 the controller
Date: Tue, 20 Oct 2015 17:11:02 +0800
Message-ID: <1445332264-6054-3-git-send-email-wxt@rock-chips.com>
References: <1445332264-6054-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1445332264-6054-1-git-send-email-wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

We need the OTP pin is gpio state before resetting the TSADC controller,
since the tshut polarity will generate a high signal.

Says:
The TSHUT temperature is setting more than 80 degree, the default tshut
polarity is high.

If T > 80C, the OTP output the High Signal.
If T < 80C, the OTP output the Low Signal.

On the moment, the TSADC controller is reset, the tshut polarity will be
low in a short period of time.
So:

If T < 80C, the OTP output the High Signal.
If T > 80C, the OTP output the Low Signal.

In some cases, the OTP pin is connected to the PMIC, maybe the PMIC can
accept the reset response time to avoid this issue.
In other words, the system will be always reboot if we make the OTP pin
is connected the others IC to control the power.

Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

 drivers/thermal/rockchip_thermal.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index c89ffb2..c53e318 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -22,6 +22,7 @@
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/thermal.h>
+#include <linux/pinctrl/consumer.h>
 
 /**
  * If the temperature over a period of time High,
@@ -79,6 +80,9 @@ struct rockchip_thermal_sensor {
 
 struct rockchip_thermal_data {
 	const struct rockchip_tsadc_chip *chip;
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pins_default;
+	struct pinctrl_state *pins_otp;
 	struct platform_device *pdev;
 	struct reset_control *reset;
 
@@ -548,6 +552,28 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 	}
 
+	/*
+	 * We need the OTP pin is gpio state before reset the TSADC controller
+	 * since the tshut polarity will generate a high signal.
+	 */
+
+	thermal->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (IS_ERR(thermal->pinctrl)) {
+		error = PTR_ERR(thermal->pinctrl);
+		dev_err(&pdev->dev, "failed to get thermal pinctrl: %d\n",
+			error);
+		goto err_disable_pclk;
+	}
+
+	thermal->pins_default = pinctrl_lookup_state(thermal->pinctrl,
+						     "default");
+	if (IS_ERR(thermal->pins_default))
+		dev_warn(&pdev->dev, "could not get the pinctrl default state\n");
+
+	thermal->pins_otp = pinctrl_lookup_state(thermal->pinctrl, "otp_out");
+	if (IS_ERR(thermal->pins_otp))
+		dev_warn(&pdev->dev, "could not get otp state\n");
+
 	rockchip_thermal_reset_controller(thermal->reset);
 
 	error = rockchip_configure_from_dt(&pdev->dev, np, thermal);
@@ -592,6 +618,8 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(thermal->sensors); i++)
 		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
 
+	pinctrl_select_state(thermal->pinctrl, thermal->pins_otp);
+
 	platform_set_drvdata(pdev, thermal);
 
 	return 0;
@@ -660,6 +688,8 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
 	if (error)
 		return error;
 
+	pinctrl_select_state(thermal->pinctrl, thermal->pins_default);
+
 	rockchip_thermal_reset_controller(thermal->reset);
 
 	thermal->chip->initialize(thermal->regs, thermal->tshut_polarity);
@@ -678,6 +708,8 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
 	for (i = 0; i < ARRAY_SIZE(thermal->sensors); i++)
 		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
 
+	pinctrl_select_state(thermal->pinctrl, thermal->pins_otp);
+
 	return 0;
 }
 
-- 
1.9.1
