From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC v1 7/8] drivers: qcom: cpu_pd: Handle cpu hotplug in the domain
Date: Thu, 11 Oct 2018 02:50:54 +0530
Message-ID: <1539206455-29342-8-git-send-email-rplsssn@codeaurora.org>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Use cpu hotplug callback mechanism to attach/dettach the cpu in
the cpu power domain. During cpu hotplug callback registration,
the starting callback is invoked on all online cpus. So there is
no need to attach from device probe.

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/cpu_pd.c  | 33 +++++++++++++++++++++++++--------
 include/linux/cpuhotplug.h |  1 +
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/qcom/cpu_pd.c b/drivers/soc/qcom/cpu_pd.c
index 242eced..bf2d95d 100644
--- a/drivers/soc/qcom/cpu_pd.c
+++ b/drivers/soc/qcom/cpu_pd.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/cpuhotplug.h>
 #include <linux/ktime.h>
 #include <linux/of_platform.h>
 #include <linux/pm_domain.h>
@@ -85,12 +86,26 @@ static int cpu_pd_power_off(struct generic_pm_domain *domain)
 	return 0;
 }
 
+static int cpu_pd_starting(unsigned int cpu)
+{
+	if (!suspend && of_genpd_attach_cpu(cpu))
+		pr_err("%s: genpd_attach_cpu fail\n", __func__);
+	return 0;
+}
+
+static int cpu_pd_dying(unsigned int cpu)
+{
+	if (!suspend)
+		of_genpd_detach_cpu(cpu);
+	return 0;
+}
+
 static int cpu_pm_domain_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct generic_pm_domain *cpu_pd;
-	int ret = -EINVAL, cpu;
+	int ret = -EINVAL;
 
 	if (!np) {
 		dev_err(dev, "device tree node not found\n");
@@ -127,15 +142,17 @@ static int cpu_pm_domain_probe(struct platform_device *pdev)
 
 	pr_info("init PM domain %s\n", cpu_pd->name);
 
-	for_each_present_cpu(cpu) {
-		ret = of_genpd_attach_cpu(cpu);
-		if (ret)
-			goto detach_cpu;
-	}
+	/* Install hotplug callbacks */
+	ret = cpuhp_setup_state(CPUHP_AP_QCOM_SYS_PM_DOMAIN_STARTING,
+				"AP_QCOM_SYS_PM_DOMAIN_STARTING",
+				cpu_pd_starting, cpu_pd_dying);
+	if (ret)
+		goto remove_hotplug;
+
 	return 0;
 
-detach_cpu:
-	of_genpd_detach_cpu(cpu);
+remove_hotplug:
+	cpuhp_remove_state(CPUHP_AP_QCOM_SYS_PM_DOMAIN_STARTING);
 
 remove_pd:
 	pm_genpd_remove(cpu_pd);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index caf40ad..4bfe8e2 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -139,6 +139,7 @@ enum cpuhp_state {
 	CPUHP_AP_X86_TBOOT_DYING,
 	CPUHP_AP_ARM_CACHE_B15_RAC_DYING,
 	CPUHP_AP_ONLINE,
+	CPUHP_AP_QCOM_SYS_PM_DOMAIN_STARTING,
 	CPUHP_TEARDOWN_CPU,
 	CPUHP_AP_ONLINE_IDLE,
 	CPUHP_AP_SMPBOOT_THREADS,
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.
