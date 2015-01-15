From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v4 6/9] ARM: dts: Add memory bus node for Exynos4210
Date: Thu, 15 Jan 2015 10:50:54 +0900
Message-ID: <1421286657-4720-7-git-send-email-cw00.choi@samsung.com>
References: <1421286657-4720-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1421286657-4720-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, mark.rutland@arm.com, a.kesavan@samsung.com, tomasz.figa@gmail.com, k.kozlowski@samsung.com, b.zolnierkie@samsung.com, robh+dt@kernel.org, cw00.choi@samsung.com, inki.dae@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch adds the memory bus node for Exynos4210 SoC. Exynos4210 SoC has
one memory bus to translate data between DRAM and eMMC/sub-IPs because
Exynos4210 must need only one regulator for memory bus.

Following list specifies the detailed relation between memory bus clock and
sub-IPs:
- DMC/ACP clock : DMC (Dynamic Memory Controller)
- ACLK200 clock : LCD0
- ACLK100 clock : PERIL/PERIR/MFC(PCLK)
- ACLK160 clock : CAM/TV/LCD0/LCD1
- ACLK133 clock : FSYS/GPS
- GDL/GDR clock : leftbus/rightbus
- SCLK_MFC clock : MFC

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Myungjoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/exynos4210.dtsi | 93 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index b2598de..c039409 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -48,6 +48,99 @@
 		};
 	};
 
+	memory_bus: memory_bus@0 {
+		compatible = "samsung,exynos-memory-bus";
+
+		operating-points = <
+			400000 1150000
+			267000 1050000
+			133000 1025000>;
+		status = "disabled";
+
+		blocks {
+			dmc_block: memory_bus_block1 {
+				clocks = <&clock CLK_DIV_DMC>;
+				clock-names = "memory-bus";
+				frequency = <
+					400000
+					267000
+					133000>;
+			};
+
+			acp_block: memory_bus_block2 {
+				clocks = <&clock CLK_DIV_ACP>;
+				clock-names = "memory-bus";
+				frequency = <
+					200000
+					160000
+					133000>;
+			};
+
+			peri_block: memory_bus_block3 {
+				clocks = <&clock CLK_ACLK100>;
+				clock-names = "memory-bus";
+				frequency = <
+					100000
+					100000
+					100000>;
+			};
+
+			fsys_block: memory_bus_block4 {
+				clocks = <&clock CLK_ACLK133>;
+				clock-names = "memory-bus";
+				frequency = <
+					133000
+					133000
+					100000>;
+			};
+
+			display_block: memory_bus_block5 {
+				clocks = <&clock CLK_ACLK160>;
+				clock-names = "memory-bus";
+				frequency = <
+					160000
+					133000
+					100000>;
+			};
+
+			lcd0_block: memory_bus_block6 {
+				clocks = <&clock CLK_ACLK200>;
+				clock-names = "memory-bus";
+				frequency = <
+					200000
+					160000
+					100000>;
+			};
+
+			leftbus_block: memory_bus_block7 {
+				clocks = <&clock CLK_DIV_GDL>;
+				clock-names = "memory-bus";
+				frequency = <
+					200000
+					160000
+					100000>;
+			};
+
+			rightbus_block: memory_bus_block8 {
+				clocks = <&clock CLK_DIV_GDR>;
+				clock-names = "memory-bus";
+				frequency = <
+					200000
+					160000
+					100000>;
+			};
+
+			mfc_block: memory_bus_block9 {
+				clocks = <&clock CLK_SCLK_MFC>;
+				clock-names = "memory-bus";
+				frequency = <
+					200000
+					160000
+					100000>;
+			};
+		};
+	};
+
 	pmu_system_controller: system-controller@10020000 {
 		clock-names = "clkout0", "clkout1", "clkout2", "clkout3",
 				"clkout4", "clkout8", "clkout9";
-- 
1.8.5.5
