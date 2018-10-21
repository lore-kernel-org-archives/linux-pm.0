From: Dmitry Osipenko <digetx@gmail.com>
Subject: [RFC PATCH v2 07/17] ARM: dts: tegra30: Add CPU Operating Performance Points
Date: Sun, 21 Oct 2018 23:54:51 +0300
Message-ID: <20181021205501.23943-8-digetx@gmail.com>
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
 arch/arm/boot/dts/tegra30.dtsi | 688 +++++++++++++++++++++++++++++++++
 1 file changed, 688 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 790d3fa7e6d2..0aefc8d9efab 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -980,6 +980,670 @@
 		status = "disabled";
 	};
 
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@408000000_800 {
+			clock-latency-ns = <2000>;
+			opp-microvolt = <800000 800000 1250000>;
+			opp-supported-hw = <0xFF 0xFFFF>;
+			opp-hz = /bits/ 64 <408000000>;
+			opp-suspend;
+		};
+
+		opp@460000000_800 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <800000 800000 1250000>;
+			opp-supported-hw = <0x01 0x0192>;
+			opp-hz = /bits/ 64 <460000000>;
+		};
+
+		opp@480000000_800 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <800000 800000 1250000>;
+			opp-supported-hw = <0x02 0x019E>;
+			opp-hz = /bits/ 64 <480000000>;
+		};
+
+		opp@520000000_800 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <800000 800000 1250000>;
+			opp-supported-hw = <0x04 0x019E>;
+			opp-hz = /bits/ 64 <520000000>;
+		};
+
+		opp@550000000_800 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <800000 800000 1250000>;
+			opp-supported-hw = <0x18 0x31FE>;
+			opp-hz = /bits/ 64 <550000000>;
+		};
+
+		opp@550000000_850 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <850000 850000 1250000>;
+			opp-supported-hw = <0x01 0x0192>;
+			opp-hz = /bits/ 64 <550000000>;
+		};
+
+		opp@600000000_850 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <850000 850000 1250000>;
+			opp-supported-hw = <0x1F 0x0800>;
+			opp-hz = /bits/ 64 <600000000>;
+		};
+
+		opp@650000000_850 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <850000 850000 1250000>;
+			opp-supported-hw = <0x02 0x019E>;
+			opp-hz = /bits/ 64 <650000000>;
+		};
+
+		opp@680000000_900 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <900000 900000 1250000>;
+			opp-supported-hw = <0x01 0x0192>;
+			opp-hz = /bits/ 64 <680000000>;
+		};
+
+		opp@684000000_850 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <850000 850000 1250000>;
+			opp-supported-hw = <0x01 0x0001>;
+			opp-hz = /bits/ 64 <684000000>;
+		};
+
+		opp@700000000_850 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <850000 850000 1250000>;
+			opp-supported-hw = <0x04 0x019E>;
+			opp-hz = /bits/ 64 <700000000>;
+		};
+
+		opp@770000000_850 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <850000 850000 1250000>;
+			opp-supported-hw = <0x18 0x31FE>;
+			opp-hz = /bits/ 64 <770000000>;
+		};
+
+		opp@780000000_900 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <900000 900000 1250000>;
+			opp-supported-hw = <0x02 0x019E>;
+			opp-hz = /bits/ 64 <780000000>;
+		};
+
+		opp@807000000_850 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <850000 850000 1250000>;
+			opp-supported-hw = <0x02 0x0001>;
+			opp-hz = /bits/ 64 <807000000>;
+		};
+
+		opp@817000000_900 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <900000 900000 1250000>;
+			opp-supported-hw = <0x01 0x0001>;
+			opp-hz = /bits/ 64 <817000000>;
+		};
+
+		opp@820000000_975 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <975000 975000 1250000>;
+			opp-supported-hw = <0x01 0x0192>;
+			opp-hz = /bits/ 64 <820000000>;
+		};
+
+		opp@860000000_900 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <900000 900000 1250000>;
+			opp-supported-hw = <0x04 0x019E>;
+			opp-hz = /bits/ 64 <860000000>;
+		};
+
+		opp@883000000_850 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <850000 850000 1250000>;
+			opp-supported-hw = <0x04 0x0001>;
+			opp-hz = /bits/ 64 <883000000>;
+		};
+
+		opp@900000000_850 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <850000 850000 1250000>;
+			opp-supported-hw = <0x1F 0x0400>;
+			opp-hz = /bits/ 64 <900000000>;
+		};
+
+		opp@900000000_912 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <912000 912000 1250000>;
+			opp-supported-hw = <0x1F 0x0200>;
+			opp-hz = /bits/ 64 <900000000>;
+		};
+
+		opp@910000000_900 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <900000 900000 1250000>;
+			opp-supported-hw = <0x08 0x31FE>;
+			opp-hz = /bits/ 64 <910000000>;
+		};
+
+		opp@931000000_850 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <850000 850000 1250000>;
+			opp-supported-hw = <0x08 0x0001>;
+			opp-hz = /bits/ 64 <931000000>;
+		};
+
+		opp@940000000_900 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <900000 900000 1250000>;
+			opp-supported-hw = <0x10 0x31E0>;
+			opp-hz = /bits/ 64 <940000000>;
+		};
+
+		opp@948000000_900 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <900000 900000 1250000>;
+			opp-supported-hw = <0x02 0x0001>;
+			opp-hz = /bits/ 64 <948000000>;
+		};
+
+		opp@970000000_1000 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1000000 1000000 1250000>;
+			opp-supported-hw = <0x01 0x0192>;
+			opp-hz = /bits/ 64 <970000000>;
+		};
+
+		opp@990000000_975 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <975000 975000 1250000>;
+			opp-supported-hw = <0x02 0x019E>;
+			opp-hz = /bits/ 64 <990000000>;
+		};
+
+		opp@1026000000_975 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <975000 975000 1250000>;
+			opp-supported-hw = <0x01 0x0001>;
+			opp-hz = /bits/ 64 <1026000000>;
+		};
+
+		opp@1039000000_900 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <900000 900000 1250000>;
+			opp-supported-hw = <0x04 0x0001>;
+			opp-hz = /bits/ 64 <1039000000>;
+		};
+
+		opp@1040000000_1000 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1000000 1000000 1250000>;
+			opp-supported-hw = <0x02 0x019E>;
+			opp-hz = /bits/ 64 <1040000000>;
+		};
+
+		opp@1040000000_1025 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1025000 1025000 1250000>;
+			opp-supported-hw = <0x01 0x0192>;
+			opp-hz = /bits/ 64 <1040000000>;
+		};
+
+		opp@1050000000_975 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <975000 975000 1250000>;
+			opp-supported-hw = <0x04 0x019E>;
+			opp-hz = /bits/ 64 <1050000000>;
+		};
+
+		opp@1080000000_1050 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1050000 1050000 1250000>;
+			opp-supported-hw = <0x01 0x0192>;
+			opp-hz = /bits/ 64 <1080000000>;
+		};
+
+		opp@1100000000_1025 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1025000 1025000 1250000>;
+			opp-supported-hw = <0x02 0x019E>;
+			opp-hz = /bits/ 64 <1100000000>;
+		};
+
+		opp@1102000000_900 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <900000 900000 1250000>;
+			opp-supported-hw = <0x08 0x0001>;
+			opp-hz = /bits/ 64 <1102000000>;
+		};
+
+		opp@1102000000_1000 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1000000 1000000 1250000>;
+			opp-supported-hw = <0x01 0x0001>;
+			opp-hz = /bits/ 64 <1102000000>;
+		};
+
+		opp@1117000000_975 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <975000 975000 1250000>;
+			opp-supported-hw = <0x02 0x0001>;
+			opp-hz = /bits/ 64 <1117000000>;
+		};
+
+		opp@1149000000_1025 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1025000 1025000 1250000>;
+			opp-supported-hw = <0x01 0x0001>;
+			opp-hz = /bits/ 64 <1149000000>;
+		};
+
+		opp@1150000000_975 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <975000 975000 1250000>;
+			opp-supported-hw = <0x08 0x31FE>;
+			opp-hz = /bits/ 64 <1150000000>;
+		};
+
+		opp@1150000000_1000 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1000000 1000000 1250000>;
+			opp-supported-hw = <0x04 0x019E>;
+			opp-hz = /bits/ 64 <1150000000>;
+		};
+
+		opp@1150000000_1075 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1075000 1075000 1250000>;
+			opp-supported-hw = <0x01 0x0192>;
+			opp-hz = /bits/ 64 <1150000000>;
+		};
+
+		opp@1160000000_975 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <975000 975000 1250000>;
+			opp-supported-hw = <0x10 0x31E0>;
+			opp-hz = /bits/ 64 <1160000000>;
+		};
+
+		opp@1171000000_1000 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1000000 1000000 1250000>;
+			opp-supported-hw = <0x02 0x0001>;
+			opp-hz = /bits/ 64 <1171000000>;
+		};
+
+		opp@1178000000_975 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <975000 975000 1250000>;
+			opp-supported-hw = <0x04 0x0001>;
+			opp-hz = /bits/ 64 <1178000000>;
+		};
+
+		opp@1187000000_1050 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1050000 1050000 1250000>;
+			opp-supported-hw = <0x01 0x0001>;
+			opp-hz = /bits/ 64 <1187000000>;
+		};
+
+		opp@1200000000_1025 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1025000 1025000 1250000>;
+			opp-supported-hw = <0x04 0x019E>;
+			opp-hz = /bits/ 64 <1200000000>;
+		};
+
+		opp@1200000000_1050 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1050000 1050000 1250000>;
+			opp-supported-hw = <0x02 0x019E>;
+			opp-hz = /bits/ 64 <1200000000>;
+		};
+
+		opp@1200000000_1100 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1100000 1100000 1250000>;
+			opp-supported-hw = <0x01 0x0192>;
+			opp-hz = /bits/ 64 <1200000000>;
+		};
+
+		opp@1206000000_1000 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1000000 1000000 1250000>;
+			opp-supported-hw = <0x04 0x0001>;
+			opp-hz = /bits/ 64 <1206000000>;
+		};
+
+		opp@1206000000_1025 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1025000 1025000 1250000>;
+			opp-supported-hw = <0x02 0x0001>;
+			opp-hz = /bits/ 64 <1206000000>;
+		};
+
+		opp@1216000000_975 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <975000 975000 1250000>;
+			opp-supported-hw = <0x08 0x0001>;
+			opp-hz = /bits/ 64 <1216000000>;
+		};
+
+		opp@1225000000_1075 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1075000 1075000 1250000>;
+			opp-supported-hw = <0x01 0x0001>;
+			opp-hz = /bits/ 64 <1225000000>;
+		};
+
+		opp@1230000000_1000 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1000000 1000000 1250000>;
+			opp-supported-hw = <0x08 0x31FE>;
+			opp-hz = /bits/ 64 <1230000000>;
+		};
+
+		opp@1240000000_1000 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1000000 1000000 1250000>;
+			opp-supported-hw = <0x10 0x3060>;
+			opp-hz = /bits/ 64 <1240000000>;
+		};
+
+		opp@1240000000_1125 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1125000 1125000 1250000>;
+			opp-supported-hw = <0x01 0x0010>;
+			opp-hz = /bits/ 64 <1240000000>;
+		};
+
+		opp@1250000000_1075 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1075000 1075000 1250000>;
+			opp-supported-hw = <0x02 0x001C>;
+			opp-hz = /bits/ 64 <1250000000>;
+		};
+
+		opp@1280000000_1025 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1025000 1025000 1250000>;
+			opp-supported-hw = <0x18 0x307C>;
+			opp-hz = /bits/ 64 <1280000000>;
+		};
+
+		opp@1280000000_1050 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1050000 1050000 1250000>;
+			opp-supported-hw = <0x04 0x001C>;
+			opp-hz = /bits/ 64 <1280000000>;
+		};
+
+		opp@1280000000_1125 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1125000 1125000 1250000>;
+			opp-supported-hw = <0x01 0x0182>;
+			opp-hz = /bits/ 64 <1280000000>;
+		};
+
+		opp@1280000000_1150 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1150000 1150000 1250000>;
+			opp-supported-hw = <0x01 0x0010>;
+			opp-hz = /bits/ 64 <1280000000>;
+		};
+
+		opp@1282000000_1100 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1100000 1100000 1250000>;
+			opp-supported-hw = <0x01 0x0001>;
+			opp-hz = /bits/ 64 <1282000000>;
+		};
+
+		opp@1300000000_1000 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1000000 1000000 1250000>;
+			opp-supported-hw = <0x18 0x0181>;
+			opp-hz = /bits/ 64 <1300000000>;
+		};
+
+		opp@1300000000_1025 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1025000 1025000 1250000>;
+			opp-supported-hw = <0x0C 0x0183>;
+			opp-hz = /bits/ 64 <1300000000>;
+		};
+
+		opp@1300000000_1050 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1050000 1050000 1250000>;
+			opp-supported-hw = <0x0E 0x018F>;
+			opp-hz = /bits/ 64 <1300000000>;
+		};
+
+		opp@1300000000_1075 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1075000 1075000 1250000>;
+			opp-supported-hw = <0x06 0x019E>;
+			opp-hz = /bits/ 64 <1300000000>;
+		};
+
+		opp@1300000000_1100 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1100000 1100000 1250000>;
+			opp-supported-hw = <0x02 0x001C>;
+			opp-hz = /bits/ 64 <1300000000>;
+		};
+
+		opp@1300000000_1125 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1125000 1125000 1250000>;
+			opp-supported-hw = <0x01 0x0001>;
+			opp-hz = /bits/ 64 <1300000000>;
+		};
+
+		opp@1300000000_1150 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1150000 1150000 1250000>;
+			opp-supported-hw = <0x01 0x0182>;
+			opp-hz = /bits/ 64 <1300000000>;
+		};
+
+		opp@1320000000_1175 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1175000 1175000 1250000>;
+			opp-supported-hw = <0x01 0x0010>;
+			opp-hz = /bits/ 64 <1320000000>;
+		};
+
+		opp@1330000000_1050 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1050000 1050000 1250000>;
+			opp-supported-hw = <0x08 0x3070>;
+			opp-hz = /bits/ 64 <1330000000>;
+		};
+
+		opp@1330000000_1125 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1125000 1125000 1250000>;
+			opp-supported-hw = <0x02 0x001C>;
+			opp-hz = /bits/ 64 <1330000000>;
+		};
+
+		opp@1340000000_1100 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1100000 1100000 1250000>;
+			opp-supported-hw = <0x04 0x0010>;
+			opp-hz = /bits/ 64 <1340000000>;
+		};
+
+		opp@1350000000_1075 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1075000 1075000 1250000>;
+			opp-supported-hw = <0x08 0x000C>;
+			opp-hz = /bits/ 64 <1350000000>;
+		};
+
+		opp@1350000000_1100 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1100000 1100000 1250000>;
+			opp-supported-hw = <0x04 0x000C>;
+			opp-hz = /bits/ 64 <1350000000>;
+		};
+
+		opp@1360000000_1050 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1050000 1050000 1250000>;
+			opp-supported-hw = <0x10 0x3060>;
+			opp-hz = /bits/ 64 <1360000000>;
+		};
+
+		opp@1360000000_1150 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1150000 1150000 1250000>;
+			opp-supported-hw = <0x02 0x0010>;
+			opp-hz = /bits/ 64 <1360000000>;
+		};
+
+		opp@1360000000_1200 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1200000 1200000 1250000>;
+			opp-supported-hw = <0x01 0x0010>;
+			opp-hz = /bits/ 64 <1360000000>;
+		};
+
+		opp@1370000000_1075 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1075000 1075000 1250000>;
+			opp-supported-hw = <0x08 0x3070>;
+			opp-hz = /bits/ 64 <1370000000>;
+		};
+
+		opp@1380000000_1125 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1125000 1125000 1250000>;
+			opp-supported-hw = <0x04 0x0010>;
+			opp-hz = /bits/ 64 <1380000000>;
+		};
+
+		opp@1390000000_1075 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1075000 1075000 1250000>;
+			opp-supported-hw = <0x10 0x3060>;
+			opp-hz = /bits/ 64 <1390000000>;
+		};
+
+		opp@1400000000_1100 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1100000 1100000 1250000>;
+			opp-supported-hw = <0x08 0x307C>;
+			opp-hz = /bits/ 64 <1400000000>;
+		};
+
+		opp@1400000000_1125 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1125000 1125000 1250000>;
+			opp-supported-hw = <0x04 0x000C>;
+			opp-hz = /bits/ 64 <1400000000>;
+		};
+
+		opp@1400000000_1150 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1150000 1150000 1250000>;
+			opp-supported-hw = <0x02 0x000C>;
+			opp-hz = /bits/ 64 <1400000000>;
+		};
+
+		opp@1400000000_1175 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1175000 1175000 1250000>;
+			opp-supported-hw = <0x02 0x0010>;
+			opp-hz = /bits/ 64 <1400000000>;
+		};
+
+		opp@1470000000_1100 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1100000 1100000 1250000>;
+			opp-supported-hw = <0x10 0x3060>;
+			opp-hz = /bits/ 64 <1470000000>;
+		};
+
+		opp@1470000000_1125 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1125000 1125000 1250000>;
+			opp-supported-hw = <0x08 0x3060>;
+			opp-hz = /bits/ 64 <1470000000>;
+		};
+
+		opp@1500000000_1125 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1125000 1125000 1250000>;
+			opp-supported-hw = <0x18 0x3070>;
+			opp-hz = /bits/ 64 <1500000000>;
+		};
+
+		opp@1500000000_1150 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1150000 1150000 1250000>;
+			opp-supported-hw = <0x0C 0x3070>;
+			opp-hz = /bits/ 64 <1500000000>;
+		};
+
+		opp@1500000000_1200 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1200000 1200000 1250000>;
+			opp-supported-hw = <0x02 0x0010>;
+			opp-hz = /bits/ 64 <1500000000>;
+		};
+
+		opp@1500000000_1237 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1237000 1237000 1250000>;
+			opp-supported-hw = <0x01 0x0010>;
+			opp-hz = /bits/ 64 <1500000000>;
+		};
+
+		opp@1520000000_1150 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1150000 1150000 1250000>;
+			opp-supported-hw = <0x10 0x3060>;
+			opp-hz = /bits/ 64 <1520000000>;
+		};
+
+		opp@1540000000_1200 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1200000 1200000 1250000>;
+			opp-supported-hw = <0x08 0x3060>;
+			opp-hz = /bits/ 64 <1540000000>;
+		};
+
+		opp@1590000000_1200 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1200000 1200000 1250000>;
+			opp-supported-hw = <0x10 0x3060>;
+			opp-hz = /bits/ 64 <1590000000>;
+		};
+
+		opp@1700000000_1212 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1212000 1212000 1250000>;
+			opp-supported-hw = <0x10 0x3060>;
+			opp-hz = /bits/ 64 <1700000000>;
+		};
+
+		opp@1700000000_1237 {
+			clock-latency-ns = <50000>;
+			opp-microvolt = <1237000 1237000 1250000>;
+			opp-supported-hw = <0x08 0x3060>;
+			opp-hz = /bits/ 64 <1700000000>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -988,24 +1652,48 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			clocks = <&tegra_car TEGRA30_CLK_PLL_X>,
+				 <&tegra_car TEGRA30_CLK_PLL_P>,
+				 <&tegra_car TEGRA30_CLK_CCLK_G>;
+			clock-names = "pll_x", "intermediate", "cclk";
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
+			clock-names = "pll_x", "intermediate", "cclk";
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
+			clock-names = "pll_x", "intermediate", "cclk";
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
+			clock-names = "pll_x", "intermediate", "cclk";
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 	};
 
-- 
2.19.0
