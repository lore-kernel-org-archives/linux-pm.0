From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH v3 3/4] ARM: EXYNOS: pm_domain: Bind devices to power domains
 using DT
Date: Tue, 13 Nov 2012 13:51:54 +0100
Message-ID: <1352811115-1198-4-git-send-email-t.figa@samsung.com>
References: <1352811115-1198-1-git-send-email-t.figa@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:29046 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149Ab2KMMwx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Nov 2012 07:52:53 -0500
In-reply-to: <1352811115-1198-1-git-send-email-t.figa@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com, kgene.kim@samsung.com, thomas.abraham@linaro.org, rjw@sisk.pl, m.szyprowski@samsung.com, t.figa@samsung.com, tomasz.figa@gmail.com

This patch adds a way to specify bindings between devices and power
domains using device tree.

A device can be bound to particular power domain by adding a
power-domain property containing a phandle to the domain. The device
will be bound to the domain before binding a driver to it and unbound
after unbinding a driver from it.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 .../bindings/arm/exynos/power_domain.txt           | 13 +++-
 arch/arm/mach-exynos/pm_domains.c                  | 82 ++++++++++++++++++++++
 2 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
index 843b546..8ed914f 100644
--- a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
+++ b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
@@ -4,14 +4,25 @@ Exynos processors include support for multiple power domains which are used
 to gate power to one or more peripherals on the processor.
 
 Required Properties:
-- compatiable: should be one of the following.
+- compatible: should be one of the following.
     * samsung,exynos4210-pd - for exynos4210 type power domain.
 - reg: physical base address of the controller and length of memory mapped
     region.
 
+Node of a device using power domains must have a power-domain property defined
+with a phandle to respective power domain.
+
 Example:
 
 	lcd0: power-domain-lcd0 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10023C00 0x10>;
 	};
+
+Example of the node using power domain:
+
+	node {
+		/* ... */
+		power-domain = <&lcd0>;
+		/* ... */
+	};
diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 5b7ce7e..7b3b8a3 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -19,6 +19,8 @@
 #include <linux/pm_domain.h>
 #include <linux/delay.h>
 #include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/sched.h>
 
 #include <mach/regs-pmu.h>
 #include <plat/devs.h>
@@ -83,14 +85,89 @@ static struct exynos_pm_domain PD = {			\
 }
 
 #ifdef CONFIG_OF
+static void exynos_add_device_to_domain(struct exynos_pm_domain *pd,
+							struct device *dev)
+{
+	int ret;
+
+	dev_dbg(dev, "adding to power domain %s\n", pd->pd.name);
+
+	while(1) {
+		ret = pm_genpd_add_device(&pd->pd, dev);
+		if (ret != -EAGAIN)
+			break;
+		cond_resched();
+	}
+
+	pm_genpd_dev_need_restore(dev, true);
+}
+
+static void exynos_remove_device_from_domain(struct device *dev)
+{
+	struct generic_pm_domain *genpd = dev_to_genpd(dev);
+	int ret;
+
+	dev_dbg(dev, "removing from power domain %s\n", genpd->name);
+
+	while(1) {
+		ret = pm_genpd_remove_device(genpd, dev);
+		if (ret != -EAGAIN)
+			break;
+		cond_resched();
+	}
+}
+
+static void exynos_read_domain_from_dt(struct device *dev)
+{
+	struct platform_device *pd_pdev;
+	struct exynos_pm_domain *pd;
+	struct device_node *node;
+
+	node = of_parse_phandle(dev->of_node, "power-domain", 0);
+	if (!node)
+		return;
+	pd_pdev = of_find_device_by_node(node);
+	if (!pd_pdev)
+		return;
+	pd = platform_get_drvdata(pd_pdev);
+	exynos_add_device_to_domain(pd, dev);
+}
+
+static int exynos_pm_notifier_call(struct notifier_block *nb,
+				    unsigned long event, void *data)
+{
+	struct device *dev = data;
+
+	switch (event) {
+	case BUS_NOTIFY_BIND_DRIVER:
+		if (dev->of_node)
+			exynos_read_domain_from_dt(dev);
+
+		break;
+
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		exynos_remove_device_from_domain(dev);
+
+		break;
+	}
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block platform_nb = {
+	.notifier_call = exynos_pm_notifier_call,
+};
+
 static __init int exynos_pm_dt_parse_domains(void)
 {
+	struct platform_device *pdev;
 	struct device_node *np;
 
 	for_each_compatible_node(np, NULL, "samsung,exynos4210-pd") {
 		struct exynos_pm_domain *pd;
 		int on;
 
+		pdev = of_find_device_by_node(np);
+
 		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
 		if (!pd) {
 			pr_err("%s: failed to allocate memory for domain\n",
@@ -105,10 +182,15 @@ static __init int exynos_pm_dt_parse_domains(void)
 		pd->pd.power_on = exynos_pd_power_on;
 		pd->pd.of_node = np;
 
+		platform_set_drvdata(pdev, pd);
+
 		on = __raw_readl(pd->base + 0x4) & S5P_INT_LOCAL_PWR_EN;
 
 		pm_genpd_init(&pd->pd, NULL, !on);
 	}
+
+	bus_register_notifier(&platform_bus_type, &platform_nb);
+
 	return 0;
 }
 #else
-- 
1.8.0

