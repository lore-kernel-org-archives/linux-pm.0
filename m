From: Lina Iyer <lina.iyer@linaro.org>
Subject: [RFC v2 06/12] PM / cpu_domains: Record CPUs that are part of the domain
Date: Fri, 12 Feb 2016 13:50:32 -0700
Message-ID: <1455310238-8963-7-git-send-email-lina.iyer@linaro.org>
References: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

In order to power down a CPU domain, the domain needs information about
the CPUs in that domain. The reference counting for the CPU devices in a
domain is done by genpd. In order to understand the idle time for the
domain, it is necessary to know which CPUs are part of the domain, so
the domain governor may understand the sleep durations of the comprising
CPU devices and make a judicious decision on the domain's idle state.
This extends to the parent of such domains, which may have multiple such
CPU domains and therefore would need to know the sleep patterns of all
the CPUs in all the CPU domains.

To aid this functionality, traverse up the parent chain and set the CPU
in the cpumasks while attaching a CPU to its domain. This mask is
provided in the callback to the platform driver to help identify the
CPUs in the domain that is being powered off.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/power/cpu_domains.c | 27 ++++++++++++++++++++++++---
 include/linux/cpu_domains.h      |  4 +++-
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/cpu_domains.c b/drivers/base/power/cpu_domains.c
index 981592f..c99710c 100644
--- a/drivers/base/power/cpu_domains.c
+++ b/drivers/base/power/cpu_domains.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/cpu.h>
+#include <linux/cpumask.h>
 #include <linux/cpu_domains.h>
 #include <linux/cpu_pm.h>
 #include <linux/device.h>
@@ -27,6 +28,7 @@ struct cpu_pm_domain {
 	struct cpu_pd_ops ops;
 	struct generic_pm_domain *genpd;
 	struct cpu_pm_domain *parent;
+	cpumask_var_t cpus;
 };
 
 /* List of CPU PM domains we care about */
@@ -50,7 +52,7 @@ struct cpu_pm_domain *to_cpu_pd(struct generic_pm_domain *d)
 	return res;
 }
 
-static int cpu_pd_attach_cpu(int cpu)
+static int cpu_pd_attach_cpu(struct cpu_pm_domain *cpu_pd, int cpu)
 {
 	int ret;
 	struct device *cpu_dev;
@@ -70,6 +72,11 @@ static int cpu_pd_attach_cpu(int cpu)
 	else
 		dev_dbg(cpu_dev, "Attached to domain\n");
 
+	while (!ret && cpu_pd) {
+		cpumask_set_cpu(cpu, cpu_pd->cpus);
+		cpu_pd = cpu_pd->parent;
+	};
+
 	return ret;
 }
 
@@ -85,7 +92,8 @@ static int cpu_pd_power_off(struct generic_pm_domain *genpd)
 	struct cpu_pm_domain *pd = to_cpu_pd(genpd);
 
 	return pd->ops.power_off(genpd->state_idx,
-			genpd->states[genpd->state_idx].param);
+			genpd->states[genpd->state_idx].param,
+			pd->cpus);
 }
 
 /**
@@ -118,6 +126,9 @@ static struct generic_pm_domain *of_init_cpu_pm_domain(struct device_node *dn,
 	if (!pd)
 		goto fail;
 
+	if (!zalloc_cpumask_var(&pd->cpus, GFP_KERNEL))
+		goto fail;
+
 	pd->genpd = genpd;
 	pd->genpd->power_off = cpu_pd_power_off;
 	pd->genpd->power_on = cpu_pd_power_on;
@@ -148,6 +159,8 @@ fail:
 
 	kfree(genpd);
 	kfree(genpd->name);
+	if (pd)
+		kfree(pd->cpus);
 	kfree(pd);
 	return ERR_PTR(ret);
 }
@@ -224,6 +237,7 @@ int of_setup_cpu_pd_single(int cpu, const struct cpu_pd_ops *ops)
 
 	struct device_node *dn;
 	struct generic_pm_domain *genpd;
+	struct cpu_pm_domain *cpu_pd;
 
 	dn = of_get_cpu_node(cpu, NULL);
 	if (!dn)
@@ -239,7 +253,14 @@ int of_setup_cpu_pd_single(int cpu, const struct cpu_pd_ops *ops)
 	if (IS_ERR(genpd))
 		return PTR_ERR(genpd);
 
-	return cpu_pd_attach_cpu(cpu);
+	cpu_pd = to_cpu_pd(genpd);
+	if (!cpu_pd) {
+		pr_err("%s: Genpd was created outside CPU PM domains\n",
+				__func__);
+		return -ENOENT;
+	}
+
+	return cpu_pd_attach_cpu(cpu_pd, cpu);
 }
 EXPORT_SYMBOL(of_setup_cpu_pd_single);
 
diff --git a/include/linux/cpu_domains.h b/include/linux/cpu_domains.h
index bab4846..0c539f0 100644
--- a/include/linux/cpu_domains.h
+++ b/include/linux/cpu_domains.h
@@ -11,8 +11,10 @@
 #ifndef __CPU_DOMAINS_H__
 #define __CPU_DOMAINS_H__
 
+#include <linux/cpumask.h>
+
 struct cpu_pd_ops {
-	int (*power_off)(u32 state_idx, u32 param);
+	int (*power_off)(u32 state_idx, u32 param, const struct cpumask *mask);
 	int (*power_on)(void);
 };
 
-- 
2.1.4
