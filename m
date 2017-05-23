From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH RFC 6/8] sched/sched.h: remove sd arch_scale_freq_capacity parameter
Date: Tue, 23 May 2017 09:53:49 +0100
Message-ID: <20170523085351.18586-7-juri.lelli@arm.com>
References: <20170523085351.18586-1-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170523085351.18586-1-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, juri.lelli@arm.com, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

sd parameter is never used in arch_scale_freq_capacity (and it's hard to
see where information coming from scheduling domains might help doing
frequency invariance scaling).

Remove it; also in anticipation of moving arch_scale_freq_capacity
outside CONFIG_SMP.

Signed-off-by: Juri Lelli <juri.lelli@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c  | 2 +-
 kernel/sched/sched.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 219fe58e3023..b0f31064bbbd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2812,7 +2812,7 @@ accumulate_sum(u64 delta, int cpu, struct sched_avg *sa,
 	u32 contrib = (u32)delta; /* p == 0 -> delta < 1024 */
 	u64 periods;
 
-	scale_freq = arch_scale_freq_capacity(NULL, cpu);
+	scale_freq = arch_scale_freq_capacity(cpu);
 	scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
 
 	delta += sa->period_contrib;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e48cc8762e04..063fd8c47e75 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1641,7 +1641,7 @@ extern void sched_avg_update(struct rq *rq);
 
 #ifndef arch_scale_freq_capacity
 static __always_inline
-unsigned long arch_scale_freq_capacity(struct sched_domain *sd, int cpu)
+unsigned long arch_scale_freq_capacity(int cpu)
 {
 	return SCHED_CAPACITY_SCALE;
 }
@@ -1660,7 +1660,7 @@ unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
 
 static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta)
 {
-	rq->rt_avg += rt_delta * arch_scale_freq_capacity(NULL, cpu_of(rq));
+	rq->rt_avg += rt_delta * arch_scale_freq_capacity(cpu_of(rq));
 	sched_avg_update(rq);
 }
 #else
-- 
2.11.0
