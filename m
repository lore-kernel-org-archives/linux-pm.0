From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv2 PATCH 21/23] sched: Use energy model in select_idle_sibling
Date: Thu,  3 Jul 2014 17:26:08 +0100
Message-ID: <1404404770-323-22-git-send-email-morten.rasmussen@arm.com>
References: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, Dietmar.Eggemann@arm.com, pjt@google.com
List-Id: linux-pm@vger.kernel.org

Make select_idle_sibling() consider energy when picking an idle cpu.
This implies having to look beyond sd_llc. Otherwise, consolidating
short frequently running tasks on fewer llc domains will not happen when
that is feasible. The fix is to start select_idle_sibling() at the
highest sched_domain level. A more refined approach causing less
overhead will be considered later. That could be to only look beyond
sd_llc occasionally.

Only idle cpus are still considered. A more aggressive energy conserving
approach could go further and consider partially utilized cpus.

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c |   41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aebf3e2..a32d6eb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4747,9 +4747,19 @@ find_idlest_cpu(struct sched_group *group, struct ta=
sk_struct *p, int this_cpu)
  */
 static int select_idle_sibling(struct task_struct *p, int target)
 {
-=09struct sched_domain *sd;
+=09struct sched_domain *sd =3D NULL, *tmp;
 =09struct sched_group *sg;
 =09int i =3D task_cpu(p);
+=09int target_nrg;
+=09int nrg_min, nrg_cpu =3D -1;
+
+=09if (energy_aware()) {
+=09=09/* When energy-aware, go above sd_llc */
+=09=09for_each_domain(target, tmp)
+=09=09=09sd =3D tmp;
+
+=09=09goto loop;
+=09}
=20
 =09if (idle_cpu(target))
 =09=09return target;
@@ -4764,6 +4774,10 @@ static int select_idle_sibling(struct task_struct *p=
, int target)
 =09 * Otherwise, iterate the domains and find an elegible idle cpu.
 =09 */
 =09sd =3D rcu_dereference(per_cpu(sd_llc, target));
+
+loop:
+=09target_nrg =3D nrg_min =3D energy_diff_task(target, p);
+
 =09for_each_lower_domain(sd) {
 =09=09sg =3D sd->groups;
 =09=09do {
@@ -4772,16 +4786,35 @@ static int select_idle_sibling(struct task_struct *=
p, int target)
 =09=09=09=09goto next;
=20
 =09=09=09for_each_cpu(i, sched_group_cpus(sg)) {
+=09=09=09=09int nrg_diff;
+=09=09=09=09if (energy_aware()) {
+=09=09=09=09=09if (!idle_cpu(i))
+=09=09=09=09=09=09continue;
+
+=09=09=09=09=09nrg_diff =3D energy_diff_task(i, p);
+=09=09=09=09=09if (nrg_diff < nrg_min) {
+=09=09=09=09=09=09nrg_min =3D nrg_diff;
+=09=09=09=09=09=09nrg_cpu =3D i;
+=09=09=09=09=09}
+=09=09=09=09}
+
 =09=09=09=09if (i =3D=3D target || !idle_cpu(i))
 =09=09=09=09=09goto next;
 =09=09=09}
=20
-=09=09=09target =3D cpumask_first_and(sched_group_cpus(sg),
-=09=09=09=09=09tsk_cpus_allowed(p));
-=09=09=09goto done;
+=09=09=09if (!energy_aware()) {
+=09=09=09=09target =3D cpumask_first_and(sched_group_cpus(sg),
+=09=09=09=09=09=09tsk_cpus_allowed(p));
+=09=09=09=09goto done;
+=09=09=09}
 next:
 =09=09=09sg =3D sg->next;
 =09=09} while (sg !=3D sd->groups);
+
+=09=09if (nrg_cpu >=3D 0) {
+=09=09=09target =3D nrg_cpu;
+=09=09=09goto done;
+=09=09}
 =09}
 done:
 =09return target;
--=20
1.7.9.5
