From: Marc Titinger <mtitinger@baylibre.com>
Subject: [RFC v3 5/7] drivers: cpu-pd: allow calling of_cpu_pd_init from platform code.
Date: Tue, 27 Oct 2015 18:40:54 +0100
Message-ID: <1445967656-28292-6-git-send-email-mtitinger+renesas@baylibre.com>
References: <1445967656-28292-1-git-send-email-mtitinger+renesas@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35292 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965777AbbJ0Rlc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2015 13:41:32 -0400
Received: by wicll6 with SMTP id ll6so170514549wic.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2015 10:41:31 -0700 (PDT)
In-Reply-To: <1445967656-28292-1-git-send-email-mtitinger+renesas@baylibre.com>
In-Reply-To: <20151019205825.GA82426@linaro.org>
References: <20151019205825.GA82426@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lina.iyer@linaro.org
Cc: rjw@rjwysocki.net, khilman@kernel.org, ahaslam@baylibre.com, bcousson@baylibre.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Marc Titinger <mtitinger@baylibre.com>, Marc Titinger <mtitinger+renesas@baylibre.com>

From: Marc Titinger <mtitinger@baylibre.com>

re-instate a two step init, first register the CPU-power domains, then
attach the CPUs, because CPU ordering does not match cluster/PD boundaries.

Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
---
 drivers/base/power/cpu-pd.c | 29 ++++++++++++-----------------
 include/linux/cpu-pd.h      |  2 ++
 2 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/base/power/cpu-pd.c b/drivers/base/power/cpu-pd.c
index eddee98..701a68f 100644
--- a/drivers/base/power/cpu-pd.c
+++ b/drivers/base/power/cpu-pd.c
@@ -8,8 +8,6 @@
  * published by the Free Software Foundation.
  */
 
-#define DEBUG
-
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/cpu.h>
@@ -160,8 +158,6 @@ static int cpu_hotplug(struct notifier_block *nb,
 int of_register_cpu_pm_domain(struct device_node *dn,
 		struct cpu_pm_domain *pd)
 {
-	int ret;
-
 	if (!pd || !pd->genpd)
 		return -EINVAL;
 
@@ -187,14 +183,6 @@ int of_register_cpu_pm_domain(struct device_node *dn,
 	pm_genpd_init_simple(pd->genpd, &simple_qos_governor, false);
 	of_genpd_add_provider_simple(dn, pd->genpd);
 
-	/* Attach the CPUs to the CPU PM domain */
-	ret = of_pm_domain_attach_cpus();
-	if (ret) {
-		of_genpd_del_provider(dn);
-		return ret;
-	}
-
-	hotcpu_notifier(cpu_hotplug, 0)
 	return 0;
 }
 EXPORT_SYMBOL(of_register_cpu_pm_domain);
@@ -245,21 +233,28 @@ int of_init_cpu_pm_domain(struct device_node *dn, struct cpu_pm_ops *ops)
 EXPORT_SYMBOL(of_init_cpu_pm_domain);
 
 
-static int __init of_cpu_pd_init(void)
+int __init of_cpu_pd_init(const char *compatible)
 {
 	struct device_node *dn;
 	int ret;
 
-	for_each_compatible_node(dn, NULL, "cpu,pd") {
+	if (!compatible)
+		return -EINVAL;
+
+	for_each_compatible_node(dn, NULL, compatible) {
 
 		if (!of_device_is_available(dn))
 			continue;
 
 		ret = of_init_cpu_pm_domain(dn, NULL);
-		if (!ret)
+		if (ret)
 			return ret;
 
 	}
-	return 0;
+
+	ret = of_pm_domain_attach_cpus();
+	if (!ret)
+		hotcpu_notifier(cpu_hotplug, 0);
+
+	return ret;
 }
-device_initcall(of_cpu_pd_init);
diff --git a/include/linux/cpu-pd.h b/include/linux/cpu-pd.h
index 9ae6f5b..f3066d0 100644
--- a/include/linux/cpu-pd.h
+++ b/include/linux/cpu-pd.h
@@ -32,4 +32,6 @@ extern int of_register_cpu_pm_domain(struct device_node *dn,
 extern int of_init_cpu_pm_domain(struct device_node *dn,
 		struct cpu_pm_ops *ops);
 
+extern int __init of_cpu_pd_init(const char *compatible);
+
 #endif /* __CPU_PD_H__ */
-- 
1.9.1

