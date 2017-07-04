From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH v2 4/6] cpufreq: schedutil: update CFS util only if used
Date: Tue,  4 Jul 2017 18:34:09 +0100
Message-ID: <1499189651-18797-5-git-send-email-patrick.bellasi@arm.com>
References: <1499189651-18797-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499189651-18797-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Joel Fernandes <joelaf@google.com>, Andres Oportus <andresoportus@google.com>, Todd Kjos <tkjos@android.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
List-Id: linux-pm@vger.kernel.org

Currently the utilization of the FAIR class is collected before locking
the policy. Although that should not be a big issue for most cases, we
also don't really know how much latency there can be between the
utilization reading and its usage.

Let's get the FAIR utilization right before its usage to be better in
sync with the current status of a CPU.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 kernel/sched/cpufreq_schedutil.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 98704d8..df433f1 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -308,10 +308,9 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 	if (unlikely(current == sg_policy->thread))
 		return;
 
-	sugov_get_util(&util, &max);
-
 	raw_spin_lock(&sg_policy->update_lock);
 
+	sugov_get_util(&util, &max);
 	sg_cpu->util = util;
 	sg_cpu->max = max;
 
-- 
2.7.4
