From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC PATCH 11/15] ARM: dts: Add bus nodes using VDD_INT for Exynos3250
Date: Thu, 26 Nov 2015 22:47:35 +0900
Message-ID: <1448545659-32287-12-git-send-email-cw00.choi@samsung.com>
References: <1448545659-32287-1-git-send-email-cw00.choi@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1448545659-32287-1-git-send-email-cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This patch adds the bus nodes using VDD_INT for Exynos3250 SoC.
Exynos3250 has following AXI buses to translate data between
DRAM and sub-blocks.

Following list specifies the detailed relation between DRAM and sub-blocks:
- ACLK400 clock for MCUISP
- ACLK266 clock for ISP
- ACLK200 clock for FSYS
- ACLK160 clock for LCD0
- ACLK100 clock for PERIL
- GDL clock for LEFTBUS
- GDR clock for RIGHTBUS

Signed-off-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/exynos3250.dtsi | 152 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 45809f83c628..2e5d60c24004 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -734,6 +734,158 @@
 				opp-microvolt = <875000>;
 			};
 		};
+
+		bus_leftbus: bus_leftbus {
+			compatible = "samsung,exynos-bus";
+			clocks = <&cmu CLK_DIV_GDL>;
+			clock-names = "bus";
+			operating-points-v2 = <&bus_leftbus_opp_table>;
+			status = "disabled";
+		};
+
+		bus_rightbus: bus_rightbus {
+			compatible = "samsung,exynos-bus";
+			clocks = <&cmu CLK_DIV_GDR>;
+			clock-names = "bus";
+			operating-points-v2 = <&bus_leftbus_opp_table>;
+			status = "disabled";
+		};
+
+		bus_lcd0: bus_lcd0 {
+			compatible = "samsung,exynos-bus";
+			clocks = <&cmu CLK_DIV_ACLK_160>;
+			clock-names = "bus";
+			operating-points-v2 = <&bus_leftbus_opp_table>;
+			status = "disabled";
+		};
+
+		bus_fsys: bus_fsys {
+			compatible = "samsung,exynos-bus";
+			clocks = <&cmu CLK_DIV_ACLK_200>;
+			clock-names = "bus";
+			operating-points-v2 = <&bus_leftbus_opp_table>;
+			status = "disabled";
+		};
+
+		bus_mcuisp: bus_mcuisp {
+			compatible = "samsung,exynos-bus";
+			clocks = <&cmu CLK_DIV_ACLK_400_MCUISP>;
+			clock-names = "bus";
+			operating-points-v2 = <&bus_mcuisp_opp_table>;
+			status = "disabled";
+		};
+
+		bus_isp: bus_isp {
+			compatible = "samsung,exynos-bus";
+			clocks = <&cmu CLK_DIV_ACLK_266>;
+			clock-names = "bus";
+			operating-points-v2 = <&bus_isp_opp_table>;
+			status = "disabled";
+		};
+
+		bus_peril: bus_peril {
+			compatible = "samsung,exynos-bus";
+			clocks = <&cmu CLK_DIV_ACLK_100>;
+			clock-names = "bus";
+			operating-points-v2 = <&bus_peril_opp_table>;
+			status = "disabled";
+		};
+
+		bus_leftbus_opp_table: opp_table1 {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			opp00 {
+				opp-hz = /bits/ 64 <50000000>;
+				opp-microvolt = <900000>;
+			};
+			opp01 {
+				opp-hz = /bits/ 64 <80000000>;
+				opp-microvolt = <900000>;
+			};
+			opp02 {
+				opp-hz = /bits/ 64 <100000000>;
+				opp-microvolt = <1000000>;
+			};
+			opp03 {
+				opp-hz = /bits/ 64 <133000000>;
+				opp-microvolt = <1000000>;
+			};
+			opp04 {
+				opp-hz = /bits/ 64 <200000000>;
+				opp-microvolt = <1000000>;
+			};
+		};
+
+		bus_mcuisp_opp_table: opp_table2 {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			opp00 {
+				opp-hz = /bits/ 64 <50000000>;
+				opp-microvolt = <900000>;
+			};
+			opp01 {
+				opp-hz = /bits/ 64 <80000000>;
+				opp-microvolt = <900000>;
+			};
+			opp02 {
+				opp-hz = /bits/ 64 <100000000>;
+				opp-microvolt = <1000000>;
+			};
+			opp03 {
+				opp-hz = /bits/ 64 <200000000>;
+				opp-microvolt = <1000000>;
+			};
+			opp04 {
+				opp-hz = /bits/ 64 <400000000>;
+				opp-microvolt = <1000000>;
+			};
+		};
+
+		bus_isp_opp_table: opp_table3 {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			opp00 {
+				opp-hz = /bits/ 64 <50000000>;
+				opp-microvolt = <900000>;
+			};
+			opp01 {
+				opp-hz = /bits/ 64 <80000000>;
+				opp-microvolt = <900000>;
+			};
+			opp02 {
+				opp-hz = /bits/ 64 <100000000>;
+				opp-microvolt = <1000000>;
+			};
+			opp03 {
+				opp-hz = /bits/ 64 <200000000>;
+				opp-microvolt = <1000000>;
+			};
+			opp04 {
+				opp-hz = /bits/ 64 <300000000>;
+				opp-microvolt = <1000000>;
+			};
+		};
+
+		bus_peril_opp_table: opp_table4 {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			opp00 {
+				opp-hz = /bits/ 64 <50000000>;
+				opp-microvolt = <900000>;
+			};
+			opp01 {
+				opp-hz = /bits/ 64 <80000000>;
+				opp-microvolt = <900000>;
+			};
+			opp02 {
+				opp-hz = /bits/ 64 <100000000>;
+				opp-microvolt = <1000000>;
+			};
+		};
 	};
 };
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
