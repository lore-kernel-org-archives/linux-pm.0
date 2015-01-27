From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH] thermal: Kconfig: Remove config for not used
 EXYNOS_THERMAL_CORE
Date: Tue, 27 Jan 2015 12:13:59 +0100
Message-ID: <1422357239-20316-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Paul Bolle <pebolle@tiscali.nl>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kukjin Kim <kgene@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

After removing exynos_thermal_common.[c|h] files the CONFIG_EXYNOS_THERMA_CORE
is not needed anymore.
This patch removes this entry from Kconfig.

Reported-by: Paul Bolle <pebolle@tiscali.nl>
Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 drivers/thermal/samsung/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kconfig
index c43306e..c8e35c1 100644
--- a/drivers/thermal/samsung/Kconfig
+++ b/drivers/thermal/samsung/Kconfig
@@ -7,12 +7,3 @@ config EXYNOS_THERMAL
 	  the TMU, reports temperature and handles cooling action if defined.
 	  This driver uses the Exynos core thermal APIs and TMU configuration
 	  data from the supported SoCs.
-
-config EXYNOS_THERMAL_CORE
-	bool "Core thermal framework support for EXYNOS SOCs"
-	depends on EXYNOS_THERMAL
-	help
-	  If you say yes here you get support for EXYNOS TMU
-	  (Thermal Management Unit) common registration/unregistration
-	  functions to the core thermal layer and also to use the generic
-	  CPU cooling APIs.
-- 
2.0.0.rc2
