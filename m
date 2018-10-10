From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC v1 6/8] drivers: qcom: cpu_pd: program next wakeup to PDC timer
Date: Thu, 11 Oct 2018 02:50:53 +0530
Message-ID: <1539206455-29342-7-git-send-email-rplsssn@codeaurora.org>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

In addition to sleep and wake request votes that need to be sent to
remote processor as part of low power mode entry, the next wake-up timer
value needs to be programmed to PDC (Power Domain Controller) which has
its own timer and is in an always on power domain. A specific control
register is provided in RSC address space for this purpose. PDC wakes-up
the RSC and sets up the resources back in active state before the
processor is woken up by a timer interrupt.

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/Kconfig  |  2 +-
 drivers/soc/qcom/cpu_pd.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 91e8b3b..9abaeab 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -105,7 +105,7 @@ config QCOM_RPMH
 
 config QCOM_CPU_PD
     bool "Qualcomm cpu power domain driver"
-    depends on QCOM_RPMH && PM_GENERIC_DOMAINS || COMPILE_TEST
+    depends on QCOM_RPMH && PM_GENERIC_DOMAINS && PM_SLEEP || COMPILE_TEST
     help
 	  Support for QCOM platform cpu power management to perform tasks
 	  necessary while application processor votes for deeper modes so that
diff --git a/drivers/soc/qcom/cpu_pd.c b/drivers/soc/qcom/cpu_pd.c
index 565c510..242eced 100644
--- a/drivers/soc/qcom/cpu_pd.c
+++ b/drivers/soc/qcom/cpu_pd.c
@@ -3,19 +3,80 @@
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/ktime.h>
 #include <linux/of_platform.h>
 #include <linux/pm_domain.h>
 #include <linux/slab.h>
+#include <linux/tick.h>
 
 #include <soc/qcom/rpmh.h>
 
+#define ARCH_TIMER_HZ (19200000)
+#define PDC_TIME_VALID_SHIFT	31
+#define PDC_TIME_UPPER_MASK	0xFFFFFF
 static struct device *cpu_pd_dev;
+static bool suspend;
+
+static uint64_t us_to_ticks(uint64_t time_us)
+{
+	uint64_t sec, nsec, time_cycles;
+
+	sec = time_us;
+	do_div(sec, USEC_PER_SEC);
+	nsec = time_us - sec * USEC_PER_SEC;
+
+	if (nsec > 0) {
+		nsec = nsec * NSEC_PER_USEC;
+		do_div(nsec, NSEC_PER_SEC);
+	}
+
+	sec += nsec;
+
+	time_cycles = (u64)sec * ARCH_TIMER_HZ;
+
+	return time_cycles;
+}
+
+static int setup_pdc_wakeup_timer(struct device *dev)
+{
+	int cpu;
+	struct tcs_cmd cmd[2] = { { 0 } };
+	ktime_t next_wakeup, cpu_wakeup;
+	uint64_t wakeup_cycles = ~0ULL;
+
+	if (!suspend) {
+		/*
+		 * Find the next wakeup for any of the online CPUs
+		 */
+		next_wakeup = ktime_set(KTIME_SEC_MAX, 0);
+		for_each_online_cpu(cpu) {
+			cpu_wakeup = tick_nohz_get_next_wakeup(cpu);
+			if (ktime_before(cpu_wakeup, next_wakeup))
+				next_wakeup = cpu_wakeup;
+		}
+		wakeup_cycles = us_to_ticks(ktime_to_us(next_wakeup));
+	}
+
+	cmd[0].data =  (wakeup_cycles >> 32) & PDC_TIME_UPPER_MASK;
+	cmd[0].data |= 1 << PDC_TIME_VALID_SHIFT;
+	cmd[1].data = (wakeup_cycles & 0xFFFFFFFF);
+
+	return rpmh_write_pdc_data(dev, cmd, ARRAY_SIZE(cmd));
+}
 
 static int cpu_pd_power_off(struct generic_pm_domain *domain)
 {
 	if (rpmh_ctrlr_idle(cpu_pd_dev)) {
 		/* Flush the sleep/wake sets */
 		rpmh_flush(cpu_pd_dev);
+		/*
+		 * The next wakeup value is converted to ticks
+		 * and copied to the Power Domain Controller
+		 * that has its own timer, which is in an
+		 * always-on power domain. The programming is
+		 * done through a separate register on the RSC
+		 */
+		setup_pdc_wakeup_timer(cpu_pd_dev);
 	} else {
 		pr_debug("rpmh controller is busy\n");
 		return -EBUSY;
@@ -89,6 +150,23 @@ static int cpu_pm_domain_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int cpu_pd_suspend(struct device *dev)
+{
+	suspend = true;
+	return 0;
+}
+
+static int cpu_pd_resume(struct device *dev)
+{
+	suspend = false;
+	return 0;
+}
+
+static const struct dev_pm_ops cpu_pd_dev_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(cpu_pd_suspend, cpu_pd_resume)
+};
+
+
 static const struct of_device_id cpu_pd_drv_match[] = {
 	{ .compatible = "qcom,cpu-pm-domain", },
 	{ }
@@ -99,6 +177,7 @@ static int cpu_pm_domain_probe(struct platform_device *pdev)
 	.driver	= {
 		.name = "cpu_pm_domain",
 		.of_match_table = cpu_pd_drv_match,
+		.pm = &cpu_pd_dev_pm_ops,
 	},
 };
 builtin_platform_driver(cpu_pm_domain_driver);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.
