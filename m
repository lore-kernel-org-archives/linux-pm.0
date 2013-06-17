From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH V6 03/30] thermal: exynos: Remove un-necessary CPU_THERMAL dependency
Date: Mon, 17 Jun 2013 12:16:12 +0530
Message-ID: <1371451599-31035-4-git-send-email-amit.daniel@samsung.com>
References: <1371451599-31035-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371451599-31035-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.kachhap@gmail.com, Kukjin Kim <kgene.kim@samsung.com>, jonghwa3.lee@samsung.com
List-Id: linux-pm@vger.kernel.org

This patch removes the dependency on CPU_THERMAL for compiling TMU driver.
This is useful for cases when only TMU controller needs to be initialised
without cpu cooling action.

Acked-by: Kukjin Kim <kgene.kim@samsung.com>
Acked-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/thermal/samsung/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kconfig
index 883a8a8..2cf31ad 100644
--- a/drivers/thermal/samsung/Kconfig
+++ b/drivers/thermal/samsung/Kconfig
@@ -1,7 +1,6 @@
 config EXYNOS_THERMAL
 	tristate "Temperature sensor on Samsung EXYNOS"
 	depends on ARCH_HAS_BANDGAP
-	depends on CPU_THERMAL
 	help
 	  If you say yes here you get support for TMU (Thermal Management
 	  Unit) on SAMSUNG EXYNOS series of SoC. This helps in registering
-- 
1.7.1
