From: "tip-bot for Rafael J. Wysocki" <tipbot@zytor.com>
Subject: [tip:sched/urgent] sched/fair: Fix !CONFIG_SMP kernel cpufreq
 governor breakage
Date: Fri, 6 May 2016 23:37:46 -0700
Message-ID: <tip-536bd00cdbb7b908573e5a93bae67b64cbae60d8@git.kernel.org>
References: <6282396.VVEdgVYxO3@vostro.rjw.lan>
Reply-To: rafael.j.wysocki@intel.com, mingo@kernel.org,
	  linux-pm@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
	  linux-kernel@vger.kernel.org, peterz@infradead.org,
	  torvalds@linux-foundation.org, viresh.kumar@linaro.org,
	  srinivas.pandruvada@linux.intel.com, steve.muckle@linaro.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6282396.VVEdgVYxO3@vostro.rjw.lan>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@kernel.org, rafael.j.wysocki@intel.com, tglx@linutronix.de, linux-pm@vger.kernel.org, steve.muckle@linaro.org, srinivas.pandruvada@linux.intel.com, torvalds@linux-foundation.org, viresh.kumar@linaro.org
List-Id: linux-pm@vger.kernel.org

Commit-ID:  536bd00cdbb7b908573e5a93bae67b64cbae60d8
Gitweb:     http://git.kernel.org/tip/536bd00cdbb7b908573e5a93bae67b64cbae60d8
Author:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
AuthorDate: Fri, 6 May 2016 14:58:43 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 7 May 2016 07:45:34 +0200

sched/fair: Fix !CONFIG_SMP kernel cpufreq governor breakage

The following commit:

  34e2c555f3e1 ("cpufreq: Add mechanism for registering utilization update callbacks")

overlooked the fact that update_load_avg(), where CFS invokes cpufreq
utilization update callbacks, becomes an empty stub on UP kernels.

In consequence, if !CONFIG_SMP, cpufreq governors are never invoked
from CFS and they do not have a chance to evaluate CPU performace
levels and update them often enough.

Needless to say, things don't work as expected then.

Fix the problem by making the !CONFIG_SMP stub of update_load_avg()
invoke cpufreq update callbacks too.

Reported-by: Steve Muckle <steve.muckle@linaro.org>
Tested-by: Steve Muckle <steve.muckle@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Steve Muckle <steve.muckle@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Fixes: 34e2c555f3e1 (cpufreq: Add mechanism for registering utilization update callbacks)
Link: http://lkml.kernel.org/r/6282396.VVEdgVYxO3@vostro.rjw.lan
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0fe30e6..40748dc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3030,7 +3030,14 @@ static int idle_balance(struct rq *this_rq);
 
 #else /* CONFIG_SMP */
 
-static inline void update_load_avg(struct sched_entity *se, int update_tg) {}
+static inline void update_load_avg(struct sched_entity *se, int not_used)
+{
+	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+	struct rq *rq = rq_of(cfs_rq);
+
+	cpufreq_trigger_update(rq_clock(rq));
+}
+
 static inline void
 enqueue_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 static inline void
