From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 04/37] cpufreq: at32ap: don't initialize part of policy that is set by core too
Date: Wed, 14 Aug 2013 19:01:53 +0530
Message-ID: <6fe9b31a6e199052e0a91b38c8f6d110e9f57b28.1376486713.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Hans-Christian Egtvedt <egtvedt@samfundet.no>
List-Id: linux-pm@vger.kernel.org

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/at32ap-cpufreq.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/at32ap-cpufreq.c b/drivers/cpufreq/at32ap-cpufreq.c
index bae6ed8..81d0752 100644
--- a/drivers/cpufreq/at32ap-cpufreq.c
+++ b/drivers/cpufreq/at32ap-cpufreq.c
@@ -64,7 +64,7 @@ static int at32_set_target(struct cpufreq_policy *policy, unsigned int index)
 
 static int __init at32_cpufreq_driver_init(struct cpufreq_policy *policy)
 {
-	unsigned int frequency, rate;
+	unsigned int frequency, rate, min_freq;
 	int retval, steps, i;
 
 	if (policy->cpu != 0)
@@ -77,12 +77,9 @@ static int __init at32_cpufreq_driver_init(struct cpufreq_policy *policy)
 		goto out_err;
 	}
 
-	policy->cpuinfo.min_freq = (clk_round_rate(cpuclk, 1) + 500) / 1000;
-	policy->cpuinfo.max_freq = (clk_round_rate(cpuclk, ~0UL) + 500) / 1000;
+	min_freq = (clk_round_rate(cpuclk, 1) + 500) / 1000;
+	frequency = (clk_round_rate(cpuclk, ~0UL) + 500) / 1000;
 	policy->cpuinfo.transition_latency = 0;
-	policy->cur = at32_get_speed(0);
-	policy->min = policy->cpuinfo.min_freq;
-	policy->max = policy->cpuinfo.max_freq;
 
 	/*
 	 * AVR32 CPU frequency rate scales in power of two between maximum and
@@ -91,7 +88,7 @@ static int __init at32_cpufreq_driver_init(struct cpufreq_policy *policy)
 	 * Further validate that the frequency is usable, and append it to the
 	 * frequency table.
 	 */
-	steps = fls(policy->cpuinfo.max_freq / policy->cpuinfo.min_freq) + 1;
+	steps = fls(frequency / min_freq) + 1;
 	freq_table = kzalloc(steps * sizeof(struct cpufreq_frequency_table),
 			GFP_KERNEL);
 	if (!freq_table) {
@@ -99,7 +96,6 @@ static int __init at32_cpufreq_driver_init(struct cpufreq_policy *policy)
 		goto out_err_put_clk;
 	}
 
-	frequency = policy->cpuinfo.max_freq;
 	for (i = 0; i < (steps - 1); i++) {
 		rate = clk_round_rate(cpuclk, frequency * 1000) / 1000;
 
-- 
1.7.12.rc2.18.g61b472e
