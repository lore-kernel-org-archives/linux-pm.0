From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH V3 3/4] arm: exynos: Enable OPP library support for exynos5440
Date: Thu,  7 Mar 2013 09:43:46 +0530
Message-ID: <1362629627-10012-3-git-send-email-amit.daniel@samsung.com>
References: <1362629627-10012-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362629627-10012-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kukjin Kim <kgene.kim@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, cpufreq@vger.kernel.org, Inderpal Singh <inderpal.singh@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

The OPP library support is needed for exynos5440 cpu frequency
dynamic scaling driver.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm/mach-exynos/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 70f94c8..d5dde07 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -72,10 +72,12 @@ config SOC_EXYNOS5440
 	bool "SAMSUNG EXYNOS5440"
 	default y
 	depends on ARCH_EXYNOS5
+	select ARCH_HAS_OPP
 	select ARM_ARCH_TIMER
 	select AUTO_ZRELADDR
 	select PINCTRL
 	select PINCTRL_EXYNOS5440
+	select PM_OPP
 	help
 	  Enable EXYNOS5440 SoC support
 
-- 
1.7.1
