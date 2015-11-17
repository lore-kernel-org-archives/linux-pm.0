From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 12/27] ARM: cpuidle: remove cpu parameter from the cpuidle_ops suspend hook
Date: Tue, 17 Nov 2015 15:37:36 -0700
Message-ID: <1447799871-56374-13-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34079 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932543AbbKQWil (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 17:38:41 -0500
Received: by padhx2 with SMTP id hx2so22135966pad.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2015 14:38:40 -0800 (PST)
In-Reply-To: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

The suspend() hook in the cpuidle_ops struct is always called on
the cpu entering idle, which means that the cpu parameter passed
to the suspend hook always corresponds to the local cpu, making
it somewhat redundant.

This patch removes the logical cpu parameter from the ARM
cpuidle_ops.suspend hook and updates all the existing kernel
implementations to reflect this change.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Lina Iyer <lina.iyer@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/include/asm/cpuidle.h |  2 +-
 arch/arm/kernel/cpuidle.c      |  2 +-
 drivers/soc/qcom/spm.c         | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
index 0f84249..3848259 100644
--- a/arch/arm/include/asm/cpuidle.h
+++ b/arch/arm/include/asm/cpuidle.h
@@ -30,7 +30,7 @@ static inline int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
 struct device_node;
 
 struct cpuidle_ops {
-	int (*suspend)(int cpu, unsigned long arg);
+	int (*suspend)(unsigned long arg);
 	int (*init)(struct device_node *, int cpu);
 };
 
diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
index 318da33..703926e 100644
--- a/arch/arm/kernel/cpuidle.c
+++ b/arch/arm/kernel/cpuidle.c
@@ -56,7 +56,7 @@ int arm_cpuidle_suspend(int index)
 	int cpu = smp_processor_id();
 
 	if (cpuidle_ops[cpu].suspend)
-		ret = cpuidle_ops[cpu].suspend(cpu, index);
+		ret = cpuidle_ops[cpu].suspend(index);
 
 	return ret;
 }
diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index b04b05a..0ad66fa 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -116,7 +116,7 @@ static const struct spm_reg_data spm_reg_8064_cpu = {
 
 static DEFINE_PER_CPU(struct spm_driver_data *, cpu_spm_drv);
 
-typedef int (*idle_fn)(int);
+typedef int (*idle_fn)(void);
 static DEFINE_PER_CPU(idle_fn*, qcom_idle_ops);
 
 static inline void spm_register_write(struct spm_driver_data *drv,
@@ -179,10 +179,10 @@ static int qcom_pm_collapse(unsigned long int unused)
 	return -1;
 }
 
-static int qcom_cpu_spc(int cpu)
+static int qcom_cpu_spc(void)
 {
 	int ret;
-	struct spm_driver_data *drv = per_cpu(cpu_spm_drv, cpu);
+	struct spm_driver_data *drv = __this_cpu_read(cpu_spm_drv);
 
 	spm_set_low_power_mode(drv, PM_SLEEP_MODE_SPC);
 	ret = cpu_suspend(0, qcom_pm_collapse);
@@ -197,9 +197,9 @@ static int qcom_cpu_spc(int cpu)
 	return ret;
 }
 
-static int qcom_idle_enter(int cpu, unsigned long index)
+static int qcom_idle_enter(unsigned long index)
 {
-	return per_cpu(qcom_idle_ops, cpu)[index](cpu);
+	return __this_cpu_read(qcom_idle_ops)[index]();
 }
 
 static const struct of_device_id qcom_idle_state_match[] __initconst = {
-- 
2.1.4

