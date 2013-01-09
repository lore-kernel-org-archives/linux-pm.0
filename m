From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH 1/4] ARM: EXYNOS5: Add PPMU device tree support
Date: Wed, 09 Jan 2013 17:36:36 +0530
Message-ID: <1357733199-17206-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:25325 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757390Ab3AIL7n (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jan 2013 06:59:43 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com
Cc: kyungmin.park@samsung.com, rjw@sisk.pl, jhbird.choi@samsung.com, Abhilash Kesavan <a.kesavan@samsung.com>

PPMU is required by the devfreq driver. Add a device tree
node for it.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Cc: Jonghwan Choi <jhbird.choi@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
---
 .../bindings/arm/exynos/ppmu-exynos5.txt           |   28 ++++++++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi                  |    9 ++++++
 2 files changed, 37 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt

diff --git a/Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt b/Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt
new file mode 100644
index 0000000..a424dfa
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt
@@ -0,0 +1,28 @@
+Exynos5 PPMU driver
+-------------------
+
+Performance events are primitive values used to get performance data. These
+events provide information about the behavior of the SoC that can be used
+when analyzing system performance. These events are made visible using the
+PPMU logic.
+Exynos5 PPMU driver is used by the exynos5 devfreq driver to control the bus
+frequency/voltage.
+
+Required properties:
+- compatible: should be one of the following.
+	* samsung,exynos5-ppmu - for exynos5250 type ppmu.
+- reg:
+	* physical base address of the PPMUs (DDR, Right Bus and CPU) and
+	length of memory mapped region.
+
+Example:
+--------
+
+	ppmu {
+		compatible = "samsung,exynos5250-ppmu";
+		reg = <0x10C40000 0x2000
+		       0x10C50000 0x2000
+		       0x10C60000 0x2000
+		       0x10CB0000 0x2000
+		       0x13660000 0x2000>;
+	};
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 30485de..d504cba 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -732,4 +732,13 @@
 		interrupt-parent = <&combiner>;
 		interrupts = <24 1>;
 	};
+
+	ppmu {
+		compatible = "samsung,exynos5250-ppmu";
+		reg = <0x10C40000 0x2000	/* PPMU_DDR_C */
+		       0x10C50000 0x2000	/* PPMU_DDR_R1 */
+		       0x10CB0000 0x2000	/* PPMU_DDR_L */
+		       0x13660000 0x2000	/* PPMU_DDR_RIGHT */
+		       0x10C60000 0x2000>;	/* PPMU_DDR_CPU */
+	};
 };
-- 
1.7.8.6

