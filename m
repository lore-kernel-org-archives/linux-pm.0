From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFC PATCH 13/16] sched: Take task wakeups into account in energy estimates
Date: Fri, 23 May 2014 19:16:40 +0100
Message-ID: <1400869003-27769-14-git-send-email-morten.rasmussen@arm.com>
References: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:36410 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbaEWSQ5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 May 2014 14:16:57 -0400
In-Reply-To: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, dietmar.eggemann@arm.com

The energy cost of waking a cpu and sending it back to sleep can be
quite significant for short running frequently waking tasks if placed on
an idle cpu in a deep sleep state. By factoring task wakeups in such
tasks can be placed on cpus where the wakeup energy cost is lower. For
example, partly utilized cpus in a shallower idle state, or cpus in a
cluster/die that is already awake.

Current cpu utilization of the target cpu is factored in guess how many
task wakeups that translate into cpu wakeups (idle exits). It is a very
naive approach, but it is virtually impossible to get an accurate estimate.

wake_energy(task) =3D unused_util(cpu) * wakeups(task) * wakeup_energy(cpu)

There is no per cpu wakeup tracking, so we can't estimate the energy
savings when removing tasks from a cpu. It is also nearly impossible to
figure out which task is the cause of cpu wakeups if multiple tasks are
scheduled on the same cpu.

Support for multiple idle-states per sched_group (e.g. WFI and core
shutdown on ARM) is not implemented yet. wakeup_energy in struct
sched_energy needs to be a table instead and cpuidle needs to tells
what the most likely state is.

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 39e9cd8..5a52467 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4271,11 +4271,13 @@ static void find_max_util(const struct cpumask *mas=
k, int cpu, int util,
  *=09=09=09=09+ 1-curr_util(sg) * idle_power(sg)
  *=09energy_after =3D new_util(sg) * busy_power(sg)
  *=09=09=09=09+ 1-new_util(sg) * idle_power(sg)
+ *=09=09=09=09+ new_util(sg) * task_wakeups
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
@@ -4368,7 +4370,8 @@ static int energy_diff_util(int cpu, int util)
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
@@ -4380,6 +4383,13 @@ static int energy_diff_util(int cpu, int util)
 =09=09energy_diff +=3D (aff_util_aft*new_state->power)/new_state->cap;
 =09=09energy_diff +=3D (unused_util_aft * sge->idle_power)
 =09=09=09=09/new_state->cap;
+=09=09/*
+=09=09 * Estimate how many of the wakeups that happens while cpu is
+=09=09 * idle assuming they are uniformly distributed. Ignoring
+=09=09 * wakeups caused by other tasks.
+=09=09 */
+=09=09energy_diff +=3D (wakeups * sge->wakeup_energy >> 10)
+=09=09=09=09* unused_util_aft/new_state->cap;
 =09}
=20
 =09/*
@@ -4410,6 +4420,8 @@ static int energy_diff_util(int cpu, int util)
 =09=09energy_diff +=3D (aff_util_aft*new_state->power)/new_state->cap;
 =09=09energy_diff +=3D (unused_util_aft * sse->idle_power)
 =09=09=09=09/new_state->cap;
+=09=09energy_diff +=3D (wakeups * sse->wakeup_energy >> 10)
+=09=09=09=09* unused_util_aft/new_state->cap;
 =09}
=20
 unlock:
@@ -4420,7 +4432,8 @@ unlock:
=20
 static int energy_diff_task(int cpu, struct task_struct *p)
 {
-=09return energy_diff_util(cpu, p->se.avg.load_avg_contrib);
+=09return energy_diff_util(cpu, p->se.avg.load_avg_contrib,
+=09=09=09p->se.avg.wakeup_avg_sum);
 }
=20
 #else
--=20
1.7.9.5


