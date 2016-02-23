From: Steve Muckle <steve.muckle@linaro.org>
Subject: [RFCv7 PATCH 01/10] sched: Compute cpu capacity available at current frequency
Date: Mon, 22 Feb 2016 17:22:41 -0800
Message-ID: <1456190570-4475-2-git-send-email-smuckle@linaro.org>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

From: Morten Rasmussen <morten.rasmussen@arm.com>

capacity_orig_of() returns the max available compute capacity of a cpu.
For scale-invariant utilization tracking and energy-aware scheduling
decisions it is useful to know the compute capacity available at the
current OPP of a cpu.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Steve Muckle <smuckle@linaro.org>
---
 kernel/sched/fair.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7ce24a4..3437e01 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4821,6 +4821,17 @@ static long effective_load(struct task_group *tg, int cpu, long wl, long wg)
 #endif
 
 /*
+ * Returns the current capacity of cpu after applying both
+ * cpu and freq scaling.
+ */
+static unsigned long capacity_curr_of(int cpu)
+{
+	return cpu_rq(cpu)->cpu_capacity_orig *
+	       arch_scale_freq_capacity(NULL, cpu)
+	       >> SCHED_CAPACITY_SHIFT;
+}
+
+/*
  * Detect M:N waker/wakee relationships via a switching-frequency heuristic.
  * A waker of many should wake a different task than the one last awakened
  * at a frequency roughly N times higher than one of its wakees.  In order
-- 
2.4.10
