From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 191/228] cpufreq: elanfreq: remove calls to cpufreq_notify_transition()
Date: Fri, 13 Sep 2013 18:32:17 +0530
Message-ID: <d80612cdfeef9d5932132f0d2bad0e0ef31e46f3.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

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

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/elanfreq.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/cpufreq/elanfreq.c b/drivers/cpufreq/elanfreq.c
index 4ab4153..de08acf 100644
--- a/drivers/cpufreq/elanfreq.c
+++ b/drivers/cpufreq/elanfreq.c
@@ -108,17 +108,6 @@ static unsigned int elanfreq_get_cpu_frequency(unsigned int cpu)
 static int elanfreq_target(struct cpufreq_policy *policy,
 			    unsigned int state)
 {
-	struct cpufreq_freqs    freqs;
-
-	freqs.old = elanfreq_get_cpu_frequency(0);
-	freqs.new = elan_multiplier[state].clock;
-
-	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
-
-	printk(KERN_INFO "elanfreq: attempting to set frequency to %i kHz\n",
-			elan_multiplier[state].clock);
-
-
 	/*
 	 * Access to the Elan's internal registers is indexed via
 	 * 0x22: Chip Setup & Control Register Index Register (CSCI)
@@ -149,8 +138,6 @@ static int elanfreq_target(struct cpufreq_policy *policy,
 	udelay(10000);
 	local_irq_enable();
 
-	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
-
 	return 0;
 }
 /*
-- 
1.7.12.rc2.18.g61b472e
