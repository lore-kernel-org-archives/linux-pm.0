From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFC PATCH 09/10] sched: Include blocked utilization in usage tracking
Date: Tue,  2 Dec 2014 14:06:31 +0000
Message-ID: <1417529192-11579-10-git-send-email-morten.rasmussen@arm.com>
References: <1417529192-11579-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1417529192-11579-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: dietmar.eggemann@arm.com, vincent.guittot@linaro.org, pjt@google.com, bsegall@google.com, mturquette@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

Add the blocked utilization contribution to group sched_entity
utilization (se->avg.utilization_avg_contrib) and to get_cpu_usage().
With this change cpu usage now includes recent usage by currently
non-runnable tasks, hence it provides a more stable view of the cpu
usage. It does, however, also mean that the meaning of usage is changed:
A cpu may be momentarily idle while usage >0. It can no longer be
assumed that cpu usage >0 implies runnable tasks on the rq.
cfs_rq->utilization_load_avg or nr_running should be used instead to get
the current rq status.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index adf64df..bd950b2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2764,7 +2764,8 @@ static long __update_entity_utilization_avg_contrib(s=
truct sched_entity *se)
 =09=09__update_task_entity_utilization(se);
 =09else
 =09=09se->avg.utilization_avg_contrib =3D
-=09=09=09=09=09group_cfs_rq(se)->utilization_load_avg;
+=09=09=09=09group_cfs_rq(se)->utilization_load_avg +
+=09=09=09=09group_cfs_rq(se)->utilization_blocked_avg;
=20
 =09return se->avg.utilization_avg_contrib - old_contrib;
 }
@@ -4827,11 +4828,12 @@ static int select_idle_sibling(struct task_struct *=
p, int target)
 static int get_cpu_usage(int cpu)
 {
 =09unsigned long usage =3D cpu_rq(cpu)->cfs.utilization_load_avg;
+=09unsigned long blocked =3D cpu_rq(cpu)->cfs.utilization_blocked_avg;
=20
-=09if (usage >=3D SCHED_LOAD_SCALE)
+=09if (usage + blocked >=3D SCHED_LOAD_SCALE)
 =09=09return capacity_orig_of(cpu);
=20
-=09return usage;
+=09return usage + blocked;
 }
=20
 /*
--=20
1.9.1
