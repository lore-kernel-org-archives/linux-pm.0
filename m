From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH v3 3/7] ARM: dts: Add PPMU device tree support for Exynos5250
Date: Wed, 16 Jul 2014 00:04:26 +0530
Message-ID: <1405449266-26267-1-git-send-email-a.kesavan@samsung.com>
References: <1400779322-4410-4-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:43179 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932828AbaGOSe5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jul 2014 14:34:57 -0400
In-Reply-To: <1400779322-4410-4-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, linux-pm@vger.kernel.org, kgene.kim@samsung.com
Cc: rjw@sisk.pl, t.figa@samsung.com, kesavan.abhilash@gmail.com, devicetree@vger.kernel.org

PPMU is required by the exynos5250 devfreq driver. Add a device
tree node for it.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 .../bindings/arm/exynos/ppmu-exynos5.txt           |   26 ++++++++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi                  |    8 ++++++
 2 files changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt

diff --git a/Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt b/Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt
new file mode 100644
index 0000000..a6a2eba
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt
@@ -0,0 +1,26 @@
+Exynos PPMU driver
+-------------------
+
+Performance events are primitive values used to get performance data. These
+events provide information about the behavior of the SoC that can be used
+when analyzing system performance. These events are made visible using the
+PPMU logic.
+Exynos PPMU driver is used by the exynos5 devfreq drivers to control the
+bus frequency/voltage.
+
+Required properties:
+- compatible: "samsung,exynos5250-int-busfreq", "samsung,exynos5420-int-busfreq"
+- reg:
+	* physical base address of the PPMUs (e.g DDR, Right Bus, Left bus etc)
+	and length of memory mapped region.
+
+Example:
+--------
+
+	ppmu@0x10C40000 {
+		compatible = "samsung,exynos5250-int-busfreq";
+		reg = <0x10C40000 0x2000
+		       0x10C50000 0x2000
+		       0x10CB0000 0x2000
+		       0x13660000 0x2000>;
+	};
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 834fb5a..5284f00 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -778,4 +778,12 @@
 		clocks = <&clock CLK_SSS>;
 		clock-names = "secss";
 	};
+
+	ppmu@10C40000 {
+		compatible = "samsung,exynos5250-int-busfreq";
+		reg = <0x10C40000 0x2000	/* PPMU_DDR_C */
+		       0x10C50000 0x2000	/* PPMU_DDR_L */
+		       0x10CB0000 0x2000	/* PPMU_DDR_R */
+		       0x13660000 0x2000>;	/* PPMU_RIGHT */
+	};
 };
-- 
1.7.9.5

