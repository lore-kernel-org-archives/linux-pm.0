From: Steve Muckle <steve.muckle@linaro.org>
Subject: [PATCH v2 1/3] cpufreq: add resolve_freq driver callback
Date: Wed, 25 May 2016 19:52:59 -0700
Message-ID: <1464231181-30741-2-git-send-email-smuckle@linaro.org>
References: <1464231181-30741-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464231181-30741-1-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Cpufreq governors may need to know what a particular target frequency
maps to in the driver without necessarily wanting to set the frequency.
Support this operation via a new cpufreq API,
cpufreq_driver_resolve_freq().

The above API will call a new cpufreq driver callback, resolve_freq(),
if it has been registered by the driver. If that callback has not been
registered and a frequency table is available then the frequency table
is walked using cpufreq_frequency_table_target().

UINT_MAX is returned if no driver callback or frequency table is
available.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Steve Muckle <smuckle@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 25 +++++++++++++++++++++++++
 include/linux/cpufreq.h   | 11 +++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 77d77a4e3b74..3b44f4bdc071 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1849,6 +1849,31 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
 
+unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
+					 unsigned int target_freq)
+{
+	struct cpufreq_frequency_table *freq_table;
+	int index, retval;
+
+	clamp_val(target_freq, policy->min, policy->max);
+
+	if (cpufreq_driver->resolve_freq)
+		return cpufreq_driver->resolve_freq(policy, target_freq);
+
+	freq_table = cpufreq_frequency_get_table(policy->cpu);
+	if (!freq_table)
+		return UINT_MAX;
+
+	retval = cpufreq_frequency_table_target(policy, freq_table,
+						target_freq, CPUFREQ_RELATION_L,
+						&index);
+	if (retval)
+		return UINT_MAX;
+
+	return freq_table[index].frequency;
+}
+EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
+
 /* Must set freqs->new to intermediate frequency */
 static int __target_intermediate(struct cpufreq_policy *policy,
 				 struct cpufreq_freqs *freqs, int index)
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 4e81e08db752..675f17f98e75 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -271,6 +271,13 @@ struct cpufreq_driver {
 	int		(*target_intermediate)(struct cpufreq_policy *policy,
 					       unsigned int index);
 
+	/*
+	 * Return the driver-supported frequency that a particular target
+	 * frequency maps to (does not set the new frequency).
+	 */
+	unsigned int	(*resolve_freq)(struct cpufreq_policy *policy,
+					unsigned int target_freq);
+
 	/* should be defined, if possible */
 	unsigned int	(*get)(unsigned int cpu);
 
@@ -487,6 +494,10 @@ int cpufreq_driver_target(struct cpufreq_policy *policy,
 int __cpufreq_driver_target(struct cpufreq_policy *policy,
 				   unsigned int target_freq,
 				   unsigned int relation);
+
+unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
+					 unsigned int target_freq);
+
 int cpufreq_register_governor(struct cpufreq_governor *governor);
 void cpufreq_unregister_governor(struct cpufreq_governor *governor);
 
-- 
2.4.10
