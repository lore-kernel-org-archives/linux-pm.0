From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 6/6] ARM: cpuidle: Enable the ARM64 driver for both ARM32/ARM64
Date: Tue,  3 Mar 2015 13:29:37 +0100
Message-ID: <1425385777-14766-7-git-send-email-daniel.lezcano@linaro.org>
References: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425385777-14766-1-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin.Marinas-5wv7dgnIgG8@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

ARM32 and ARM64 have the same DT definitions and the same approaches.

The generic ARM cpuidle driver can be put in common for those two
architectures.

Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/cpuidle/Kconfig                            |  7 +------
 drivers/cpuidle/Kconfig.arm                        | 10 ++++++++++
 drivers/cpuidle/Kconfig.arm64                      | 13 -------------
 drivers/cpuidle/Makefile                           |  5 +----
 drivers/cpuidle/{cpuidle-arm64.c => cpuidle-arm.c} |  0
 5 files changed, 12 insertions(+), 23 deletions(-)
 delete mode 100644 drivers/cpuidle/Kconfig.arm64
 rename drivers/cpuidle/{cpuidle-arm64.c => cpuidle-arm.c} (100%)

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index c5029c1..8c7930b 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -29,15 +29,10 @@ config DT_IDLE_STATES
 	bool
 
 menu "ARM CPU Idle Drivers"
-depends on ARM
+depends on ARM || ARM64
 source "drivers/cpuidle/Kconfig.arm"
 endmenu
 
-menu "ARM64 CPU Idle Drivers"
-depends on ARM64
-source "drivers/cpuidle/Kconfig.arm64"
-endmenu
-
 menu "MIPS CPU Idle Drivers"
 depends on MIPS
 source "drivers/cpuidle/Kconfig.mips"
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 8e07c94..f08043e 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -14,6 +14,16 @@ config ARM_BIG_LITTLE_CPUIDLE
 	  define different C-states for little and big cores through the
 	  multiple CPU idle drivers infrastructure.
 
+config ARM_CPUIDLE
+	bool "Generic ARM/ARM64 CPU idle Driver"
+	select DT_IDLE_STATES
+	help
+	  Select this to enable generic cpuidle driver for ARM.
+	  It provides a generic idle driver whose idle states are configured
+	  at run-time through DT nodes. The CPUidle suspend backend is
+	  initialized by calling the CPU operations init idle hook
+	  provided by architecture code.
+
 config ARM_CLPS711X_CPUIDLE
 	bool "CPU Idle Driver for CLPS711X processors"
 	depends on ARCH_CLPS711X || COMPILE_TEST
diff --git a/drivers/cpuidle/Kconfig.arm64 b/drivers/cpuidle/Kconfig.arm64
deleted file mode 100644
index 6effb36..0000000
--- a/drivers/cpuidle/Kconfig.arm64
+++ /dev/null
@@ -1,13 +0,0 @@
-#
-# ARM64 CPU Idle drivers
-#
-
-config ARM64_CPUIDLE
-	bool "Generic ARM64 CPU idle Driver"
-	select DT_IDLE_STATES
-	help
-	  Select this to enable generic cpuidle driver for ARM64.
-	  It provides a generic idle driver whose idle states are configured
-	  at run-time through DT nodes. The CPUidle suspend backend is
-	  initialized by calling the CPU operations init idle hook
-	  provided by architecture code.
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 4d177b9..3ba81b1 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -17,16 +17,13 @@ obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
 obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
 obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
 obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
+obj-$(CONFIG_ARM_CPUIDLE)		+= cpuidle-arm.o
 
 ###############################################################################
 # MIPS drivers
 obj-$(CONFIG_MIPS_CPS_CPUIDLE)		+= cpuidle-cps.o
 
 ###############################################################################
-# ARM64 drivers
-obj-$(CONFIG_ARM64_CPUIDLE)		+= cpuidle-arm64.o
-
-###############################################################################
 # POWERPC drivers
 obj-$(CONFIG_PSERIES_CPUIDLE)		+= cpuidle-pseries.o
 obj-$(CONFIG_POWERNV_CPUIDLE)		+= cpuidle-powernv.o
diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm.c
similarity index 100%
rename from drivers/cpuidle/cpuidle-arm64.c
rename to drivers/cpuidle/cpuidle-arm.c
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
