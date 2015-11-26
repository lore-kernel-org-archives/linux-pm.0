From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC PATCH 14/15] ARM: dts: Add bus nodes using VDD_INT for Exynos4x12
Date: Thu, 26 Nov 2015 22:47:38 +0900
Message-ID: <1448545659-32287-15-git-send-email-cw00.choi@samsung.com>
References: <1448545659-32287-1-git-send-email-cw00.choi@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1448545659-32287-1-git-send-email-cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This patch adds the bus noes using VDD_INT for Exynos4x12 SoC.
Exynos4x12 has the following AXI buses to translate data between
DRAM and sub-blocks.

Following list specifies the detailed relation between DRAM and sub-blocks:
- ACLK100 clock for PERIL/PERIR/MFC(PCLK)
- ACLK160 clock for CAM/TV/LCD
- ACLK133 clock for FSYS
- GDL clock for LEFTBUS
- GDR clock for RIGHTBUS
- SCLK_MFC clock for MFC

Signed-off-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/exynos4x12.dtsi | 119 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index c7ab2825d7cd..1b90d4984e35 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -355,6 +355,125 @@
 		};
 	};
 
+	bus_leftbus: bus_leftbus {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DIV_GDL>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		status = "disabled";
+	};
+
+	bus_rightbus: bus_leftbus {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DIV_GDR>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		status = "disabled";
+	};
+
+	bus_display: bus_display {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_ACLK160>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_display_opp_table>;
+		status = "disabled";
+	};
+
+	bus_fsys: bus_fsys {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_ACLK133>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_fsys_opp_table>;
+		status = "disabled";
+	};
+
+	bus_peri: bus_peri {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_ACLK100>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_peri_opp_table>;
+		status = "disabled";
+	};
+
+	bus_mfc: bus_mfc {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_SCLK_MFC>;
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
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <900000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <133000000>;
+			opp-microvolt = <925000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <160000000>;
+			opp-microvolt = <950000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <1000000>;
+		};
+	};
+
+	bus_display_opp_table: opp_table2 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <900000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <133000000>;
+			opp-microvolt = <925000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <160000000>;
+			opp-microvolt = <950000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <160000000>;
+			opp-microvolt = <1000000>;
+		};
+	};
+
+	bus_fsys_opp_table: opp_table3 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <900000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <133000000>;
+			opp-microvolt = <925000>;
+		};
+	};
+
+	bus_peri_opp_table: opp_table4 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <50000000>;
+			opp-microvolt = <900000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <925000>;
+		};
+	};
 };
 
 &combiner {
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
