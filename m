From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 5/8] ARM: STi: STiH407: Move PWM nodes STiH407 => STiH407-family
Date: Mon, 22 Jun 2015 16:43:54 +0100
Message-ID: <1434987837-24212-6-git-send-email-lee.jones@linaro.org>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434987837-24212-1-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ajitpal.singh-qxv4g6HH51o@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This also incorporates the STiH410.

Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 29 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/stih407.dtsi        | 28 ----------------------------
 2 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index f57fd83..a673386 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -569,5 +569,34 @@
 
 			status = "disabled";
 		};
+
+		/* COMMS PWM Module */
+		pwm0: pwm@9810000 {
+			compatible	= "st,sti-pwm";
+			status		= "okay";
+			#pwm-cells	= <2>;
+			reg		= <0x9810000 0x68>;
+			pinctrl-names	= "default";
+			pinctrl-0	= <&pinctrl_pwm0_chan0_default>;
+			clock-names	= "pwm";
+			clocks		= <&clk_sysin>;
+			st,pwm-num-chan = <1>;
+		};
+
+		/* SBC PWM Module */
+		pwm1: pwm@9510000 {
+			compatible	= "st,sti-pwm";
+			status		= "okay";
+			#pwm-cells	= <2>;
+			reg		= <0x9510000 0x68>;
+			pinctrl-names	= "default";
+			pinctrl-0	= <&pinctrl_pwm1_chan0_default
+					&pinctrl_pwm1_chan1_default
+					&pinctrl_pwm1_chan2_default
+					&pinctrl_pwm1_chan3_default>;
+			clock-names	= "pwm";
+			clocks		= <&clk_sysin>;
+			st,pwm-num-chan = <4>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
index 2c560fc3..3efa3b2 100644
--- a/arch/arm/boot/dts/stih407.dtsi
+++ b/arch/arm/boot/dts/stih407.dtsi
@@ -147,33 +147,5 @@
 				};
 			};
 		};
-
-		/* COMMS PWM Module */
-		pwm0: pwm@9810000 {
-			compatible	= "st,sti-pwm";
-			status		= "disabled";
-			#pwm-cells	= <2>;
-			reg		= <0x9810000 0x68>;
-			pinctrl-names	= "default";
-			pinctrl-0	= <&pinctrl_pwm0_chan0_default>;
-			clock-names	= "pwm";
-			clocks		= <&clk_sysin>;
-		};
-
-		/* SBC PWM Module */
-		pwm1: pwm@9510000 {
-			compatible	= "st,sti-pwm";
-			status		= "disabled";
-			#pwm-cells	= <2>;
-			reg		= <0x9510000 0x68>;
-			pinctrl-names	= "default";
-			pinctrl-0	= <&pinctrl_pwm1_chan0_default
-					&pinctrl_pwm1_chan1_default
-					&pinctrl_pwm1_chan2_default
-					&pinctrl_pwm1_chan3_default>;
-			clock-names	= "pwm";
-			clocks		= <&clk_sysin>;
-			st,pwm-num-chan = <4>;
-		};
 	};
 };
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
