From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Subject: [PATCH v12 4/4] ARM: dts: Exynos5420: Add device nodes for TMU blocks
Date: Thu, 19 Dec 2013 11:37:02 +0530
Message-ID: <1387433222-7893-1-git-send-email-ch.naveen@samsung.com>
References: <1382004240-3282-1-git-send-email-l.krishna@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:9383 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655Ab3LSGGR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2013 01:06:17 -0500
In-reply-to: <1382004240-3282-1-git-send-email-l.krishna@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: naveenkrishna.ch@gmail.com, rui.zhang@intel.com, eduardo.valentin@ti.com, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.daniel@samsung.com, kgene.kim@samsung.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, cpgs@samsung.com, t.figa@samsung.com

Exynos5420 SoC has per core thermal management unit.
5 TMU channels 4 for CPUs and 5th for GPU.

This patch adds the device tree nodes to the DT device list.

Nodes carry the misplaced second base address and the second
clock to access the misplaced base address.

Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
Changes since v11:
  changed the secondary clock name to "tmu_triminfo_apbif"
from "tmu_apbif_triminfo"

Changes since previous version:
1. used lables instead of comment lines
2. pass the same clock as trimfo_apbif clock for TMU channel 2

 arch/arm/boot/dts/exynos5420.dtsi |   40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index b1fa334..c62cde6 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -402,4 +402,44 @@
 		clock-names = "gscl";
 		samsung,power-domain = <&gsc_pd>;
 	};
+
+	tmu_cpu0:tmu@10060000 {
+		compatible = "samsung,exynos5420-tmu";
+		reg = <0x10060000 0x100>;
+		interrupts = <0 65 0>;
+		clocks = <&clock 318>;
+		clock-names = "tmu_apbif";
+	};
+
+	tmu_cpu1:tmu@10064000 {
+		compatible = "samsung,exynos5420-tmu";
+		reg = <0x10064000 0x100>;
+		interrupts = <0 183 0>;
+		clocks = <&clock 318>;
+		clock-names = "tmu_apbif";
+	};
+
+	tmu_cpu2:tmu@10068000 {
+		compatible = "samsung,exynos5420-tmu-ext-triminfo";
+		reg = <0x10068000 0x100>, <0x1006c000 0x4>;
+		interrupts = <0 184 0>;
+		clocks = <&clock 318>, <&clock 318>;
+		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
+	};
+
+	tmu_cpu3:tmu@1006c000 {
+		compatible = "samsung,exynos5420-tmu-ext-triminfo";
+		reg = <0x1006c000 0x100>, <0x100a0000 0x4>;
+		interrupts = <0 185 0>;
+		clocks = <&clock 318>, <&clock 319>;
+		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
+	};
+
+	tmu_gpu:tmu@100a0000 {
+		compatible = "samsung,exynos5420-tmu-ext-triminfo";
+		reg = <0x100a0000 0x100>, <0x10068000 0x4>;
+		interrupts = <0 215 0>;
+		clocks = <&clock 319>, <&clock 318>;
+		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
+	};
 };
-- 
1.7.10.4

