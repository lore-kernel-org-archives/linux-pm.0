From: Dmitry Osipenko <digetx@gmail.com>
Subject: [RFC PATCH v2 06/17] ARM: dts: tegra20: Add CPU Operating Performance Points
Date: Sun, 21 Oct 2018 23:54:50 +0300
Message-ID: <20181021205501.23943-7-digetx@gmail.com>
References: <20181021205501.23943-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181021205501.23943-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add CPU's Operating Performance Points to the device tree, they are used
by the CPUFreq driver and allow to setup thermal throttling for the boards
by linking the cooling device (CPU) with thermal sensors via thermal-zones
description.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 277 +++++++++++++++++++++++++++++++++
 1 file changed, 277 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 185cd074eeff..51ffb5d2b974 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -859,6 +859,271 @@
 		status = "disabled";
 	};
 
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@216000000_750 {
+			clock-latency-ns = <2000>;
+			opp-microvolt = <750000 750000 1125000>;
+			opp-supported-hw = <0xFF 0xFFFF>;
+			opp-hz = /bits/ 64 <216000000>;
+			opp-suspend;
+		};
+
+		opp@314000000_750 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <750000 750000 1125000>;
+			opp-supported-hw = <0x03 0x0001>;
+			opp-hz = /bits/ 64 <314000000>;
+		};
+
+		opp@380000000_750 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <750000 750000 1125000>;
+			opp-supported-hw = <0x01 0x0002>;
+			opp-hz = /bits/ 64 <380000000>;
+		};
+
+		opp@389000000_750 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <750000 750000 1125000>;
+			opp-supported-hw = <0x02 0x0002>;
+			opp-hz = /bits/ 64 <389000000>;
+		};
+
+		opp@456000000_825 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <825000 825000 1125000>;
+			opp-supported-hw = <0x03 0x0001>;
+			opp-hz = /bits/ 64 <456000000>;
+		};
+
+		opp@494000000_750 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <750000 750000 1125000>;
+			opp-supported-hw = <0x04 0x0001>;
+			opp-hz = /bits/ 64 <494000000>;
+		};
+
+		opp@503000000_800 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <800000 800000 1125000>;
+			opp-supported-hw = <0x03 0x0002>;
+			opp-hz = /bits/ 64 <503000000>;
+		};
+
+		opp@598000000_750 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <750000 750000 1125000>;
+			opp-supported-hw = <0x04 0x0002>;
+			opp-hz = /bits/ 64 <598000000>;
+		};
+
+		opp@608000000_900 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <900000 900000 1125000>;
+			opp-supported-hw = <0x01 0x0001>;
+			opp-hz = /bits/ 64 <608000000>;
+		};
+
+		opp@618000000_900 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <900000 900000 1125000>;
+			opp-supported-hw = <0x02 0x0001>;
+			opp-hz = /bits/ 64 <618000000>;
+		};
+
+		opp@655000000_850 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <850000 850000 1125000>;
+			opp-supported-hw = <0x03 0x0002>;
+			opp-hz = /bits/ 64 <655000000>;
+		};
+
+		opp@675000000_825 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <825000 825000 1125000>;
+			opp-supported-hw = <0x04 0x0001>;
+			opp-hz = /bits/ 64 <675000000>;
+		};
+
+		opp@730000000_750 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <750000 750000 1125000>;
+			opp-supported-hw = <0x08 0x0003>;
+			opp-hz = /bits/ 64 <730000000>;
+		};
+
+		opp@750000000_800 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <800000 800000 1125000>;
+			opp-supported-hw = <0x04 0x0002>;
+			opp-hz = /bits/ 64 <750000000>;
+		};
+
+		opp@760000000_775 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <775000 775000 1125000>;
+			opp-supported-hw = <0x08 0x0003>;
+			opp-hz = /bits/ 64 <760000000>;
+		};
+
+		opp@760000000_875 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <875000 875000 1125000>;
+			opp-supported-hw = <0x02 0x0002>;
+			opp-hz = /bits/ 64 <760000000>;
+		};
+
+		opp@760000000_975 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <975000 975000 1125000>;
+			opp-supported-hw = <0x01 0x0001>;
+			opp-hz = /bits/ 64 <760000000>;
+		};
+
+		opp@770000000_975 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <975000 975000 1125000>;
+			opp-supported-hw = <0x02 0x0001>;
+			opp-hz = /bits/ 64 <770000000>;
+		};
+
+		opp@798000000_900 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <900000 900000 1125000>;
+			opp-supported-hw = <0x03 0x0002>;
+			opp-hz = /bits/ 64 <798000000>;
+		};
+
+		opp@817000000_875 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <875000 875000 1125000>;
+			opp-supported-hw = <0x04 0x0001>;
+			opp-hz = /bits/ 64 <817000000>;
+		};
+
+		opp@817000000_1000 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <1000000 1000000 1125000>;
+			opp-supported-hw = <0x01 0x0001>;
+			opp-hz = /bits/ 64 <817000000>;
+		};
+
+		opp@827000000_1000 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <1000000 1000000 1125000>;
+			opp-supported-hw = <0x02 0x0001>;
+			opp-hz = /bits/ 64 <827000000>;
+		};
+
+		opp@845000000_800 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <800000 800000 1125000>;
+			opp-supported-hw = <0x08 0x0003>;
+			opp-hz = /bits/ 64 <845000000>;
+		};
+
+		opp@893000000_850 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <850000 850000 1125000>;
+			opp-supported-hw = <0x04 0x0002>;
+			opp-hz = /bits/ 64 <893000000>;
+		};
+
+		opp@902000000_950 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <950000 950000 1125000>;
+			opp-supported-hw = <0x01 0x0002>;
+			opp-hz = /bits/ 64 <902000000>;
+		};
+
+		opp@912000000_1050 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <1050000 1050000 1125000>;
+			opp-supported-hw = <0x01 0x0001>;
+			opp-hz = /bits/ 64 <912000000>;
+		};
+
+		opp@922000000_925 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <925000 925000 1125000>;
+			opp-supported-hw = <0x04 0x0001>;
+			opp-hz = /bits/ 64 <922000000>;
+		};
+
+		opp@922000000_1050 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <1050000 1050000 1125000>;
+			opp-supported-hw = <0x02 0x0001>;
+			opp-hz = /bits/ 64 <922000000>;
+		};
+
+		opp@940000000_850 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <850000 850000 1125000>;
+			opp-supported-hw = <0x08 0x0003>;
+			opp-hz = /bits/ 64 <940000000>;
+		};
+
+		opp@950000000_950 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <950000 950000 1125000>;
+			opp-supported-hw = <0x02 0x0002>;
+			opp-hz = /bits/ 64 <950000000>;
+		};
+
+		opp@960000000_1000 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <1000000 1000000 1125000>;
+			opp-supported-hw = <0x01 0x0002>;
+			opp-hz = /bits/ 64 <960000000>;
+		};
+
+		opp@1000000000_875 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <875000 875000 1125000>;
+			opp-supported-hw = <0x08 0x0003>;
+			opp-hz = /bits/ 64 <1000000000>;
+		};
+
+		opp@1000000000_900 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <900000 900000 1125000>;
+			opp-supported-hw = <0x04 0x0002>;
+			opp-hz = /bits/ 64 <1000000000>;
+		};
+
+		opp@1000000000_975 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <975000 975000 1125000>;
+			opp-supported-hw = <0x04 0x0001>;
+			opp-hz = /bits/ 64 <1000000000>;
+		};
+
+		opp@1000000000_1000 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <1000000 1000000 1125000>;
+			opp-supported-hw = <0x02 0x0002>;
+			opp-hz = /bits/ 64 <1000000000>;
+		};
+
+		opp@1000000000_1025 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <1025000 1025000 1125000>;
+			opp-supported-hw = <0x01 0x0002>;
+			opp-hz = /bits/ 64 <1000000000>;
+		};
+
+		opp@1000000000_1100 {
+			clock-latency-ns = <125000>;
+			opp-microvolt = <1100000 1100000 1125000>;
+			opp-supported-hw = <0x03 0x0001>;
+			opp-hz = /bits/ 64 <1000000000>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -867,12 +1132,24 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			clocks = <&tegra_car TEGRA20_CLK_PLL_X>,
+				 <&tegra_car TEGRA20_CLK_PLL_P>,
+				 <&tegra_car TEGRA20_CLK_CCLK>;
+			clock-names = "pll_x", "intermediate", "cclk";
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
+			clock-names = "pll_x", "intermediate", "cclk";
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 	};
 
-- 
2.19.0
