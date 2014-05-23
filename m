From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFC PATCH 14/16] sched: Use energy model in select_idle_sibling
Date: Fri, 23 May 2014 19:16:41 +0100
Message-ID: <1400869003-27769-15-git-send-email-morten.rasmussen@arm.com>
References: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:36439 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbaEWSQ5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 May 2014 14:16:57 -0400
In-Reply-To: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, dietmar.eggemann@arm.com

Make select_idle_sibling() consider energy when picking an idle cpu.

Only idle cpus are still considered. A more aggressive energy conserving
approach could go further and consider partly utilized cpus.

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5a52467..542c2b2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4644,7 +4644,9 @@ static int select_idle_sibling(struct task_struct *p,=
 int target)
 =09struct sched_domain *sd;
 =09struct sched_group *sg;
 =09int i =3D task_cpu(p);
+=09int target_energy;
=20
+#ifndef CONFIG_SCHED_ENERGY
 =09if (idle_cpu(target))
 =09=09return target;
=20
@@ -4653,6 +4655,8 @@ static int select_idle_sibling(struct task_struct *p,=
 int target)
 =09 */
 =09if (i !=3D target && cpus_share_cache(i, target) && idle_cpu(i))
 =09=09return i;
+#endif
+=09target_energy =3D energy_diff_task(target, p);
=20
 =09/*
 =09 * Otherwise, iterate the domains and find an elegible idle cpu.
@@ -4666,8 +4670,12 @@ static int select_idle_sibling(struct task_struct *p=
, int target)
 =09=09=09=09goto next;
=20
 =09=09=09for_each_cpu(i, sched_group_cpus(sg)) {
+=09=09=09=09int diff;
 =09=09=09=09if (i =3D=3D target || !idle_cpu(i))
 =09=09=09=09=09goto next;
+=09=09=09=09diff =3D energy_diff_task(i, p);
+=09=09=09=09if (diff > target_energy)
+=09=09=09=09=09goto next;
 =09=09=09}
=20
 =09=09=09target =3D cpumask_first_and(sched_group_cpus(sg),
--=20
1.7.9.5


