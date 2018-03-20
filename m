From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [RFC PATCH 1/6] sched/fair: Create util_fits_capacity()
Date: Tue, 20 Mar 2018 09:43:07 +0000
Message-ID: <20180320094312.24081-2-dietmar.eggemann@arm.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180320094312.24081-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Quentin Perret <quentin.perret@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>
Cc: linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
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
index 3582117e1580..bf7b485ddf60 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6374,6 +6374,11 @@ static unsigned long cpu_util_wake(int cpu, struct task_struct *p)
 	return (util >= capacity) ? capacity : util;
 }
 
+static inline int util_fits_capacity(unsigned long util, unsigned long capacity)
+{
+	return capacity * 1024 > util * capacity_margin;
+}
+
 /*
  * Disable WAKE_AFFINE in the case where task @p doesn't fit in the
  * capacity of either the waking CPU @cpu or the previous CPU @prev_cpu.
@@ -6395,7 +6400,7 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
 	/* Bring task utilization in sync with prev_cpu */
 	sync_entity_load_avg(&p->se);
 
-	return min_cap * 1024 < task_util(p) * capacity_margin;
+	return !util_fits_capacity(task_util(p), min_cap);
 }
 
 /*
-- 
2.11.0
