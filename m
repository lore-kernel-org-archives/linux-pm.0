From: Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH v7 3/6] ARM: EXYNOS: split up exynos4 SoC specific PMU data
Date: Fri, 18 Dec 2015 09:02:13 +0530
Message-ID: <1450409536-30463-4-git-send-email-pankaj.dubey@samsung.com>
References: <1450409536-30463-1-git-send-email-pankaj.dubey@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1450409536-30463-1-git-send-email-pankaj.dubey@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: kgene.kim@samsung.com, k.kozlowski@samsung.com, thomas.ab@samsung.com, amitdanielk@gmail.com, olof@lixom.net, khilman@linaro.org, arnd@arndb.de, Pankaj Dubey <pankaj.dubey@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch splits up mach-exynos/pmu.c file, and moves exynos4210,
exynos4412 and exynos4212 PMU configuration data and functions handing
data into a common exynos4 SoC specific PMU file mach-exynos/exynos4-pmu.c.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
[for testing on Trats2 (Exynos4412, S2R, reboot, poweroff)]
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/mach-exynos/Makefile      |   2 +-
 arch/arm/mach-exynos/exynos-pmu.h  |   3 +
 arch/arm/mach-exynos/exynos4-pmu.c | 223 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-exynos/pmu.c         | 207 ----------------------------------
 4 files changed, 227 insertions(+), 208 deletions(-)
 create mode 100644 arch/arm/mach-exynos/exynos4-pmu.c

diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index e869f86..8969683 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -9,7 +9,7 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) += -I$(srctree)/$(src)/include -I$(srctree)
 
 # Core
 
-obj-$(CONFIG_ARCH_EXYNOS)	+= exynos.o pmu.o exynos-smc.o firmware.o exynos3250-pmu.o
+obj-$(CONFIG_ARCH_EXYNOS)	+= exynos.o pmu.o exynos-smc.o firmware.o exynos3250-pmu.o exynos4-pmu.o
 
 obj-$(CONFIG_EXYNOS_CPU_SUSPEND) += pm.o sleep.o
 obj-$(CONFIG_PM_SLEEP)		+= suspend.o
diff --git a/arch/arm/mach-exynos/exynos-pmu.h b/arch/arm/mach-exynos/exynos-pmu.h
index 5d09fa3..3d21aad 100644
--- a/arch/arm/mach-exynos/exynos-pmu.h
+++ b/arch/arm/mach-exynos/exynos-pmu.h
@@ -33,6 +33,9 @@ struct exynos_pmu_data {
 extern void __iomem *pmu_base_addr;
 /* list of all exported SoC specific data */
 extern const struct exynos_pmu_data exynos3250_pmu_data;
+extern const struct exynos_pmu_data exynos4210_pmu_data;
+extern const struct exynos_pmu_data exynos4212_pmu_data;
+extern const struct exynos_pmu_data exynos4412_pmu_data;
 
 extern void pmu_raw_writel(u32 val, u32 offset);
 extern u32 pmu_raw_readl(u32 offset);
diff --git a/arch/arm/mach-exynos/exynos4-pmu.c b/arch/arm/mach-exynos/exynos4-pmu.c
new file mode 100644
index 0000000..4b0a79e
--- /dev/null
+++ b/arch/arm/mach-exynos/exynos4-pmu.c
@@ -0,0 +1,223 @@
+/*
+ * Copyright (c) 2011-2015 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * EXYNOS4 - CPU PMU(Power Management Unit) support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/soc/samsung/exynos-regs-pmu.h>
+#include <linux/soc/samsung/exynos-pmu.h>
+
+#include "exynos-pmu.h"
+
+static const struct exynos_pmu_conf exynos4210_pmu_config[] = {
+	/* { .offset = offset, .val = { AFTR, LPA, SLEEP } */
+	{ S5P_ARM_CORE0_LOWPWR,			{ 0x0, 0x0, 0x2 } },
+	{ S5P_DIS_IRQ_CORE0,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_DIS_IRQ_CENTRAL0,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_ARM_CORE1_LOWPWR,			{ 0x0, 0x0, 0x2 } },
+	{ S5P_DIS_IRQ_CORE1,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_DIS_IRQ_CENTRAL1,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_ARM_COMMON_LOWPWR,		{ 0x0, 0x0, 0x2 } },
+	{ S5P_L2_0_LOWPWR,			{ 0x2, 0x2, 0x3 } },
+	{ S5P_L2_1_LOWPWR,			{ 0x2, 0x2, 0x3 } },
+	{ S5P_CMU_ACLKSTOP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_SCLKSTOP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_LOWPWR,			{ 0x1, 0x1, 0x0 } },
+	{ S5P_APLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_MPLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_VPLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_EPLL_SYSCLK_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_CLKSTOP_GPS_ALIVE_LOWPWR,	{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_GPSALIVE_LOWPWR,	{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_CLKSTOP_CAM_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_CLKSTOP_TV_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_CLKSTOP_MFC_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_CLKSTOP_G3D_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_CLKSTOP_LCD0_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_CLKSTOP_LCD1_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_CLKSTOP_MAUDIO_LOWPWR,	{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_CLKSTOP_GPS_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_CAM_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_TV_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_MFC_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_G3D_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_LCD0_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_LCD1_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_MAUDIO_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_GPS_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_TOP_BUS_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_TOP_RETENTION_LOWPWR,		{ 0x1, 0x0, 0x1 } },
+	{ S5P_TOP_PWR_LOWPWR,			{ 0x3, 0x0, 0x3 } },
+	{ S5P_LOGIC_RESET_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_ONENAND_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
+	{ S5P_MODIMIF_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
+	{ S5P_G2D_ACP_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
+	{ S5P_USBOTG_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
+	{ S5P_HSMMC_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_CSSYS_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_SECSS_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_PCIE_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_SATA_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_DRAM_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_MAUDIO_LOWPWR,	{ 0x1, 0x1, 0x0 } },
+	{ S5P_PAD_RETENTION_GPIO_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_UART_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_MMCA_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_MMCB_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_EBIA_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_EBIB_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_ISOLATION_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_ALV_SEL_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_XUSBXTI_LOWPWR,			{ 0x1, 0x1, 0x0 } },
+	{ S5P_XXTI_LOWPWR,			{ 0x1, 0x1, 0x0 } },
+	{ S5P_EXT_REGULATOR_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_GPIO_MODE_LOWPWR,			{ 0x1, 0x0, 0x0 } },
+	{ S5P_GPIO_MODE_MAUDIO_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CAM_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_TV_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_MFC_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_G3D_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_LCD0_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_LCD1_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_MAUDIO_LOWPWR,			{ 0x7, 0x7, 0x0 } },
+	{ S5P_GPS_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_GPS_ALIVE_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ PMU_TABLE_END,},
+};
+
+static const struct exynos_pmu_conf exynos4x12_pmu_config[] = {
+	{ S5P_ARM_CORE0_LOWPWR,			{ 0x0, 0x0, 0x2 } },
+	{ S5P_DIS_IRQ_CORE0,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_DIS_IRQ_CENTRAL0,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_ARM_CORE1_LOWPWR,			{ 0x0, 0x0, 0x2 } },
+	{ S5P_DIS_IRQ_CORE1,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_DIS_IRQ_CENTRAL1,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_ISP_ARM_LOWPWR,			{ 0x1, 0x0, 0x0 } },
+	{ S5P_DIS_IRQ_ISP_ARM_LOCAL_LOWPWR,	{ 0x0, 0x0, 0x0 } },
+	{ S5P_DIS_IRQ_ISP_ARM_CENTRAL_LOWPWR,	{ 0x0, 0x0, 0x0 } },
+	{ S5P_ARM_COMMON_LOWPWR,		{ 0x0, 0x0, 0x2 } },
+	{ S5P_L2_0_LOWPWR,			{ 0x0, 0x0, 0x3 } },
+	/* XXX_OPTION register should be set other field */
+	{ S5P_ARM_L2_0_OPTION,			{ 0x10, 0x10, 0x0 } },
+	{ S5P_L2_1_LOWPWR,			{ 0x0, 0x0, 0x3 } },
+	{ S5P_ARM_L2_1_OPTION,			{ 0x10, 0x10, 0x0 } },
+	{ S5P_CMU_ACLKSTOP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_SCLKSTOP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_LOWPWR,			{ 0x1, 0x1, 0x0 } },
+	{ S5P_DRAM_FREQ_DOWN_LOWPWR,		{ 0x1, 0x1, 0x1 } },
+	{ S5P_DDRPHY_DLLOFF_LOWPWR,		{ 0x1, 0x1, 0x1 } },
+	{ S5P_LPDDR_PHY_DLL_LOCK_LOWPWR,	{ 0x1, 0x1, 0x1 } },
+	{ S5P_CMU_ACLKSTOP_COREBLK_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_SCLKSTOP_COREBLK_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_COREBLK_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_APLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_MPLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_VPLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_EPLL_SYSCLK_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_MPLLUSER_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_CLKSTOP_GPS_ALIVE_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_GPSALIVE_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_CLKSTOP_CAM_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_CLKSTOP_TV_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_CLKSTOP_MFC_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_CLKSTOP_G3D_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_CLKSTOP_LCD0_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_CLKSTOP_ISP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_CLKSTOP_MAUDIO_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_CLKSTOP_GPS_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_CAM_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_TV_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_MFC_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_G3D_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_LCD0_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_ISP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_MAUDIO_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_GPS_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_TOP_BUS_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_TOP_RETENTION_LOWPWR,		{ 0x1, 0x0, 0x1 } },
+	{ S5P_TOP_PWR_LOWPWR,			{ 0x3, 0x0, 0x3 } },
+	{ S5P_TOP_BUS_COREBLK_LOWPWR,		{ 0x3, 0x0, 0x0 } },
+	{ S5P_TOP_RETENTION_COREBLK_LOWPWR,	{ 0x1, 0x0, 0x1 } },
+	{ S5P_TOP_PWR_COREBLK_LOWPWR,		{ 0x3, 0x0, 0x3 } },
+	{ S5P_LOGIC_RESET_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_OSCCLK_GATE_LOWPWR,		{ 0x1, 0x0, 0x1 } },
+	{ S5P_LOGIC_RESET_COREBLK_LOWPWR,	{ 0x1, 0x1, 0x0 } },
+	{ S5P_OSCCLK_GATE_COREBLK_LOWPWR,	{ 0x1, 0x0, 0x1 } },
+	{ S5P_ONENAND_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
+	{ S5P_ONENAND_MEM_OPTION,		{ 0x10, 0x10, 0x0 } },
+	{ S5P_HSI_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_HSI_MEM_OPTION,			{ 0x10, 0x10, 0x0 } },
+	{ S5P_G2D_ACP_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
+	{ S5P_G2D_ACP_MEM_OPTION,		{ 0x10, 0x10, 0x0 } },
+	{ S5P_USBOTG_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
+	{ S5P_USBOTG_MEM_OPTION,		{ 0x10, 0x10, 0x0 } },
+	{ S5P_HSMMC_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_HSMMC_MEM_OPTION,			{ 0x10, 0x10, 0x0 } },
+	{ S5P_CSSYS_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_CSSYS_MEM_OPTION,			{ 0x10, 0x10, 0x0 } },
+	{ S5P_SECSS_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_SECSS_MEM_OPTION,			{ 0x10, 0x10, 0x0 } },
+	{ S5P_ROTATOR_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
+	{ S5P_ROTATOR_MEM_OPTION,		{ 0x10, 0x10, 0x0 } },
+	{ S5P_PAD_RETENTION_DRAM_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_MAUDIO_LOWPWR,	{ 0x1, 0x1, 0x0 } },
+	{ S5P_PAD_RETENTION_GPIO_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_UART_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_MMCA_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_MMCB_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_EBIA_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_EBIB_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_GPIO_COREBLK_LOWPWR, { 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_ISOLATION_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_ISOLATION_COREBLK_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_ALV_SEL_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_XUSBXTI_LOWPWR,			{ 0x1, 0x1, 0x0 } },
+	{ S5P_XXTI_LOWPWR,			{ 0x1, 0x1, 0x0 } },
+	{ S5P_EXT_REGULATOR_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_GPIO_MODE_LOWPWR,			{ 0x1, 0x0, 0x0 } },
+	{ S5P_GPIO_MODE_COREBLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_GPIO_MODE_MAUDIO_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_TOP_ASB_RESET_LOWPWR,		{ 0x1, 0x1, 0x1 } },
+	{ S5P_TOP_ASB_ISOLATION_LOWPWR,		{ 0x1, 0x0, 0x1 } },
+	{ S5P_CAM_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_TV_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_MFC_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_G3D_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_LCD0_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_ISP_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_MAUDIO_LOWPWR,			{ 0x7, 0x7, 0x0 } },
+	{ S5P_GPS_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_GPS_ALIVE_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_CMU_SYSCLK_ISP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_SYSCLK_GPS_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ PMU_TABLE_END,},
+};
+
+static const struct exynos_pmu_conf exynos4412_pmu_config[] = {
+	{ S5P_ARM_CORE2_LOWPWR,			{ 0x0, 0x0, 0x2 } },
+	{ S5P_DIS_IRQ_CORE2,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_DIS_IRQ_CENTRAL2,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_ARM_CORE3_LOWPWR,			{ 0x0, 0x0, 0x2 } },
+	{ S5P_DIS_IRQ_CORE3,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_DIS_IRQ_CENTRAL3,			{ 0x0, 0x0, 0x0 } },
+	{ PMU_TABLE_END,},
+};
+
+const struct exynos_pmu_data exynos4210_pmu_data = {
+	.pmu_config	= exynos4210_pmu_config,
+};
+
+const struct exynos_pmu_data exynos4212_pmu_data = {
+	.pmu_config	= exynos4x12_pmu_config,
+};
+
+const struct exynos_pmu_data exynos4412_pmu_data = {
+	.pmu_config		= exynos4x12_pmu_config,
+	.pmu_config_extra	= exynos4412_pmu_config,
+};
+
diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index 31475d0..21bacba 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -39,200 +39,6 @@ u32 pmu_raw_readl(u32 offset)
 	return readl_relaxed(pmu_base_addr + offset);
 }
 
-static const struct exynos_pmu_conf exynos4210_pmu_config[] = {
-	/* { .offset = offset, .val = { AFTR, LPA, SLEEP } */
-	{ S5P_ARM_CORE0_LOWPWR,			{ 0x0, 0x0, 0x2 } },
-	{ S5P_DIS_IRQ_CORE0,			{ 0x0, 0x0, 0x0 } },
-	{ S5P_DIS_IRQ_CENTRAL0,			{ 0x0, 0x0, 0x0 } },
-	{ S5P_ARM_CORE1_LOWPWR,			{ 0x0, 0x0, 0x2 } },
-	{ S5P_DIS_IRQ_CORE1,			{ 0x0, 0x0, 0x0 } },
-	{ S5P_DIS_IRQ_CENTRAL1,			{ 0x0, 0x0, 0x0 } },
-	{ S5P_ARM_COMMON_LOWPWR,		{ 0x0, 0x0, 0x2 } },
-	{ S5P_L2_0_LOWPWR,			{ 0x2, 0x2, 0x3 } },
-	{ S5P_L2_1_LOWPWR,			{ 0x2, 0x2, 0x3 } },
-	{ S5P_CMU_ACLKSTOP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_SCLKSTOP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_RESET_LOWPWR,			{ 0x1, 0x1, 0x0 } },
-	{ S5P_APLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_MPLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_VPLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_EPLL_SYSCLK_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_CLKSTOP_GPS_ALIVE_LOWPWR,	{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_RESET_GPSALIVE_LOWPWR,	{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_CLKSTOP_CAM_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_CLKSTOP_TV_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_CLKSTOP_MFC_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_CLKSTOP_G3D_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_CLKSTOP_LCD0_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_CLKSTOP_LCD1_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_CLKSTOP_MAUDIO_LOWPWR,	{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_CLKSTOP_GPS_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_RESET_CAM_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_RESET_TV_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_RESET_MFC_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_RESET_G3D_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_RESET_LCD0_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_RESET_LCD1_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_RESET_MAUDIO_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_RESET_GPS_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_TOP_BUS_LOWPWR,			{ 0x3, 0x0, 0x0 } },
-	{ S5P_TOP_RETENTION_LOWPWR,		{ 0x1, 0x0, 0x1 } },
-	{ S5P_TOP_PWR_LOWPWR,			{ 0x3, 0x0, 0x3 } },
-	{ S5P_LOGIC_RESET_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_ONENAND_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
-	{ S5P_MODIMIF_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
-	{ S5P_G2D_ACP_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
-	{ S5P_USBOTG_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
-	{ S5P_HSMMC_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
-	{ S5P_CSSYS_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
-	{ S5P_SECSS_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
-	{ S5P_PCIE_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
-	{ S5P_SATA_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_DRAM_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_MAUDIO_LOWPWR,	{ 0x1, 0x1, 0x0 } },
-	{ S5P_PAD_RETENTION_GPIO_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_UART_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_MMCA_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_MMCB_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_EBIA_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_EBIB_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_ISOLATION_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_ALV_SEL_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_XUSBXTI_LOWPWR,			{ 0x1, 0x1, 0x0 } },
-	{ S5P_XXTI_LOWPWR,			{ 0x1, 0x1, 0x0 } },
-	{ S5P_EXT_REGULATOR_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_GPIO_MODE_LOWPWR,			{ 0x1, 0x0, 0x0 } },
-	{ S5P_GPIO_MODE_MAUDIO_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CAM_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_TV_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_MFC_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_G3D_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_LCD0_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_LCD1_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_MAUDIO_LOWPWR,			{ 0x7, 0x7, 0x0 } },
-	{ S5P_GPS_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_GPS_ALIVE_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ PMU_TABLE_END,},
-};
-
-static const struct exynos_pmu_conf exynos4x12_pmu_config[] = {
-	{ S5P_ARM_CORE0_LOWPWR,			{ 0x0, 0x0, 0x2 } },
-	{ S5P_DIS_IRQ_CORE0,			{ 0x0, 0x0, 0x0 } },
-	{ S5P_DIS_IRQ_CENTRAL0,			{ 0x0, 0x0, 0x0 } },
-	{ S5P_ARM_CORE1_LOWPWR,			{ 0x0, 0x0, 0x2 } },
-	{ S5P_DIS_IRQ_CORE1,			{ 0x0, 0x0, 0x0 } },
-	{ S5P_DIS_IRQ_CENTRAL1,			{ 0x0, 0x0, 0x0 } },
-	{ S5P_ISP_ARM_LOWPWR,			{ 0x1, 0x0, 0x0 } },
-	{ S5P_DIS_IRQ_ISP_ARM_LOCAL_LOWPWR,	{ 0x0, 0x0, 0x0 } },
-	{ S5P_DIS_IRQ_ISP_ARM_CENTRAL_LOWPWR,	{ 0x0, 0x0, 0x0 } },
-	{ S5P_ARM_COMMON_LOWPWR,		{ 0x0, 0x0, 0x2 } },
-	{ S5P_L2_0_LOWPWR,			{ 0x0, 0x0, 0x3 } },
-	/* XXX_OPTION register should be set other field */
-	{ S5P_ARM_L2_0_OPTION,			{ 0x10, 0x10, 0x0 } },
-	{ S5P_L2_1_LOWPWR,			{ 0x0, 0x0, 0x3 } },
-	{ S5P_ARM_L2_1_OPTION,			{ 0x10, 0x10, 0x0 } },
-	{ S5P_CMU_ACLKSTOP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_SCLKSTOP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_RESET_LOWPWR,			{ 0x1, 0x1, 0x0 } },
-	{ S5P_DRAM_FREQ_DOWN_LOWPWR,		{ 0x1, 0x1, 0x1 } },
-	{ S5P_DDRPHY_DLLOFF_LOWPWR,		{ 0x1, 0x1, 0x1 } },
-	{ S5P_LPDDR_PHY_DLL_LOCK_LOWPWR,	{ 0x1, 0x1, 0x1 } },
-	{ S5P_CMU_ACLKSTOP_COREBLK_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_SCLKSTOP_COREBLK_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_RESET_COREBLK_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_APLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_MPLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_VPLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_EPLL_SYSCLK_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_MPLLUSER_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_CLKSTOP_GPS_ALIVE_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_RESET_GPSALIVE_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_CLKSTOP_CAM_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_CLKSTOP_TV_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_CLKSTOP_MFC_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_CLKSTOP_G3D_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_CLKSTOP_LCD0_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_CLKSTOP_ISP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_CLKSTOP_MAUDIO_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_CLKSTOP_GPS_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_RESET_CAM_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_RESET_TV_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_RESET_MFC_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_RESET_G3D_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_RESET_LCD0_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_RESET_ISP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_RESET_MAUDIO_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_CMU_RESET_GPS_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_TOP_BUS_LOWPWR,			{ 0x3, 0x0, 0x0 } },
-	{ S5P_TOP_RETENTION_LOWPWR,		{ 0x1, 0x0, 0x1 } },
-	{ S5P_TOP_PWR_LOWPWR,			{ 0x3, 0x0, 0x3 } },
-	{ S5P_TOP_BUS_COREBLK_LOWPWR,		{ 0x3, 0x0, 0x0 } },
-	{ S5P_TOP_RETENTION_COREBLK_LOWPWR,	{ 0x1, 0x0, 0x1 } },
-	{ S5P_TOP_PWR_COREBLK_LOWPWR,		{ 0x3, 0x0, 0x3 } },
-	{ S5P_LOGIC_RESET_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_OSCCLK_GATE_LOWPWR,		{ 0x1, 0x0, 0x1 } },
-	{ S5P_LOGIC_RESET_COREBLK_LOWPWR,	{ 0x1, 0x1, 0x0 } },
-	{ S5P_OSCCLK_GATE_COREBLK_LOWPWR,	{ 0x1, 0x0, 0x1 } },
-	{ S5P_ONENAND_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
-	{ S5P_ONENAND_MEM_OPTION,		{ 0x10, 0x10, 0x0 } },
-	{ S5P_HSI_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
-	{ S5P_HSI_MEM_OPTION,			{ 0x10, 0x10, 0x0 } },
-	{ S5P_G2D_ACP_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
-	{ S5P_G2D_ACP_MEM_OPTION,		{ 0x10, 0x10, 0x0 } },
-	{ S5P_USBOTG_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
-	{ S5P_USBOTG_MEM_OPTION,		{ 0x10, 0x10, 0x0 } },
-	{ S5P_HSMMC_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
-	{ S5P_HSMMC_MEM_OPTION,			{ 0x10, 0x10, 0x0 } },
-	{ S5P_CSSYS_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
-	{ S5P_CSSYS_MEM_OPTION,			{ 0x10, 0x10, 0x0 } },
-	{ S5P_SECSS_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
-	{ S5P_SECSS_MEM_OPTION,			{ 0x10, 0x10, 0x0 } },
-	{ S5P_ROTATOR_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
-	{ S5P_ROTATOR_MEM_OPTION,		{ 0x10, 0x10, 0x0 } },
-	{ S5P_PAD_RETENTION_DRAM_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_MAUDIO_LOWPWR,	{ 0x1, 0x1, 0x0 } },
-	{ S5P_PAD_RETENTION_GPIO_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_UART_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_MMCA_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_MMCB_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_EBIA_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_EBIB_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_GPIO_COREBLK_LOWPWR,{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_ISOLATION_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_ISOLATION_COREBLK_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_PAD_RETENTION_ALV_SEL_LOWPWR,	{ 0x1, 0x0, 0x0 } },
-	{ S5P_XUSBXTI_LOWPWR,			{ 0x1, 0x1, 0x0 } },
-	{ S5P_XXTI_LOWPWR,			{ 0x1, 0x1, 0x0 } },
-	{ S5P_EXT_REGULATOR_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_GPIO_MODE_LOWPWR,			{ 0x1, 0x0, 0x0 } },
-	{ S5P_GPIO_MODE_COREBLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_GPIO_MODE_MAUDIO_LOWPWR,		{ 0x1, 0x1, 0x0 } },
-	{ S5P_TOP_ASB_RESET_LOWPWR,		{ 0x1, 0x1, 0x1 } },
-	{ S5P_TOP_ASB_ISOLATION_LOWPWR,		{ 0x1, 0x0, 0x1 } },
-	{ S5P_CAM_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_TV_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_MFC_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_G3D_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_LCD0_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_ISP_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_MAUDIO_LOWPWR,			{ 0x7, 0x7, 0x0 } },
-	{ S5P_GPS_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_GPS_ALIVE_LOWPWR,			{ 0x7, 0x0, 0x0 } },
-	{ S5P_CMU_SYSCLK_ISP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ S5P_CMU_SYSCLK_GPS_LOWPWR,		{ 0x1, 0x0, 0x0 } },
-	{ PMU_TABLE_END,},
-};
-
-static const struct exynos_pmu_conf exynos4412_pmu_config[] = {
-	{ S5P_ARM_CORE2_LOWPWR,			{ 0x0, 0x0, 0x2 } },
-	{ S5P_DIS_IRQ_CORE2,			{ 0x0, 0x0, 0x0 } },
-	{ S5P_DIS_IRQ_CENTRAL2,			{ 0x0, 0x0, 0x0 } },
-	{ S5P_ARM_CORE3_LOWPWR,			{ 0x0, 0x0, 0x2 } },
-	{ S5P_DIS_IRQ_CORE3,			{ 0x0, 0x0, 0x0 } },
-	{ S5P_DIS_IRQ_CENTRAL3,			{ 0x0, 0x0, 0x0 } },
-	{ PMU_TABLE_END,},
-};
-
 static const struct exynos_pmu_conf exynos5250_pmu_config[] = {
 	/* { .offset = offset, .val = { AFTR, LPA, SLEEP } */
 	{ EXYNOS5_ARM_CORE0_SYS_PWR_REG,		{ 0x0, 0x0, 0x2} },
@@ -691,19 +497,6 @@ static void exynos5420_pmu_init(void)
 	pr_info("EXYNOS5420 PMU initialized\n");
 }
 
-static const struct exynos_pmu_data exynos4210_pmu_data = {
-	.pmu_config	= exynos4210_pmu_config,
-};
-
-static const struct exynos_pmu_data exynos4212_pmu_data = {
-	.pmu_config	= exynos4x12_pmu_config,
-};
-
-static const struct exynos_pmu_data exynos4412_pmu_data = {
-	.pmu_config		= exynos4x12_pmu_config,
-	.pmu_config_extra	= exynos4412_pmu_config,
-};
-
 static const struct exynos_pmu_data exynos5250_pmu_data = {
 	.pmu_config	= exynos5250_pmu_config,
 	.pmu_init	= exynos5250_pmu_init,
-- 
2.4.5
