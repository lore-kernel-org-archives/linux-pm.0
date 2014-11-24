From: Amit Daniel Kachhap <amit.daniel-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH RFC v2 11/12] drivers: soc: samsung: Add support for clock rate
 save/restore in power domain
Date: Mon, 24 Nov 2014 18:34:15 +0530
Message-ID: <1416834256-11225-11-git-send-email-amit.daniel@samsung.com>
References: <1416833572-6880-1-git-send-email-amit.daniel@samsung.com>
 <1416834256-11225-1-git-send-email-amit.daniel@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1416834256-11225-1-git-send-email-amit.daniel-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, pankaj.dubey-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Amit Daniel Kachhap <amit.daniel-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

While turning power domain to on/off, some clocks rates might change and
need to be saved/restored in the Exynos7 SOC. This patch adds the
framework for saving those clocks before power off and restoring it back
after power on operation.

Signed-off-by: Amit Daniel Kachhap <amit.daniel-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 .../bindings/arm/exynos/power_domain.txt           |    7 ++
 drivers/soc/samsung/pm_domains.c                   |   74 ++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
index c48769e..97fec1b 100644
--- a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
+++ b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
@@ -32,6 +32,11 @@ Optional Properties:
 	before turning off a power domain.
 - pd-off-en-clock-names: clocks can be specified as,
 	- clkN: N can vary between 0-30.
+- pd-rate-clocks: List of clock handles. The rates of these clocks are required
+	to be saved before turning off a power domain and restoring after turning
+	on a power domain.
+- pd-rate-clock-names: clocks can be specified as,
+	- clkN: N can vary between 0-30.
 - parents: phandle of parent power domains.
 
 Node of a device using power domains must have a samsung,power-domain property
@@ -55,6 +60,8 @@ Example:
 		pd-on-en-clock-names = "clk0", "clk1";
 		pd-off-en-clocks = <&clock CLK_IP1>, <&clock CLK_IP2>,
 		pd-off-en-clock-names = "clk0", "clk1";
+		pd-rate-clocks = <&clock CLK_IP3>, <&clock CLK_IP4>,
+		pd-rate-clock-names = "clk0", "clk1";
 		#power-domain-cells = <0>;
 	};
 
diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
index 5407eb7..a235277 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -36,6 +36,12 @@ struct clk_enable_list {
 	unsigned int en_status;
 };
 
+struct clk_rate_list {
+	struct clk **clks;
+	unsigned int *rates;
+	unsigned int count;
+};
+
 struct clk_parent_list {
 	struct clk **clks;
 	struct clk **parent_clks;
@@ -53,6 +59,7 @@ struct exynos_pm_domain {
 	struct generic_pm_domain pd;
 	struct clk_enable_list *clk_pd_on;
 	struct clk_enable_list *clk_pd_off;
+	struct clk_rate_list *clk_rate;
 	struct clk_parent_list *clk_parent;
 };
 
@@ -198,6 +205,49 @@ static int pd_init_parent_clocks(struct platform_device *pdev,
 	return 0;
 }
 
+static int pd_init_rate_clocks(struct platform_device *pdev,
+		struct device_node *np, struct exynos_pm_domain *pd)
+{
+	struct clk_rate_list *list;
+	char propname[32], clk_name[8];
+	int count, i;
+	struct clk *clk = ERR_PTR(-ENOENT);
+
+	list = devm_kzalloc(&pdev->dev, sizeof(*list), GFP_KERNEL);
+	if (!list)
+		return -ENOMEM;
+
+	pd->clk_rate = list;
+	snprintf(propname, sizeof(propname), "pd-rate-clock-names");
+
+	count = of_property_count_strings(np, propname);
+	if (!count || count > MAX_CLK_PER_DOMAIN)
+		return -EINVAL;
+
+	list->count = count;
+	list->clks = devm_kzalloc(&pdev->dev, sizeof(*list->clks) * count,
+				GFP_KERNEL);
+	if (!list->clks)
+		return -ENOMEM;
+
+	list->rates = devm_kzalloc(&pdev->dev, sizeof(list->rates) * count,
+				GFP_KERNEL);
+	if (!list->rates)
+		return -ENOMEM;
+
+	for (i = 0; i < count; i++) {
+		snprintf(clk_name, sizeof(clk_name), "clk%d", i);
+		clk = exynos_pd_clk_get(np, "pd-rate", clk_name);
+		if (IS_ERR(clk)) {
+			dev_err(&pdev->dev, "%s clock not found\n", clk_name);
+			return -EINVAL;
+		}
+		list->clks[i] = clk;
+	}
+	dev_info(&pdev->dev, "pd rate clocks initialised\n");
+	return 0;
+}
+
 static void exynos_pd_poweron_prepare(struct exynos_pm_domain *pd)
 {
 	struct clk_enable_list *en_list;
@@ -220,6 +270,7 @@ static void exynos_pd_post_poweron(struct exynos_pm_domain *pd)
 {
 	struct clk_parent_list *p_list;
 	struct clk_enable_list *en_list;
+	struct clk_rate_list *rt_list;
 	int i;
 
 	p_list = pd->clk_parent;
@@ -229,6 +280,17 @@ static void exynos_pd_post_poweron(struct exynos_pm_domain *pd)
 			clk_set_parent(p_list->clks[i], p_list->parent_clks[i]);
 	}
 
+	rt_list = pd->clk_rate;
+	if (rt_list) {
+		/* restore the rate from the rate clock list */
+		for (i = 0; i < rt_list->count; i++) {
+			if (!rt_list->rates[i])
+				continue;
+			clk_set_rate(rt_list->clks[i], rt_list->rates[i]);
+			rt_list->rates[i] = 0;
+		}
+	}
+
 	en_list = pd->clk_pd_on;
 	if (!en_list)
 		return;
@@ -246,6 +308,7 @@ static void exynos_pd_poweroff_prepare(struct exynos_pm_domain *pd)
 {
 	struct clk_parent_list *p_list;
 	struct clk_enable_list *en_list;
+	struct clk_rate_list *rt_list;
 	int i;
 
 	en_list = pd->clk_pd_off;
@@ -259,6 +322,13 @@ static void exynos_pd_poweroff_prepare(struct exynos_pm_domain *pd)
 		}
 	}
 
+	rt_list = pd->clk_rate;
+	if (rt_list) {
+		/* save the rate from the rate clock list */
+		for (i = 0; i < rt_list->count; i++)
+			rt_list->rates[i] = clk_get_rate(rt_list->clks[i]);
+	}
+
 	p_list = pd->clk_parent;
 	if (!p_list)
 		return;
@@ -366,6 +436,10 @@ static int exynos_power_domain_probe(struct platform_device *pdev)
 			if (pd_init_parent_clocks(pdev, np, pd))
 				return -EINVAL;
 
+		if (of_find_property(np, "pd-rate-clocks", NULL))
+			if (pd_init_rate_clocks(pdev, np, pd))
+				return -EINVAL;
+
 		on = pd_ops->pd_status(pd->base);
 
 		pm_genpd_init(&pd->pd, NULL, !on);
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
