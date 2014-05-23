From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFC PATCH 05/16] sched: Add sd energy procfs interface
Date: Fri, 23 May 2014 19:16:32 +0100
Message-ID: <1400869003-27769-6-git-send-email-morten.rasmussen@arm.com>
References: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:36020 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbaEWSQw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 May 2014 14:16:52 -0400
In-Reply-To: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, dietmar.eggemann@arm.com

=46rom: Dietmar Eggemann <dietmar.eggemann@arm.com>

This patch makes the values of the sd energy data structure available v=
ia
procfs.  The related files are placed as sub-directory named 'energy'
inside the /proc/sys/kernel/sched_domain/cpuX/domainY/groupZ directory =
for
those cpu/domain/group tuples which have sd energy information.

The following example depicts the contents of
/proc/sys/kernel/sched_domain/cpu0/domain0/group[01] for a system which
has sd energy information attached to domain level 0.

=E2=94=9C=E2=94=80=E2=94=80 cpu0
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 domain0
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 busy_factor
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 busy_idx
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 cache_nice_tries
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 flags
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 forkexec_idx
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 group0
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=94=E2=94=80=E2=94=80 energy
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0     =E2=
=94=9C=E2=94=80=E2=94=80 cap_states
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0     =E2=
=94=9C=E2=94=80=E2=94=80 idle_power
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0     =E2=
=94=9C=E2=94=80=E2=94=80 max_capacity
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0     =E2=
=94=9C=E2=94=80=E2=94=80 nr_cap_states
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0     =E2=
=94=94=E2=94=80=E2=94=80 wakeup_energy
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 group1
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=94=E2=94=80=E2=94=80 energy
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0     =E2=
=94=9C=E2=94=80=E2=94=80 cap_states
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0     =E2=
=94=9C=E2=94=80=E2=94=80 idle_power
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0     =E2=
=94=9C=E2=94=80=E2=94=80 max_capacity
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0     =E2=
=94=9C=E2=94=80=E2=94=80 nr_cap_states
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0     =E2=
=94=94=E2=94=80=E2=94=80 wakeup_energy
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 idle_idx
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 imbalance_pct
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 max_interval
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 max_newidle_lb_cost
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 min_interval
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 name
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 newidle_idx
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80=
 wake_idx
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 domain1
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 busy_factor
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 busy_idx
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 cache_nice_tries
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 flags
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 forkexec_idx
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 idle_idx
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 imbalance_pct
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 max_interval
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 max_newidle_lb_co=
st
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 min_interval
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 name
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 newidle_idx
=E2=94=82=C2=A0=C2=A0     =E2=94=94=E2=94=80=E2=94=80 wake_idx

The files 'idle_power', 'max_capacity', 'nr_cap_states' and 'wakeup_ene=
rgy'
contain a scalar value whereas 'cap_states' contains a vector of
(compute capacity, power consumption @ this compute capacity) tuples.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/core.c |   73 +++++++++++++++++++++++++++++++++++++++++++=
++++++--
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 785b61d..096fa55 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4837,10 +4837,66 @@ set_table_entry(struct ctl_table *entry,
 	}
 }
=20
+#ifdef CONFIG_SCHED_ENERGY
+static struct ctl_table *
+sd_alloc_ctl_energy_table(struct sched_group_energy *sge)
+{
+	struct ctl_table *table =3D sd_alloc_ctl_entry(6);
+
+	if (table =3D=3D NULL)
+		return NULL;
+
+	set_table_entry(&table[0], "max_capacity", &sge->data.max_capacity,
+			sizeof(long), 0644, proc_doulongvec_minmax, false);
+	set_table_entry(&table[1], "idle_power", &sge->data.idle_power,
+			sizeof(int), 0644, proc_dointvec_minmax, false);
+	set_table_entry(&table[2], "wakeup_energy", &sge->data.wakeup_energy,
+			sizeof(int), 0644, proc_dointvec_minmax, false);
+	set_table_entry(&table[3], "nr_cap_states", &sge->data.nr_cap_states,
+			sizeof(int), 0644, proc_dointvec_minmax, false);
+	set_table_entry(&table[4], "cap_states", &sge->data.cap_states[0].cap=
,
+			sge->data.nr_cap_states*2*sizeof(int), 0644,
+			proc_dointvec_minmax, false);
+
+	return table;
+}
+
+static struct ctl_table *
+sd_alloc_ctl_group_table(struct sched_group *sg)
+{
+	struct ctl_table *table =3D sd_alloc_ctl_entry(2);
+
+	if (table =3D=3D NULL)
+		return NULL;
+
+	table->procname =3D kstrdup("energy", GFP_KERNEL);
+	table->mode =3D 0555;
+	table->child =3D sd_alloc_ctl_energy_table(sg->sge);
+
+	return table;
+}
+#endif
+
 static struct ctl_table *
 sd_alloc_ctl_domain_table(struct sched_domain *sd)
 {
-	struct ctl_table *table =3D sd_alloc_ctl_entry(14);
+	struct ctl_table *table;
+	unsigned int nr_entries =3D 14;
+
+#ifdef CONFIG_SCHED_ENERGY
+	int i =3D 0;
+	struct sched_group *sg =3D sd->groups;
+
+	if (sg->sge) {
+		int nr_sgs =3D 0;
+
+		do {} while (nr_sgs++, sg =3D sg->next, sg !=3D sd->groups);
+
+		nr_entries +=3D nr_sgs;
+	}
+#endif
+
+	table =3D sd_alloc_ctl_entry(nr_entries);
=20
 	if (table =3D=3D NULL)
 		return NULL;
@@ -4873,7 +4929,20 @@ sd_alloc_ctl_domain_table(struct sched_domain *s=
d)
 		sizeof(long), 0644, proc_doulongvec_minmax, false);
 	set_table_entry(&table[12], "name", sd->name,
 		CORENAME_MAX_SIZE, 0444, proc_dostring, false);
-	/* &table[13] is terminator */
+#ifdef CONFIG_SCHED_ENERGY
+	sg =3D sd->groups;
+	if (sg->sge) {
+		char buf[32];
+		struct ctl_table *entry =3D &table[13];
+		do {
+			snprintf(buf, 32, "group%d", i);
+			entry->procname =3D kstrdup(buf, GFP_KERNEL);
+			entry->mode =3D 0555;
+			entry->child =3D sd_alloc_ctl_group_table(sg);
+		} while (entry++, i++, sg =3D sg->next, sg !=3D sd->groups);
+	}
+#endif
+	/* &table[nr_entries-1] is terminator */
=20
 	return table;
 }
--=20
1.7.9.5


