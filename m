From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH RFC v2 02/12] soc: exynos: Move exynos power domain file to
 driver/soc/samsung folder
Date: Mon, 24 Nov 2014 18:34:06 +0530
Message-ID: <1416834256-11225-2-git-send-email-amit.daniel@samsung.com>
References: <1416833572-6880-1-git-send-email-amit.daniel@samsung.com>
 <1416834256-11225-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:35630 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbaKXNMj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Nov 2014 08:12:39 -0500
In-reply-to: <1416834256-11225-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: kgene.kim@samsung.com, linux-kernel@vger.kernel.org, s.nawrocki@samsung.com, pankaj.dubey@samsung.com, ulf.hansson@linaro.org, khilman@kernel.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, rjw@rjwysocki.net, devicetree@vger.kernel.org, Amit Daniel Kachhap <amit.daniel@samsung.com>

This patch moves arch/arm/mach-exynos/pm_domains.c to driver/soc/samsung
folder. In this way it can be used for both arm and arm64 platforms.
This file is moved in this directory as this driver is soc specific and
only used by exynos platforms.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm/mach-exynos/Makefile                      |    1 -
 drivers/soc/samsung/Kconfig                        |    9 +++++++++
 drivers/soc/samsung/Makefile                       |    3 ++-
 .../soc/samsung}/pm_domains.c                      |    0
 4 files changed, 11 insertions(+), 2 deletions(-)
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
 
diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index 6855cc4..2bb33e7 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -17,4 +17,13 @@ config EXYNOS_PMU
 	  functionality like initialisation and transition to various low power
 	  states.
 
+config EXYNOS_POWER_DOMAIN
+	tristate "Support Exynos PM Power Domain"
+	depends on ARCH_EXYNOS && PM_GENERIC_DOMAINS
+	default y
+	help
+	  Exynos SOC have power domain gating support. This driver implements
+	  that functionality and registers all the necessary hooks to the
+	  generic power domain core kernel infrastructure.
+
 endmenu
diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
index 5a879c6..61ccd51 100644
--- a/drivers/soc/samsung/Makefile
+++ b/drivers/soc/samsung/Makefile
@@ -1 +1,2 @@
-obj-$(CONFIG_EXYNOS_PMU)	+= exynos-pmu.o
+obj-$(CONFIG_EXYNOS_PMU)		+= exynos-pmu.o
+obj-$(CONFIG_EXYNOS_POWER_DOMAIN)	+= pm_domains.o
diff --git a/arch/arm/mach-exynos/pm_domains.c b/drivers/soc/samsung/pm_domains.c
similarity index 100%
rename from arch/arm/mach-exynos/pm_domains.c
rename to drivers/soc/samsung/pm_domains.c
-- 
1.7.9.5

