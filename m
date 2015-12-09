From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 09/19] PM / devfreq: exynos: Update documentation for bus
 devices using passive governor
Date: Wed, 09 Dec 2015 13:08:01 +0900
Message-ID: <1449634091-1842-10-git-send-email-cw00.choi@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch updates the documentation for passive bus devices and adds the
detailed example of Exynos3250.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 .../devicetree/bindings/devfreq/exynos-bus.txt     | 244 ++++++++++++++++++++-
 1 file changed, 241 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
index 54a1f9c46c88..c4fdc70f8eac 100644
--- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
+++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
@@ -13,18 +13,23 @@ SoC has the different sub-blocks. So, this difference should be specified
 in devicetree file instead of each device driver. In result, this driver
 is able to support the bus frequency for all Exynos SoCs.
 
-Required properties for bus device:
+Required properties for all bus devices:
 - compatible: Should be "samsung,exynos-bus".
 - clock-names : the name of clock used by the bus, "bus".
 - clocks : phandles for clock specified in "clock-names" property.
 - #clock-cells: should be 1.
 - operating-points-v2: the OPP table including frequency/voltage information
   to support DVFS (Dynamic Voltage/Frequency Scaling) feature.
+
+Required properties for only parent bus device:
 - vdd-supply: the regulator to provide the buses with the voltage.
 - devfreq-events: the devfreq-event device to monitor the curret utilization
   of buses.
 
-Optional properties for bus device:
+Required properties for only passive bus device:
+- devfreq: the parent bus device.
+
+Optional properties for only parent bus device:
 - exynos,saturation-ratio: the percentage value which is used to calibrate
                    the performance count againt total cycle count.
 
@@ -33,7 +38,20 @@ Example1:
 	power line (regulator). The MIF (Memory Interface) AXI bus is used to
 	transfer data between DRAM and CPU and uses the VDD_MIF regualtor.
 
-	- power line(VDD_MIF) --> bus for DMC (Dynamic Memory Controller) block
+	- MIF (Memory Interface) block
+	: VDD_MIF |--- DMC (Dynamic Memory Controller)
+
+	- INT (Internal) block
+	: VDD_INT |--- LEFTBUS (parent device)
+		  |--- PERIL
+		  |--- MFC
+		  |--- G3D
+		  |--- RIGHTBUS
+		  |--- FSYS
+		  |--- LCD0
+		  |--- PERIR
+		  |--- ISP
+		  |--- CAM
 
 	- MIF bus's frequency/voltage table
 	-----------------------
@@ -46,6 +64,24 @@ Example1:
 	|L5| 400000 |875000   |
 	-----------------------
 
+	- INT bus's frequency/voltage table
+	----------------------------------------------------------
+	|Block|LEFTBUS|RIGHTBUS|MCUISP |ISP    |PERIL  ||VDD_INT |
+	| name|       |LCD0    |       |       |       ||        |
+	|     |       |FSYS    |       |       |       ||        |
+	|     |       |MFC     |       |       |       ||        |
+	----------------------------------------------------------
+	|Mode |*parent|passive |passive|passive|passive||        |
+	----------------------------------------------------------
+	|Lv   |Frequency                               ||Voltage |
+	----------------------------------------------------------
+	|L1   |50000  |50000   |50000  |50000  |50000  ||900000  |
+	|L2   |80000  |80000   |80000  |80000  |80000  ||900000  |
+	|L3   |100000 |100000  |100000 |100000 |100000 ||1000000 |
+	|L4   |134000 |134000  |200000 |200000 |       ||1000000 |
+	|L5   |200000 |200000  |400000 |300000 |       ||1000000 |
+	----------------------------------------------------------
+
 Example2 :
 	The bus of DMC (Dynamic Memory Controller) block in exynos3250.dtsi
 	are listed below:
@@ -84,6 +120,167 @@ Example2 :
 		};
 	};
 
+	bus_leftbus: bus_leftbus {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu CLK_DIV_GDL>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		status = "disabled";
+	};
+
+	bus_rightbus: bus_rightbus {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu CLK_DIV_GDR>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		status = "disabled";
+	};
+
+	bus_lcd0: bus_lcd0 {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu CLK_DIV_ACLK_160>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		status = "disabled";
+	};
+
+	bus_fsys: bus_fsys {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu CLK_DIV_ACLK_200>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		status = "disabled";
+	};
+
+	bus_mcuisp: bus_mcuisp {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu CLK_DIV_ACLK_400_MCUISP>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_mcuisp_opp_table>;
+		status = "disabled";
+	};
+
+	bus_isp: bus_isp {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu CLK_DIV_ACLK_266>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_isp_opp_table>;
+		status = "disabled";
+	};
+
+	bus_peril: bus_perir {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu CLK_DIV_ACLK_100>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_peril_opp_table>;
+		status = "disabled";
+	};
+
+	bus_mfc: bus_mfc {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu CLK_SCLK_MFC>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		status = "disabled";
+	};
+
+	bus_leftbus_opp_table: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <50000000>;
+			opp-microvolt = <900000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <80000000>;
+			opp-microvolt = <900000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <134000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <1000000>;
+		};
+	};
+
+	bus_mcuisp_opp_table: opp_table2 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <50000000>;
+			opp-microvolt = <900000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <80000000>;
+			opp-microvolt = <900000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <1000000>;
+		};
+	};
+
+	bus_isp_opp_table: opp_table3 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <50000000>;
+			opp-microvolt = <900000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <80000000>;
+			opp-microvolt = <900000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <1000000>;
+		};
+	};
+
+	bus_peril_opp_table: opp_table4 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <50000000>;
+			opp-microvolt = <900000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <80000000>;
+			opp-microvolt = <900000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <1000000>;
+		};
+	};
+
+
 	Usage case to handle the frequency and voltage of bus on runtime
 	in exynos3250-rinato.dts are listed below:
 
@@ -92,3 +289,44 @@ Example2 :
 		vdd-supply = <&buck1_reg>;	/* VDD_MIF */
 		status = "okay";
 	};
+
+	&bus_leftbus {
+		devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
+		vdd-supply = <&buck3_reg>;
+		status = "okay";
+	};
+
+	&bus_rightbus {
+		devfreq = <&bus_leftbus>;
+		status = "okay";
+	};
+
+	&bus_lcd0 {
+		devfreq = <&bus_leftbus>;
+		status = "okay";
+	};
+
+	&bus_fsys {
+		devfreq = <&bus_leftbus>;
+		status = "okay";
+	};
+
+	&bus_mcuisp {
+		devfreq = <&bus_leftbus>;
+		status = "okay";
+	};
+
+	&bus_isp {
+		devfreq = <&bus_leftbus>;
+		status = "okay";
+	};
+
+	&bus_peril {
+		devfreq = <&bus_leftbus>;
+		status = "okay";
+	};
+
+	&bus_mfc {
+		devfreq = <&bus_leftbus>;
+		status = "okay";
+	};
-- 
1.9.1
