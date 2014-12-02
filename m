From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFC PATCH 01/10] sched: Make load tracking frequency scale-invariant
Date: Tue,  2 Dec 2014 14:06:23 +0000
Message-ID: <1417529192-11579-2-git-send-email-morten.rasmussen@arm.com>
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

Apply frequency scale-invariance correction factor to load tracking.
Each segment of the sched_avg::runnable_avg_sum geometric series is now
scaled by the current frequency so the sched_avg::load_avg_contrib of each
entity will be invariant with frequency scaling. As a result,
cfs_rq::runnable_load_avg which is the sum of sched_avg::load_avg_contrib,
becomes invariant too. So the load level that is returned by
weighted_cpuload, stays relative to the max frequency of the cpu.

Then, we want the keep the load tracking values in a 32bits type, which
implies that the max value of sched_avg::{runnable|running}_avg_sum must
be lower than 2^32/88761=3D48388 (88761 is the max weight of a task). As
LOAD_AVG_MAX =3D 47742, arch_scale_freq_capacity must return a value less
than (48388/47742) << SCHED_CAPACITY_SHIFT =3D 1037 (SCHED_SCALE_CAPACITY =
=3D
1024). So we define the range to [0..SCHED_SCALE_CAPACITY] in order to
avoid overflow.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/fair.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ee76d52..b41f03d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2507,9 +2507,9 @@ static __always_inline int __update_entity_runnable_a=
vg(u64 now, int cpu,
 =09=09=09=09=09=09=09int runnable,
 =09=09=09=09=09=09=09int running)
 {
-=09u64 delta, periods;
-=09u32 runnable_contrib;
-=09int delta_w, decayed =3D 0;
+=09u64 delta, scaled_delta, periods;
+=09u32 runnable_contrib, scaled_runnable_contrib;
+=09int delta_w, scaled_delta_w, decayed =3D 0;
 =09unsigned long scale_freq =3D arch_scale_freq_capacity(NULL, cpu);
=20
 =09delta =3D now - sa->last_runnable_update;
@@ -2543,11 +2543,12 @@ static __always_inline int __update_entity_runnable=
_avg(u64 now, int cpu,
 =09=09 * period and accrue it.
 =09=09 */
 =09=09delta_w =3D 1024 - delta_w;
+=09=09scaled_delta_w =3D (delta_w * scale_freq) >> SCHED_CAPACITY_SHIFT;
+
 =09=09if (runnable)
-=09=09=09sa->runnable_avg_sum +=3D delta_w;
+=09=09=09sa->runnable_avg_sum +=3D scaled_delta_w;
 =09=09if (running)
-=09=09=09sa->running_avg_sum +=3D delta_w * scale_freq
-=09=09=09=09>> SCHED_CAPACITY_SHIFT;
+=09=09=09sa->running_avg_sum +=3D scaled_delta_w;
 =09=09sa->avg_period +=3D delta_w;
=20
 =09=09delta -=3D delta_w;
@@ -2565,20 +2566,23 @@ static __always_inline int __update_entity_runnable=
_avg(u64 now, int cpu,
=20
 =09=09/* Efficiently calculate \sum (1..n_period) 1024*y^i */
 =09=09runnable_contrib =3D __compute_runnable_contrib(periods);
+=09=09scaled_runnable_contrib =3D (runnable_contrib * scale_freq)
+=09=09=09=09=09=09>> SCHED_CAPACITY_SHIFT;
+
 =09=09if (runnable)
-=09=09=09sa->runnable_avg_sum +=3D runnable_contrib;
+=09=09=09sa->runnable_avg_sum +=3D scaled_runnable_contrib;
 =09=09if (running)
-=09=09=09sa->running_avg_sum +=3D runnable_contrib * scale_freq
-=09=09=09=09>> SCHED_CAPACITY_SHIFT;
+=09=09=09sa->running_avg_sum +=3D scaled_runnable_contrib;
 =09=09sa->avg_period +=3D runnable_contrib;
 =09}
=20
 =09/* Remainder of delta accrued against u_0` */
+=09scaled_delta =3D (delta * scale_freq) >> SCHED_CAPACITY_SHIFT;
+
 =09if (runnable)
-=09=09sa->runnable_avg_sum +=3D delta;
+=09=09sa->runnable_avg_sum +=3D scaled_delta;
 =09if (running)
-=09=09sa->running_avg_sum +=3D delta * scale_freq
-=09=09=09>> SCHED_CAPACITY_SHIFT;
+=09=09sa->running_avg_sum +=3D scaled_delta;
 =09sa->avg_period +=3D delta;
=20
 =09return decayed;
--=20
1.9.1
