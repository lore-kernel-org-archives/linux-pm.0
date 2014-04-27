From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 5/5] ARM: dove: add non-DT PMU support
Date: Sun, 27 Apr 2014 14:29:11 +0100
Message-ID: <E1WeP8p-0000Uw-7m@rmk-PC.arm.linux.org.uk>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:53704 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753188AbaD0N3P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 27 Apr 2014 09:29:15 -0400
In-Reply-To: <20140427132312.GC26756@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>

Since Dove has non-DT support still, this patch adds the static data
to the PMU driver in order to initialise PMU domains.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-dove/pmu.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-dove/pmu.c b/arch/arm/mach-dove/pmu.c
index 0b3201fa2d5c..9832044dbab9 100644
--- a/arch/arm/mach-dove/pmu.c
+++ b/arch/arm/mach-dove/pmu.c
@@ -226,6 +226,20 @@ static void __pmu_domain_register(struct pmu_domain *domain)
 	pm_genpd_init(&domain->base, NULL, !(val & domain->pwr_mask));
 }
 
+static void pmu_domain_register(struct pmu_data *pmu,
+	const struct pmu_domain *pmu_dom)
+{
+	struct pmu_domain *domain;
+
+	domain = kmemdup(pmu_dom, sizeof(*domain), GFP_KERNEL);
+	if (!domain)
+		return;
+
+	domain->pmu = pmu;
+
+	__pmu_domain_register(domain);
+}
+
 static void pmu_add_genpd_of(struct device *dev)
 {
 	struct device_node *node;
@@ -241,6 +255,15 @@ static void pmu_add_genpd_of(struct device *dev)
 	}
 }
 
+static void pmu_add_genpd_name(const char *name, struct device *dev)
+{
+	while (1) {
+		if (pm_genpd_name_add_device(name, dev) != -EAGAIN)
+			break;
+		cond_resched();
+	}
+}
+
 static void pmu_remove_genpd(struct device *dev)
 {
 	struct generic_pm_domain *genpd = dev_to_genpd(dev);
@@ -256,11 +279,19 @@ static int pmu_platform_call(struct notifier_block *nb,
 	unsigned long event, void *data)
 {
 	struct device *dev = data;
+	const char *name = NULL;
+
+	if (strcmp(dev_name(dev), "ap510-vmeta.0") == 0)
+		name = "vpu";
+	else if (strcmp(dev_name(dev), "galcore.0") == 0)
+		name = "gpu";
 
 	switch (event) {
 	case BUS_NOTIFY_ADD_DEVICE:
 		if (dev->of_node)
 			pmu_add_genpd_of(dev);
+		else if (name)
+			pmu_add_genpd_name(name, dev);
 		break;
 
 	case BUS_NOTIFY_DEL_DEVICE:
@@ -363,6 +394,49 @@ static int __init dove_init_pmu_irq(struct pmu_data *pmu, int irq)
 	return 0;
 }
 
+static struct pmu_data pmu_data = {
+	.lock = __SPIN_LOCK_UNLOCKED(&pmu.lock),
+	.pmc_base = DOVE_PMU_VIRT_BASE,
+	.pmu_base = DOVE_PMU_VIRT_BASE + 0x8000,
+};
+
+static struct pmu_domain vpu_domain = {
+	.pwr_mask = PMU_PWR_DOWN_VPU,
+	.rst_mask = PMU_SW_RST_VIDEO_MASK,
+	.iso_mask = PMU_ISO_VPU,
+	.base = {
+		.name = "vpu",
+	},
+};
+
+static struct pmu_domain gpu_domain = {
+	.pwr_mask = PMU_PWR_DOWN_GPU,
+	.rst_mask = PMU_SW_RST_GPU_MASK,
+	.iso_mask = PMU_ISO_GPU,
+	.base = {
+		.name = "gpu",
+	},
+};
+
+static int __init dove_pmu_init_legacy(void)
+{
+	struct pmu_data *pmu = &pmu_data;
+	int ret, parent_irq;
+
+	pmu_reset_init(pmu);
+	pmu_domain_register(pmu, &vpu_domain);
+	pmu_domain_register(pmu, &gpu_domain);
+	pm_genpd_poweroff_unused();
+
+	ret = dove_init_pmu_irq(pmu, IRQ_DOVE_PMU);
+	if (ret)
+		pr_err("dove_init_pmu_irq() failed: %d\n", ret);
+
+	bus_register_notifier(&platform_bus_type, &platform_nb);
+
+	return 0;
+}
+
 /*
  * pmu {
  *	compatible = "marvell,pmu";
@@ -390,7 +464,7 @@ int __init dove_init_pmu(void)
 	/* Lookup the PMU node */
 	np_pmu = of_find_compatible_node(NULL, NULL, "marvell,pmu");
 	if (!np_pmu)
-		return 0;
+		return dove_pmu_init_legacy();
 
 	pmu = kzalloc(sizeof(*pmu), GFP_KERNEL);
 	if (!pmu)
-- 
1.8.3.1

