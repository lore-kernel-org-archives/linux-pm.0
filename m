From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v8 07/20] PM / devfreq: exynos: Update documentation for bus
 devices using passive governor
Date: Fri, 08 Apr 2016 13:24:56 +0900
Message-ID: <1460089509-16260-8-git-send-email-cw00.choi@samsung.com>
References: <1460089509-16260-1-git-send-email-cw00.choi@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1460089509-16260-1-git-send-email-cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux.amoon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, m.reichl-SRyzfwRm/0rPTwkrwQOX7A@public.gmane.org, tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This patch updates the documentation for passive bus devices and adds the
detailed example of Exynos3250.

Signed-off-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Acked-by: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 .../devicetree/bindings/devfreq/exynos-bus.txt     | 250 ++++++++++++++++++++-
 1 file changed, 247 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
index 78171b918e3f..03f13d38f1a1 100644
--- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
+++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
@@ -8,22 +8,46 @@ of the bus in runtime. To monitor the usage of each bus in runtime,
 the driver uses the PPMU (Platform Performance Monitoring Unit), which
 is able to measure the current load of sub-blocks.
 
+The Exynos SoC includes the various sub-blocks which have the each AXI bus.
+The each AXI bus has the owned source clock but, has not the only owned
+power line. The power line might be shared among one more sub-blocks.
+So, we can divide into two type of device as the role of each sub-block.
+There are two type of bus devices as following:
+- parent bus device
+- passive bus device
+
+Basically, parent and passive bus device share the same power line.
+The parent bus device can only change the voltage of shared power line
+and the rest bus devices (passive bus device) depend on the decision of
+the parent bus device. If there are three blocks which share the VDD_xxx
+power line, Only one block should be parent device and then the rest blocks
+should depend on the parent device as passive device.
+
+	VDD_xxx |--- A block (parent)
+		|--- B block (passive)
+		|--- C block (passive)
+
 There are a little different composition among Exynos SoC because each Exynos
 SoC has different sub-blocks. Therefore, shch difference should be specified
 in devicetree file instead of each device driver. In result, this driver
 is able to support the bus frequency for all Exynos SoCs.
 
-Required properties for bus device:
+Required properties for all bus devices:
 - compatible: Should be "samsung,exynos-bus".
 - clock-names : the name of clock used by the bus, "bus".
 - clocks : phandles for clock specified in "clock-names" property.
 - operating-points-v2: the OPP table including frequency/voltage information
   to support DVFS (Dynamic Voltage/Frequency Scaling) feature.
+
+Required properties only for parent bus device:
 - vdd-supply: the regulator to provide the buses with the voltage.
 - devfreq-events: the devfreq-event device to monitor the current utilization
   of buses.
 
-Optional properties for bus device:
+Required properties only for passive bus device:
+- devfreq: the parent bus device.
+
+Optional properties only for parent bus device:
 - exynos,saturation-ratio: the percentage value which is used to calibrate
 			the performance count against total cycle count.
 - exynos,voltage-tolerance: the percentage value for bus voltage tolerance
@@ -34,7 +58,20 @@ Example1:
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
@@ -47,6 +84,24 @@ Example1:
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
 	is listed below:
@@ -85,6 +140,154 @@ Example2 :
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
+	bus_peril: bus_peril {
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
+		opp@50000000 {
+			opp-hz = /bits/ 64 <50000000>;
+			opp-microvolt = <900000>;
+		};
+		opp@80000000 {
+			opp-hz = /bits/ 64 <80000000>;
+			opp-microvolt = <900000>;
+		};
+		opp@100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp@134000000 {
+			opp-hz = /bits/ 64 <134000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp@200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <1000000>;
+		};
+	};
+
+	bus_mcuisp_opp_table: opp_table2 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@50000000 {
+			opp-hz = /bits/ 64 <50000000>;
+		};
+		opp@80000000 {
+			opp-hz = /bits/ 64 <80000000>;
+		};
+		opp@100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+		};
+		opp@200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+		};
+		opp@400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+		};
+	};
+
+	bus_isp_opp_table: opp_table3 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@50000000 {
+			opp-hz = /bits/ 64 <50000000>;
+		};
+		opp@80000000 {
+			opp-hz = /bits/ 64 <80000000>;
+		};
+		opp@100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+		};
+		opp@200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+		};
+		opp@300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+		};
+	};
+
+	bus_peril_opp_table: opp_table4 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@50000000 {
+			opp-hz = /bits/ 64 <50000000>;
+		};
+		opp@80000000 {
+			opp-hz = /bits/ 64 <80000000>;
+		};
+		opp@100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+		};
+	};
+
+
 	Usage case to handle the frequency and voltage of bus on runtime
 	in exynos3250-rinato.dts is listed below:
 
@@ -93,3 +296,44 @@ Example2 :
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
