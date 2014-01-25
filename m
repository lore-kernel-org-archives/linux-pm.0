From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/2] thermal,rcar_thermal: Add dependency on HAS_IOMEM
Date: Sat, 25 Jan 2014 23:29:14 +0100
Message-ID: <1390688954-4940-1-git-send-email-richard@nod.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com
Cc: eduardo.valentin@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, horms@verge.net.au, laurent.pinchart+renesas@ideasonboard.com, Richard Weinberger <richard@nod.at>
List-Id: linux-pm@vger.kernel.org

Commit beeb5a1e (thermal: rcar-thermal: Enable driver compilation with COMPILE_TEST)
broke build on archs wihout io memory.

On archs like S390 or um this driver cannot build nor work.
Make it depend on HAS_IOMEM to bypass build failures.

drivers/thermal/rcar_thermal.c:404: undefined reference to `devm_ioremap_resource'
drivers/thermal/rcar_thermal.c:426: undefined reference to `devm_ioremap_resource'

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/thermal/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 35c0664..88efa8f 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -136,6 +136,7 @@ config SPEAR_THERMAL
 config RCAR_THERMAL
 	tristate "Renesas R-Car thermal driver"
 	depends on ARCH_SHMOBILE || COMPILE_TEST
+	depends on HAS_IO_MEM
 	help
 	  Enable this to plug the R-Car thermal sensor driver into the Linux
 	  thermal framework.
-- 
1.8.1.4
