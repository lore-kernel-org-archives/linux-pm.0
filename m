From: Andy Gross <andy.gross@linaro.org>
Subject: [PATCH 4/5] ARM: dts: qcom: Remove size elements from pmic reg
Date: Thu, 19 May 2016 00:00:19 -0500
Message-ID: <1463634020-17252-5-git-send-email-andy.gross@linaro.org>
References: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stanimir.varbanov@linaro.org, Andy Gross <andy.gross@linaro.org>
List-Id: linux-pm@vger.kernel.org

The #size-cells for the pmics are 0, but we specify a size in the
reg property so that MPP and GPIO modules can figure out how many
pins there are. Now that we've done that by counting irqs, we can
remove the size elements in the reg properties and be DT
compliant.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 arch/arm/boot/dts/qcom-pma8084.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-pma8084.dtsi b/arch/arm/boot/dts/qcom-pma8084.dtsi
index 4e9bd3f..ea7fce3 100644
--- a/arch/arm/boot/dts/qcom-pma8084.dtsi
+++ b/arch/arm/boot/dts/qcom-pma8084.dtsi
@@ -12,15 +12,15 @@
 
 		rtc@6000 {
 			compatible = "qcom,pm8941-rtc";
-			reg = <0x6000 0x100>,
-			      <0x6100 0x100>;
+			reg = <0x6000>,
+			      <0x6100>;
 			reg-names = "rtc", "alarm";
 			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
 		};
 
 		pma8084_gpios: gpios@c000 {
 			compatible = "qcom,pma8084-gpio", "qcom,spmi-gpio";
-			reg = <0xc000 0x1600>;
+			reg = <0xc000>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupts = <0 0xc0 0 IRQ_TYPE_NONE>,
@@ -49,7 +49,7 @@
 
 		pma8084_mpps: mpps@a000 {
 			compatible = "qcom,pma8084-mpp", "qcom,spmi-mpp";
-			reg = <0xa000 0x800>;
+			reg = <0xa000>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupts = <0 0xa0 0 IRQ_TYPE_NONE>,
@@ -64,7 +64,7 @@
 
 		pma8084_temp: temp-alarm@2400 {
 			compatible = "qcom,spmi-temp-alarm";
-			reg = <0x2400 0x100>;
+			reg = <0x2400>;
 			interrupts = <0 0x24 0 IRQ_TYPE_EDGE_RISING>;
 			#thermal-sensor-cells = <0>;
 			io-channels = <&pma8084_vadc VADC_DIE_TEMP>;
@@ -73,7 +73,7 @@
 
 		pma8084_vadc: vadc@3100 {
 			compatible = "qcom,spmi-vadc";
-			reg = <0x3100 0x100>;
+			reg = <0x3100>;
 			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
1.9.1
