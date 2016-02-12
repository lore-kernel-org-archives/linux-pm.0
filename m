From: Lina Iyer <lina.iyer@linaro.org>
Subject: [RFC v2 03/12] PM / cpu_domains: Setup PM domains for CPUs/clusters
Date: Fri, 12 Feb 2016 13:50:29 -0700
Message-ID: <1455310238-8963-4-git-send-email-lina.iyer@linaro.org>
References: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35793 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbcBLUvW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2016 15:51:22 -0500
Received: by mail-pf0-f179.google.com with SMTP id c10so53772360pfc.2
        for <linux-pm@vger.kernel.org>; Fri, 12 Feb 2016 12:51:21 -0800 (PST)
In-Reply-To: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

Define and add Generic PM domains (genpd) for CPU clusters. Many new
SoCs group CPUs as clusters. Clusters share common resources like power
rails, caches, VFP, Coresight etc. When all CPUs in the cluster are
idle, these shared resources may also be put in their idle state.

CPUs may be associated with their domain providers in DT. The domains in
turn may be associated with their providers. This is clean way to model
the cluster hierarchy like that of ARM's big.little architecture.

For each CPU in the DT, we identify the domain provider; initialize and
register the PM domain if isn't already registered and attach all the
CPU devices to the domain. Usually, when there are multiple clusters of
CPUs, there is a top level coherency domain that is dependent on these
individual domains. All domains thus created are marked IRQ safe
automatically and therefore may be powered down when the CPUs in the
domain are powered down by cpuidle.

Reading DT, initializing Generic PM domains, attaching CPUs to it
domains are common functionalities across ARM SoCs. Provide a common set
of APIs to setup PM domains for CPU clusters and its parents. The
platform drivers may just call of_setup_cpu_pd() to do a single step
setup of CPU domains.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Suggested-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
Changes since RFC v1 -
- Initialize down up, start with CPUs, identify and create domains
- Clean up of the API
- Two simple API for setting up CPU PM domains
- File name change: cpu-pd.[ch] ->cpu_domains.[ch]
- Depends on CONFIG_PM_GENERIC_DOMAINS_OF only
- cpu_pd_ops abstracts generic pm domains
- platform code does not know about genpd object used inside
- simplification and bug fixes

 drivers/base/power/Makefile      |   1 +
 drivers/base/power/cpu_domains.c | 267 +++++++++++++++++++++++++++++++++++++++
 include/linux/cpu_domains.h      |  33 +++++
 3 files changed, 301 insertions(+)
 create mode 100644 drivers/base/power/cpu_domains.c
 create mode 100644 include/linux/cpu_domains.h

diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
index 5998c53..9883e89 100644
--- a/drivers/base/power/Makefile
+++ b/drivers/base/power/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o
 obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
 obj-$(CONFIG_PM_OPP)	+= opp/
 obj-$(CONFIG_PM_GENERIC_DOMAINS)	+=  domain.o domain_governor.o
+obj-$(CONFIG_PM_GENERIC_DOMAINS_OF)	+= cpu_domains.o
 obj-$(CONFIG_HAVE_CLK)	+= clock_ops.o
 
 ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
diff --git a/drivers/base/power/cpu_domains.c b/drivers/base/power/cpu_domains.c
new file mode 100644
index 0000000..981592f
--- /dev/null
+++ b/drivers/base/power/cpu_domains.c
@@ -0,0 +1,267 @@
+/*
+ * drivers/base/power/cpu_domains.c - Helper functions to create CPU PM domains.
+ *
+ * Copyright (C) 2016 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/cpu.h>
+#include <linux/cpu_domains.h>
+#include <linux/cpu_pm.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/of.h>
+#include <linux/pm_domain.h>
+#include <linux/rculist.h>
+#include <linux/rcupdate.h>
+#include <linux/slab.h>
+
+#define CPU_PD_NAME_MAX 36
+
+struct cpu_pm_domain {
+	struct list_head link;
+	struct cpu_pd_ops ops;
+	struct generic_pm_domain *genpd;
+	struct cpu_pm_domain *parent;
+};
+
+/* List of CPU PM domains we care about */
+static LIST_HEAD(of_cpu_pd_list);
+static DEFINE_SPINLOCK(cpu_pd_list_lock);
+
+static inline
+struct cpu_pm_domain *to_cpu_pd(struct generic_pm_domain *d)
+{
+	struct cpu_pm_domain *pd;
+	struct cpu_pm_domain *res = NULL;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(pd, &of_cpu_pd_list, link)
+		if (pd->genpd == d) {
+			res = pd;
+			break;
+		}
+	rcu_read_unlock();
+
+	return res;
+}
+
+static int cpu_pd_attach_cpu(int cpu)
+{
+	int ret;
+	struct device *cpu_dev;
+
+	cpu_dev = get_cpu_device(cpu);
+	if (!cpu_dev) {
+		pr_warn("%s: Unable to get device for CPU%d\n",
+				__func__, cpu);
+		return -ENODEV;
+	}
+
+	ret = genpd_dev_pm_attach(cpu_dev);
+	if (ret)
+		dev_warn(cpu_dev,
+			"%s: Unable to attach to power-domain: %d\n",
+			__func__, ret);
+	else
+		dev_dbg(cpu_dev, "Attached to domain\n");
+
+	return ret;
+}
+
+static int cpu_pd_power_on(struct generic_pm_domain *genpd)
+{
+	struct cpu_pm_domain *pd = to_cpu_pd(genpd);
+
+	return pd->ops.power_on();
+}
+
+static int cpu_pd_power_off(struct generic_pm_domain *genpd)
+{
+	struct cpu_pm_domain *pd = to_cpu_pd(genpd);
+
+	return pd->ops.power_off(genpd->state_idx,
+			genpd->states[genpd->state_idx].param);
+}
+
+/**
+ * of_init_cpu_pm_domain() - Initialize a CPU PM domain from a device node
+ *
+ * @dn: The domain provider's device node
+ * @ops: The power_on/_off callbacks for the domain
+ *
+ * Returns the generic_pm_domain (genpd) pointer to the domain on success
+ */
+static struct generic_pm_domain *of_init_cpu_pm_domain(struct device_node *dn,
+				const struct cpu_pd_ops *ops)
+{
+	struct cpu_pm_domain *pd = NULL;
+	struct generic_pm_domain *genpd = NULL;
+	int ret = -ENOMEM;
+
+	if (!of_device_is_available(dn))
+		return ERR_PTR(-ENODEV);
+
+	genpd = kzalloc(sizeof(*(genpd)), GFP_KERNEL);
+	if (!genpd)
+		goto fail;
+
+	genpd->name = kstrndup(dn->full_name, CPU_PD_NAME_MAX, GFP_KERNEL);
+	if (!genpd->name)
+		goto fail;
+
+	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		goto fail;
+
+	pd->genpd = genpd;
+	pd->genpd->power_off = cpu_pd_power_off;
+	pd->genpd->power_on = cpu_pd_power_on;
+	pd->genpd->flags |= GENPD_FLAG_IRQ_SAFE;
+	pd->ops.power_on = ops->power_on;
+	pd->ops.power_off = ops->power_off;
+
+	INIT_LIST_HEAD_RCU(&pd->link);
+	spin_lock(&cpu_pd_list_lock);
+	list_add_rcu(&pd->link, &of_cpu_pd_list);
+	spin_unlock(&cpu_pd_list_lock);
+
+	/* Register the CPU genpd */
+	pr_debug("adding %s as CPU PM domain.\n", pd->genpd->name);
+	ret = of_pm_genpd_init(dn, pd->genpd, &simple_qos_governor, false);
+	if (ret) {
+		pr_err("Unable to initialize domain %s\n", dn->full_name);
+		goto fail;
+	}
+
+	ret = of_genpd_add_provider_simple(dn, pd->genpd);
+	if (ret)
+		pr_warn("Unable to add genpd %s as provider\n",
+				pd->genpd->name);
+
+	return pd->genpd;
+fail:
+
+	kfree(genpd);
+	kfree(genpd->name);
+	kfree(pd);
+	return ERR_PTR(ret);
+}
+
+static struct generic_pm_domain *of_get_cpu_domain(struct device_node *dn,
+		const struct cpu_pd_ops *ops, int cpu)
+{
+	struct of_phandle_args args;
+	struct generic_pm_domain *genpd, *parent;
+	int ret;
+
+	/* Do we have this domain? If not, create the domain */
+	args.np = dn;
+	args.args_count = 0;
+
+	genpd = of_genpd_get_from_provider(&args);
+	if (!IS_ERR(genpd))
+		goto skip_parent;
+
+	genpd = of_init_cpu_pm_domain(dn, ops);
+	if (IS_ERR(genpd))
+		return genpd;
+
+	/* Is there a domain provider for this domain? */
+	ret = of_parse_phandle_with_args(dn, "power-domains",
+			"#power-domain-cells", 0, &args);
+	of_node_put(dn);
+	if (ret < 0)
+		goto skip_parent;
+
+	/* Find its parent and attach this domain to it, recursively */
+	parent = of_get_cpu_domain(args.np, ops, cpu);
+	if (IS_ERR(parent)) {
+		struct cpu_pm_domain *cpu_pd, *parent_cpu_pd;
+
+		ret = pm_genpd_add_subdomain(genpd, parent);
+		if (ret) {
+			pr_err("%s: Unable to add sub-domain (%s) to parent (%s)\n err: %d",
+					__func__, genpd->name, parent->name,
+					ret);
+			return ERR_PTR(ret);
+		}
+
+		/*
+		 * Reference parent domain for easy access.
+		 * Note: We could be attached to a domain that is not a
+		 * CPU PM domain in that case dont reference the parent.
+		 */
+		cpu_pd = to_cpu_pd(genpd);
+		parent_cpu_pd = to_cpu_pd(parent);
+
+		if (cpu_pd && parent_cpu_pd)
+			cpu_pd->parent = parent_cpu_pd;
+	}
+
+skip_parent:
+	return genpd;
+}
+
+/**
+ * of_setup_cpu_pd_single() - Setup the PM domains for a CPU
+ *
+ * @cpu: The CPU for which the PM domain is to be set up.
+ * @ops: The PM domain suspend/resume ops for the CPU's domain
+ *
+ * If the CPU PM domain exists already, then the CPU is attached to
+ * that CPU PD. If it doesn't, the domain is created, the @ops are
+ * set for power_on/power_off callbacks and then the CPU is attached
+ * to that domain. If the domain was created outside this framework,
+ * then we do not attach the CPU to the domain.
+ */
+int of_setup_cpu_pd_single(int cpu, const struct cpu_pd_ops *ops)
+{
+
+	struct device_node *dn;
+	struct generic_pm_domain *genpd;
+
+	dn = of_get_cpu_node(cpu, NULL);
+	if (!dn)
+		return -ENODEV;
+
+	dn = of_parse_phandle(dn, "power-domains", 0);
+	if (!dn)
+		return -ENODEV;
+	of_node_put(dn);
+
+	/* Find the genpd for this CPU, create if not found */
+	genpd = of_get_cpu_domain(dn, ops, cpu);
+	if (IS_ERR(genpd))
+		return PTR_ERR(genpd);
+
+	return cpu_pd_attach_cpu(cpu);
+}
+EXPORT_SYMBOL(of_setup_cpu_pd_single);
+
+/**
+ * of_setup_cpu_pd() - Setup the PM domains for all CPUs
+ *
+ * @ops: The PM domain suspend/resume ops for all the domains
+ *
+ * Setup the CPU PM domain and attach all possible CPUs to their respective
+ * domains. The domains are created if not already and then attached.
+ */
+int of_setup_cpu_pd(const struct cpu_pd_ops *ops)
+{
+	int cpu;
+	int ret;
+
+	for_each_possible_cpu(cpu) {
+		ret = of_setup_cpu_pd_single(cpu, ops);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(of_setup_cpu_pd);
diff --git a/include/linux/cpu_domains.h b/include/linux/cpu_domains.h
new file mode 100644
index 0000000..bab4846
--- /dev/null
+++ b/include/linux/cpu_domains.h
@@ -0,0 +1,33 @@
+/*
+ * include/linux/cpu_domains.h
+ *
+ * Copyright (C) 2016 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __CPU_DOMAINS_H__
+#define __CPU_DOMAINS_H__
+
+struct cpu_pd_ops {
+	int (*power_off)(u32 state_idx, u32 param);
+	int (*power_on)(void);
+};
+
+#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
+int of_setup_cpu_pd_single(int cpu, const struct cpu_pd_ops *ops);
+int of_setup_cpu_pd(const struct cpu_pd_ops *ops);
+#else
+static inline int of_setup_cpu_pd_single(int cpu, const struct cpu_pd_ops *ops)
+{
+	return -ENODEV;
+}
+static inline int of_setup_cpu_pd(const struct cpu_pd_ops *ops)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
+
+#endif /* __CPU_DOMAINS_H__ */
-- 
2.1.4

