From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/3] thermal: exynos: Fix typos in Kconfig
Date: Mon, 19 Aug 2013 11:58:41 +0530
Message-ID: <1376893723-22138-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:56774 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967Ab3HSGp5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2013 02:45:57 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so4697568pdj.22
        for <linux-pm@vger.kernel.org>; Sun, 18 Aug 2013 23:45:56 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: jonghwa3.lee@samsung.com, eduardo.valentin@ti.com, rui.zhang@intel.com, amit.daniel@samsung.com, sachin.kamat@linaro.org, patches@linaro.org

Fixes some trivial typos.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
This series is based on next branch of below tree:
git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git

This is tested on Exynos4210 and 5250 based boards.
---
 drivers/thermal/samsung/Kconfig |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kconfig
index b653f15..92492e4 100644
--- a/drivers/thermal/samsung/Kconfig
+++ b/drivers/thermal/samsung/Kconfig
@@ -3,16 +3,16 @@ config EXYNOS_THERMAL
 	depends on ARCH_HAS_BANDGAP
 	help
 	  If you say yes here you get support for the TMU (Thermal Management
-	  Unit) driver for SAMSUNG EXYNOS series of soc. This driver initialises
+	  Unit) driver for SAMSUNG EXYNOS series of SoCs. This driver initialises
 	  the TMU, reports temperature and handles cooling action if defined.
-	  This driver uses the exynos core thermal API's and TMU configuration
-	  data from the supported soc's.
+	  This driver uses the Exynos core thermal APIs and TMU configuration
+	  data from the supported SoCs.
 
 config EXYNOS_THERMAL_CORE
-	bool "Core thermal framework support for EXYNOS SOC's"
+	bool "Core thermal framework support for EXYNOS SOCs"
 	depends on EXYNOS_THERMAL
 	help
 	  If you say yes here you get support for EXYNOS TMU
 	  (Thermal Management Unit) common registration/unregistration
 	  functions to the core thermal layer and also to use the generic
-	  cpu cooling API's.
+	  CPU cooling APIs.
-- 
1.7.9.5

