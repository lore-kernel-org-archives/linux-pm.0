From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [PATCH v3] cpufreq: conservative: Decrease frequency faster when the
 update deferred
Date: Tue, 15 Nov 2016 23:25:19 +0200
Message-ID: <faad4ff0-8115-059b-2ebc-2cec2a76fafe@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.semaphore.gr ([138.201.185.188]:55262 "EHLO
        mail.semaphore.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752745AbcKOVZc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Nov 2016 16:25:32 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Conservative governor changes the CPU frequency in steps.
That means that if a CPU runs at max frequency, it will need several
sampling periods to return to min frequency when the workload
is finished.

If the update function that calculates the load and target frequency
is deferred, the governor might need even more time to decrease the
frequency.

This may have impact to power consumption and after all conservative
should decrease the frequency if there is no workload at every sampling
rate.

To resolve the above issue calculate the number of sampling periods
that the update is deferred. Considering that for each sampling period
conservative should drop the frequency by a freq_step because the
CPU was idle apply the proper subtraction to requested frequency.

Below, the kernel trace with and without this patch. First an
intensive workload is applied on a specific CPU. Then the workload
is removed and the CPU goes to idle.

WITHOUT

     <idle>-0     [007] dN..   620.329153: cpu_idle: state=4294967295 cpu_id=7
kworker/7:2-556   [007] ....   620.350857: cpu_frequency: state=1700000 cpu_id=7
kworker/7:2-556   [007] ....   620.370856: cpu_frequency: state=1900000 cpu_id=7
kworker/7:2-556   [007] ....   620.390854: cpu_frequency: state=2100000 cpu_id=7
kworker/7:2-556   [007] ....   620.411853: cpu_frequency: state=2200000 cpu_id=7
kworker/7:2-556   [007] ....   620.432854: cpu_frequency: state=2400000 cpu_id=7
kworker/7:2-556   [007] ....   620.453854: cpu_frequency: state=2600000 cpu_id=7
kworker/7:2-556   [007] ....   620.494856: cpu_frequency: state=2900000 cpu_id=7
kworker/7:2-556   [007] ....   620.515856: cpu_frequency: state=3100000 cpu_id=7
kworker/7:2-556   [007] ....   620.536858: cpu_frequency: state=3300000 cpu_id=7
kworker/7:2-556   [007] ....   620.557857: cpu_frequency: state=3401000 cpu_id=7
     <idle>-0     [007] d...   669.591363: cpu_idle: state=4 cpu_id=7
     <idle>-0     [007] d...   669.591939: cpu_idle: state=4294967295 cpu_id=7
     <idle>-0     [007] d...   669.591980: cpu_idle: state=4 cpu_id=7
     <idle>-0     [007] dN..   669.591989: cpu_idle: state=4294967295 cpu_id=7
...
     <idle>-0     [007] d...   670.201224: cpu_idle: state=4 cpu_id=7
     <idle>-0     [007] d...   670.221975: cpu_idle: state=4294967295 cpu_id=7
kworker/7:2-556   [007] ....   670.222016: cpu_frequency: state=3300000 cpu_id=7
     <idle>-0     [007] d...   670.222026: cpu_idle: state=4 cpu_id=7
     <idle>-0     [007] d...   670.234964: cpu_idle: state=4294967295 cpu_id=7
...
     <idle>-0     [007] d...   670.801251: cpu_idle: state=4 cpu_id=7
     <idle>-0     [007] d...   671.236046: cpu_idle: state=4294967295 cpu_id=7
kworker/7:2-556   [007] ....   671.236073: cpu_frequency: state=3100000 cpu_id=7
     <idle>-0     [007] d...   671.236112: cpu_idle: state=4 cpu_id=7
     <idle>-0     [007] d...   671.393437: cpu_idle: state=4294967295 cpu_id=7
...
     <idle>-0     [007] d...   671.401277: cpu_idle: state=4 cpu_id=7
     <idle>-0     [007] d...   671.404083: cpu_idle: state=4294967295 cpu_id=7
kworker/7:2-556   [007] ....   671.404111: cpu_frequency: state=2900000 cpu_id=7
     <idle>-0     [007] d...   671.404125: cpu_idle: state=4 cpu_id=7
     <idle>-0     [007] d...   671.404974: cpu_idle: state=4294967295 cpu_id=7
...
     <idle>-0     [007] d...   671.501180: cpu_idle: state=4 cpu_id=7
     <idle>-0     [007] d...   671.995414: cpu_idle: state=4294967295 cpu_id=7
kworker/7:2-556   [007] ....   671.995459: cpu_frequency: state=2800000 cpu_id=7
     <idle>-0     [007] d...   671.995469: cpu_idle: state=4 cpu_id=7
     <idle>-0     [007] d...   671.996287: cpu_idle: state=4294967295 cpu_id=7
...
     <idle>-0     [007] d...   672.001305: cpu_idle: state=4 cpu_id=7
     <idle>-0     [007] d...   672.078374: cpu_idle: state=4294967295 cpu_id=7
kworker/7:2-556   [007] ....   672.078410: cpu_frequency: state=2600000 cpu_id=7
     <idle>-0     [007] d...   672.078419: cpu_idle: state=4 cpu_id=7
     <idle>-0     [007] d...   672.158020: cpu_idle: state=4294967295 cpu_id=7
kworker/7:2-556   [007] ....   672.158040: cpu_frequency: state=2400000 cpu_id=7
     <idle>-0     [007] d...   672.158044: cpu_idle: state=4 cpu_id=7
     <idle>-0     [007] d...   672.160038: cpu_idle: state=4294967295 cpu_id=7
...
     <idle>-0     [007] d...   672.234557: cpu_idle: state=4 cpu_id=7
     <idle>-0     [007] d...   672.237121: cpu_idle: state=4294967295 cpu_id=7
kworker/7:2-556   [007] ....   672.237174: cpu_frequency: state=2100000 cpu_id=7
     <idle>-0     [007] d...   672.237186: cpu_idle: state=4 cpu_id=7
     <idle>-0     [007] d...   672.237778: cpu_idle: state=4294967295 cpu_id=7
...
     <idle>-0     [007] d...   672.267902: cpu_idle: state=4 cpu_id=7
     <idle>-0     [007] d...   672.269860: cpu_idle: state=4294967295 cpu_id=7
kworker/7:2-556   [007] ....   672.269906: cpu_frequency: state=1900000 cpu_id=7
     <idle>-0     [007] d...   672.269914: cpu_idle: state=4 cpu_id=7
     <idle>-0     [007] d...   672.271902: cpu_idle: state=4294967295 cpu_id=7
...
     <idle>-0     [007] d...   672.751342: cpu_idle: state=4 cpu_id=7
     <idle>-0     [007] d...   672.823056: cpu_idle: state=4294967295 cpu_id=7
kworker/7:2-556   [007] ....   672.823095: cpu_frequency: state=1600000 cpu_id=7

WITH

     <idle>-0     [007] dN..  4380.928009: cpu_idle: state=4294967295 cpu_id=7
kworker/7:2-399   [007] ....  4380.949767: cpu_frequency: state=2000000 cpu_id=7
kworker/7:2-399   [007] ....  4380.969765: cpu_frequency: state=2200000 cpu_id=7
kworker/7:2-399   [007] ....  4381.009766: cpu_frequency: state=2500000 cpu_id=7
kworker/7:2-399   [007] ....  4381.029767: cpu_frequency: state=2600000 cpu_id=7
kworker/7:2-399   [007] ....  4381.049769: cpu_frequency: state=2800000 cpu_id=7
kworker/7:2-399   [007] ....  4381.069769: cpu_frequency: state=3000000 cpu_id=7
kworker/7:2-399   [007] ....  4381.089771: cpu_frequency: state=3100000 cpu_id=7
kworker/7:2-399   [007] ....  4381.109772: cpu_frequency: state=3400000 cpu_id=7
kworker/7:2-399   [007] ....  4381.129773: cpu_frequency: state=3401000 cpu_id=7
     <idle>-0     [007] d...  4428.226159: cpu_idle: state=1 cpu_id=7
     <idle>-0     [007] d...  4428.226176: cpu_idle: state=4294967295 cpu_id=7
     <idle>-0     [007] d...  4428.226181: cpu_idle: state=4 cpu_id=7
     <idle>-0     [007] d...  4428.227177: cpu_idle: state=4294967295 cpu_id=7
...
     <idle>-0     [007] d...  4428.551640: cpu_idle: state=4 cpu_id=7
     <idle>-0     [007] d...  4428.649239: cpu_idle: state=4294967295 cpu_id=7
kworker/7:2-399   [007] ....  4428.649268: cpu_frequency: state=2800000 cpu_id=7
     <idle>-0     [007] d...  4428.649278: cpu_idle: state=4 cpu_id=7
     <idle>-0     [007] d...  4428.689856: cpu_idle: state=4294967295 cpu_id=7
...
     <idle>-0     [007] d...  4428.799542: cpu_idle: state=4 cpu_id=7
     <idle>-0     [007] d...  4428.801683: cpu_idle: state=4294967295 cpu_id=7
kworker/7:2-399   [007] ....  4428.801748: cpu_frequency: state=1700000 cpu_id=7
     <idle>-0     [007] d...  4428.801761: cpu_idle: state=4 cpu_id=7
     <idle>-0     [007] d...  4428.806545: cpu_idle: state=4294967295 cpu_id=7
...
     <idle>-0     [007] d...  4429.051880: cpu_idle: state=4 cpu_id=7
     <idle>-0     [007] d...  4429.086240: cpu_idle: state=4294967295 cpu_id=7
kworker/7:2-399   [007] ....  4429.086293: cpu_frequency: state=1600000 cpu_id=7

Without the patch the CPU dropped to min frequency after 3.2s
With the patch applied the CPU dropped to min frequency after 0.86s

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---
 v2 -> v3
- cpufreq_conservative.c: move the calculation below the block that check
the limits
- Calculate the freq_step only once
- Fix the bug introduced in dbs_update() because of wrong estimation of
'if' conditions

 v1 -> v2
- Use correct terminology in change log
- Change the member variable name from 'deferred_periods' to 'idle_periods'
- Fix format issue

 drivers/cpufreq/cpufreq_conservative.c | 21 ++++++++++++++++++---
 drivers/cpufreq/cpufreq_governor.c     |  9 ++++++++-
 drivers/cpufreq/cpufreq_governor.h     |  1 +
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 0681fcf..808cc4d 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -66,6 +66,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 	unsigned int load = dbs_update(policy);
+	unsigned int freq_step;

 	/*
 	 * break out if we 'cannot' reduce the speed as the user might
@@ -82,6 +83,22 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
 	if (requested_freq > policy->max || requested_freq < policy->min)
 		requested_freq = policy->cur;

+	freq_step = get_freq_step(cs_tuners, policy);
+
+	/*
+	 * Decrease requested_freq one freq_step for each idle period that
+	 * we didn't update the frequency.
+	 */
+	if (policy_dbs->idle_periods < UINT_MAX) {
+		unsigned int freq_steps = policy_dbs->idle_periods * freq_step;
+
+		if (requested_freq > freq_steps)
+			requested_freq -= freq_steps;
+		else
+			requested_freq = policy->min;
+		policy_dbs->idle_periods = UINT_MAX;
+	}
+
 	/* Check for frequency increase */
 	if (load > dbs_data->up_threshold) {
 		dbs_info->down_skip = 0;
@@ -90,7 +107,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
 		if (requested_freq == policy->max)
 			goto out;

-		requested_freq += get_freq_step(cs_tuners, policy);
+		requested_freq += freq_step;
 		if (requested_freq > policy->max)
 			requested_freq = policy->max;

@@ -106,14 +123,12 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)

 	/* Check for frequency decrease */
 	if (load < cs_tuners->down_threshold) {
-		unsigned int freq_step;
 		/*
 		 * if we cannot reduce the frequency anymore, break out early
 		 */
 		if (requested_freq == policy->min)
 			goto out;

-		freq_step = get_freq_step(cs_tuners, policy);
 		if (requested_freq > freq_step)
 			requested_freq -= freq_step;
 		else
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 3729474..9780f50 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -117,7 +117,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	unsigned int ignore_nice = dbs_data->ignore_nice_load;
-	unsigned int max_load = 0;
+	unsigned int max_load = 0, idle_periods = UINT_MAX;
 	unsigned int sampling_rate, io_busy, j;

 	/*
@@ -214,10 +214,17 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 			}
 			j_cdbs->prev_load = load;
 		}
+		if (time_elapsed > 2 * sampling_rate) {
+			unsigned int periods = time_elapsed / sampling_rate;

+			if (periods < idle_periods)
+				idle_periods = periods;
+		}
 		if (load > max_load)
 			max_load = load;
 	}
+	policy_dbs->idle_periods = idle_periods;
+
 	return max_load;
 }
 EXPORT_SYMBOL_GPL(dbs_update);
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 9660cc6..10a3e0a 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -97,6 +97,7 @@ struct policy_dbs_info {
 	struct list_head list;
 	/* Multiplier for increasing sample delay temporarily. */
 	unsigned int rate_mult;
+	unsigned int idle_periods;
 	/* Status indicators */
 	bool is_shared;		/* This object is used by multiple CPUs */
 	bool work_in_progress;	/* Work is being queued up or in progress */
-- 
2.7.4
