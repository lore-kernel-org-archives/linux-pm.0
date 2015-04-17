From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 2/7] arm64: qcom: Add SPM driver support for ARM and ARM64
Date: Fri, 17 Apr 2015 17:49:04 -0600
Message-ID: <1429314549-6730-3-git-send-email-lina.iyer@linaro.org>
References: <1429314549-6730-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33594 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251AbbDQXtZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Apr 2015 19:49:25 -0400
Received: by paboj16 with SMTP id oj16so140450965pab.0
        for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2015 16:49:24 -0700 (PDT)
In-Reply-To: <1429314549-6730-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: arnd@arndb.de, catalin.marinas@arm.com, mark.rutland@arm.com, Will.Deacon@arm.com, lorenzo.pieralisi@arm.com
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, mlocke@codeaurora.org, bryanh@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

The SAW power controller can be used with both ARM v7 and v8 cpus. The
driver registers with the cpuidle framework as a provider of idle entry
points for all idle states. Certain aspects of cpuidle callback
registration are different been ARM and ARM64 variants. Use compile time
definitions to use appropriate idle and registration functions.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/soc/qcom/cpu_ops.c |  5 +++++
 drivers/soc/qcom/spm.c     | 12 +++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/cpu_ops.c b/drivers/soc/qcom/cpu_ops.c
index d831cb0..363147c 100644
--- a/drivers/soc/qcom/cpu_ops.c
+++ b/drivers/soc/qcom/cpu_ops.c
@@ -32,6 +32,9 @@
 #include <asm/cputype.h>
 #include <asm/smp_plat.h>
 
+extern int qcom_idle_enter(unsigned long index);
+extern int qcom_cpuidle_init(struct device_node *cpu_node, u32 cpu);
+
 static DEFINE_RAW_SPINLOCK(boot_lock);
 
 DEFINE_PER_CPU(int, cold_boot_done);
@@ -339,5 +342,7 @@ static const struct cpu_operations msm_cortex_a_ops = {
 	.cpu_prepare	= msm_cpu_prepare,
 	.cpu_boot	= msm_cpu_boot,
 	.cpu_postboot	= msm_cpu_postboot,
+	.cpu_suspend	= qcom_idle_enter,
+	.cpu_init_idle	= qcom_cpuidle_init,
 };
 CPU_METHOD_OF_DECLARE(msm_cortex_a_ops, &msm_cortex_a_ops);
diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index 5d0dd8c..b66d86c 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -29,6 +29,7 @@
 #include <asm/cpuidle.h>
 #include <asm/proc-fns.h>
 #include <asm/suspend.h>
+#include <asm/cpu_ops.h>
 
 #define MAX_PMIC_DATA		2
 #define MAX_SEQ_DATA		64
@@ -185,7 +186,11 @@ static int qcom_cpu_spc(int cpu)
 	struct spm_driver_data *drv = per_cpu(cpu_spm_drv, cpu);
 
 	spm_set_low_power_mode(drv, PM_SLEEP_MODE_SPC);
+#if defined (CONFIG_ARCH_ARM)
 	ret = cpu_suspend(0, qcom_pm_collapse);
+#else
+	ret = __cpu_suspend(0, qcom_pm_collapse);
+#endif
 	/*
 	 * ARM common code executes WFI without calling into our driver and
 	 * if the SPM mode is not reset, then we may accidently power down the
@@ -197,7 +202,7 @@ static int qcom_cpu_spc(int cpu)
 	return ret;
 }
 
-static int qcom_idle_enter(unsigned long index)
+int qcom_idle_enter(unsigned long index)
 {
 	int cpu = smp_processor_id();
 	return per_cpu(qcom_idle_ops, cpu)[index](cpu);
@@ -208,7 +213,7 @@ static const struct of_device_id qcom_idle_state_match[] __initconst = {
 	{ },
 };
 
-static int __init qcom_cpuidle_init(struct device_node *cpu_node, u32 cpu)
+int __init qcom_cpuidle_init(struct device_node *cpu_node, u32 cpu)
 {
 	const struct of_device_id *match_id;
 	struct device_node *state_node;
@@ -275,13 +280,14 @@ check_spm:
 	return per_cpu(cpu_spm_drv, cpu) ? 0 : -ENXIO;
 }
 
+#if defined (CONFIG_ARCH_ARM)
 static struct cpuidle_ops qcom_cpuidle_ops __initdata = {
 	.suspend = qcom_idle_enter,
 	.init = qcom_cpuidle_init,
 };
-
 CPUIDLE_METHOD_OF_DECLARE(qcom_idle_v1, "qcom,kpss-acc-v1", &qcom_cpuidle_ops);
 CPUIDLE_METHOD_OF_DECLARE(qcom_idle_v2, "qcom,kpss-acc-v2", &qcom_cpuidle_ops);
+#endif
 
 static struct spm_driver_data *spm_get_drv(struct platform_device *pdev,
 		int *spm_cpu)
-- 
2.1.0

