From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH RFC v2 04/12] soc: samsung: Re-structure PMU driver to create
 pd on/off handlers
Date: Mon, 24 Nov 2014 18:34:08 +0530
Message-ID: <1416834256-11225-4-git-send-email-amit.daniel@samsung.com>
References: <1416833572-6880-1-git-send-email-amit.daniel@samsung.com>
 <1416834256-11225-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1416834256-11225-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: kgene.kim@samsung.com, linux-kernel@vger.kernel.org, s.nawrocki@samsung.com, pankaj.dubey@samsung.com, ulf.hansson@linaro.org, khilman@kernel.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, rjw@rjwysocki.net, devicetree@vger.kernel.org, Amit Daniel Kachhap <amit.daniel@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch moves PD domain on/off implementation inside the PMU driver.
The handlers will be supplied via the MFD platform data. Power domains
are basically sparse memories in the Exynos PMU controllers, so with
this restructuring all the register access operations reside inside pmu
file.
This restructuring will be useful for SoC's where certain extra
operation need to implemented along with PD on/off operation or if
some PD registers are different. There is no functionality change for the
existing SoC's.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/soc/samsung/exynos-pmu.c            |   62 +++++++++++++++++++++++++++
 drivers/soc/samsung/pm_domains.c            |   50 ++++++++++++---------
 include/linux/soc/samsung/exynos-pmu.h      |   15 +++++++
 include/linux/soc/samsung/exynos-regs-pmu.h |    9 ++++
 4 files changed, 115 insertions(+), 21 deletions(-)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index da77c7e..e690f65 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -34,6 +34,7 @@ struct exynos_pmu_conf {
 struct exynos_pmu_data {
 	const struct exynos_pmu_conf *pmu_config;
 	const struct exynos_pmu_conf *pmu_config_extra;
+	struct exynos_pmu_pd_ops *pd_ops;
 
 	void (*pmu_init)(void);
 	void (*powerdown_conf)(enum sys_powerdown);
@@ -44,6 +45,7 @@ struct exynos_pmu_context {
 	struct device *dev;
 	const struct exynos_pmu_data *pmu_data;
 	struct mfd_cell cells[MFD_MAX];
+	struct pmu_dev_client_data mfd_data[MFD_MAX];
 };
 
 static void __iomem *pmu_base_addr;
@@ -880,6 +882,52 @@ void exynos_sys_powerup_conf(enum sys_powerdown mode)
 		pmu_data->powerup_conf(mode);
 }
 
+static int __exynos_pd_poweron_off(bool power_on, const char *pd_name,
+		void __iomem *pd_addr, int conf_val)
+{
+	unsigned int timeout, pwr;
+	char *op;
+
+	/* Wait max 1ms */
+	timeout = 10;
+	pwr = power_on ? conf_val : 0;
+
+	writel_relaxed(pwr, pd_addr + EXYNOS_PD_CONFIG);
+
+	while ((readl_relaxed(pd_addr + EXYNOS_PD_STATUS) & conf_val) != pwr) {
+		if (!timeout) {
+			op = (power_on) ? "enable" : "disable";
+			pr_err("Power domain %s %s failed\n", pd_name, op);
+			return -ETIMEDOUT;
+		}
+		timeout--;
+		cpu_relax();
+		usleep_range(80, 100);
+	}
+	return 0;
+}
+
+static int exynos_pd_poweron(const char *pd_name, void __iomem *pd_addr)
+{
+	return __exynos_pd_poweron_off(true, pd_name, pd_addr,
+					EXYNOS_INT_LOCAL_PWR_EN);
+}
+
+static int exynos_pd_poweroff(const char *pd_name, void __iomem *pd_addr)
+{
+	return __exynos_pd_poweron_off(false, pd_name, pd_addr,
+					EXYNOS_INT_LOCAL_PWR_EN);
+}
+
+static bool exynos_pd_status(void __iomem *pd_addr)
+{
+	unsigned int val;
+
+	val = readl_relaxed(pd_addr + EXYNOS_PD_STATUS) &
+				EXYNOS_INT_LOCAL_PWR_EN;
+	return  val ? true : false;
+}
+
 static void exynos5250_pmu_init(void)
 {
 	unsigned int value;
@@ -1154,29 +1202,40 @@ static void exynos7_pmu_init(void)
 	}
 }
 
+static struct exynos_pmu_pd_ops exynos_pd_ops = {
+	.pd_on		= exynos_pd_poweron,
+	.pd_off		= exynos_pd_poweroff,
+	.pd_status	= exynos_pd_status,
+};
+
 static const struct exynos_pmu_data exynos4210_pmu_data = {
 	.pmu_config	= exynos4210_pmu_config,
+	.pd_ops		= &exynos_pd_ops,
 };
 
 static const struct exynos_pmu_data exynos4212_pmu_data = {
 	.pmu_config	= exynos4x12_pmu_config,
+	.pd_ops		= &exynos_pd_ops,
 };
 
 static const struct exynos_pmu_data exynos4412_pmu_data = {
 	.pmu_config		= exynos4x12_pmu_config,
 	.pmu_config_extra	= exynos4412_pmu_config,
+	.pd_ops			= &exynos_pd_ops,
 };
 
 static const struct exynos_pmu_data exynos5250_pmu_data = {
 	.pmu_config	= exynos5250_pmu_config,
 	.pmu_init	= exynos5250_pmu_init,
 	.powerdown_conf	= exynos5_powerdown_conf,
+	.pd_ops		= &exynos_pd_ops,
 };
 
 static struct exynos_pmu_data exynos5420_pmu_data = {
 	.pmu_config	= exynos5420_pmu_config,
 	.pmu_init	= exynos5420_pmu_init,
 	.powerdown_conf	= exynos5420_powerdown_conf,
+	.pd_ops		= &exynos_pd_ops,
 };
 
 static const struct exynos_pmu_data exynos7_pmu_data = {
@@ -1259,6 +1318,9 @@ static int exynos_pmu_probe(struct platform_device *pdev)
 	/* Initialize and invoke mfd clients */
 	cell = &pmu_context->cells[MFD_PD];
 	cell->name = "exynos-pmu-pd";
+	pmu_context->mfd_data[MFD_PD].ops = pmu_context->pmu_data->pd_ops;
+	cell->platform_data = &pmu_context->mfd_data[MFD_PD];
+	cell->pdata_size = sizeof(pmu_context->mfd_data[MFD_PD]);
 
 	ret = mfd_add_devices(&pdev->dev, pdev->id, pmu_context->cells, MFD_MAX,
 				NULL, 0, NULL);
diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
index 5cb5440..69bc8b1 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -22,10 +22,13 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/sched.h>
+#include <linux/soc/samsung/exynos-pmu.h>
 
-#define INT_LOCAL_PWR_EN	0x7
 #define MAX_CLK_PER_DOMAIN	4
 
+static struct exynos_pmu_pd_ops *pd_ops;
+
+
 /*
  * Exynos specific wrapper around the generic power domain
  */
@@ -43,8 +46,7 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 {
 	struct exynos_pm_domain *pd;
 	void __iomem *base;
-	u32 timeout, pwr;
-	char *op;
+	int ret = 0;
 
 	pd = container_of(domain, struct exynos_pm_domain, pd);
 	base = pd->base;
@@ -62,22 +64,13 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 		}
 	}
 
-	pwr = power_on ? INT_LOCAL_PWR_EN : 0;
-	__raw_writel(pwr, base);
-
-	/* Wait max 1ms */
-	timeout = 10;
+	if (power_on)
+		ret = pd_ops->pd_on(domain->name, base);
+	else
+		ret = pd_ops->pd_off(domain->name, base);
 
-	while ((__raw_readl(base + 0x4) & INT_LOCAL_PWR_EN) != pwr) {
-		if (!timeout) {
-			op = (power_on) ? "enable" : "disable";
-			pr_err("Power domain %s %s failed\n", domain->name, op);
-			return -ETIMEDOUT;
-		}
-		timeout--;
-		cpu_relax();
-		usleep_range(80, 100);
-	}
+	if (ret)
+		return ret;
 
 	/* Restore clocks after powering on a domain*/
 	if (power_on) {
@@ -92,7 +85,7 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 		}
 	}
 
-	return 0;
+	return ret;
 }
 
 static int exynos_pd_power_on(struct generic_pm_domain *domain)
@@ -108,10 +101,25 @@ static int exynos_pd_power_off(struct generic_pm_domain *domain)
 static int exynos_power_domain_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
+	struct pmu_dev_client_data *pdata = NULL;
+
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		dev_err(&pdev->dev, "No platform data passed\n");
+		return -EINVAL;
+	}
+
+	pd_ops = pdata->ops;
+	if (!pd_ops || !pd_ops->pd_on || !pd_ops->pd_off ||
+						!pd_ops->pd_status) {
+		dev_err(&pdev->dev, "Invalid platform data\n");
+		return -EINVAL;
+	}
 
 	for_each_compatible_node(np, NULL, "samsung,exynos4210-pd") {
 		struct exynos_pm_domain *pd;
-		int on, i;
+		int i;
+		bool on;
 
 		pd = devm_kzalloc(&pdev->dev, sizeof(*pd), GFP_KERNEL);
 		if (!pd)
@@ -147,7 +155,7 @@ static int exynos_power_domain_probe(struct platform_device *pdev)
 			clk_put(pd->oscclk);
 
 no_clk:
-		on = __raw_readl(pd->base + 0x4) & INT_LOCAL_PWR_EN;
+		on = pd_ops->pd_status(pd->base);
 
 		pm_genpd_init(&pd->pd, NULL, !on);
 		of_genpd_add_provider_simple(np, &pd->pd);
diff --git a/include/linux/soc/samsung/exynos-pmu.h b/include/linux/soc/samsung/exynos-pmu.h
index b497712..6774aea 100644
--- a/include/linux/soc/samsung/exynos-pmu.h
+++ b/include/linux/soc/samsung/exynos-pmu.h
@@ -19,6 +19,21 @@ enum sys_powerdown {
 	NUM_SYS_POWERDOWN,
 };
 
+struct exynos_pmu_pd_ops {
+	/*
+	 * pd name may be useful to carry out any operations specific
+	 * to the power domain. pd_addr provides the base address of the
+	 * power domain.
+	 */
+	int (*pd_on)(const char *pd_name, void __iomem *pd_addr);
+	int (*pd_off)(const char *pd_name, void __iomem *pd_addr);
+	bool (*pd_status)(void __iomem *pd_addr);
+};
+
+struct pmu_dev_client_data {
+	void *ops; /* void * may be useful for all types of mfd clients */
+};
+
 extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
 extern void exynos_sys_powerup_conf(enum sys_powerdown mode);
 
diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
index 7cfadd3..c61f91a 100644
--- a/include/linux/soc/samsung/exynos-regs-pmu.h
+++ b/include/linux/soc/samsung/exynos-regs-pmu.h
@@ -146,6 +146,15 @@
 
 #define EXYNOS5_L2RSTDISABLE_VALUE		BIT(3)
 
+#define EXYNOS_INT_LOCAL_PWR_EN			0x7
+
+/*
+ *Power domain register offsets from the PD configuration register
+ */
+#define EXYNOS_PD_CONFIG			(0x0)
+#define EXYNOS_PD_STATUS			(0x4)
+#define EXYNOS_PD_OPTION			(0x8)
+
 #define S5P_PAD_RET_MAUDIO_OPTION		0x3028
 #define S5P_PAD_RET_GPIO_OPTION			0x3108
 #define S5P_PAD_RET_UART_OPTION			0x3128
-- 
1.7.9.5
