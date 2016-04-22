From: Penny Chiu <pchiu@nvidia.com>
Subject: [PATCH 09/11] arm64: tegra: Add DFLL clock node on Jetson TX1
Date: Fri, 22 Apr 2016 18:31:09 +0800
Message-ID: <1461321071-6431-10-git-send-email-pchiu@nvidia.com>
References: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: mturquette@baylibre.com, sboyd@codeaurora.org, linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org, linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Penny Chiu <pchiu@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Add DFLL clock device-tree node for Tegra210 DFLL IP block.

Signed-off-by: Penny Chiu <pchiu@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi | 16 ++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi       | 15 +++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
index 9d02db2..5cf07f2 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
@@ -43,6 +43,22 @@
 		};
 	};
 
+	dfll: clock@70110000 {
+		status = "okay";
+
+		reg = <0x0 0x70110000 0x0 0x400>;
+		vdd-cpu-supply = <&cpu_ovr_reg>;
+		nvidia,pwm-to-pmic;
+		nvidia,init-uv = <1000000>;
+		nvidia,align-step-uv = <19200>; /* 19.2mv */
+		nvidia,sample-rate = <25000>;
+		nvidia,droop-ctrl = <0x00000f00>;
+		nvidia,force-mode = <1>;
+		nvidia,cf = <6>;
+		nvidia,ci = <0>;
+		nvidia,cg = <2>;
+	};
+
 	pwm_dfll: pwm@70110000 {
 		compatible = "nvidia,tegra210-dfll-pwm";
 		reg = <0x0 0x70110000 0x0 0x400>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index ba0462e..204d9cd 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -3,6 +3,7 @@
 #include <dt-bindings/memory/tegra210-mc.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/tegra210-car.h>
 
 / {
 	compatible = "nvidia,tegra210";
@@ -684,6 +685,20 @@
 		status = "disabled";
 	};
 
+	dfll: clock@70110000 {
+		compatible = "nvidia,tegra210-dfll";
+		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA210_CLK_DFLL_SOC>,
+			 <&tegra_car TEGRA210_CLK_DFLL_REF>,
+			 <&tegra_car TEGRA210_CLK_I2C5>;
+		clock-names = "soc", "ref", "i2c";
+		resets = <&tegra_car TEGRA210_RST_DFLL_DVCO>;
+		reset-names = "dvco";
+		#clock-cells = <0>;
+		clock-output-names = "dfllCPU_out";
+		status = "disabled";
+	};
+
 	usb@7d000000 {
 		compatible = "nvidia,tegra210-ehci", "nvidia,tegra30-ehci", "usb-ehci";
 		reg = <0x0 0x7d000000 0x0 0x4000>;
-- 
2.8.1
