From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [RFC PATCH v2 1/6] sched/fair: Create util_fits_capacity()
Date: Fri,  6 Apr 2018 16:36:02 +0100
Message-ID: <20180406153607.17815-2-dietmar.eggemann@arm.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180406153607.17815-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Quentin Perret <quentin.perret@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>
Cc: linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@redhat.com>, Steve Muckle <smuckle@google.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

The functionality that a given utilization fits into a given capacity
is factored out into a separate function.

Currently it is only used in wake_cap() but will be re-used to figure
out if a cpu or a scheduler group is over-utilized.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/fair.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0951d1c58d2f..0a76ad2ef022 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6574,6 +6574,11 @@ static unsigned long cpu_util_wake(int cpu, struct task_struct *p)
 	return min_t(unsigned long, util, capacity_orig_of(cpu));
 }
 
+static inline int util_fits_capacity(unsigned long util, unsigned long capacity)
+{
+	return capacity * 1024 > util * capacity_margin;
+}
+
 /*
  * Disable WAKE_AFFINE in the case where task @p doesn't fit in the
  * capacity of either the waking CPU @cpu or the previous CPU @prev_cpu.
@@ -6595,7 +6600,7 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
 	/* Bring task utilization in sync with prev_cpu */
 	sync_entity_load_avg(&p->se);
 
-	return min_cap * 1024 < task_util(p) * capacity_margin;
+	return !util_fits_capacity(task_util(p), min_cap);
 }
 
 /*
-- 
2.11.0
