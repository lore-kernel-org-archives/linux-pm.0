From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] thermal: Exynos: Add missing dependency
Date: Wed, 14 Nov 2012 12:18:24 +0530
Message-ID: <1352875704-2178-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55216 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675Ab2KNGyS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Nov 2012 01:54:18 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so95181pad.19
        for <linux-pm@vger.kernel.org>; Tue, 13 Nov 2012 22:54:18 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, durgadoss.r@intel.com, sachin.kamat@linaro.org, patches@linaro.org, akpm@linux-foundation.org, Amit Daniel Kachhap <amit.kachhap@linaro.org>

CPU_FREQ_TABLE depends on CPU_FREQ. Selecting CPU_FREQ_TABLE without checking
for dependencies gives the following compilation warnings:
warning: (ARCH_TEGRA_2x_SOC && ARCH_TEGRA_3x_SOC && UX500_SOC_DB8500 &&
CPU_THERMAL && EXYNOS_THERMAL) selects CPU_FREQ_TABLE which has unmet
direct dependencies (ARCH_HAS_CPUFREQ && CPU_FREQ)

Cc: Amit Daniel Kachhap <amit.kachhap@linaro.org>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
Build tested using exynos4_defconfig on linux-next tree of 20121114.
---
 drivers/thermal/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 266c15e..197b7db 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -50,7 +50,7 @@ config RCAR_THERMAL
 
 config EXYNOS_THERMAL
 	tristate "Temperature sensor on Samsung EXYNOS"
-	depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5) && THERMAL
+	depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5) && THERMAL && CPU_FREQ
 	select CPU_FREQ_TABLE
 	help
 	  If you say yes here you get support for TMU (Thermal Managment
-- 
1.7.4.1

