From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH v4 1/4] ARM: EXYNOS5: Add PPMU device tree support
Date: Fri, 18 Jan 2013 18:53:14 +0530
Message-ID: <1358515394-7423-1-git-send-email-a.kesavan@samsung.com>
References: <1357733199-17206-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-da0-f41.google.com ([209.85.210.41]:48651 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618Ab3ARNX1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jan 2013 08:23:27 -0500
In-Reply-To: <1357733199-17206-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com
Cc: kyungmin.park@samsung.com, rjw@sisk.pl, jhbird.choi@samsung.com

PPMU is required by the devfreq driver. Add a device tree
node for it.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Jonghwan Choi <jhbird.choi@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
---
Changes since v3:
* Modified the dt bindings as per updated devfreq driver
Changes before v3:
* No change

Tested after merging for-rafael branch of
git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
with for-next branch of
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git

 .../bindings/arm/exynos/ppmu-exynos5.txt           |   24 ++++++++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi                  |    5 ++++
 2 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt

diff --git a/Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt b/Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt
new file mode 100644
index 0000000..06d40d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt
@@ -0,0 +1,24 @@
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
+	* physical base address of the Right PPMU and length of memory mapped
+	region
+
+Example:
+--------
+
+	ppmu {
+		compatible = "samsung,exynos5250-ppmu";
+		reg = <0x13660000 0x2000>;
+	};
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 30485de..96ef6ed 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -732,4 +732,9 @@
 		interrupt-parent = <&combiner>;
 		interrupts = <24 1>;
 	};
+
+	ppmu {
+		compatible = "samsung,exynos5250-ppmu";
+		reg = <0x13660000 0x2000>;	/* PPMU_DDR_RIGHT */
+	};
 };
-- 
1.7.8.6

