From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFC PATCH 07/10] sched: Get rid of scaling usage by cpu_capacity_orig
Date: Tue,  2 Dec 2014 14:06:29 +0000
Message-ID: <1417529192-11579-8-git-send-email-morten.rasmussen@arm.com>
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

Since now we have besides frequency invariant also cpu (uarch plus max
system frequency) invariant cfs_rq::utilization_load_avg both, frequency
and cpu scaling happens as part of the load tracking.
So cfs_rq::utilization_load_avg does not have to be scaled by the original
capacity of the cpu again.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/fair.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5c4c989..090223f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4806,12 +4806,11 @@ static int select_idle_sibling(struct task_struct *=
p, int target)
 static int get_cpu_usage(int cpu)
 {
 =09unsigned long usage =3D cpu_rq(cpu)->cfs.utilization_load_avg;
-=09unsigned long capacity =3D capacity_orig_of(cpu);
=20
 =09if (usage >=3D SCHED_LOAD_SCALE)
-=09=09return capacity;
+=09=09return capacity_orig_of(cpu);
=20
-=09return (usage * capacity) >> SCHED_LOAD_SHIFT;
+=09return usage;
 }
=20
 /*
--=20
1.9.1
