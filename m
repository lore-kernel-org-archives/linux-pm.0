From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 205/228] cpufreq: s5pv210: remove calls to cpufreq_notify_transition()
Date: Fri, 13 Sep 2013 18:32:31 +0530
Message-ID: <3542c13d2492d421cf6b157246fe7e16182ed71f.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34487 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757747Ab3IMN10 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2013 09:27:26 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so1261705pde.9
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2013 06:27:25 -0700 (PDT)
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>

Most of the drivers do following in their ->target_index() routines:

	struct cpufreq_freqs freqs;
	freqs.old = old freq...
	freqs.new = new freq...

	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);

	/* Change rate here */

	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);

This is replicated over all cpufreq drivers today and there doesn't exists a
good enough reason why this shouldn't be moved to cpufreq core instead.

Earlier patches have added support in cpufreq core to do cpufreq notification on
frequency change, this one removes it from this driver.

Some related minor cleanups are also done along with it.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/s5pv210-cpufreq.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 5978b94..e3973da 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -26,7 +26,6 @@
 static struct clk *cpu_clk;
 static struct clk *dmc0_clk;
 static struct clk *dmc1_clk;
-static struct cpufreq_freqs freqs;
 static DEFINE_MUTEX(set_freq_lock);
 
 /* APLL M,P,S values for 1G/800Mhz */
@@ -179,6 +178,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
 	unsigned int priv_index;
 	unsigned int pll_changing = 0;
 	unsigned int bus_speed_changing = 0;
+	unsigned int old_freq, new_freq;
 	int arm_volt, int_volt;
 	int ret = 0;
 
@@ -193,12 +193,12 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
 		goto exit;
 	}
 
-	freqs.old = s5pv210_getspeed(0);
-	freqs.new = s5pv210_freq_table[index].frequency;
+	old_freq = s5pv210_getspeed(0);
+	new_freq = s5pv210_freq_table[index].frequency;
 
 	/* Finding current running level index */
 	if (cpufreq_frequency_table_target(policy, s5pv210_freq_table,
-					   freqs.old, CPUFREQ_RELATION_H,
+					   old_freq, CPUFREQ_RELATION_H,
 					   &priv_index)) {
 		ret = -EINVAL;
 		goto exit;
@@ -207,7 +207,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
 	arm_volt = dvs_conf[index].arm_volt;
 	int_volt = dvs_conf[index].int_volt;
 
-	if (freqs.new > freqs.old) {
+	if (new_freq > old_freq) {
 		ret = regulator_set_voltage(arm_regulator,
 				arm_volt, arm_volt_max);
 		if (ret)
@@ -219,8 +219,6 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
 			goto exit;
 	}
 
-	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
-
 	/* Check if there need to change PLL */
 	if ((index == L0) || (priv_index == L0))
 		pll_changing = 1;
@@ -431,9 +429,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
 		}
 	}
 
-	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
-
-	if (freqs.new < freqs.old) {
+	if (new_freq < old_freq) {
 		regulator_set_voltage(int_regulator,
 				int_volt, int_volt_max);
 
-- 
1.7.12.rc2.18.g61b472e

