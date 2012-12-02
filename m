From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 27/34] Exynos: Add missing dependency
Date: Sun,  2 Dec 2012 22:45:01 +0800
Message-ID: <1354459508-3707-27-git-send-email-rui.zhang@intel.com>
References: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:29043 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630Ab2LBOpu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:45:50 -0500
In-Reply-To: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>

CPU_FREQ_TABLE depends on CPU_FREQ. Selecting CPU_FREQ_TABLE without checking
for dependencies gives the following compilation warnings:
warning: (ARCH_TEGRA_2x_SOC && ARCH_TEGRA_3x_SOC && UX500_SOC_DB8500 &&
CPU_THERMAL && EXYNOS_THERMAL) selects CPU_FREQ_TABLE which has unmet
direct dependencies (ARCH_HAS_CPUFREQ && CPU_FREQ)

Based-on-patch-by: Sachin Kamat <sachin.kamat@linaro.org>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 937a23d..99b6587 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -96,7 +96,7 @@ config RCAR_THERMAL
 config EXYNOS_THERMAL
 	tristate "Temperature sensor on Samsung EXYNOS"
 	depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5)
-	select CPU_FREQ_TABLE
+	depends on CPU_THERMAL
 	help
 	  If you say yes here you get support for TMU (Thermal Managment
 	  Unit) on SAMSUNG EXYNOS series of SoC.
-- 
1.7.7.6

