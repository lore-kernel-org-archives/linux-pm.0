From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH 06/12] soc: exynos: Move exynos power domain file to
 driver/soc/samsung folder
Date: Mon, 03 Nov 2014 09:23:04 +0530
Message-ID: <1414986790-11940-7-git-send-email-amit.daniel@samsung.com>
References: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: kgene.kim@samsung.com, pankaj.dubey@samsung.com, Amit Daniel Kachhap <amit.daniel@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch moves arch/arm/mach-exynos/pm_domains.c to driver/soc/samsung
folder. This will be useful to use it for both arm and arm64 platforms.
This file is moved in this directory as this driver is soc specific and
only used by exynos platforms.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm/mach-exynos/Makefile                      |    1 -
 drivers/soc/Kconfig                                |    1 +
 drivers/soc/Makefile                               |    1 +
 drivers/soc/samsung/Kconfig                        |   11 +++++++++++
 drivers/soc/samsung/Makefile                       |    1 +
 .../soc/samsung}/pm_domains.c                      |    0
 6 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/samsung/Kconfig
 create mode 100644 drivers/soc/samsung/Makefile
 rename {arch/arm/mach-exynos => drivers/soc/samsung}/pm_domains.c (100%)

diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index b91b382..9ea6c54 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -13,7 +13,6 @@ obj-$(CONFIG_ARCH_EXYNOS)	+= exynos.o exynos-smc.o firmware.o
 
 obj-$(CONFIG_EXYNOS_CPU_SUSPEND) += pm.o sleep.o
 obj-$(CONFIG_PM_SLEEP)		+= suspend.o
-obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
 
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 76d6bd4..90f33b9 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -3,5 +3,6 @@ menu "SOC (System On Chip) specific Drivers"
 source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/ti/Kconfig"
 source "drivers/soc/versatile/Kconfig"
+source "drivers/soc/samsung/Kconfig"
 
 endmenu
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 063113d..44d220d 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_ARCH_QCOM)		+= qcom/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
 obj-$(CONFIG_SOC_TI)		+= ti/
 obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
+obj-$(CONFIG_ARCH_EXYNOS)	+= samsung/
diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
new file mode 100644
index 0000000..1dc6a35
--- /dev/null
+++ b/drivers/soc/samsung/Kconfig
@@ -0,0 +1,11 @@
+#
+# Samsung Soc drivers
+#
+config EXYNOS_POWER_DOMAIN
+	tristate "Support Exynos PM Power Domain"
+	depends on ARCH_EXYNOS && PM_GENERIC_DOMAINS
+	default y
+	help
+	  Exynos SOC have power domain gating support. This driver implements that
+	  functionality and registers all the necessary hooks to the generic power domain
+	  core kernel infrastructure.
diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
new file mode 100644
index 0000000..f4efce7
--- /dev/null
+++ b/drivers/soc/samsung/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_EXYNOS_POWER_DOMAIN)	+=	pm_domains.o
diff --git a/arch/arm/mach-exynos/pm_domains.c b/drivers/soc/samsung/pm_domains.c
similarity index 100%
rename from arch/arm/mach-exynos/pm_domains.c
rename to drivers/soc/samsung/pm_domains.c
-- 
1.7.9.5
