From: Brian Masney <masneyb@onstation.org>
Subject: [PATCH v2 6/7] ARM: dts: qcom: msm8974: add gpio-ranges
Date: Wed, 31 Oct 2018 20:11:48 -0400
Message-ID: <20181101001149.13453-7-masneyb@onstation.org>
References: <20181101001149.13453-1-masneyb@onstation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181101001149.13453-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org, david.brown@linaro.org, bjorn.andersson@linaro.org, linus.walleij@linaro.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-gpio@vger.kernel.org, jonathan@marek.ca, masneyb@onstation.org
List-Id: linux-pm@vger.kernel.org

This adds the gpio-ranges property to pm8941_gpios so that the GPIO
pins are initialized by the GPIO framework and not pinctrl. This fixes
a circular dependency so GPIO hogging can be used on this board.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 arch/arm/boot/dts/qcom-pm8941.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
index 2515c5c217ac..9a91b758f7aa 100644
--- a/arch/arm/boot/dts/qcom-pm8941.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
@@ -63,6 +63,7 @@
 			compatible = "qcom,pm8941-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
+			gpio-ranges = <&pm8941_gpios 0 0 36>;
 			#gpio-cells = <2>;
 			interrupts = <0 0xc0 0 IRQ_TYPE_NONE>,
 				     <0 0xc1 0 IRQ_TYPE_NONE>,
-- 
2.17.2
