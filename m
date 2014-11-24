From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH RFC v2 06/12] driver: soc: exynos-pmu: Add exynos7 power domain
 on/off ops
Date: Mon, 24 Nov 2014 18:34:10 +0530
Message-ID: <1416834256-11225-6-git-send-email-amit.daniel@samsung.com>
References: <1416833572-6880-1-git-send-email-amit.daniel@samsung.com>
 <1416834256-11225-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1416834256-11225-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: kgene.kim@samsung.com, linux-kernel@vger.kernel.org, s.nawrocki@samsung.com, pankaj.dubey@samsung.com, ulf.hansson@linaro.org, khilman@kernel.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, rjw@rjwysocki.net, devicetree@vger.kernel.org, Amit Daniel Kachhap <amit.daniel@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch uses the restructuring done in PD handlers and adds PD
on/off/status handlers for exynos7. In this SoC, some extra settings
need to be done prior to turning on/off power domains. Some of those
settings are also different from different power domains so is uses
the power domain compatible name feature to distinguish between power
domains.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/soc/samsung/exynos-pmu.c            |  105 +++++++++++++++++++++++++++
 include/linux/soc/samsung/exynos-regs-pmu.h |   17 +++++
 2 files changed, 122 insertions(+)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index e690f65..b9631d5 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -1202,6 +1202,104 @@ static void exynos7_pmu_init(void)
 	}
 }
 
+static int exynos7_pd_extraconf_base(const char *pd_name)
+{
+	if (!pd_name)
+		return -EINVAL;
+
+	if (!strcmp("samsung,exynos7-pd-mfc", pd_name))
+		return EXYNOS7_CLKRUN_CMU_MFC_SYS_PWR_REG;
+	else if (!strcmp("samsung,exynos7-pd-hevc", pd_name))
+		return EXYNOS7_CLKRUN_CMU_HEVC_SYS_PWR_REG;
+	else if (!strcmp("samsung,exynos7-pd-mscl", pd_name))
+		return EXYNOS7_CLKRUN_CMU_MSCL_SYS_PWR_REG;
+	else if (!strcmp("samsung,exynos7-pd-g2d", pd_name))
+		return EXYNOS7_CLKRUN_CMU_G2D_SYS_PWR_REG;
+	else if (!strcmp("samsung,exynos7-pd-fsys0", pd_name))
+		return EXYNOS7_CLKRUN_CMU_FSYS0_SYS_PWR_REG;
+	else if (!strcmp("samsung,exynos7-pd-fsys1", pd_name))
+		return EXYNOS7_CLKRUN_CMU_FSYS1_SYS_PWR_REG;
+	else if (!strcmp("samsung,exynos7-pd-aud", pd_name))
+		return EXYNOS7_CLKRUN_CMU_AUD_SYS_PWR_REG;
+	else if (!strcmp("samsung,exynos7-pd-disp", pd_name))
+		return EXYNOS7_CLKRUN_CMU_DISP_SYS_PWR_REG;
+	else if (!strcmp("samsung,exynos7-pd-vpp", pd_name))
+		return EXYNOS7_CLKRUN_CMU_VPP_SYS_PWR_REG;
+	else if (!strcmp("samsung,exynos7-pd-vpp", pd_name))
+		return EXYNOS7_CLKRUN_CMU_VPP_SYS_PWR_REG;
+	else if (!strcmp("samsung,exynos7-pd-isp0", pd_name))
+		return EXYNOS7_CLKRUN_CMU_ISP0_SYS_PWR_REG;
+	else if (!strcmp("samsung,exynos7-pd-isp1", pd_name))
+		return EXYNOS7_CLKRUN_CMU_ISP1_SYS_PWR_REG;
+	else if (!strcmp("samsung,exynos7-pd-cam0", pd_name))
+		return EXYNOS7_CLKRUN_CMU_CAM0_SYS_PWR_REG;
+	else if (!strcmp("samsung,exynos7-pd-cam1", pd_name))
+		return EXYNOS7_CLKRUN_CMU_CAM1_SYS_PWR_REG;
+	else if (!strcmp("samsung,exynos7-pd-g3d", pd_name))
+		return EXYNOS7_CLKRUN_CMU_CAM1_SYS_PWR_REG;
+
+	pr_err("%s: Unsupported power domain\n", pd_name);
+	return 0;
+}
+
+static int exynos7_pd_powerdown(const char *pd_name, void __iomem *pd_addr)
+{
+	int off_base = exynos7_pd_extraconf_base(pd_name);
+
+	if (!off_base)
+		return -EINVAL;
+
+	/* Initialise the pd extraconf registers */
+	pmu_raw_writel(0, off_base + EXYNOS7_CLKRUN_CMU_PD_SYS_PWR_REG);
+	pmu_raw_writel(0, off_base + EXYNOS7_CLKSTOP_CMU_PD_SYS_PWR_REG);
+	pmu_raw_writel(0, off_base + EXYNOS7_DISABLE_PLL_CMU_PD_SYS_PWR_REG);
+	pmu_raw_writel(0, off_base + EXYNOS7_RESET_LOGIC_PD_SYS_PWR_REG);
+	pmu_raw_writel(0, off_base + EXYNOS7_MEMORY_PD_SYS_PWR_REG);
+	pmu_raw_writel(0, off_base + EXYNOS7_RESET_CMU_PD_SYS_PWR_REG);
+
+	if (!strcmp("samsung,exynos7-pd-fsys0", pd_name) ||
+			!strcmp("samsung,exynos7-pd-fsys1", pd_name))
+		pmu_raw_writel(1,
+				off_base + EXYNOS7_RESET_SLEEP_PD_SYS_PWR_REG);
+
+	if (!strcmp("samsung,exynos7-pd-aud", pd_name)) {
+		pmu_raw_writel(0, EXYNOS7_PAD_RETENTION_AUD_SYS_PWR_REG);
+		pmu_raw_writel(0, EXYNOS7_GPIO_MODE_AUD_SYS_PWR_REG);
+	}
+
+	writel_relaxed((EXYNOS7_USE_PROLONGED_LOGIC_RESET |
+			EXYNOS7_USE_SC_FEEDBACK), pd_addr + EXYNOS_PD_OPTION);
+
+	return 0;
+}
+
+static int exynos7_pd_poweron(const char *pd_name, void __iomem *pd_addr)
+{
+	if (exynos7_pd_powerdown(pd_name, pd_addr))
+		return -EINVAL;
+
+	return __exynos_pd_poweron_off(true, pd_name, pd_addr,
+			EXYNOS7_INT_LOCAL_PWR_EN);
+}
+
+static int exynos7_pd_poweroff(const char *pd_name, void __iomem *pd_addr)
+{
+	if (exynos7_pd_powerdown(pd_name, pd_addr))
+		return -EINVAL;
+
+	return __exynos_pd_poweron_off(false, pd_name, pd_addr,
+			EXYNOS7_INT_LOCAL_PWR_EN);
+}
+
+static bool exynos7_pd_status(void __iomem *pd_addr)
+{
+	unsigned int val;
+
+	val = readl_relaxed(pd_addr + EXYNOS_PD_STATUS) &
+				EXYNOS7_INT_LOCAL_PWR_EN;
+	return  val ? true : false;
+}
+
 static struct exynos_pmu_pd_ops exynos_pd_ops = {
 	.pd_on		= exynos_pd_poweron,
 	.pd_off		= exynos_pd_poweroff,
@@ -1238,12 +1336,19 @@ static struct exynos_pmu_data exynos5420_pmu_data = {
 	.pd_ops		= &exynos_pd_ops,
 };
 
+static struct exynos_pmu_pd_ops exynos7_pd_ops = {
+	.pd_on		= exynos7_pd_poweron,
+	.pd_off		= exynos7_pd_poweroff,
+	.pd_status	= exynos7_pd_status,
+};
+
 static const struct exynos_pmu_data exynos7_pmu_data = {
 	.pmu_config		= exynos7_pmu_config,
 	.pmu_init		= exynos7_pmu_init,
 	.pmu_config_extra	= exynos7_pmu_config_extra,
 	.powerdown_conf		= exynos7_powerdown_conf,
 	.powerup_conf		= exynos7_powerup_conf,
+	.pd_ops			= &exynos7_pd_ops,
 };
 
 /*
diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
index c61f91a..520595f 100644
--- a/include/linux/soc/samsung/exynos-regs-pmu.h
+++ b/include/linux/soc/samsung/exynos-regs-pmu.h
@@ -680,6 +680,8 @@ static inline unsigned int exynos_pmu_cpunr(unsigned int mpidr)
 #define EXYNOS7_VPP_SYS_PWR_REG					(0x1438)
 #define EXYNOS7_CLKRUN_CMU_AUD_SYS_PWR_REG			(0x1440)
 #define EXYNOS7_CLKRUN_CMU_BUS0_SYS_PWR_REG			(0x1444)
+#define EXYNOS7_CLKRUN_CMU_CAM0_SYS_PWR_REG			(0x1448)
+#define EXYNOS7_CLKRUN_CMU_CAM1_SYS_PWR_REG			(0x144C)
 #define EXYNOS7_CLKRUN_CMU_DISP_SYS_PWR_REG			(0x1450)
 #define EXYNOS7_CLKRUN_CMU_FSYS0_SYS_PWR_REG			(0x1454)
 #define EXYNOS7_CLKRUN_CMU_FSYS1_SYS_PWR_REG			(0x1458)
@@ -824,6 +826,7 @@ static inline unsigned int exynos_pmu_cpunr(unsigned int mpidr)
 #define EXYNOS7_USE_STANDBYWFI					(0x1 << 16)
 #define EXYNOS7_USE_SC_FEEDBACK					(0x1 << 1)
 #define EXYNOS7_USE_SC_COUNTER					(0x1 << 0)
+#define EXYNOS7_USE_PROLONGED_LOGIC_RESET			(0x1 << 8)
 
 /* EXYNOS7_PAD_RETENTION_AUD_OPTION */
 #define PAD_INITIATE_WAKEUP					(0x1 << 28)
@@ -841,4 +844,18 @@ static inline unsigned int exynos_pmu_cpunr(unsigned int mpidr)
 
 #define EXYNOS7_CORE_ARMCLK_STOPCTRL		(0x1000)
 
+#define EXYNOS7_INT_LOCAL_PWR_EN		0xF
+
+/*
+ * Power domain register offsets from the EXYNOS7
+ * CLKRUN_CMU_HEVC_SYS_PWR_REG configuration register.
+ */
+#define EXYNOS7_CLKRUN_CMU_PD_SYS_PWR_REG	(0x0)
+#define EXYNOS7_CLKSTOP_CMU_PD_SYS_PWR_REG	(0x40)
+#define EXYNOS7_DISABLE_PLL_CMU_PD_SYS_PWR_REG	(0x80)
+#define EXYNOS7_RESET_LOGIC_PD_SYS_PWR_REG	(0xC0)
+#define EXYNOS7_MEMORY_PD_SYS_PWR_REG		(0x100)
+#define EXYNOS7_RESET_CMU_PD_SYS_PWR_REG	(0x140)
+#define EXYNOS7_RESET_SLEEP_PD_SYS_PWR_REG	(0x180)
+
 #endif /* __ASM_ARCH_REGS_PMU_H */
-- 
1.7.9.5
