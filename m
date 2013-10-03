From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 28/92] cpufreq: s5pv210: Use generic cpufreq routines
Date: Thu,  3 Oct 2013 20:28:22 +0530
Message-ID: <f675427788a1fb09d6fb9002bead956921c88846.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-pm@vger.kernel.org

Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
and .attr. So its better if we have generic routines for them which can be used
by cpufreq drivers then.

This patch uses these generic routines for this driver.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/s5pv210-cpufreq.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index c266a7e..0eafc52 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -174,14 +174,6 @@ static void s5pv210_set_refresh(enum s5pv210_dmc_port ch, unsigned long freq)
 	__raw_writel(tmp1, reg);
 }
 
-static int s5pv210_verify_speed(struct cpufreq_policy *policy)
-{
-	if (policy->cpu)
-		return -EINVAL;
-
-	return cpufreq_frequency_table_verify(policy, s5pv210_freq_table);
-}
-
 static unsigned int s5pv210_getspeed(unsigned int cpu)
 {
 	if (cpu)
@@ -603,7 +595,7 @@ static int s5pv210_cpufreq_reboot_notifier_event(struct notifier_block *this,
 
 static struct cpufreq_driver s5pv210_driver = {
 	.flags		= CPUFREQ_STICKY,
-	.verify		= s5pv210_verify_speed,
+	.verify		= cpufreq_generic_frequency_table_verify,
 	.target		= s5pv210_target,
 	.get		= s5pv210_getspeed,
 	.init		= s5pv210_cpu_init,
-- 
1.7.12.rc2.18.g61b472e

