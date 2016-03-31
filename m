From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v7 13/20] ARM: dts: Add bus nodes using VDD_INT for Exynos3250
Date: Thu, 31 Mar 2016 18:05:58 +0900
Message-ID: <1459415165-32613-14-git-send-email-cw00.choi@samsung.com>
References: <1459415165-32613-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1459415165-32613-1-git-send-email-cw00.choi@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: mark.rutland@arm.com, inki.dae@samsung.com, linux-samsung-soc@vger.kernel.org, linux@arm.linux.org.uk, cw00.choi@samsung.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux.amoon@gmail.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, devicetree@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org, linux-arm-kernel@lists.infradead.org
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
- SCLK_MFC clock for MFC

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 147 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 1ae72c4fa55e..b5157492a422 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -722,6 +722,153 @@
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
+		bus_mfc: bus_mfc {
+			compatible = "samsung,exynos-bus";
+			clocks = <&cmu CLK_SCLK_MFC>;
+			clock-names = "bus";
+			operating-points-v2 = <&bus_leftbus_opp_table>;
+			status = "disabled";
+		};
+
+		bus_leftbus_opp_table: opp_table2 {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			opp@50000000 {
+				opp-hz = /bits/ 64 <50000000>;
+				opp-microvolt = <900000>;
+			};
+			opp@80000000 {
+				opp-hz = /bits/ 64 <80000000>;
+				opp-microvolt = <900000>;
+			};
+			opp@100000000 {
+				opp-hz = /bits/ 64 <100000000>;
+				opp-microvolt = <1000000>;
+			};
+			opp@134000000 {
+				opp-hz = /bits/ 64 <134000000>;
+				opp-microvolt = <1000000>;
+			};
+			opp@200000000 {
+				opp-hz = /bits/ 64 <200000000>;
+				opp-microvolt = <1000000>;
+			};
+		};
+
+		bus_mcuisp_opp_table: opp_table3 {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			opp@50000000 {
+				opp-hz = /bits/ 64 <50000000>;
+			};
+			opp@80000000 {
+				opp-hz = /bits/ 64 <80000000>;
+			};
+			opp@100000000 {
+				opp-hz = /bits/ 64 <100000000>;
+			};
+			opp@200000000 {
+				opp-hz = /bits/ 64 <200000000>;
+			};
+			opp@400000000 {
+				opp-hz = /bits/ 64 <400000000>;
+			};
+		};
+
+		bus_isp_opp_table: opp_table4 {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			opp@50000000 {
+				opp-hz = /bits/ 64 <50000000>;
+			};
+			opp@80000000 {
+				opp-hz = /bits/ 64 <80000000>;
+			};
+			opp@100000000 {
+				opp-hz = /bits/ 64 <100000000>;
+			};
+			opp@200000000 {
+				opp-hz = /bits/ 64 <200000000>;
+			};
+			opp@300000000 {
+				opp-hz = /bits/ 64 <300000000>;
+			};
+		};
+
+		bus_peril_opp_table: opp_table5 {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			opp@50000000 {
+				opp-hz = /bits/ 64 <50000000>;
+			};
+			opp@80000000 {
+				opp-hz = /bits/ 64 <80000000>;
+			};
+			opp@100000000 {
+				opp-hz = /bits/ 64 <100000000>;
+			};
+		};
 	};
 };
 
-- 
1.9.1
