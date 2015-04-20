From: "pi-cheng.chen" <pi-cheng.chen@linaro.org>
Subject: [PATCH 2/2] ARM64: mt8173: dts Add MT8173 cpufreq driver support
Date: Mon, 20 Apr 2015 17:27:27 +0800
Message-ID: <1429522047-16675-3-git-send-email-pi-cheng.chen@linaro.org>
References: <1429522047-16675-1-git-send-email-pi-cheng.chen@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429522047-16675-1-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Mike Turquette <mturquette@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: "pi-cheng.chen" <pi-cheng.chen@linaro.org>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Howard Chen <ibanezchen@gmail.com>, fan.chen@mediatek.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-mediatek@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This patch adds voltage supplies and clocks used by MT8173 cpufreq driver.

Signed-off-by: pi-cheng.chen <pi-cheng.chen@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 9 +++++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 96e141c..7a00cfe 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -330,3 +330,12 @@
 	status = "okay";
 	clock-frequency = <100000>;
 };
+
+&cpu0 {
+	proc-supply = <&mt6397_vpca15_reg>;
+};
+
+&cpu2 {
+	proc-supply = <&da9211_vcpu_reg>;
+	sram-supply = <&mt6397_vsramca7_reg>;
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index d9cc84e..b8a5454 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -51,6 +51,9 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x000>;
+			clocks = <&infracfg INFRA_CA53SEL>,
+				 <&apmixedsys APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
 		};
 
 		cpu1: cpu@1 {
@@ -65,6 +68,9 @@
 			compatible = "arm,cortex-a57";
 			reg = <0x100>;
 			enable-method = "psci";
+			clocks = <&infracfg INFRA_CA57SEL>,
+				 <&apmixedsys APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
 		};
 
 		cpu3: cpu@101 {
-- 
1.9.1
