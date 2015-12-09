From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 15/19] ARM: dts: Add bus nodes using VDD_MIF for Exynos4210
Date: Wed, 09 Dec 2015 13:08:07 +0900
Message-ID: <1449634091-1842-16-git-send-email-cw00.choi@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:59296 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070AbbLIEIb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2015 23:08:31 -0500
In-reply-to: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org

This patch adds the bus nodes for Exynos4210 SoC. Exynos4210 SoC has
one power line for all buses to translate data between DRAM and sub-blocks.

Following list specifies the detailed relation between DRAM and sub-blocks:
- DMC/ACP clock for DMC (Dynamic Memory Controller)
- ACLK200 clock for LCD0
- ACLK100 clock for PERIL/PERIR/MFC(PCLK)
- ACLK160 clock for CAM/TV/LCD0/LCD1
- ACLK133 clock for FSYS/GPS
- GDL/GDR clock for LEFTBUS/RIGHTBUS
- SCLK_MFC clock for MFC

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/exynos4210.dtsi | 172 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 3e5ba665d200..658c5a1fe03c 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -257,6 +257,178 @@
 		power-domains = <&pd_lcd1>;
 		#iommu-cells = <0>;
 	};
+
+	bus_dmc: bus_dmc {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DIV_DMC>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_dmc_opp_table>;
+		status = "disabled";
+	};
+
+	bus_acp: bus_acp {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DIV_ACP>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_acp_opp_table>;
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
+	bus_fsys: bus_fsys {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_ACLK133>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_fsys_opp_table>;
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
+	bus_lcd0: bus_lcd0 {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_ACLK200>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		status = "disabled";
+	};
+
+	bus_leftbus: bus_leftbus {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DIV_GDL>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		status = "disabled";
+	};
+
+	bus_rightbus: bus_rightbus {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DIV_GDR>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
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
+	bus_dmc_opp_table: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <134000000>;
+			opp-microvolt = <1025000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <267000000>;
+			opp-microvolt = <1050000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <1150000>;
+		};
+	};
+
+	bus_acp_opp_table: opp_table2 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <134000000>;
+			opp-microvolt = <1025000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <160000000>;
+			opp-microvolt = <1050000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <1150000>;
+		};
+	};
+
+	bus_peri_opp_table: opp_table3 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <5000000>;
+			opp-microvolt = <1025000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <1050000>;
+		};
+	};
+
+	bus_fsys_opp_table: opp_table4 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <10000000>;
+			opp-microvolt = <1025000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <134000000>;
+			opp-microvolt = <1050000>;
+		};
+	};
+
+	bus_display_opp_table: opp_table5 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <1025000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <134000000>;
+			opp-microvolt = <1050000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <160000000>;
+			opp-microvolt = <1150000>;
+		};
+	};
+
+	bus_leftbus_opp_table: opp_table6 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <1025000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <160000000>;
+			opp-microvolt = <1050000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <1150000>;
+		};
+	};
 };
 
 &gic {
-- 
1.9.1

