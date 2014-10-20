From: Thomas Abraham <thomas.ab@samsung.com>
Subject: [PATCH v11 5/6] cpufreq: exynos: remove exynos4210/5250 specific
 cpufreq driver support
Date: Mon, 20 Oct 2014 17:11:20 +0530
Message-ID: <1413805281-6269-6-git-send-email-thomas.ab@samsung.com>
References: <1413805281-6269-1-git-send-email-thomas.ab@samsung.com>
 <1413805281-6269-2-git-send-email-thomas.ab@samsung.com>
 <1413805281-6269-3-git-send-email-thomas.ab@samsung.com>
 <1413805281-6269-4-git-send-email-thomas.ab@samsung.com>
 <1413805281-6269-5-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1413805281-6269-5-git-send-email-thomas.ab@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, tomasz.figa@gmail.com, l.majewski@samsung.com, viresh.kumar@linaro.org, thomas.ab@samsung.com, heiko@sntech.de, cw00.choi@samsung.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Exynos4210 and Exynos5250 based platforms have switched over to use generic
cpufreq drivers for cpufreq functionality. So the Exynos specific cpufreq
drivers for these platforms can be removed.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Chander Kashyap <k.chander@samsung.com>
---
 drivers/cpufreq/Kconfig.arm |   22 ----------------------
 drivers/cpufreq/Makefile    |    2 --
 2 files changed, 0 insertions(+), 24 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 83a75dc..701f5ca 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -28,17 +28,6 @@ config ARM_VEXPRESS_SPC_CPUFREQ
 config ARM_EXYNOS_CPUFREQ
 	bool
 
-config ARM_EXYNOS4210_CPUFREQ
-	bool "SAMSUNG EXYNOS4210"
-	depends on CPU_EXYNOS4210
-	default y
-	select ARM_EXYNOS_CPUFREQ
-	help
-	  This adds the CPUFreq driver for Samsung EXYNOS4210
-	  SoC (S5PV310 or S5PC210).
-
-	  If in doubt, say N.
-
 config ARM_EXYNOS4X12_CPUFREQ
 	bool "SAMSUNG EXYNOS4x12"
 	depends on SOC_EXYNOS4212 || SOC_EXYNOS4412
@@ -50,17 +39,6 @@ config ARM_EXYNOS4X12_CPUFREQ
 
 	  If in doubt, say N.
 
-config ARM_EXYNOS5250_CPUFREQ
-	bool "SAMSUNG EXYNOS5250"
-	depends on SOC_EXYNOS5250
-	default y
-	select ARM_EXYNOS_CPUFREQ
-	help
-	  This adds the CPUFreq driver for Samsung EXYNOS5250
-	  SoC.
-
-	  If in doubt, say N.
-
 config ARM_EXYNOS5440_CPUFREQ
 	bool "SAMSUNG EXYNOS5440"
 	depends on SOC_EXYNOS5440
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 40c53dc..74e55f9 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -52,9 +52,7 @@ obj-$(CONFIG_ARM_DT_BL_CPUFREQ)		+= arm_big_little_dt.o
 obj-$(CONFIG_ARCH_DAVINCI)		+= davinci-cpufreq.o
 obj-$(CONFIG_UX500_SOC_DB8500)		+= dbx500-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+= exynos-cpufreq.o
-obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+= exynos4210-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)	+= exynos4x12-cpufreq.o
-obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)	+= exynos5250-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+= exynos5440-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
-- 
1.6.6.rc2
