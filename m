From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC 4/6] drivers: qcom: system_pm: program next wakeup to PDC timer
Date: Sat, 25 Aug 2018 01:36:26 +0530
Message-ID: <1535141188-29731-5-git-send-email-rplsssn@codeaurora.org>
References: <1535141188-29731-1-git-send-email-rplsssn@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535141188-29731-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, rafael@kernel.org, drake@endlessm.com, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
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
 drivers/soc/qcom/system_pm.c | 61 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/soc/qcom/system_pm.c b/drivers/soc/qcom/system_pm.c
index 8810b84..1451bf8 100644
--- a/drivers/soc/qcom/system_pm.c
+++ b/drivers/soc/qcom/system_pm.c
@@ -5,15 +5,67 @@
 
 #include <linux/cpu_pm.h>
 #include <linux/kernel.h>
+#include <linux/ktime.h>
 #include <linux/platform_device.h>
+#include <linux/tick.h>
 
 #include <soc/qcom/rpmh.h>
 
+#define ARCH_TIMER_HZ (19200000)
+#define PDC_TIME_VALID_SHIFT	31
+#define PDC_TIME_UPPER_MASK	0xFFFFFF
 static struct cpumask cpu_pm_state_mask;
 static raw_spinlock_t cpu_pm_state_lock;
 
 static struct device *sys_pm_dev;
 
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
+static int setup_pdc_wakeup_timer(bool suspend)
+{
+	int cpu;
+	struct tcs_cmd cmd[2] = { { 0 } };
+	ktime_t next_wakeup, cpu_wakeup;
+	uint64_t wakeup_cycles = ~0U;
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
+	return rpmh_write_pdc_data(sys_pm_dev, cmd, ARRAY_SIZE(cmd));
+}
+
 static int sys_pm_notifier(struct notifier_block *b,
 			       unsigned long cmd, void *v)
 {
@@ -25,6 +77,14 @@ static int sys_pm_notifier(struct notifier_block *b,
 			if (rpmh_ctrlr_idle(sys_pm_dev)) {
 				/* Flush the sleep/wake sets */
 				rpmh_flush(sys_pm_dev);
+				/*
+				 * The next wakeup value is converted to ticks
+				 * and copied to the Power Domain Controller
+				 * that has its own timer, which is in an
+				 * always-on power domain. The programming is
+				 * done through a separate register on the RSC
+				 */
+				setup_pdc_wakeup_timer(false);
 			} else {
 				pr_err("%s:rpmh controller is busy\n",
 						__func__);
@@ -72,6 +132,7 @@ static int sys_pm_suspend(struct device *dev)
 	if (rpmh_ctrlr_idle(dev)) {
 		/* Flush the sleep/wake sets in RSC controller */
 		rpmh_flush(dev);
+		setup_pdc_wakeup_timer(true);
 	} else {
 		pr_err("%s:rpmh controller is busy\n", __func__);
 		return -EBUSY;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.
