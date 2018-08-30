From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1 4/5] ARM: dts: tegra20: Add CPU Operating Performance Points
Date: Thu, 30 Aug 2018 22:43:55 +0300
Message-ID: <20180830194356.14059-5-digetx@gmail.com>
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
 arch/arm/boot/dts/tegra20.dtsi | 58 ++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 01398db0c9c7..4415de0f7c65 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -859,6 +859,52 @@
 		status = "disabled";
 	};
 
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@216000000 {
+			clock-latency-ns = <2000>;
+			opp-hz = /bits/ 64 <216000000>;
+			opp-suspend;
+		};
+
+		opp@312000000 {
+			clock-latency-ns = <125000>;
+			opp-hz = /bits/ 64 <312000000>;
+		};
+
+		opp@456000000 {
+			clock-latency-ns = <125000>;
+			opp-hz = /bits/ 64 <456000000>;
+		};
+
+		opp@608000000 {
+			clock-latency-ns = <125000>;
+			opp-hz = /bits/ 64 <608000000>;
+		};
+
+		opp@760000000 {
+			clock-latency-ns = <125000>;
+			opp-hz = /bits/ 64 <760000000>;
+		};
+
+		opp@816000000 {
+			clock-latency-ns = <125000>;
+			opp-hz = /bits/ 64 <816000000>;
+		};
+
+		opp@912000000 {
+			clock-latency-ns = <125000>;
+			opp-hz = /bits/ 64 <912000000>;
+		};
+
+		opp@1000000000 {
+			clock-latency-ns = <125000>;
+			opp-hz = /bits/ 64 <1000000000>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -867,12 +913,24 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			clocks = <&tegra_car TEGRA20_CLK_PLL_X>,
+				 <&tegra_car TEGRA20_CLK_PLL_P>,
+				 <&tegra_car TEGRA20_CLK_CCLK>;
+			clock-names = "pll_x", "backup", "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
+			clocks = <&tegra_car TEGRA20_CLK_PLL_X>,
+				 <&tegra_car TEGRA20_CLK_PLL_P>,
+				 <&tegra_car TEGRA20_CLK_CCLK>;
+			clock-names = "pll_x", "backup", "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 	};
 
-- 
2.18.0
