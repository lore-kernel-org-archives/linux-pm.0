From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC v2 12/16] drivers: qcom: spm: Enable runtime suspend/resume of CPU PM domain
Date: Fri, 26 Jun 2015 21:02:32 -0600
Message-ID: <1435374156-19214-13-git-send-email-lina.iyer@linaro.org>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35922 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbbF0DDD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 23:03:03 -0400
Received: by pdcu2 with SMTP id u2so84847657pdc.3
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 20:03:02 -0700 (PDT)
In-Reply-To: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

On APQ8084 QCOM SoC's, the CPUs are powered by a single rail controlled
by the L2 cache power controller (L2 SPM). The L2 power domain supplies
power to all the CPUs and L2. It is safe to power down the domain when
all the CPUs and the L2 are powered down.

Powering down of the domain is done through the finite state machine on
the L2 SAW. The L2 SPM can be configured to enter an idle state, when
all CPUs enter their idle state. The L2 SPM state machine would turn off
the cache and possibly power off the power domain as well. The SPM also
guarantees that the h/w is ready for the CPU to resume, when woken up by
an interrupt.

Define a cluster that holds the SPM and possibly other common cluster
elements. The L2 SAW is also the genpd domain provider and the CPUs are
the devices attached to the domain. When CPUIdle powers down each CPU,
the ARM domain framework would callback to notify that the domain may be
powered off. Configure the L2 SPM at that time to flush the L2 cache and
turn off the CPU power rail.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/soc/qcom/spm.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index bef2dfe1..ad1498e 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -24,9 +24,12 @@
 #include <linux/platform_device.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
+#include <linux/pm_domain.h>
 #include <linux/qcom_scm.h>
 
+#include <asm/cacheflush.h>
 #include <asm/cpuidle.h>
+#include <asm/pm_domain.h>
 #include <asm/proc-fns.h>
 #include <asm/suspend.h>
 
@@ -79,6 +82,7 @@ struct spm_driver_data {
 /* Group for domain entities */
 struct cluster {
 	struct spm_driver_data *domain_spm;
+	bool domain_off;
 };
 
 static const u8 spm_reg_offset_v2_1[SPM_REG_NR] = {
@@ -181,7 +185,23 @@ static void spm_set_low_power_mode(struct spm_driver_data *drv,
 
 static int qcom_pm_collapse(unsigned long int unused)
 {
-	qcom_scm_cpu_power_down(QCOM_SCM_CPU_PWR_DOWN_L2_ON);
+	int flags = QCOM_SCM_CPU_PWR_DOWN_L2_ON;
+	int cpu = smp_processor_id();
+	bool domain_off;
+
+	/*
+	 * Check if the CPU domain will power off after this CPU
+	 * enters idle.
+	 * L2 cache may be turned off when the domain powers off,
+	 * flush the non-secure cache before calling into secure.
+	 */
+	domain_off = per_cpu(cpu_spm_drv, cpu)->domain->domain_off;
+	if (domain_off) {
+		flags = QCOM_SCM_CPU_PWR_DOWN_L2_OFF;
+		flush_cache_all();
+	}
+
+	qcom_scm_cpu_power_down(flags);
 
 	/*
 	 * Returns here only if there was a pending interrupt and we did not
@@ -293,6 +313,35 @@ static struct cpuidle_ops qcom_cpuidle_ops __initdata = {
 CPUIDLE_METHOD_OF_DECLARE(qcom_idle_v1, "qcom,kpss-acc-v1", &qcom_cpuidle_ops);
 CPUIDLE_METHOD_OF_DECLARE(qcom_idle_v2, "qcom,kpss-acc-v2", &qcom_cpuidle_ops);
 
+static int pd_power_on(struct generic_pm_domain *domain)
+{
+	struct spm_driver_data *drv = per_cpu(cpu_spm_drv, smp_processor_id());
+	struct cluster *pmd = drv->domain;
+
+	if (!pmd || !pmd->domain_spm)
+		return 0;
+
+	pmd->domain_off = false;
+	spm_set_low_power_mode(pmd->domain_spm, PM_SLEEP_MODE_STBY);
+
+	return 0;
+}
+
+static int pd_power_off(struct generic_pm_domain *domain)
+{
+	struct spm_driver_data *drv = per_cpu(cpu_spm_drv, smp_processor_id());
+	struct cluster *pmd = drv->domain;
+
+	if (!pmd || !pmd->domain_spm)
+		return 0;
+
+	pmd->domain_off = true;
+	spm_set_low_power_mode(pmd->domain_spm, PM_SLEEP_MODE_SPC);
+
+	return 0;
+}
+
+
 /* Match L2 SPM with their affinity level */
 static const struct of_device_id cache_spm_table[] = {
 	{ },
@@ -418,8 +467,18 @@ static int spm_dev_probe(struct platform_device *pdev)
 	spm_set_low_power_mode(drv, PM_SLEEP_MODE_STBY);
 
 	/* We are ready to use the CPU/Cache SPM. */
-	if (is_domain_spm)
+	if (is_domain_spm) {
+		struct of_phandle_args args;
+		int ret;
+
+		args.np = pdev->dev.of_node;
+		args.args_count = 0;
+		ret = register_platform_domain_handlers(&args,
+				pd_power_on, pd_power_off);
+		if (ret)
+			dev_dbg(&pdev->dev, "Domain callback not registered\n");
 		cpu_domain[index].domain_spm = drv;
+	}
 	else
 		per_cpu(cpu_spm_drv, index) = drv;
 
-- 
2.1.4

