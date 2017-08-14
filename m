From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 2/2] cpufreq: schedutil: Always process remote callback with slow switching
Date: Mon, 14 Aug 2017 14:50:16 +0530
Message-ID: <c31960d7db67bdf4fc578fa967d4699291879f43.1502701992.git.viresh.kumar@linaro.org>
References: <2a395ea76235dce00828172a1129c46bf87a79c8.1502338812.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2a395ea76235dce00828172a1129c46bf87a79c8.1502338812.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Juri.Lelli@arm.com, joelaf@google.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The frequency update from the utilization update handlers can be divided
into two parts:

(A) Finding the next frequency
(B) Updating the frequency

While any CPU can do (A), (B) can be restricted to a group of CPUs only,
depending on the current platform.

For platforms where fast cpufreq switching is possible, both (A) and (B)
are always done from the same CPU and that CPU should be capable of
changing the frequency of the target CPU.

But for platforms where fast cpufreq switching isn't possible, after
doing (A) we wake up a kthread which will eventually do (B). This
kthread is already bound to the right set of CPUs, i.e. only those which
can change the frequency of CPUs of a cpufreq policy. And so any CPU
can actually do (A) in this case, as the frequency is updated from the
right set of CPUs only.

Check cpufreq_can_do_remote_dvfs() only for the fast switching case.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2: s/policy/sg_policy->policy/, missed updating the commit with local
updates earlier, noticed that just now.

 kernel/sched/cpufreq_schedutil.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 504d0752f8f2..9209d83ecdcf 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -84,13 +84,18 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 	 *
 	 * However, drivers cannot in general deal with cross-cpu
 	 * requests, so while get_next_freq() will work, our
-	 * sugov_update_commit() call may not.
+	 * sugov_update_commit() call may not for the fast switching platforms.
 	 *
 	 * Hence stop here for remote requests if they aren't supported
 	 * by the hardware, as calculating the frequency is pointless if
 	 * we cannot in fact act on it.
+	 *
+	 * For the slow switching platforms, the kthread is always scheduled on
+	 * the right set of CPUs and any CPU can find the next frequency and
+	 * schedule the kthread.
 	 */
-	if (!cpufreq_can_do_remote_dvfs(sg_policy->policy))
+	if (sg_policy->policy->fast_switch_enabled &&
+	    !cpufreq_can_do_remote_dvfs(sg_policy->policy))
 		return false;
 
 	if (sg_policy->work_in_progress)
-- 
2.7.4
