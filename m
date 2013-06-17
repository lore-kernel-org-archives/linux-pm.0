From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH V6 30/30] arm: exynos: enable ARCH_HAS_BANDGAP
Date: Mon, 17 Jun 2013 12:16:39 +0530
Message-ID: <1371451599-31035-31-git-send-email-amit.daniel@samsung.com>
References: <1371451599-31035-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1371451599-31035-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.kachhap@gmail.com, Kukjin Kim <kgene.kim@samsung.com>, jonghwa3.lee@samsung.com
List-Id: linux-pm@vger.kernel.org

This patch enables ARCH_HAS_BANDGAP config for exynos4210, 4212, 4412, 5250
and 5440 SOC. This config symbol is recently added to allow the platforms
to enable bandgap based temperature sensor.

Acked-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm/mach-exynos/Kconfig |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index d19edff..d3cb5c7 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -33,6 +33,7 @@ config CPU_EXYNOS4210
 	bool "SAMSUNG EXYNOS4210"
 	default y
 	depends on ARCH_EXYNOS4
+	select ARCH_HAS_BANDGAP
 	select ARM_CPU_SUSPEND if PM
 	select PM_GENERIC_DOMAINS
 	select S5P_PM if PM
@@ -45,6 +46,7 @@ config SOC_EXYNOS4212
 	bool "SAMSUNG EXYNOS4212"
 	default y
 	depends on ARCH_EXYNOS4
+	select ARCH_HAS_BANDGAP
 	select S5P_PM if PM
 	select S5P_SLEEP if PM
 	select SAMSUNG_DMADEV
@@ -55,6 +57,7 @@ config SOC_EXYNOS4412
 	bool "SAMSUNG EXYNOS4412"
 	default y
 	depends on ARCH_EXYNOS4
+	select ARCH_HAS_BANDGAP
 	select SAMSUNG_DMADEV
 	help
 	  Enable EXYNOS4412 SoC support
@@ -63,6 +66,7 @@ config SOC_EXYNOS5250
 	bool "SAMSUNG EXYNOS5250"
 	default y
 	depends on ARCH_EXYNOS5
+	select ARCH_HAS_BANDGAP
 	select PM_GENERIC_DOMAINS if PM
 	select S5P_PM if PM
 	select S5P_SLEEP if PM
@@ -76,6 +80,7 @@ config SOC_EXYNOS5440
 	default y
 	depends on ARCH_EXYNOS5
 	select ARCH_HAS_OPP
+	select ARCH_HAS_BANDGAP
 	select ARM_ARCH_TIMER
 	select AUTO_ZRELADDR
 	select PINCTRL
-- 
1.7.1
