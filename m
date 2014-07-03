From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv2 PATCH 20/23] sched: Take task wakeups into account in energy estimates
Date: Thu,  3 Jul 2014 17:26:07 +0100
Message-ID: <1404404770-323-21-git-send-email-morten.rasmussen@arm.com>
References: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:53542 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758067AbaGCQ2d (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jul 2014 12:28:33 -0400
In-Reply-To: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, Dietmar.Eggemann@arm.com, pjt@google.com

The energy cost of waking a cpu and sending it back to sleep can be
quite significant for short running frequently waking tasks if placed on
an idle cpu in a deep sleep state. By factoring task wakeups in such
tasks can be placed on cpus where the wakeup energy cost is lower. For
example, partly utilized cpus in a shallower idle state, or cpus in a
cluster/die that is already awake.

Current cpu utilization of the target cpu is factored in to guess how
many task wakeups translate into cpu wakeups (idle exits). It is a
very naive approach, but it is virtually impossible to get an accurate
estimate.

wake_energy(task) =3D unused_util(cpu) * wakeups(task) * wakeup_energy(cpu)

There is no per cpu wakeup tracking, so we can't estimate the energy
savings when removing tasks from a cpu. It is also nearly impossible to
figure out which task is the cause of cpu wakeups if multiple tasks are
scheduled on the same cpu.

wakeup_energy for each idle-state is obtained from the idle_states array.
A prediction of the most likely idle-state is needed. cpuidle is best
placed to provide that. It is not implemented yet.

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c |   21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6da8e2b..aebf3e2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4367,11 +4367,13 @@ static inline unsigned long get_curr_capacity(int c=
pu);
  *=09=09=09=09+ (1-curr_util(sg)) * idle_power(sg)
  *=09energy_after =3D new_util(sg) * busy_power(sg)
  *=09=09=09=09+ (1-new_util(sg)) * idle_power(sg)
+ *=09=09=09=09+ (1-new_util(sg)) * task_wakeups
+ *=09=09=09=09=09=09=09* wakeup_energy(sg)
  *=09energy_diff +=3D energy_before - energy_after
  * }
  *
  */
-static int energy_diff_util(int cpu, int util)
+static int energy_diff_util(int cpu, int util, int wakeups)
 {
 =09struct sched_domain *sd;
 =09int i;
@@ -4476,7 +4478,8 @@ static int energy_diff_util(int cpu, int util)
 =09=09 * The utilization change has no impact at this level (or any
 =09=09 * parent level).
 =09=09 */
-=09=09if (aff_util_bef =3D=3D aff_util_aft && curr_cap_idx =3D=3D new_cap_=
idx)
+=09=09if (aff_util_bef =3D=3D aff_util_aft && curr_cap_idx =3D=3D new_cap_=
idx
+=09=09=09=09&& unused_util_aft < 100)
 =09=09=09goto unlock;
=20
 =09=09/* Energy before */
@@ -4486,6 +4489,14 @@ static int energy_diff_util(int cpu, int util)
 =09=09/* Energy after */
 =09=09nrg_diff +=3D (aff_util_aft*new_state->power)/new_state->cap;
 =09=09nrg_diff +=3D (unused_util_aft * is->power)/new_state->cap;
+
+=09=09/*
+=09=09 * Estimate how many of the wakeups that happens while cpu is
+=09=09 * idle assuming they are uniformly distributed. Ignoring
+=09=09 * wakeups caused by other tasks.
+=09=09 */
+=09=09nrg_diff +=3D (wakeups * is->wu_energy >> 10)
+=09=09=09=09* unused_util_aft/new_state->cap;
 =09}
=20
 =09/*
@@ -4516,6 +4527,8 @@ static int energy_diff_util(int cpu, int util)
 =09=09/* Energy after */
 =09=09nrg_diff +=3D (aff_util_aft*new_state->power)/new_state->cap;
 =09=09nrg_diff +=3D (unused_util_aft * is->power)/new_state->cap;
+=09=09nrg_diff +=3D (wakeups * is->wu_energy >> 10)
+=09=09=09=09* unused_util_aft/new_state->cap;
 =09}
=20
 unlock:
@@ -4532,8 +4545,8 @@ static int energy_diff_task(int cpu, struct task_stru=
ct *p)
 =09if (!cpumask_test_cpu(cpu, tsk_cpus_allowed(p)))
 =09=09return INT_MAX;
=20
-=09return energy_diff_util(cpu, p->se.avg.uw_load_avg_contrib);
-
+=09return energy_diff_util(cpu, p->se.avg.uw_load_avg_contrib,
+=09=09=09p->se.avg.wakeup_avg_sum);
 }
=20
 static int wake_wide(struct task_struct *p)
--=20
1.7.9.5


