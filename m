From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH RFC v2 4/7] ARM: dts: Add PPMU device tree support for Exynos5420
Date: Thu, 22 May 2014 22:51:59 +0530
Message-ID: <1400779322-4410-5-git-send-email-a.kesavan@samsung.com>
References: <1400779322-4410-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:60364 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbaEVRWf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 May 2014 13:22:35 -0400
In-Reply-To: <1400779322-4410-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com, t.figa@samsung.com, myungjoo.ham@samsung.com, rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: kesavan.abhilash@gmail.com

PPMU is required by the exynos5420 devfreq driver. Add a device
tree node for it.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 8e7e35c..6ab7b03 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -833,4 +833,11 @@
 		samsung,pmu-syscon = <&pmu_system_controller>;
 		#phy-cells = <1>;
 	};
+
+	ppmu {
+		compatible = "samsung,exynos5420-int-busfreq";
+		reg = <0x10D00000 0x2000	/* PPMU_DMC_0_0 */
+		       0x10D10000 0x2000	/* PPMU_DMC_0_1 */
+		       0x10D60000 0x2000>;	/* PPMU_DMC_1_0 */
+	};
 };
-- 
1.7.9.5

