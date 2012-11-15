From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH-Resend] thermal: Exynos: Add missing dependency
Date: Thu, 15 Nov 2012 12:09:39 +0530
Message-ID: <1352961579-13807-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:52748 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554Ab2KOGph (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Nov 2012 01:45:37 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so536596dak.19
        for <linux-pm@vger.kernel.org>; Wed, 14 Nov 2012 22:45:36 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, sachin.kamat@linaro.org, patches@linaro.org, akpm@linux-foundation.org, Amit Daniel Kachhap <amit.kachhap@linaro.org>

CPU_FREQ_TABLE depends on CPU_FREQ. Selecting CPU_FREQ_TABLE without checking
for dependencies gives the following compilation warnings:
warning: (ARCH_TEGRA_2x_SOC && ARCH_TEGRA_3x_SOC && UX500_SOC_DB8500 &&
CPU_THERMAL && EXYNOS_THERMAL) selects CPU_FREQ_TABLE which has unmet
direct dependencies (ARCH_HAS_CPUFREQ && CPU_FREQ)

Cc: Amit Daniel Kachhap <amit.kachhap@linaro.org>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/thermal/Kconfig |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 266c15e..6124c4b 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -50,8 +50,7 @@ config RCAR_THERMAL
 
 config EXYNOS_THERMAL
 	tristate "Temperature sensor on Samsung EXYNOS"
-	depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5) && THERMAL
-	select CPU_FREQ_TABLE
+	depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5) && CPU_THERMAL
 	help
 	  If you say yes here you get support for TMU (Thermal Managment
 	  Unit) on SAMSUNG EXYNOS series of SoC.
-- 
1.7.4.1

