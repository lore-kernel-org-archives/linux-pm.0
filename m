From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v3 2/3] thermal: rockchip: ensure the otp states before resetting the controller
Date: Fri, 23 Oct 2015 09:54:55 +0800
Message-ID: <1445565296-31517-3-git-send-email-wxt@rock-chips.com>
References: <1445565296-31517-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445565296-31517-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, dianders@chromium.org, Eduardo Valentin <edubezval@gmail.com>, Caesar Wang <wxt@rock-chips.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

We need the OTP pin is gpio state before resetting the TSADC controller,
since the tshut polarity will generate a high signal.

Says:
The TSHUT temperature is setting more than 80 degree, the
default tshut polarity is high.

If T > 80C, the OTP output the high signal.
If T < 80C, the OTP output the low signal.

On the moment, the tshut polarity will be low in a short period of time
if the TSADC controller is reset.

So:
If T < 80C, the OTP output the High Signal.
If T > 80C, the OTP output the Low Signal.

In some cases, the OTP pin is connected to the PMIC, maybe the PMIC can
accept the reset response time to avoid this issue.
In other words, the system will be always reboot if we
make the OTP pin is connected the others IC to control the power.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v3:
  - Add the pinctrl state for in the suspend/resume.

Changes in v2: None
Changes in v1: None

 drivers/thermal/rockchip_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index c89ffb2..3b8fbda 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -642,6 +642,8 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
 	clk_disable(thermal->pclk);
 	clk_disable(thermal->clk);
 
+	pinctrl_pm_select_sleep_state(dev);
+
 	return 0;
 }
 
@@ -678,6 +680,8 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
 	for (i = 0; i < ARRAY_SIZE(thermal->sensors); i++)
 		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
 
+	pinctrl_pm_select_default_state(dev);
+
 	return 0;
 }
 
-- 
1.9.1
