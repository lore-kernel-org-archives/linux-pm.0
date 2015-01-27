From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH v4 1/2] dts: Documentation: Add documentation for Exynos7 SoC
 thermal bindings
Date: Tue, 27 Jan 2015 11:18:21 +0530
Message-ID: <1422337703-11289-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, kgene.kim@samsung.com, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, l.majewski@samsung.com, amit.daniel@samsung.com, kesavan.abhilash@gmail.com, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add documentation for exynos7 thermal bindings including compatible
name and special clock properties.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 .../devicetree/bindings/thermal/exynos-thermal.txt |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
index 0f44932..695150a 100644
--- a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
@@ -12,6 +12,7 @@
 	       "samsung,exynos5420-tmu-ext-triminfo" for TMU channels 2, 3 and 4
 			Exynos5420 (Must pass triminfo base and triminfo clock)
 	       "samsung,exynos5440-tmu"
+	       "samsung,exynos7-tmu"
 - interrupt-parent : The phandle for the interrupt controller
 - reg : Address range of the thermal registers. For soc's which has multiple
 	instances of TMU and some registers are shared across all TMU's like
@@ -32,10 +33,13 @@
 - clocks : The main clocks for TMU device
 	-- 1. operational clock for TMU channel
 	-- 2. optional clock to access the shared registers of TMU channel
+	-- 3. optional special clock for functional operation
 - clock-names : Thermal system clock name
 	-- "tmu_apbif" operational clock for current TMU channel
 	-- "tmu_triminfo_apbif" clock to access the shared triminfo register
 		for current TMU channel
+	-- "tmu_sclk" clock for functional operation of the current TMU
+		channel
 - vtmu-supply: This entry is optional and provides the regulator node supplying
 		voltage to TMU. If needed this entry can be placed inside
 		board/platform specific dts file.
-- 
1.7.9.5
