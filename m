From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [RFC PATCHv2 5/8] ARM: dts: Add memory bus node for Exynos4x12
Date: Wed, 31 Dec 2014 14:19:49 +0900
Message-ID: <1420003192-5576-6-git-send-email-cw00.choi@samsung.com>
References: <1420003192-5576-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:49839 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbaLaFT5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 31 Dec 2014 00:19:57 -0500
In-reply-to: <1420003192-5576-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: kgene.kim@samsung.com, kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, mark.rutland@arm.com, a.kesavan@samsung.com, tomasz.figa@gmail.com, k.kozlowski@samsung.com, b.zolnierkie@samsung.com, cw00.choi@samsung.com, inki.dae@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org

This patch adds the memory bus node for Exynos4x12 SoC. Exynos4x12 SoC has
two memory bus to translate data between DRAM and eMMC/sub-IPs.

Following list specifies the detailed relation between memory bus clock and DMC
IP in MIF (Memory Interface) block:
- DMC/ACP clock : DMC (Dynamic Memory Controller)

Following list specifies the detailed relation between memory bus clock and
sub-IPs in INT (Internal) block:
- ACLK100 clock : PERIL/PERIR/MFC(PCLK)
- ACLK160 clock : CAM/TV/LCD
- ACLK133 clock : FSYS
- GDL/GDR clock : leftbus/rightbus
- SCLK_MFC clock : MFC

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Myungjoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/exynos4x12.dtsi | 121 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 93b7040..44f6272 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -31,6 +31,127 @@
 		mshc0 = &mshc_0;
 	};
 
+	memory_bus_mif: memory_bus@0 {
+		compatible = "samsung,exynos-memory-bus";
+
+		operating-points = <
+			400000 1100000
+			200000 1000000
+			160000 950000
+			133000 950000
+			100000 950000>;
+		status = "disabled";
+
+		blocks {
+			dmc_block: memory_bus_block1 {
+				clocks = <&clock CLK_DIV_DMC>;
+				clock-names = "memory-bus";
+				frequency = <
+					400000
+					200000
+					160000
+					133000
+					100000>;
+			};
+
+			acp_block: memory_bus_block2 {
+				clocks = <&clock CLK_DIV_ACP>;
+				clock-names = "memory-bus";
+				frequency = <
+					200000
+					160000
+					133000
+					133000
+					100000>;
+			};
+
+			c2c_block: memory_bus_block3 {
+				clocks = <&clock CLK_DIV_C2C>;
+				clock-names = "memory-bus";
+				frequency = <
+					400000
+					200000
+					160000
+					133000
+					100000>;
+			};
+		};
+	};
+
+	memory_bus_int: memory_bus@1 {
+		compatible = "samsung,exynos-memory-bus";
+
+		operating-points = <
+			200000 1000000
+			160000 950000
+			133000 925000
+			100000 900000>;
+
+		status = "disabled";
+
+		blocks {
+			peri_block: memory_bus_block1 {
+				clocks = <&clock CLK_ACLK100>;
+				clock-names = "memory-bus";
+				frequency = <
+					100000
+					100000
+					100000
+					100000>;
+			};
+
+			fsys_block: memory_bus_block2 {
+				clocks = <&clock CLK_ACLK133>;
+				clock-names = "memory-bus";
+				frequency = <
+					133000
+					133000
+					100000
+					100000>;
+			};
+
+			display_block: memory_bus_block3 {
+				clocks = <&clock CLK_ACLK160>;
+				clock-names = "memory-bus";
+				frequency = <
+					160000
+					160000
+					133000
+					100000>;
+			};
+
+			leftbus_block: memory_bus_block4 {
+				clocks = <&clock CLK_DIV_GDL>;
+				clock-names = "memory-bus";
+				frequency = <
+					200000
+					160000
+					133000
+					100000>;
+			};
+
+			rightbus_block: memory_bus_block5 {
+				clocks = <&clock CLK_DIV_GDR>;
+				clock-names = "memory-bus";
+				frequency = <
+					200000
+					160000
+					133000
+					100000>;
+			};
+
+			mfc_block: memory_bus_block6 {
+				clocks = <&clock CLK_SCLK_MFC>;
+				clock-names = "memory-bus";
+				frequency = <
+					200000
+					160000
+					133000
+					100000>;
+			};
+		};
+	};
+
 	sysram@02020000 {
 		compatible = "mmio-sram";
 		reg = <0x02020000 0x40000>;
-- 
1.8.5.5

