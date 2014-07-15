From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH v3 4/7] ARM: dts: Add PPMU device tree support for Exynos5420
Date: Wed, 16 Jul 2014 00:04:57 +0530
Message-ID: <1405449297-26307-1-git-send-email-a.kesavan@samsung.com>
References: <1400779322-4410-5-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:48435 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932523AbaGOSfc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jul 2014 14:35:32 -0400
In-Reply-To: <1400779322-4410-5-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, linux-pm@vger.kernel.org, kgene.kim@samsung.com
Cc: rjw@sisk.pl, t.figa@samsung.com, kesavan.abhilash@gmail.com, devicetree@vger.kernel.org

PPMU is required by the exynos5420 devfreq driver. Add a device
tree node for it.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 1595722..6d6c00f 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -882,4 +882,11 @@
 		samsung,sysreg-phandle = <&sysreg_system_controller>;
 		samsung,pmureg-phandle = <&pmu_system_controller>;
 	};
+
+	ppmu@0x10D00000 {
+		compatible = "samsung,exynos5420-int-busfreq";
+		reg = <0x10D00000 0x2000	/* PPMU_DMC_0_0 */
+		       0x10D10000 0x2000	/* PPMU_DMC_0_1 */
+		       0x10D60000 0x2000>;	/* PPMU_DMC_1_0 */
+	};
 };
-- 
1.7.9.5

