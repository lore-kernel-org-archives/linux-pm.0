From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH RFC v2 01/12] arm: exynos: Add platform driver support for
 power domain driver
Date: Mon, 24 Nov 2014 18:34:05 +0530
Message-ID: <1416834256-11225-1-git-send-email-amit.daniel@samsung.com>
References: <1416833572-6880-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1416833572-6880-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: kgene.kim@samsung.com, linux-kernel@vger.kernel.org, s.nawrocki@samsung.com, pankaj.dubey@samsung.com, ulf.hansson@linaro.org, khilman@kernel.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, rjw@rjwysocki.net, devicetree@vger.kernel.org, Amit Daniel Kachhap <amit.daniel@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch modifies Exynos Power Domain driver initialization
implementation in following way:

   - Added platform driver support and probe function where Exynos PM
     Domain driver will finally register itself as MFD PMU client driver.
     In this way,all the Exynos power domains are probed once and registered
     with the power domain subsystem.
   - Existing DT bindings are used.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm/mach-exynos/pm_domains.c |   40 +++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 20f2671..5cb5440 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -105,25 +105,17 @@ static int exynos_pd_power_off(struct generic_pm_domain *domain)
 	return exynos_pd_power(domain, false);
 }
 
-static __init int exynos4_pm_init_power_domain(void)
+static int exynos_power_domain_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev;
 	struct device_node *np;
 
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
@@ -131,7 +123,7 @@ static __init int exynos4_pm_init_power_domain(void)
 		pd->pd.power_off = exynos_pd_power_off;
 		pd->pd.power_on = exynos_pd_power_on;
 
-		pd->oscclk = clk_get(dev, "oscclk");
+		pd->oscclk = of_clk_get_by_name(np, "oscclk");
 		if (IS_ERR(pd->oscclk))
 			goto no_clk;
 
@@ -139,11 +131,11 @@ static __init int exynos4_pm_init_power_domain(void)
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
@@ -163,4 +155,22 @@ no_clk:
 
 	return 0;
 }
-arch_initcall(exynos4_pm_init_power_domain);
+
+static const struct platform_device_id exynos_power_domain_id[] = {
+	{ "exynos-pmu-pd"},
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
