From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1 5/5] ARM: dts: tegra30: Add CPU Operating Performance Points
Date: Thu, 30 Aug 2018 22:43:56 +0300
Message-ID: <20180830194356.14059-6-digetx@gmail.com>
References: <20180830194356.14059-1-digetx@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830194356.14059-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add CPU's Operating Performance Points to the device tree, they are used
by the CPUFreq driver and allow to setup thermal throttling for the boards
by linking the cooling device (CPU) with thermal sensors via thermal-zones
description.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30.dtsi | 65 ++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 37c4757516d2..5c8098bdfb2a 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -980,6 +980,47 @@
 		status = "disabled";
 	};
 
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@408000000 {
+			clock-latency-ns = <2000>;
+			opp-hz = /bits/ 64 <408000000>;
+			opp-suspend;
+		};
+
+		opp@456000000 {
+			clock-latency-ns = <50000>;
+			opp-hz = /bits/ 64 <456000000>;
+		};
+
+		opp@608000000 {
+			clock-latency-ns = <50000>;
+			opp-hz = /bits/ 64 <608000000>;
+		};
+
+		opp@760000000 {
+			clock-latency-ns = <50000>;
+			opp-hz = /bits/ 64 <760000000>;
+		};
+
+		opp@816000000 {
+			clock-latency-ns = <50000>;
+			opp-hz = /bits/ 64 <816000000>;
+		};
+
+		opp@912000000 {
+			clock-latency-ns = <50000>;
+			opp-hz = /bits/ 64 <912000000>;
+		};
+
+		opp@1000000000 {
+			clock-latency-ns = <50000>;
+			opp-hz = /bits/ 64 <1000000000>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -988,24 +1029,48 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			clocks = <&tegra_car TEGRA30_CLK_PLL_X>,
+				 <&tegra_car TEGRA30_CLK_PLL_P>,
+				 <&tegra_car TEGRA30_CLK_CCLK_G>;
+			clock-names = "pll_x", "backup", "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
+			clocks = <&tegra_car TEGRA30_CLK_PLL_X>,
+				 <&tegra_car TEGRA30_CLK_PLL_P>,
+				 <&tegra_car TEGRA30_CLK_CCLK_G>;
+			clock-names = "pll_x", "backup", "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <2>;
+			clocks = <&tegra_car TEGRA30_CLK_PLL_X>,
+				 <&tegra_car TEGRA30_CLK_PLL_P>,
+				 <&tegra_car TEGRA30_CLK_CCLK_G>;
+			clock-names = "pll_x", "backup", "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <3>;
+			clocks = <&tegra_car TEGRA30_CLK_PLL_X>,
+				 <&tegra_car TEGRA30_CLK_PLL_P>,
+				 <&tegra_car TEGRA30_CLK_CCLK_G>;
+			clock-names = "pll_x", "backup", "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 	};
 
-- 
2.18.0
