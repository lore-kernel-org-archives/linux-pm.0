From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v6 01/11] soc: renesas: Move pm-rcar to drivers/soc/renesas/rcar-sysc
Date: Wed, 20 Apr 2016 14:02:36 +0200
Message-ID: <1461153766-750-2-git-send-email-geert+renesas@glider.be>
References: <1461153766-750-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1461153766-750-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Move the pm-rcar driver from arch/arm/mach-shmobile/ to
drivers/soc/renesas/, and its header file to include/linux/soc/renesas/,
so it can be shared between arm32 (R-Car H1 and Gen2) and arm64 (R-Car
Gen3). Rename it to rcar-sysc as it's really a driver for the R-Car
System Controller (SYSC).

Kill the intermediate PM_RCAR config symbol, as it's not user
configurable anymore, and to prepare for SoC-specific make rules.

Add the missing #include <linux/types.h> to rcar-sysc.h, which was
exposed by different include order.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v6:
  - No changes,

v5:
  - No changes,

v4:
  - Update MAINTAINERS,

v3:
  - Add Reviewed-by,
  - Rename driver from pm-rcar to rcar-sysc,
  - Kill CONFIG_PM_RCAR,
  - Add missing include,

v2:
  - New.
---
 MAINTAINERS                                                   |  4 ++++
 arch/arm/mach-shmobile/Kconfig                                | 11 ++++-------
 arch/arm/mach-shmobile/Makefile                               |  1 -
 arch/arm/mach-shmobile/pm-r8a7779.c                           |  3 ++-
 arch/arm/mach-shmobile/pm-rcar-gen2.c                         |  2 +-
 arch/arm/mach-shmobile/smp-r8a7779.c                          |  2 +-
 arch/arm/mach-shmobile/smp-r8a7790.c                          |  2 +-
 drivers/soc/Makefile                                          |  3 ++-
 drivers/soc/renesas/Makefile                                  |  5 +++++
 .../pm-rcar.c => drivers/soc/renesas/rcar-sysc.c              |  2 +-
 .../pm-rcar.h => include/linux/soc/renesas/rcar-sysc.h        |  8 +++++---
 11 files changed, 26 insertions(+), 17 deletions(-)
 create mode 100644 drivers/soc/renesas/Makefile
 rename arch/arm/mach-shmobile/pm-rcar.c => drivers/soc/renesas/rcar-sysc.c (99%)
 rename arch/arm/mach-shmobile/pm-rcar.h => include/linux/soc/renesas/rcar-sysc.h (66%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d5b4becab6f9a1d..a0c482ff6a9727b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1491,6 +1491,8 @@ Q:	http://patchwork.kernel.org/project/linux-renesas-soc/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
 S:	Supported
 F:	arch/arm64/boot/dts/renesas/
+F:	drivers/soc/renesas/
+F:	include/linux/soc/renesas/
 
 ARM/RISCPC ARCHITECTURE
 M:	Russell King <linux@arm.linux.org.uk>
@@ -1604,6 +1606,8 @@ F:	arch/arm/configs/shmobile_defconfig
 F:	arch/arm/include/debug/renesas-scif.S
 F:	arch/arm/mach-shmobile/
 F:	drivers/sh/
+F:	drivers/soc/renesas/
+F:	include/linux/soc/renesas/
 
 ARM/SOCFPGA ARCHITECTURE
 M:	Dinh Nguyen <dinguyen@opensource.altera.com>
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index f2bc5c353119e96d..fe4ccb52f9213d8b 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -4,11 +4,6 @@ config ARCH_SHMOBILE
 config ARCH_SHMOBILE_MULTI
 	bool
 
-config PM_RCAR
-	bool
-	select PM
-	select PM_GENERIC_DOMAINS
-
 config PM_RMOBILE
 	bool
 	select PM
@@ -16,13 +11,15 @@ config PM_RMOBILE
 
 config ARCH_RCAR_GEN1
 	bool
-	select PM_RCAR
+	select PM
+	select PM_GENERIC_DOMAINS
 	select RENESAS_INTC_IRQPIN
 	select SYS_SUPPORTS_SH_TMU
 
 config ARCH_RCAR_GEN2
 	bool
-	select PM_RCAR
+	select PM
+	select PM_GENERIC_DOMAINS
 	select RENESAS_IRQC
 	select SYS_SUPPORTS_SH_CMT
 	select PCI_DOMAINS if PCI
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index a65c80ac9009d51f..ebb909c55b856a58 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -39,7 +39,6 @@ smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o platsmp-scu.o
 # PM objects
 obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
-obj-$(CONFIG_PM_RCAR)		+= pm-rcar.o
 obj-$(CONFIG_PM_RMOBILE)	+= pm-rmobile.o
 obj-$(CONFIG_ARCH_RCAR_GEN2)	+= pm-rcar-gen2.o
 
diff --git a/arch/arm/mach-shmobile/pm-r8a7779.c b/arch/arm/mach-shmobile/pm-r8a7779.c
index 14c42a1bdf1ef20d..4174cbcbc467d047 100644
--- a/arch/arm/mach-shmobile/pm-r8a7779.c
+++ b/arch/arm/mach-shmobile/pm-r8a7779.c
@@ -9,9 +9,10 @@
  * for more details.
  */
 
+#include <linux/soc/renesas/rcar-sysc.h>
+
 #include <asm/io.h>
 
-#include "pm-rcar.h"
 #include "r8a7779.h"
 
 /* SYSC */
diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
index 6815781ad1165ef3..691ac166a277c03f 100644
--- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
@@ -13,9 +13,9 @@
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/smp.h>
+#include <linux/soc/renesas/rcar-sysc.h>
 #include <asm/io.h>
 #include "common.h"
-#include "pm-rcar.h"
 #include "rcar-gen2.h"
 
 /* RST */
diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index f5c31fbc10b2efbf..c6951ee245889b8f 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -19,13 +19,13 @@
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/soc/renesas/rcar-sysc.h>
 
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 
 #include "common.h"
-#include "pm-rcar.h"
 #include "r8a7779.h"
 
 #define AVECR IOMEM(0xfe700040)
diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c b/arch/arm/mach-shmobile/smp-r8a7790.c
index f6426c6fdefcb489..28f26d5362d8d4d2 100644
--- a/arch/arm/mach-shmobile/smp-r8a7790.c
+++ b/arch/arm/mach-shmobile/smp-r8a7790.c
@@ -17,12 +17,12 @@
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/io.h>
+#include <linux/soc/renesas/rcar-sysc.h>
 
 #include <asm/smp_plat.h>
 
 #include "common.h"
 #include "platsmp-apmu.h"
-#include "pm-rcar.h"
 #include "rcar-gen2.h"
 #include "r8a7790.h"
 
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 5ade71306ee10d08..380230f03874d4ad 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -9,7 +9,8 @@ obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-y				+= fsl/
 obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
 obj-$(CONFIG_ARCH_QCOM)		+= qcom/
-obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
+obj-$(CONFIG_ARCH_RENESAS)	+= renesas/
+obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
 obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
 obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
new file mode 100644
index 0000000000000000..2b64f6c9468136f9
--- /dev/null
+++ b/drivers/soc/renesas/Makefile
@@ -0,0 +1,5 @@
+obj-$(CONFIG_ARCH_R8A7779)	+= rcar-sysc.o
+obj-$(CONFIG_ARCH_R8A7790)	+= rcar-sysc.o
+obj-$(CONFIG_ARCH_R8A7791)	+= rcar-sysc.o
+obj-$(CONFIG_ARCH_R8A7793)	+= rcar-sysc.o
+obj-$(CONFIG_ARCH_R8A7794)	+= rcar-sysc.o
diff --git a/arch/arm/mach-shmobile/pm-rcar.c b/drivers/soc/renesas/rcar-sysc.c
similarity index 99%
rename from arch/arm/mach-shmobile/pm-rcar.c
rename to drivers/soc/renesas/rcar-sysc.c
index 0af05d288b09c3ab..d59bcdf78f0b56ba 100644
--- a/arch/arm/mach-shmobile/pm-rcar.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -13,7 +13,7 @@
 #include <linux/mm.h>
 #include <linux/spinlock.h>
 #include <linux/io.h>
-#include "pm-rcar.h"
+#include <linux/soc/renesas/rcar-sysc.h>
 
 /* SYSC Common */
 #define SYSCSR			0x00	/* SYSC Status Register */
diff --git a/arch/arm/mach-shmobile/pm-rcar.h b/include/linux/soc/renesas/rcar-sysc.h
similarity index 66%
rename from arch/arm/mach-shmobile/pm-rcar.h
rename to include/linux/soc/renesas/rcar-sysc.h
index 1b901db4a24c4633..96f30c2883881d97 100644
--- a/arch/arm/mach-shmobile/pm-rcar.h
+++ b/include/linux/soc/renesas/rcar-sysc.h
@@ -1,5 +1,7 @@
-#ifndef PM_RCAR_H
-#define PM_RCAR_H
+#ifndef __LINUX_SOC_RENESAS_RCAR_SYSC_H__
+#define __LINUX_SOC_RENESAS_RCAR_SYSC_H__
+
+#include <linux/types.h>
 
 struct rcar_sysc_ch {
 	u16 chan_offs;
@@ -12,4 +14,4 @@ int rcar_sysc_power_up(const struct rcar_sysc_ch *sysc_ch);
 bool rcar_sysc_power_is_off(const struct rcar_sysc_ch *sysc_ch);
 void __iomem *rcar_sysc_init(phys_addr_t base);
 
-#endif /* PM_RCAR_H */
+#endif /* __LINUX_SOC_RENESAS_RCAR_SYSC_H__ */
-- 
1.9.1
