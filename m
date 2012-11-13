From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH v3 4/4] ARM: dts: exynos4: Set up power domains
Date: Tue, 13 Nov 2012 14:08:27 +0100
Message-ID: <1352812107-8777-5-git-send-email-t.figa@samsung.com>
References: <1352812107-8777-1-git-send-email-t.figa@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:30137 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753778Ab2KMNJp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Nov 2012 08:09:45 -0500
In-reply-to: <1352812107-8777-1-git-send-email-t.figa@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com, kgene.kim@samsung.com, thomas.abraham@linaro.org, rjw@sisk.pl, m.szyprowski@samsung.com, t.figa@samsung.com, tomasz.figa@gmail.com

This patch adds device tree nodes for power domains available
on Exynos 4 SoCs.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi    | 30 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi |  5 +++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index a26c3dd..0c14f50 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -30,6 +30,36 @@
 		spi2 = &spi_2;
 	};
 
+	pd_mfc: mfc-power-domain@10023C40 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x10023C40 0x20>;
+	};
+
+	pd_g3d: g3d-power-domain@10023C60 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x10023C60 0x20>;
+	};
+
+	pd_lcd0: lcd0-power-domain@10023C80 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x10023C80 0x20>;
+	};
+
+	pd_tv: tv-power-domain@10023C20 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x10023C20 0x20>;
+	};
+
+	pd_cam: cam-power-domain@10023C00 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x10023C00 0x20>;
+	};
+
+	pd_gps: gps-power-domain@10023CE0 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x10023CE0 0x20>;
+	};
+
 	gic:interrupt-controller@10490000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 939f639..e31bfc4 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -31,6 +31,11 @@
 		pinctrl2 = &pinctrl_2;
 	};
 
+	pd_lcd1: lcd1-power-domain@10023CA0 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x10023CA0 0x20>;
+	};
+
 	gic:interrupt-controller@10490000 {
 		cpu-offset = <0x8000>;
 	};
-- 
1.8.0

