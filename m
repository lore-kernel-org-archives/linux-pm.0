From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v1 1/2] dt-bindings: Sync the dts to this document
Date: Wed, 21 Oct 2015 10:42:59 +0800
Message-ID: <1445395380-5365-2-git-send-email-wxt@rock-chips.com>
References: <1445395380-5365-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445395380-5365-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, dianders@chromium.org, Eduardo Valentin <edubezval@gmail.com>, Caesar Wang <wxt@rock-chips.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Pawel Moll <pawel.moll@arm.com>, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

Add the OTP gpio state, we need switch the pin to gpio state
before the TSADC controller is reset.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v1:
  - As the Doug comments, add the 'init' property to sync document.

 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
index ef802de..28e84f7 100644
--- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
@@ -27,8 +27,9 @@ tsadc: tsadc@ff280000 {
 	clock-names = "tsadc", "apb_pclk";
 	resets = <&cru SRST_TSADC>;
 	reset-names = "tsadc-apb";
-	pinctrl-names = "default";
-	pinctrl-0 = <&otp_out>;
+	pinctrl-names = "init", "default";
+	pinctrl-0 = <&otp_gpio>;
+	pinctrl-1 = <&otp_out>;
 	#thermal-sensor-cells = <1>;
 	rockchip,hw-tshut-temp = <95000>;
 	rockchip,hw-tshut-mode = <0>;
-- 
1.9.1
