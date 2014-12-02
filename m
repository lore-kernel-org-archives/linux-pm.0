From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFC PATCH 02/10] sched: Make usage and load tracking cpu scale-invariant
Date: Tue,  2 Dec 2014 14:06:24 +0000
Message-ID: <1417529192-11579-3-git-send-email-morten.rasmussen@arm.com>
References: <1417529192-11579-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1417529192-11579-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: dietmar.eggemann@arm.com, vincent.guittot@linaro.org, pjt@google.com, bsegall@google.com, mturquette@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

Besides the existing frequency scale-invariance correction factor, apply
cpu scale-invariance correction factor to usage and load tracking.

Cpu scale-invariance takes cpu performance deviations due to
micro-architectural differences (i.e. instructions per seconds) between
cpus in HMP systems (e.g. big.LITTLE) and differences in the frequency
value of the highest OPP between cpus in SMP systems into consideration.

Each segment of the sched_avg::{running_avg_sum, runnable_avg_sum}
geometric series is now scaled by the cpu performance factor too so the
sched_avg::{utilization_avg_contrib, load_avg_contrib} of each entity will
be invariant from the particular cpu of the HMP/SMP system it is gathered
on. As a result, cfs_rq::runnable_load_avg which is the sum of
sched_avg::load_avg_contrib, becomes cpu scale-invariant too.

So the {usage, load} level that is returned by {get_cpu_usage,
weighted_cpuload} stays relative to the max cpu performance of the system.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/fair.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b41f03d..5c4c989 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2473,6 +2473,21 @@ static u32 __compute_runnable_contrib(u64 n)
 }
=20
 unsigned long __weak arch_scale_freq_capacity(struct sched_domain *sd, int=
 cpu);
+unsigned long __weak arch_scale_cpu_capacity(struct sched_domain *sd, int =
cpu);
+
+static unsigned long contrib_scale_factor(int cpu)
+{
+=09unsigned long scale_factor;
+
+=09scale_factor =3D arch_scale_freq_capacity(NULL, cpu);
+=09scale_factor *=3D arch_scale_cpu_capacity(NULL, cpu);
+=09scale_factor >>=3D SCHED_CAPACITY_SHIFT;
+
+=09return scale_factor;
+}
+
+#define scale_contrib(contrib, scale_factor) \
+=09((contrib * scale_factor) >> SCHED_CAPACITY_SHIFT)
=20
 /*
  * We can represent the historical contribution to runnable average as the
@@ -2510,7 +2525,7 @@ static __always_inline int __update_entity_runnable_a=
vg(u64 now, int cpu,
 =09u64 delta, scaled_delta, periods;
 =09u32 runnable_contrib, scaled_runnable_contrib;
 =09int delta_w, scaled_delta_w, decayed =3D 0;
-=09unsigned long scale_freq =3D arch_scale_freq_capacity(NULL, cpu);
+=09unsigned long scale_factor;
=20
 =09delta =3D now - sa->last_runnable_update;
 =09/*
@@ -2531,6 +2546,8 @@ static __always_inline int __update_entity_runnable_a=
vg(u64 now, int cpu,
 =09=09return 0;
 =09sa->last_runnable_update =3D now;
=20
+=09scale_factor =3D contrib_scale_factor(cpu);
+
 =09/* delta_w is the amount already accumulated against our next period */
 =09delta_w =3D sa->avg_period % 1024;
 =09if (delta + delta_w >=3D 1024) {
@@ -2543,7 +2560,7 @@ static __always_inline int __update_entity_runnable_a=
vg(u64 now, int cpu,
 =09=09 * period and accrue it.
 =09=09 */
 =09=09delta_w =3D 1024 - delta_w;
-=09=09scaled_delta_w =3D (delta_w * scale_freq) >> SCHED_CAPACITY_SHIFT;
+=09=09scaled_delta_w =3D scale_contrib(delta_w, scale_factor);
=20
 =09=09if (runnable)
 =09=09=09sa->runnable_avg_sum +=3D scaled_delta_w;
@@ -2566,8 +2583,8 @@ static __always_inline int __update_entity_runnable_a=
vg(u64 now, int cpu,
=20
 =09=09/* Efficiently calculate \sum (1..n_period) 1024*y^i */
 =09=09runnable_contrib =3D __compute_runnable_contrib(periods);
-=09=09scaled_runnable_contrib =3D (runnable_contrib * scale_freq)
-=09=09=09=09=09=09>> SCHED_CAPACITY_SHIFT;
+=09=09scaled_runnable_contrib =3D
+=09=09=09scale_contrib(runnable_contrib, scale_factor);
=20
 =09=09if (runnable)
 =09=09=09sa->runnable_avg_sum +=3D scaled_runnable_contrib;
@@ -2577,7 +2594,7 @@ static __always_inline int __update_entity_runnable_a=
vg(u64 now, int cpu,
 =09}
=20
 =09/* Remainder of delta accrued against u_0` */
-=09scaled_delta =3D (delta * scale_freq) >> SCHED_CAPACITY_SHIFT;
+=09scaled_delta =3D scale_contrib(delta, scale_factor);
=20
 =09if (runnable)
 =09=09sa->runnable_avg_sum +=3D scaled_delta;
--=20
1.9.1
