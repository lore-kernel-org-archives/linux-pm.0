From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 17/27] drivers: cpu-pd: Record CPUs that are part of the domain
Date: Tue, 17 Nov 2015 15:37:41 -0700
Message-ID: <1447799871-56374-18-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

In order to power down the heirarchy of the CPU domain, the domain needs
information about the CPUs in that domain hierarchy . A domain that has
sub-domains containing CPU devices, will need information about all the
CPUs in the sub-domains as well.

Introduce of_attach_cpu_pm_domain() to allow CPU domains to be attached
to its parent domain and the information on CPUs attached directly or
indirectly be bubbled up the hierarchy.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/power/cpu-pd.c | 96 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/cpu-pd.h      |  3 ++
 2 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/cpu-pd.c b/drivers/base/power/cpu-pd.c
index 9758b8d..617ce54 100644
--- a/drivers/base/power/cpu-pd.c
+++ b/drivers/base/power/cpu-pd.c
@@ -18,6 +18,7 @@
 #include <linux/device.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
+#include <linux/pm_qos.h>
 #include <linux/rculist.h>
 #include <linux/slab.h>
 
@@ -44,6 +45,27 @@ struct cpu_pm_domain *to_cpu_pd(struct generic_pm_domain *d)
 	return res;
 }
 
+/**
+ * get_cpus_in_domain() - Recursively parse CPUs in a domain.
+ */
+static void get_cpus_in_domain(struct generic_pm_domain *genpd,
+		struct cpumask *mask)
+{
+	struct gpd_link *link;
+	struct cpu_pm_domain *pd = to_cpu_pd(genpd);
+	struct generic_pm_domain *sd;
+
+	if (!cpumask_empty(pd->cpus) && mask != pd->cpus) {
+		cpumask_or(mask, pd->cpus, mask);
+		return;
+	}
+
+	list_for_each_entry(link, &genpd->master_links, master_node) {
+		sd = link->slave;
+		get_cpus_in_domain(sd, mask);
+	}
+}
+
 static int cpu_pd_power_off(struct generic_pm_domain *genpd)
 {
 	struct cpu_pm_domain *pd = to_cpu_pd(genpd);
@@ -81,7 +103,8 @@ static void run_cpu(void *unused)
 	pm_runtime_get_noresume(cpu_dev);
 }
 
-static int of_pm_domain_attach_cpus(struct device_node *dn)
+static int of_pm_domain_attach_cpus(struct device_node *dn,
+		struct cpu_pm_domain *pd)
 {
 	int cpuid, ret;
 
@@ -126,6 +149,7 @@ static int of_pm_domain_attach_cpus(struct device_node *dn)
 		} else {
 			pm_runtime_enable(cpu_dev);
 			dev_dbg(cpu_dev, "Attached CPU%d to domain\n", cpuid);
+			cpumask_set_cpu(cpuid, pd->cpus);
 		}
 	}
 
@@ -171,7 +195,7 @@ int of_register_cpu_pm_domain(struct device_node *dn,
 				pd->genpd->name);
 
 	/* Attach the CPUs to the CPU PM domain */
-	ret = of_pm_domain_attach_cpus(dn);
+	ret = of_pm_domain_attach_cpus(dn, pd);
 	if (ret)
 		of_genpd_del_provider(dn);
 
@@ -213,6 +237,13 @@ struct generic_pm_domain *of_init_cpu_pm_domain(struct device_node *dn,
 		return ERR_PTR(-ENOMEM);
 	}
 
+	if (!zalloc_cpumask_var(&pd->cpus, GFP_KERNEL)) {
+		kfree(pd->genpd->name);
+		kfree(pd->genpd);
+		kfree(pd);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	if (ops) {
 		pd->plat_ops.power_off = ops->power_off;
 		pd->plat_ops.power_on = ops->power_on;
@@ -222,6 +253,7 @@ struct generic_pm_domain *of_init_cpu_pm_domain(struct device_node *dn,
 	if (ret) {
 		kfree(pd->genpd->name);
 		kfree(pd->genpd);
+		kfree(pd->cpus);
 		kfree(pd);
 		return ERR_PTR(ret);
 	}
@@ -229,3 +261,63 @@ struct generic_pm_domain *of_init_cpu_pm_domain(struct device_node *dn,
 	return pd->genpd;
 }
 EXPORT_SYMBOL(of_init_cpu_pm_domain);
+
+/**
+ * of_attach_cpu_pm_domain() - Attach a CPU PM domain to its parent
+ * @dn: The device node of the CPU PM domain that needs to be attached
+ *
+ * The platform code can use this simplfied function to parse the domain
+ * provider of this device node and attach the genpd associated with @dn
+ * to it parents.
+ *
+ * Note: Both @dn and its domain provider must be initialized using
+ * of_init_cpu_pm_domain.
+ */
+int of_attach_cpu_pm_domain(struct device_node *dn)
+{
+	struct of_phandle_args args;
+	struct generic_pm_domain *genpd, *parent;
+	struct cpu_pm_domain *pd;
+	int ret;
+
+	args.np = dn;
+	args.args_count = 0;
+
+	genpd = of_genpd_get_from_provider(&args);
+	if (IS_ERR(genpd))
+		return -EINVAL;
+
+	if (!to_cpu_pd(genpd)) {
+		pr_warn("%s: domain %s is not a CPU domain\n",
+				__func__, genpd->name);
+		return -EINVAL;
+	}
+
+	ret = of_parse_phandle_with_args(dn, "power-domains",
+			"#power-domain-cells", 0, &args);
+	if (ret < 0)
+		return ret;
+
+	parent = of_genpd_get_from_provider(&args);
+	if (IS_ERR(parent))
+		return -EINVAL;
+
+	pd = to_cpu_pd(parent);
+	if (!pd) {
+		pr_warn("%s: domain (%s) parent (%s) is non-CPU domain\n",
+				__func__, genpd->name, parent->name);
+		return -EINVAL;
+	}
+
+	ret = pm_genpd_add_subdomain(genpd, parent);
+	if (ret) {
+		pr_err("%s: Unable to add sub-domain (%s) to parent (%s)\n",
+				__func__, genpd->name, parent->name);
+		return ret;
+	}
+
+	get_cpus_in_domain(parent, pd->cpus);
+
+	return 0;
+}
+EXPORT_SYMBOL(of_attach_cpu_pm_domain);
diff --git a/include/linux/cpu-pd.h b/include/linux/cpu-pd.h
index a2a217d..489ee2f 100644
--- a/include/linux/cpu-pd.h
+++ b/include/linux/cpu-pd.h
@@ -11,6 +11,7 @@
 #ifndef __CPU_PD_H__
 #define __CPU_PD_H__
 
+#include <linux/cpumask.h>
 #include <linux/list.h>
 #include <linux/of.h>
 #include <linux/pm_domain.h>
@@ -25,8 +26,10 @@ struct cpu_pm_domain {
 	struct generic_pm_domain *genpd;
 	struct device_node *dn;
 	struct cpu_pd_ops plat_ops;
+	cpumask_var_t cpus;
 };
 
 struct generic_pm_domain *of_init_cpu_pm_domain(struct device_node *dn,
 		const struct cpu_pd_ops *ops);
+int of_attach_cpu_pm_domain(struct device_node *dn);
 #endif /* __CPU_PD_H__ */
-- 
2.1.4
