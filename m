From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH V5 29/30] ARM: dts: Add device tree node for exynos5440 TMU controller
Date: Tue, 11 Jun 2013 18:23:39 +0530
Message-ID: <1370955220-2949-30-git-send-email-amit.daniel@samsung.com>
References: <1370955220-2949-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1370955220-2949-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.kachhap@gmail.com, Kukjin Kim <kgene.kim@samsung.com>, jonghwa3.lee@samsung.com
List-Id: linux-pm@vger.kernel.org

This patch adds device node for TMU controller. There are 3
instances of the controllers so 3 nodes are created.

Acked-by: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm/boot/dts/exynos5440.dtsi |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index f6b1c89..716e90c 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -16,6 +16,12 @@
 
 	interrupt-parent = <&gic>;
 
+	aliases {
+		tmuctrl0 = &tmuctrl_0;
+		tmuctrl1 = &tmuctrl_1;
+		tmuctrl2 = &tmuctrl_2;
+	};
+
 	clock: clock-controller@0x160000 {
 		compatible = "samsung,exynos5440-clock";
 		reg = <0x160000 0x1000>;
@@ -216,4 +222,28 @@
 		clock-names = "rtc";
 		status = "disabled";
 	};
+
+	tmuctrl_0: tmuctrl@160118 {
+		compatible = "samsung,exynos5440-tmu";
+		reg = <0x160118 0x230>, <0x160368 0x10>;
+		interrupts = <0 58 0>;
+		clocks = <&clock 21>;
+		clock-names = "tmu_apbif";
+	};
+
+	tmuctrl_1: tmuctrl@16011C {
+		compatible = "samsung,exynos5440-tmu";
+		reg = <0x16011C 0x230>, <0x160368 0x10>;
+		interrupts = <0 58 0>;
+		clocks = <&clock 21>;
+		clock-names = "tmu_apbif";
+	};
+
+	tmuctrl_2: tmuctrl@160120 {
+		compatible = "samsung,exynos5440-tmu";
+		reg = <0x160120 0x230>, <0x160368 0x10>;
+		interrupts = <0 58 0>;
+		clocks = <&clock 21>;
+		clock-names = "tmu_apbif";
+	};
 };
-- 
1.7.1
