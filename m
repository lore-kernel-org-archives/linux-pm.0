From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH 08/12] soc: samsung: pm_domain: Add a new parameter for power
 configuration
Date: Mon, 03 Nov 2014 09:23:06 +0530
Message-ID: <1414986790-11940-9-git-send-email-amit.daniel@samsung.com>
References: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: kgene.kim@samsung.com, pankaj.dubey@samsung.com, Amit Daniel Kachhap <amit.daniel@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch adds a new optional parameter "pd-power-conf" to fetch the
correct power configuration value. In exynos7 soc, this field is
different from previous exynos soc's.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 .../bindings/arm/exynos/power_domain.txt           |    3 +++
 drivers/soc/samsung/pm_domains.c                   |   13 +++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
index 7250a5c..07e4ffe 100644
--- a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
+++ b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
@@ -24,6 +24,8 @@ Optional Properties:
 	- pclkN, clkN: Pairs of parent of input clock and input clock to the
 		devices in this power domain. Maximum of 4 pairs (N = 0 to 3)
 		are supported currently.
+- pd-power-conf: This optional parameter provides the local power configuration
+	value for the power domain.
 
 Node of a device using power domains must have a samsung,power-domain property
 defined with a phandle to respective power domain.
@@ -48,6 +50,7 @@ Example:
 	mfc_pd: power-domain@10044060 {
 		compatible = "samsung,exynos4210-pd", "samsung,exynos7-pd-mfc";
 		pd-offset = <0x4060>;
+		pd-power-conf = <0xf>;
 		#power-domain-cells = <0>;
 	};
 
diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
index e63d129..84a3f1f 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -34,6 +34,7 @@ struct exynos_pm_domain {
 	void __iomem *base;
 	char const *name;
 	bool is_off;
+	unsigned int pwr_conf_val;
 	struct generic_pm_domain pd;
 	struct clk *oscclk;
 	struct clk *clk[MAX_CLK_PER_DOMAIN];
@@ -63,13 +64,13 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 		}
 	}
 
-	pwr = power_on ? INT_LOCAL_PWR_EN : 0;
+	pwr = power_on ? pd->pwr_conf_val : 0;
 	__raw_writel(pwr, base);
 
 	/* Wait max 1ms */
 	timeout = 10;
 
-	while ((__raw_readl(base + 0x4) & INT_LOCAL_PWR_EN) != pwr) {
+	while ((__raw_readl(base + 0x4) & pd->pwr_conf_val) != pwr) {
 		if (!timeout) {
 			op = (power_on) ? "enable" : "disable";
 			pr_err("Power domain %s %s failed\n", domain->name, op);
@@ -111,7 +112,7 @@ static int exynos_power_domain_probe(struct platform_device *pdev)
 	struct device_node *np;
 	struct pmu_dev_client_data *pdata = NULL;
 	void __iomem *pmu_base_addr;
-	unsigned int offset;
+	unsigned int offset, pwr_conf;
 
 	pdata = pdev->dev.platform_data;
 	if (!pdata) {
@@ -141,9 +142,13 @@ static int exynos_power_domain_probe(struct platform_device *pdev)
 					__func__);
 			return -EINVAL;
 		}
+		if (of_property_read_u32(np, "pd-power-conf", &pwr_conf))
+			pwr_conf = INT_LOCAL_PWR_EN;
+
 		pd->base = pmu_base_addr + offset;
 		pd->pd.power_off = exynos_pd_power_off;
 		pd->pd.power_on = exynos_pd_power_on;
+		pd->pwr_conf_val = pwr_conf;
 
 		pd->oscclk = of_clk_get_by_name(np, "oscclk");
 		if (IS_ERR(pd->oscclk))
@@ -169,7 +174,7 @@ static int exynos_power_domain_probe(struct platform_device *pdev)
 			clk_put(pd->oscclk);
 
 no_clk:
-		on = __raw_readl(pd->base + 0x4) & INT_LOCAL_PWR_EN;
+		on = __raw_readl(pd->base + 0x4) & pwr_conf;
 
 		pm_genpd_init(&pd->pd, NULL, !on);
 		of_genpd_add_provider_simple(np, &pd->pd);
-- 
1.7.9.5
