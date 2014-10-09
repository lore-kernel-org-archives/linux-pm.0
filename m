From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 09/21] thermal: dts: Provide bindings and enable TMU at
 Exynos4x12 devices
Date: Thu, 09 Oct 2014 18:38:45 +0200
Message-ID: <1412872737-624-10-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Linux PM list <linux-pm@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

This commit adds necessary bindings for enabling TMU IP block on the
Exynos4412 Odroid U3 device.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |  5 +++++
 arch/arm/boot/dts/exynos4x12.dtsi               | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 5364f1a..5d4ecc3 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -374,6 +374,11 @@
 	ehci: ehci@12580000 {
 		status = "okay";
 	};
+
+	tmu@100C0000 {
+		vtmu-supply = <&ldo10_reg>;
+		status = "okay";
+	};
 };
 
 &pinctrl_1 {
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 861bb91..c12890c 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -271,4 +271,14 @@
 		compatible = "samsung,exynos4x12-usb2-phy";
 		samsung,sysreg-phandle = <&sys_reg>;
 	};
+
+	tmu@100C0000 {
+		compatible = "samsung,exynos4412-tmu";
+		interrupt-parent = <&combiner>;
+		reg = <0x100C0000 0x100>;
+		interrupts = <2 4>;
+		clocks = <&clock 383>;
+		clock-names = "tmu_apbif";
+		status = "disabled";
+	};
 };
-- 
2.0.0.rc2
