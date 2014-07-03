From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv2 PATCH 11/23] sched: Introduce an unweighted cpu_load array
Date: Thu,  3 Jul 2014 17:25:58 +0100
Message-ID: <1404404770-323-12-git-send-email-morten.rasmussen@arm.com>
References: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, Dietmar.Eggemann@arm.com, pjt@google.com
List-Id: linux-pm@vger.kernel.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

Maintain an unweighted (uw) cpu_load array as the uw counterpart
of rq.cpu_load[].

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/core.c  |    4 +++-
 kernel/sched/proc.c  |   22 ++++++++++++++++++----
 kernel/sched/sched.h |    1 +
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d7544a..d814064 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7114,8 +7114,10 @@ void __init sched_init(void)
 =09=09init_tg_rt_entry(&root_task_group, &rq->rt, NULL, i, NULL);
 #endif
=20
-=09=09for (j =3D 0; j < CPU_LOAD_IDX_MAX; j++)
+=09=09for (j =3D 0; j < CPU_LOAD_IDX_MAX; j++) {
 =09=09=09rq->cpu_load[j] =3D 0;
+=09=09=09rq->uw_cpu_load[j] =3D 0;
+=09=09}
=20
 =09=09rq->last_load_update_tick =3D jiffies;
=20
diff --git a/kernel/sched/proc.c b/kernel/sched/proc.c
index 16f5a30..2260092 100644
--- a/kernel/sched/proc.c
+++ b/kernel/sched/proc.c
@@ -471,6 +471,7 @@ decay_load_missed(unsigned long load, unsigned long mis=
sed_updates, int idx)
  * every tick. We fix it up based on jiffies.
  */
 static void __update_cpu_load(struct rq *this_rq, unsigned long this_load,
+=09=09=09      unsigned long uw_this_load,
 =09=09=09      unsigned long pending_updates)
 {
 =09int i, scale;
@@ -479,14 +480,20 @@ static void __update_cpu_load(struct rq *this_rq, uns=
igned long this_load,
=20
 =09/* Update our load: */
 =09this_rq->cpu_load[0] =3D this_load; /* Fasttrack for idx 0 */
+=09this_rq->uw_cpu_load[0] =3D uw_this_load; /* Fasttrack for idx 0 */
 =09for (i =3D 1, scale =3D 2; i < CPU_LOAD_IDX_MAX; i++, scale +=3D scale)=
 {
-=09=09unsigned long old_load, new_load;
+=09=09unsigned long old_load, new_load, uw_old_load, uw_new_load;
=20
 =09=09/* scale is effectively 1 << i now, and >> i divides by scale */
=20
 =09=09old_load =3D this_rq->cpu_load[i];
 =09=09old_load =3D decay_load_missed(old_load, pending_updates - 1, i);
 =09=09new_load =3D this_load;
+
+=09=09uw_old_load =3D this_rq->uw_cpu_load[i];
+=09=09uw_old_load =3D decay_load_missed(uw_old_load,
+=09=09=09=09pending_updates - 1, i);
+=09=09uw_new_load =3D uw_this_load;
 =09=09/*
 =09=09 * Round up the averaging division if load is increasing. This
 =09=09 * prevents us from getting stuck on 9 if the load is 10, for
@@ -494,8 +501,12 @@ static void __update_cpu_load(struct rq *this_rq, unsi=
gned long this_load,
 =09=09 */
 =09=09if (new_load > old_load)
 =09=09=09new_load +=3D scale - 1;
+=09=09if (uw_new_load > uw_old_load)
+=09=09=09uw_new_load +=3D scale - 1;
=20
 =09=09this_rq->cpu_load[i] =3D (old_load * (scale - 1) + new_load) >> i;
+=09=09this_rq->uw_cpu_load[i] =3D (uw_old_load * (scale - 1) +
+=09=09=09=09=09=09uw_new_load) >> i;
 =09}
=20
 =09sched_avg_update(this_rq);
@@ -535,6 +546,7 @@ void update_idle_cpu_load(struct rq *this_rq)
 {
 =09unsigned long curr_jiffies =3D ACCESS_ONCE(jiffies);
 =09unsigned long load =3D get_rq_runnable_load(this_rq);
+=09unsigned long uw_load =3D this_rq->cfs.uw_runnable_load_avg;
 =09unsigned long pending_updates;
=20
 =09/*
@@ -546,7 +558,7 @@ void update_idle_cpu_load(struct rq *this_rq)
 =09pending_updates =3D curr_jiffies - this_rq->last_load_update_tick;
 =09this_rq->last_load_update_tick =3D curr_jiffies;
=20
-=09__update_cpu_load(this_rq, load, pending_updates);
+=09__update_cpu_load(this_rq, load, uw_load, pending_updates);
 }
=20
 /*
@@ -569,7 +581,7 @@ void update_cpu_load_nohz(void)
 =09=09 * We were idle, this means load 0, the current load might be
 =09=09 * !0 due to remote wakeups and the sort.
 =09=09 */
-=09=09__update_cpu_load(this_rq, 0, pending_updates);
+=09=09__update_cpu_load(this_rq, 0, 0, pending_updates);
 =09}
 =09raw_spin_unlock(&this_rq->lock);
 }
@@ -581,11 +593,13 @@ void update_cpu_load_nohz(void)
 void update_cpu_load_active(struct rq *this_rq)
 {
 =09unsigned long load =3D get_rq_runnable_load(this_rq);
+=09unsigned long uw_load =3D this_rq->cfs.uw_runnable_load_avg;
+
 =09/*
 =09 * See the mess around update_idle_cpu_load() / update_cpu_load_nohz().
 =09 */
 =09this_rq->last_load_update_tick =3D jiffies;
-=09__update_cpu_load(this_rq, load, 1);
+=09__update_cpu_load(this_rq, load, uw_load, 1);
=20
 =09calc_load_account_active(this_rq);
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d7d2ee2..455d152 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -521,6 +521,7 @@ struct rq {
 #endif
 =09#define CPU_LOAD_IDX_MAX 5
 =09unsigned long cpu_load[CPU_LOAD_IDX_MAX];
+=09unsigned long uw_cpu_load[CPU_LOAD_IDX_MAX];
 =09unsigned long last_load_update_tick;
 #ifdef CONFIG_NO_HZ_COMMON
 =09u64 nohz_stamp;
--=20
1.7.9.5
