From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] thermal: offer Samsung thermal support only when ARCH_EXYNOS
 is defined
Date: Fri, 04 Oct 2013 14:36:42 +0200
Message-ID: <2958660.aJeCDrTTOe@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

Menu for Samsung thermal support is visible on all Samsung
platforms while thermal drivers are currently available only
for EXYNOS SoCs. Fix it by replacing PLAT_SAMSUNG dependency
with ARCH_EXYNOS one.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index a709c63..05cf95c 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -198,7 +198,7 @@ source "drivers/thermal/ti-soc-thermal/Kconfig"
 endmenu
 
 menu "Samsung thermal drivers"
-depends on PLAT_SAMSUNG
+depends on ARCH_EXYNOS
 source "drivers/thermal/samsung/Kconfig"
 endmenu
 
-- 
1.8.2.3
