From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH V5 8/9] PM / cpu_domains: Initialize CPU PM domains from DT
Date: Fri,  3 Mar 2017 12:41:34 -0800
Message-ID: <1488573695-106680-9-git-send-email-lina.iyer@linaro.org>
References: <1488573695-106680-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33443 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752057AbdCCUmy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Mar 2017 15:42:54 -0500
Received: by mail-pg0-f53.google.com with SMTP id 25so47490909pgy.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Mar 2017 12:42:00 -0800 (PST)
In-Reply-To: <1488573695-106680-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>

Add helper functions to parse DT and initialize the CPU PM domains and
attach CPU to their respective domains using information provided in the
DT.

For each CPU in the DT, we identify the domain provider; initialize and
register the PM domain if isn't already registered and attach all the
CPU devices to the domain. Usually, when there are multiple clusters of
CPUs, there is a top level coherency domain that is dependent on these
individual domains. All domains thus created are marked IRQ safe
automatically and therefore may be powered down when the CPUs in the
domain are powered down by cpuidle.

Cc: Kevin Hilman <khilman@kernel.org>
Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/power/cpu_domains.c | 210 +++++++++++++++++++++++++++++++++++++++
 include/linux/cpu_domains.h      |  20 ++++
 2 files changed, 230 insertions(+)

diff --git a/drivers/base/power/cpu_domains.c b/drivers/base/power/cpu_domains.c
index 4f2a40e..a566d84 100644
--- a/drivers/base/power/cpu_domains.c
+++ b/drivers/base/power/cpu_domains.c
@@ -13,8 +13,10 @@
 #include <linux/cpu_domains.h>
 #include <linux/cpu_pm.h>
 #include <linux/device.h>
+#include <linux/fwnode.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/of.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_qos.h>
 #include <linux/pm_runtime.h>
@@ -268,3 +270,211 @@ int cpu_pd_init(struct generic_pm_domain *genpd, const struct cpu_pd_ops *ops)
 	return ret;
 }
 EXPORT_SYMBOL(cpu_pd_init);
+
+#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
+
+static struct generic_pm_domain *of_get_genpd(struct device_node *dn)
+{
+	struct cpu_pm_domain *pd;
+	struct generic_pm_domain *genpd = NULL;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(pd, &of_cpu_pd_list, link)
+		if (pd->genpd->provider == &dn->fwnode) {
+			genpd = pd->genpd;
+			break;
+		}
+	rcu_read_unlock();
+
+	return genpd;
+}
+
+static struct generic_pm_domain *alloc_genpd(struct device_node *dn)
+{
+	struct generic_pm_domain *genpd;
+
+	genpd = kzalloc(sizeof(*genpd), GFP_KERNEL);
+	if (!genpd)
+		return ERR_PTR(-ENOMEM);
+
+	genpd->name = kstrndup(dn->full_name, CPU_PD_NAME_MAX, GFP_KERNEL);
+	if (!genpd->name) {
+		kfree(genpd);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return genpd;
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
+				const struct cpu_pd_ops *plat_ops)
+{
+	struct cpu_pm_domain *pd = NULL;
+	struct generic_pm_domain *genpd = NULL;
+	int ret = -ENOMEM;
+	struct genpd_power_state *states = NULL;
+	const struct cpu_pd_ops *ops = plat_ops;
+	int count;
+	int i;
+
+	if (!of_device_is_available(dn))
+		return ERR_PTR(-ENODEV);
+
+	/* If we already have the PM domain return that */
+	genpd = of_get_genpd(dn);
+	if (genpd)
+		return genpd;
+
+	/* Initialize a new PM Domains */
+	genpd = alloc_genpd(dn);
+	if (IS_ERR(genpd))
+		return genpd;
+
+	ret = of_genpd_parse_idle_states(dn, &states, &count);
+	if (ret)
+		goto fail;
+	if (!count) {
+		ops = NULL;
+		goto skip_states;
+	}
+
+	/* Populate platform specific states from DT */
+	for (i = 0; ops->populate_state_data && i < count; i++) {
+		ret = ops->populate_state_data(to_of_node(states[i].fwnode),
+						&states[i].param);
+		if (ret)
+			goto fail;
+	}
+
+	genpd->states = states;
+	genpd->state_count = count;
+
+skip_states:
+	ret = cpu_pd_init(genpd, ops);
+	if (ret)
+		goto fail;
+
+	ret = of_genpd_add_provider_simple(dn, genpd);
+	if (ret)
+		pr_warn("Unable to add genpd %s as provider\n",
+				pd->genpd->name);
+
+	return genpd;
+fail:
+	kfree(genpd->name);
+	kfree(genpd);
+	if (pd)
+		kfree(pd->cpus);
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
+	genpd = of_init_cpu_pm_domain(dn, ops);
+	if (IS_ERR(genpd))
+		return genpd;
+
+	/* Is there a domain provider for this domain? */
+	ret = of_parse_phandle_with_args(dn, "power-domains",
+					"#power-domain-cells", 0, &args);
+	if (ret < 0)
+		goto skip_parent;
+
+	/* Find its parent and attach this domain to it, recursively */
+	parent = of_get_cpu_domain(args.np, ops, cpu);
+	if (IS_ERR(parent))
+		goto skip_parent;
+
+	ret = cpu_pd_attach_domain(parent, genpd);
+	if (ret)
+		pr_err("Unable to attach domain %s to parent %s\n",
+				genpd->name, parent->name);
+
+skip_parent:
+	of_node_put(dn);
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
+	struct device_node *dn, *np;
+	struct generic_pm_domain *genpd;
+	struct cpu_pm_domain *cpu_pd;
+
+	np = of_get_cpu_node(cpu, NULL);
+	if (!np)
+		return -ENODEV;
+
+	dn = of_parse_phandle(np, "power-domains", 0);
+	of_node_put(np);
+	if (!dn)
+		return -ENODEV;
+
+	/* Find the genpd for this CPU, create if not found */
+	genpd = of_get_cpu_domain(dn, ops, cpu);
+	of_node_put(dn);
+	if (IS_ERR(genpd))
+		return PTR_ERR(genpd);
+
+	cpu_pd = to_cpu_pd(genpd);
+	if (!cpu_pd) {
+		pr_err("%s: Genpd was created outside CPU PM domains\n",
+				__func__);
+		return -ENOENT;
+	}
+
+	return cpu_pd_attach_cpu(genpd, cpu);
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
+
+#endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
diff --git a/include/linux/cpu_domains.h b/include/linux/cpu_domains.h
index 7e71291..251fbc2 100644
--- a/include/linux/cpu_domains.h
+++ b/include/linux/cpu_domains.h
@@ -15,8 +15,12 @@
 
 struct generic_pm_domain;
 struct cpumask;
+struct device_node;
 
 struct cpu_pd_ops {
+#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
+	int (*populate_state_data)(struct device_node *n, u32 *param);
+#endif
 	int (*power_off)(u32 state_idx, u32 param, const struct cpumask *mask);
 	int (*power_on)(void);
 };
@@ -45,4 +49,20 @@ static inline int cpu_pd_attach_cpu(struct generic_pm_domain *genpd, int cpu)
 
 #endif /* CONFIG_PM_GENERIC_DOMAINS */
 
+#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
+
+int of_setup_cpu_pd_single(int cpu, const struct cpu_pd_ops *ops);
+
+int of_setup_cpu_pd(const struct cpu_pd_ops *ops);
+
+#else
+
+static inline int of_setup_cpu_pd_single(int cpu, const struct cpu_pd_ops *ops)
+{ return -ENODEV; }
+
+static inline int of_setup_cpu_pd(const struct cpu_pd_ops *ops)
+{ return -ENODEV; }
+
+#endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
+
 #endif /* __CPU_DOMAINS_H__ */
-- 
2.7.4
