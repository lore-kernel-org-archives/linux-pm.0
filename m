From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH 05/12] arm: exynos: Add platform driver support for power
 domain driver
Date: Mon, 03 Nov 2014 09:23:03 +0530
Message-ID: <1414986790-11940-6-git-send-email-amit.daniel@samsung.com>
References: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: kgene.kim@samsung.com, pankaj.dubey@samsung.com, Amit Daniel Kachhap <amit.daniel@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch modifies Exynos Power Domain driver initialization
implementation in following way:

   - Added platform driver support and probe function where Exynos
     PM Domain driver will register itself as MFD PMU client
     driver.
   - This driver will now use the PMU base address with certain offset
     for power domain register address so reg property is not required.
     This change will avoid unnecessary ioremap of the power register.
   - PMU base address is directly accessed and syscon interface is
     not used as PM Domain driver is quite critical and syscon based
     lock protected register access(regmap) is not used.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 .../bindings/arm/exynos/power_domain.txt           |    8 +--
 arch/arm/mach-exynos/pm_domains.c                  |   59 ++++++++++++++------
 2 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
index abde1ea..5599017 100644
--- a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
+++ b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
@@ -6,8 +6,8 @@ to gate power to one or more peripherals on the processor.
 Required Properties:
 - compatible: should be one of the following.
     * samsung,exynos4210-pd - for exynos4210 type power domain.
-- reg: physical base address of the controller and length of memory mapped
-    region.
+- pd-offset: this gives the offset of PM power domain register from
+	     the PMU base address.
 - #power-domain-cells: number of cells in power domain specifier;
     must be 0.
 
@@ -30,13 +30,13 @@ Example:
 
 	lcd0: power-domain-lcd0 {
 		compatible = "samsung,exynos4210-pd";
-		reg = <0x10023C00 0x10>;
+		pd-offset = <0x3C00>;
 		#power-domain-cells = <0>;
 	};
 
 	mfc_pd: power-domain@10044060 {
 		compatible = "samsung,exynos4210-pd";
-		reg = <0x10044060 0x20>;
+		pd-offset = <0x4060>;
 		clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MOUT_SW_ACLK333>,
 			<&clock CLK_MOUT_USER_ACLK333>;
 		clock-names = "oscclk", "pclk0", "clk0";
diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 20f2671..923eb57 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -22,6 +22,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/sched.h>
+#include <linux/mfd/samsung/exynos-pmu.h>
 
 #define INT_LOCAL_PWR_EN	0x7
 #define MAX_CLK_PER_DOMAIN	4
@@ -105,33 +106,41 @@ static int exynos_pd_power_off(struct generic_pm_domain *domain)
 	return exynos_pd_power(domain, false);
 }
 
-static __init int exynos4_pm_init_power_domain(void)
+static int exynos_power_domain_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev;
 	struct device_node *np;
+	struct pmu_dev_client_data *pdata = NULL;
+	void __iomem *pmu_base_addr;
+	unsigned int offset;
+
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		dev_err(&pdev->dev, "No platform data passed\n");
+		return -EINVAL;
+	}
+
+	pmu_base_addr = pdata->mem_base_addr;
 
 	for_each_compatible_node(np, NULL, "samsung,exynos4210-pd") {
 		struct exynos_pm_domain *pd;
 		int on, i;
-		struct device *dev;
 
-		pdev = of_find_device_by_node(np);
-		dev = &pdev->dev;
-
-		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
-		if (!pd) {
-			pr_err("%s: failed to allocate memory for domain\n",
-					__func__);
+		pd = devm_kzalloc(&pdev->dev, sizeof(*pd), GFP_KERNEL);
+		if (!pd)
 			return -ENOMEM;
-		}
 
 		pd->pd.name = kstrdup(np->name, GFP_KERNEL);
 		pd->name = pd->pd.name;
-		pd->base = of_iomap(np, 0);
+		if (of_property_read_u32(np, "pd-offset", &offset)) {
+			pr_err("%s: failed to find offset for power domain\n",
+					__func__);
+			return -EINVAL;
+		}
+		pd->base = pmu_base_addr + offset;
 		pd->pd.power_off = exynos_pd_power_off;
 		pd->pd.power_on = exynos_pd_power_on;
 
-		pd->oscclk = clk_get(dev, "oscclk");
+		pd->oscclk = of_clk_get_by_name(np, "oscclk");
 		if (IS_ERR(pd->oscclk))
 			goto no_clk;
 
@@ -139,11 +148,11 @@ static __init int exynos4_pm_init_power_domain(void)
 			char clk_name[8];
 
 			snprintf(clk_name, sizeof(clk_name), "clk%d", i);
-			pd->clk[i] = clk_get(dev, clk_name);
+			pd->clk[i] = of_clk_get_by_name(np, clk_name);
 			if (IS_ERR(pd->clk[i]))
 				break;
 			snprintf(clk_name, sizeof(clk_name), "pclk%d", i);
-			pd->pclk[i] = clk_get(dev, clk_name);
+			pd->pclk[i] = of_clk_get_by_name(np, clk_name);
 			if (IS_ERR(pd->pclk[i])) {
 				clk_put(pd->clk[i]);
 				pd->clk[i] = ERR_PTR(-EINVAL);
@@ -163,4 +172,22 @@ no_clk:
 
 	return 0;
 }
-arch_initcall(exynos4_pm_init_power_domain);
+
+static const struct platform_device_id exynos_power_domain_id[] = {
+	{ "exynos-pmu-domain"},
+	{ },
+};
+
+static struct platform_driver exynos_power_domain_driver = {
+	.driver  = {
+		.name   = "exynos-pd",
+	},
+	.probe = exynos_power_domain_probe,
+	.id_table = exynos_power_domain_id,
+};
+
+static int __init exynos_power_domain_init(void)
+{
+	return platform_driver_register(&exynos_power_domain_driver);
+}
+postcore_initcall(exynos_power_domain_init);
-- 
1.7.9.5
