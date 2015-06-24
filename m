From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 6/9] ARM: STi: STiH407: Move PWM nodes STiH407 => STiH407-family
Date: Wed, 24 Jun 2015 14:59:05 +0100
Message-ID: <1435154348-28840-7-git-send-email-lee.jones@linaro.org>
References: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36652 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbbFXN71 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2015 09:59:27 -0400
Received: by wicnd19 with SMTP id nd19so136311191wic.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2015 06:59:26 -0700 (PDT)
In-Reply-To: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com, Lee Jones <lee.jones@linaro.org>

This also incorporates the STiH410.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 29 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/stih407.dtsi        | 28 ----------------------------
 2 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 838f1c3..477e92a 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -565,5 +565,34 @@
 
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

