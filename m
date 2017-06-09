From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/3] cpufreq: schedutil: Restore cached_raw_freq behavior
Date: Fri,  9 Jun 2017 15:45:54 +0530
Message-ID: <f979ca208e4582b7db1eed17df5543d4b70d5de7.1497002895.git.viresh.kumar@linaro.org>
References: <cover.1497002895.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1497002895.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1497002895.git.viresh.kumar@linaro.org>
References: <cover.1497002895.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, patrick.bellasi@arm.com, john.ettedgui@gmail.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

The purpose of the "cached_raw_freq" field is to avoid a call to
cpufreq_driver_resolve_freq() when the next selected frequency is same
as the one selected last time and we can use sg_policy->next_freq then.

With the recent changes (reduce frequencies slower), we update the next
frequency at the very last moment from sugov_update_commit() and that
breaks the working of cached_raw_freq somewhat.

Here is an example to illustrate what happens now.
Min freq: 1 GHz
Max and current freq: 4 GHz

- get_next_freq() gets called and it calculates the next frequency to be
  1 GHz and so it updates cached_raw_freq as 1 GHz as well. It then
  calls cpufreq_driver_resolve_freq() and that also returns 1 GHz.

- We then call sugov_update_commit() and it updates the
  sg_policy->next_freq to 2.5 GHz.

- get_next_freq() gets called again and this time it calculates the next
  frequency as 2.5 GHz. Even when the previous next_freq was set to 2.5
  GHz, we end up calling cpufreq_driver_resolve_freq() as
  cached_raw_freq was set to 1 GHz.

Moreover, it is not right to update the target frequency after we have
called cpufreq_driver_resolve_freq() as that was called to map the
target frequency to the driver supported one, so that we can avoid the
update completely if we are already at the driver supported frequency.

Fix this by moving the newly added code to get_next_freq() before the
cached_raw_freq is accessed/updated.

Also add a minor comment above that code to explain why it is done.

We cannot take a simple average anymore as the "freq" here can be well
below policy->min and we may end up reducing the frequency drastically.
Take care of that by making sure "freq" is at least as much as
policy->min.

Fixes: 39b64aa1c007 ("cpufreq: schedutil: Reduce frequencies slower")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 622eed1b7658..1852bd73d903 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -101,9 +101,6 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
 	if (sg_policy->next_freq == next_freq)
 		return;
 
-	if (sg_policy->next_freq > next_freq)
-		next_freq = (sg_policy->next_freq + next_freq) >> 1;
-
 	sg_policy->next_freq = next_freq;
 	sg_policy->last_freq_update_time = time;
 
@@ -151,6 +148,17 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 
 	freq = (freq + (freq >> 2)) * util / max;
 
+	/*
+	 * Reduce frequency gradually to avoid undesirable performance drops.
+	 * Before that we need to make sure that freq >= policy->min, else we
+	 * may still end up reducing frequency rapidly.
+	 */
+	if (freq < policy->min)
+		freq = policy->min;
+
+	if (sg_policy->next_freq > freq)
+		freq = (sg_policy->next_freq + freq) >> 1;
+
 	if (freq == sg_policy->cached_raw_freq && sg_policy->next_freq != UINT_MAX)
 		return sg_policy->next_freq;
 	sg_policy->cached_raw_freq = freq;
-- 
2.13.0.70.g6367777092d9
