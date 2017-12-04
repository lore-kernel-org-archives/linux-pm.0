From: Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH v2 6/8] sched/sched.h: remove sd arch_scale_freq_capacity parameter
Date: Mon,  4 Dec 2017 11:23:23 +0100
Message-ID: <20171204102325.5110-7-juri.lelli@redhat.com>
References: <20171204102325.5110-1-juri.lelli@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171204102325.5110-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, alessio.balsini@arm.com, juri.lelli@redhat.com, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Juri Lelli <juri.lelli@arm.com>

sd parameter is never used in arch_scale_freq_capacity (and it's hard to
see where information coming from scheduling domains might help doing
frequency invariance scaling).

Remove it; also in anticipation of moving arch_scale_freq_capacity
outside CONFIG_SMP.

Signed-off-by: Juri Lelli <juri.lelli@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/arch_topology.h | 2 +-
 kernel/sched/fair.c           | 2 +-
 kernel/sched/sched.h          | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 304511267c82..2b709416de05 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -27,7 +27,7 @@ void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
 DECLARE_PER_CPU(unsigned long, freq_scale);
 
 static inline
-unsigned long topology_get_freq_scale(struct sched_domain *sd, int cpu)
+unsigned long topology_get_freq_scale(int cpu)
 {
 	return per_cpu(freq_scale, cpu);
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4037e19bbca2..535d9409f4af 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3122,7 +3122,7 @@ accumulate_sum(u64 delta, int cpu, struct sched_avg *sa,
 	u32 contrib = (u32)delta; /* p == 0 -> delta < 1024 */
 	u64 periods;
 
-	scale_freq = arch_scale_freq_capacity(NULL, cpu);
+	scale_freq = arch_scale_freq_capacity(cpu);
 	scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
 
 	delta += sa->period_contrib;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 280b421a82e8..b64207d54a55 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1712,7 +1712,7 @@ extern void sched_avg_update(struct rq *rq);
 
 #ifndef arch_scale_freq_capacity
 static __always_inline
-unsigned long arch_scale_freq_capacity(struct sched_domain *sd, int cpu)
+unsigned long arch_scale_freq_capacity(int cpu)
 {
 	return SCHED_CAPACITY_SCALE;
 }
@@ -1731,7 +1731,7 @@ unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
 
 static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta)
 {
-	rq->rt_avg += rt_delta * arch_scale_freq_capacity(NULL, cpu_of(rq));
+	rq->rt_avg += rt_delta * arch_scale_freq_capacity(cpu_of(rq));
 	sched_avg_update(rq);
 }
 #else
-- 
2.14.3
