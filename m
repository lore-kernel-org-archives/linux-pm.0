From: Lina Iyer <lina.iyer@linaro.org>
Subject: [RFC v3 06/12] PM / cpu_domains: Record CPUs that are part of the domain
Date: Tue,  1 Mar 2016 14:15:25 -0700
Message-ID: <1456866931-37851-8-git-send-email-lina.iyer@linaro.org>
References: <1456866931-37851-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33086 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655AbcCAVQR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 16:16:17 -0500
Received: by mail-pf0-f176.google.com with SMTP id 124so58012988pfg.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Mar 2016 13:16:16 -0800 (PST)
In-Reply-To: <1456866931-37851-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>

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
 drivers/base/power/cpu_domains.c | 28 ++++++++++++++++++++++++----
 include/linux/cpu_domains.h      |  4 +++-
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/cpu_domains.c b/drivers/base/power/cpu_domains.c
index 62704e6..62c1ab9 100644
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
 
@@ -85,8 +92,8 @@ static int cpu_pd_power_off(struct generic_pm_domain *genpd)
 	struct cpu_pm_domain *pd = to_cpu_pd(genpd);
 
 	return pd->ops.power_off ? pd->ops.power_off(genpd->state_idx,
-					genpd->states[genpd->state_idx].param),
-					: 0;
+					genpd->states[genpd->state_idx].param,
+					pd->cpus) : 0;
 }
 
 /**
@@ -119,6 +126,9 @@ static struct generic_pm_domain *of_init_cpu_pm_domain(struct device_node *dn,
 	if (!pd)
 		goto fail;
 
+	if (!zalloc_cpumask_var(&pd->cpus, GFP_KERNEL))
+		goto fail;
+
 	pd->genpd = genpd;
 	pd->genpd->power_off = cpu_pd_power_off;
 	pd->genpd->power_on = cpu_pd_power_on;
@@ -149,6 +159,8 @@ fail:
 
 	kfree(genpd->name);
 	kfree(genpd);
+	if (pd)
+		kfree(pd->cpus);
 	kfree(pd);
 	return ERR_PTR(ret);
 }
@@ -224,6 +236,7 @@ int of_setup_cpu_pd_single(int cpu, const struct cpu_pd_ops *ops)
 
 	struct device_node *dn;
 	struct generic_pm_domain *genpd;
+	struct cpu_pm_domain *cpu_pd;
 
 	dn = of_get_cpu_node(cpu, NULL);
 	if (!dn)
@@ -239,7 +252,14 @@ int of_setup_cpu_pd_single(int cpu, const struct cpu_pd_ops *ops)
 		return PTR_ERR(genpd);
 
 	of_node_put(dn);
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
index 9530b2d..50e3321 100644
--- a/include/linux/cpu_domains.h
+++ b/include/linux/cpu_domains.h
@@ -13,8 +13,10 @@
 
 #include <linux/types.h>
 
+struct cpumask;
+
 struct cpu_pd_ops {
-	int (*power_off)(u32 state_idx, u32 param);
+	int (*power_off)(u32 state_idx, u32 param, const struct cpumask *mask);
 	int (*power_on)(void);
 };
 
-- 
2.1.4

