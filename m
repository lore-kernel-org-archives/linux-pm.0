From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v4 1/3] dt-bindings: rockchip-thermal: Add the pinctrl states in this document
Date: Fri, 23 Oct 2015 19:25:26 +0800
Message-ID: <1445599528-18825-2-git-send-email-wxt@rock-chips.com>
References: <1445599528-18825-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445599528-18825-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, dianders@chromium.org, Eduardo Valentin <edubezval@gmail.com>, Caesar Wang <wxt@rock-chips.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Pawel Moll <pawel.moll@arm.com>, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

The "init" pinctrl is defined we'll set
pinctrl to this state before probe and then "default" after probe.
Add the "init" and "sleep" pinctrl as the OTP gpio state, since we need
switch the pin to gpio state before the TSADC controller is reset.

AFAIK, the TSADC controller is reset, the tshut polarity will be
a *low* signal in a short period of time for some devices.

Says:
The TSADC get the temperature on rockchip thermal.

If T(current temperature) < (setting temperature), the OTP output the
*high* signal.
If T(current temperature) > (setting temperature), the OTP output the
*low* Signal.

In some cases, the OTP pin is connected to the PMIC, maybe the
PMIC can accept the reset response time to avoid this issue.

In other words, the system will be always reboot if we make the
OTP pin is connected the others IC to control the power.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4: None
Changes in v3:
  - Add the pictrl states decription in document.

Changes in v2:
  - Add the 'init' pinctrl more decription in commit.
  - Fix the subject to make more obvious in PATCH[1/2]
  - Resend this patch v2 since fix the subject to be specific.

Changes in v1:
  - As the Doug comments, add the 'init' property to sync document.

 .../devicetree/bindings/thermal/rockchip-thermal.txt          | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
index ef802de..b38200d 100644
--- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
@@ -12,6 +12,11 @@ Required properties:
 - resets : Must contain an entry for each entry in reset-names.
 	   See ../reset/reset.txt for details.
 - reset-names : Must include the name "tsadc-apb".
+- pinctrl-names : The pin control state names;
+- pinctrl-0 : The "init" pinctrl state, it will be set before device probe.
+- pinctrl-1 : The "default" pinctrl state, it will be set after reset the
+	      TSADC controller.
+- pinctrl-2 : The "sleep" pinctrl state, it will be in for suspend.
 - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
 - rockchip,hw-tshut-temp : The hardware-controlled shutdown temperature value.
 - rockchip,hw-tshut-mode : The hardware-controlled shutdown mode 0:CRU 1:GPIO.
@@ -27,8 +32,10 @@ tsadc: tsadc@ff280000 {
 	clock-names = "tsadc", "apb_pclk";
 	resets = <&cru SRST_TSADC>;
 	reset-names = "tsadc-apb";
-	pinctrl-names = "default";
-	pinctrl-0 = <&otp_out>;
+	pinctrl-names = "init", "default", "sleep";
+	pinctrl-0 = <&otp_gpio>;
+	pinctrl-1 = <&otp_out>;
+	pinctrl-2 = <&otp_gpio>;
 	#thermal-sensor-cells = <1>;
 	rockchip,hw-tshut-temp = <95000>;
 	rockchip,hw-tshut-mode = <0>;
-- 
1.9.1
