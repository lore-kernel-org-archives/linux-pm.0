From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 9/9] ARM: exynos: Move to generic power domain bindings
Date: Thu, 28 Aug 2014 10:39:02 +0200
Message-ID: <1409215142-8218-10-git-send-email-ulf.hansson@linaro.org>
References: <1409215142-8218-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1409215142-8218-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>, Tomasz Figa <t.figa@samsung.com>, linux-samsung-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Tomasz Figa <t.figa@samsung.com>

This patch moves Exynos power domain code to use the new generic power
domain look-up framework introduced in previous patches, thus also
allowing the new code to be compiled with CONFIG_ARCH_EXYNOS as well.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[Ulf:Rebased and resolved conflicts]
---
 .../bindings/arm/exynos/power_domain.txt           | 13 ++--
 arch/arm/mach-exynos/pm_domains.c                  | 78 +---------------------
 kernel/power/Kconfig                               |  2 +-
 3 files changed, 8 insertions(+), 85 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
index 8b4f7b7f..abde1ea 100644
--- a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
+++ b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
@@ -8,6 +8,8 @@ Required Properties:
     * samsung,exynos4210-pd - for exynos4210 type power domain.
 - reg: physical base address of the controller and length of memory mapped
     region.
+- #power-domain-cells: number of cells in power domain specifier;
+    must be 0.
 
 Optional Properties:
 - clocks: List of clock handles. The parent clocks of the input clocks to the
@@ -29,6 +31,7 @@ Example:
 	lcd0: power-domain-lcd0 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10023C00 0x10>;
+		#power-domain-cells = <0>;
 	};
 
 	mfc_pd: power-domain@10044060 {
@@ -37,12 +40,8 @@ Example:
 		clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MOUT_SW_ACLK333>,
 			<&clock CLK_MOUT_USER_ACLK333>;
 		clock-names = "oscclk", "pclk0", "clk0";
+		#power-domain-cells = <0>;
 	};
 
-Example of the node using power domain:
-
-	node {
-		/* ... */
-		samsung,power-domain = <&lcd0>;
-		/* ... */
-	};
+See Documentation/devicetree/bindings/power/power_domain.txt for description
+of consumer-side bindings.
diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index fd76e1b..46b6502 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -105,78 +105,6 @@ static int exynos_pd_power_off(struct generic_pm_domain *domain)
 	return exynos_pd_power(domain, false);
 }
 
-static void exynos_add_device_to_domain(struct exynos_pm_domain *pd,
-					 struct device *dev)
-{
-	int ret;
-
-	dev_dbg(dev, "adding to power domain %s\n", pd->pd.name);
-
-	while (1) {
-		ret = pm_genpd_add_device(&pd->pd, dev);
-		if (ret != -EAGAIN)
-			break;
-		cond_resched();
-	}
-
-	pm_genpd_dev_need_restore(dev, true);
-}
-
-static void exynos_remove_device_from_domain(struct device *dev)
-{
-	struct generic_pm_domain *genpd = dev_to_genpd(dev);
-	int ret;
-
-	dev_dbg(dev, "removing from power domain %s\n", genpd->name);
-
-	while (1) {
-		ret = pm_genpd_remove_device(genpd, dev);
-		if (ret != -EAGAIN)
-			break;
-		cond_resched();
-	}
-}
-
-static void exynos_read_domain_from_dt(struct device *dev)
-{
-	struct platform_device *pd_pdev;
-	struct exynos_pm_domain *pd;
-	struct device_node *node;
-
-	node = of_parse_phandle(dev->of_node, "samsung,power-domain", 0);
-	if (!node)
-		return;
-	pd_pdev = of_find_device_by_node(node);
-	if (!pd_pdev)
-		return;
-	pd = platform_get_drvdata(pd_pdev);
-	exynos_add_device_to_domain(pd, dev);
-}
-
-static int exynos_pm_notifier_call(struct notifier_block *nb,
-				    unsigned long event, void *data)
-{
-	struct device *dev = data;
-
-	switch (event) {
-	case BUS_NOTIFY_BIND_DRIVER:
-		if (dev->of_node)
-			exynos_read_domain_from_dt(dev);
-
-		break;
-
-	case BUS_NOTIFY_UNBOUND_DRIVER:
-		exynos_remove_device_from_domain(dev);
-
-		break;
-	}
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block platform_nb = {
-	.notifier_call = exynos_pm_notifier_call,
-};
-
 static __init int exynos4_pm_init_power_domain(void)
 {
 	struct platform_device *pdev;
@@ -202,7 +130,6 @@ static __init int exynos4_pm_init_power_domain(void)
 		pd->base = of_iomap(np, 0);
 		pd->pd.power_off = exynos_pd_power_off;
 		pd->pd.power_on = exynos_pd_power_on;
-		pd->pd.of_node = np;
 
 		pd->oscclk = clk_get(dev, "oscclk");
 		if (IS_ERR(pd->oscclk))
@@ -228,15 +155,12 @@ static __init int exynos4_pm_init_power_domain(void)
 			clk_put(pd->oscclk);
 
 no_clk:
-		platform_set_drvdata(pdev, pd);
-
 		on = __raw_readl(pd->base + 0x4) & INT_LOCAL_PWR_EN;
 
 		pm_genpd_init(&pd->pd, NULL, !on);
+		of_genpd_add_provider(np, of_genpd_xlate_simple, &pd->pd);
 	}
 
-	bus_register_notifier(&platform_bus_type, &platform_nb);
-
 	return 0;
 }
 arch_initcall(exynos4_pm_init_power_domain);
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 897619b..bbef57f 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -304,7 +304,7 @@ config PM_GENERIC_DOMAINS_RUNTIME
 
 config PM_GENERIC_DOMAINS_OF
 	def_bool y
-	depends on PM_GENERIC_DOMAINS && OF && !ARCH_EXYNOS
+	depends on PM_GENERIC_DOMAINS && OF
 
 config CPU_PM
 	bool
-- 
1.9.1
