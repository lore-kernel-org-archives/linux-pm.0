From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 2/2] Thermal: Exynos : add missing dependency
Date: Thu, 15 Nov 2012 15:02:27 +0800
Message-ID: <1352962947.2080.10.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32869 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992548Ab2KOHCb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 15 Nov 2012 02:02:31 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Sachin Kamat <sachin.kamat@linaro.org>, Amit Kachhap <amit.kachhap@linaro.org>, "Zhang, Rui" <rui.zhang@intel.com>, patches@linaro.org

there is still something unclear to me.

Amit, the next step should be remove this "depends on CPU_THERMAL"
line for EXYNOS driver, right?
If we do this, the exynos driver should work w/ or w/o CPU_THERMAL,
but should we have something like,
"hey, I like CPU_THERMAL, I work better with it set"?

"Select" does not work here
because it may block exynos driver when CPU_FREQ cleared.

any ideas on this?

thanks,
rui

 CPU_FREQ_TABLE depends on CPU_FREQ. Selecting
 CPU_FREQ_TABLE without checking for dependencies gives
 the following compilation warnings: warning:
 (ARCH_TEGRA_2x_SOC && ARCH_TEGRA_3x_SOC &&
 UX500_SOC_DB8500 && CPU_THERMAL && EXYNOS_THERMAL)
 selects CPU_FREQ_TABLE which has unmet direct
 dependencies (ARCH_HAS_CPUFREQ && CPU_FREQ)

Patch-based-on: Sachin Kamat <sachin.kamat@linaro.org>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
1.7.9.5



