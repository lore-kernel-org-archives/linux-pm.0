From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFC PATCH 12/16] sched: Task wakeup tracking
Date: Fri, 23 May 2014 19:16:39 +0100
Message-ID: <1400869003-27769-13-git-send-email-morten.rasmussen@arm.com>
References: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

Track task wakeup rate in wakeup_avg_sum by counting wakeups. Note that
this is _not_ cpu wakeups (idle exits). Task wakeups only cause cpu
wakeups if the cpu is idle when the task wakeup occurs.

The wakeup rate decays over time at the same rate as used for the
existing entity load tracking. Unlike runnable_avg_sum, wakeup_avg_sum
is counting events, not time, and is therefore theoretically unbounded
and should be used with care.

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 include/linux/sched.h |    3 +++
 kernel/sched/fair.c   |   18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 727b936..d7b032f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1109,6 +1109,9 @@ struct sched_avg {
 =09u64 last_runnable_update;
 =09s64 decay_count;
 =09unsigned long load_avg_contrib;
+
+=09unsigned long last_wakeup_update;
+=09u32 wakeup_avg_sum;
 };
=20
 #ifdef CONFIG_SCHEDSTATS
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 09e5232..39e9cd8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -679,6 +679,8 @@ void init_task_runnable_average(struct task_struct *p)
 =09p->se.avg.runnable_avg_sum =3D slice;
 =09p->se.avg.runnable_avg_period =3D slice;
 =09__update_task_entity_contrib(&p->se);
+
+=09p->se.avg.last_wakeup_update =3D jiffies;
 }
 #else
 void init_task_runnable_average(struct task_struct *p)
@@ -4025,6 +4027,21 @@ static void record_wakee(struct task_struct *p)
 =09}
 }
=20
+static void update_wakeup_avg(struct task_struct *p)
+{
+=09struct sched_entity *se =3D &p->se;
+=09struct sched_avg *sa =3D &se->avg;
+=09unsigned long now =3D ACCESS_ONCE(jiffies);
+
+=09if (time_after(now, sa->last_wakeup_update)) {
+=09=09sa->wakeup_avg_sum =3D decay_load(sa->wakeup_avg_sum,
+=09=09=09=09jiffies_to_msecs(now - sa->last_wakeup_update));
+=09=09sa->last_wakeup_update =3D now;
+=09}
+
+=09sa->wakeup_avg_sum +=3D 1024;
+}
+
 static void task_waking_fair(struct task_struct *p)
 {
 =09struct sched_entity *se =3D &p->se;
@@ -4045,6 +4062,7 @@ static void task_waking_fair(struct task_struct *p)
=20
 =09se->vruntime -=3D min_vruntime;
 =09record_wakee(p);
+=09update_wakeup_avg(p);
 }
=20
 #ifdef CONFIG_FAIR_GROUP_SCHED
--=20
1.7.9.5
