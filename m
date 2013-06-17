From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH V6 02/30] thermal: exynos: Use ARCH_HAS_BANDGAP config to know the supported soc's
Date: Mon, 17 Jun 2013 12:16:11 +0530
Message-ID: <1371451599-31035-3-git-send-email-amit.daniel@samsung.com>
References: <1371451599-31035-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371451599-31035-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.kachhap@gmail.com, Kukjin Kim <kgene.kim@samsung.com>, jonghwa3.lee@samsung.com
List-Id: linux-pm@vger.kernel.org

This patch uses the recently added config sybmol ARCH_HAS_BANDGAP to enable
the TMU driver. This will allow adding support for new soc easily as now it
is the platform responsibility to enable this config symbol for a particular
soc.

Acked-by: Kukjin Kim <kgene.kim@samsung.com>
Acked-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/thermal/samsung/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kconfig
index 2d3d9dc..883a8a8 100644
--- a/drivers/thermal/samsung/Kconfig
+++ b/drivers/thermal/samsung/Kconfig
@@ -1,6 +1,6 @@
 config EXYNOS_THERMAL
 	tristate "Temperature sensor on Samsung EXYNOS"
-	depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5)
+	depends on ARCH_HAS_BANDGAP
 	depends on CPU_THERMAL
 	help
 	  If you say yes here you get support for TMU (Thermal Management
-- 
1.7.1
