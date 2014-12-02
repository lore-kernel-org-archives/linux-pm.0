From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFC PATCH 10/10] sched: Include blocked load in weighted_cpuload
Date: Tue,  2 Dec 2014 14:06:32 +0000
Message-ID: <1417529192-11579-11-git-send-email-morten.rasmussen@arm.com>
References: <1417529192-11579-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1417529192-11579-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: dietmar.eggemann@arm.com, vincent.guittot@linaro.org, pjt@google.com, bsegall@google.com, mturquette@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

Adds blocked_load_avg to weighted_cpuload() to take recently runnable
tasks into account in load-balancing decisions. This changes the nature
of weighted_cpuload() as it may >0 while there are currently no runnable
tasks on the cpu rq. Hence care must be taken in the load-balance code
to use cfs_rq->runnable_load_avg or nr_running when current rq status is
needed.

This patch is highly experimental and will probably have require
additional updates of the users of weighted_cpuload().

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bd950b2..ad0ebb7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4349,7 +4349,8 @@ static void dequeue_task_fair(struct rq *rq, struct t=
ask_struct *p, int flags)
 /* Used instead of source_load when we know the type =3D=3D 0 */
 static unsigned long weighted_cpuload(const int cpu)
 {
-=09return cpu_rq(cpu)->cfs.runnable_load_avg;
+=09return cpu_rq(cpu)->cfs.runnable_load_avg
+=09=09+ cpu_rq(cpu)->cfs.blocked_load_avg;
 }
=20
 /*
--=20
1.9.1
