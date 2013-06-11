From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH V5 02/30] thermal: exynos: Add ARCH_HAS_TMU config to know the supported soc's
Date: Tue, 11 Jun 2013 18:23:12 +0530
Message-ID: <1370955220-2949-3-git-send-email-amit.daniel@samsung.com>
References: <1370955220-2949-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1370955220-2949-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.kachhap@gmail.com, Kukjin Kim <kgene.kim@samsung.com>, jonghwa3.lee@samsung.com
List-Id: linux-pm@vger.kernel.org

This patch adds config sybmol ARCH_HAS_TMU to enable the TMU driver.
This will allow adding support for new soc easily as now it is the
platform responsibility to enable this config symbol.

Acked-by: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/thermal/samsung/Kconfig |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kconfig
index 2d3d9dc..145a55d 100644
--- a/drivers/thermal/samsung/Kconfig
+++ b/drivers/thermal/samsung/Kconfig
@@ -1,6 +1,9 @@
+config ARCH_HAS_TMU
+	bool
+
 config EXYNOS_THERMAL
 	tristate "Temperature sensor on Samsung EXYNOS"
-	depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5)
+	depends on ARCH_HAS_TMU
 	depends on CPU_THERMAL
 	help
 	  If you say yes here you get support for TMU (Thermal Management
-- 
1.7.1
