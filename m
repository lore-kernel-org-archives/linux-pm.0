From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv2 PATCH 05/23] sched: Add energy procfs interface
Date: Thu,  3 Jul 2014 17:25:52 +0100
Message-ID: <1404404770-323-6-git-send-email-morten.rasmussen@arm.com>
References: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, Dietmar.Eggemann@arm.com, pjt@google.com
List-Id: linux-pm@vger.kernel.org

=46rom: Dietmar Eggemann <dietmar.eggemann@arm.com>

This patch makes the energy data available via procfs. The related file=
s
are placed as sub-directory named 'energy' inside the
/proc/sys/kernel/sched_domain/cpuX/domainY/groupZ directory for those
cpu/domain/group tuples which have energy information.

The following example depicts the contents of
/proc/sys/kernel/sched_domain/cpu0/domain0/group[01] for a system which
has energy information attached to domain level 0.

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
=94=9C=E2=94=80=E2=94=80 idle_states
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0     =E2=
=94=9C=E2=94=80=E2=94=80 nr_cap_states
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0     =E2=
=94=94=E2=94=80=E2=94=80 nr_idle_states
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 group1
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=94=E2=94=80=E2=94=80 energy
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0     =E2=
=94=9C=E2=94=80=E2=94=80 cap_states
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0     =E2=
=94=9C=E2=94=80=E2=94=80 idle_states
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0     =E2=
=94=9C=E2=94=80=E2=94=80 nr_cap_states
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0     =E2=
=94=94=E2=94=80=E2=94=80 nr_idle_states
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

The files 'nr_idle_states' and 'nr_cap_states' contain a scalar value
whereas 'idle_states' and 'cap_states' contain a vector of (power
consumption, wakeup energy for run->sleep->run cycle for this idle
state) respectively (compute capacity, power consumption at this comput=
e
capacity) tuples.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/core.c |   67 +++++++++++++++++++++++++++++++++++++++++++=
++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ecece17..7fecc63 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4931,9 +4931,60 @@ set_table_entry(struct ctl_table *entry,
 }
=20
 static struct ctl_table *
+sd_alloc_ctl_energy_table(struct sched_group_energy *sge)
+{
+	struct ctl_table *table =3D sd_alloc_ctl_entry(5);
+
+	if (table =3D=3D NULL)
+		return NULL;
+
+	set_table_entry(&table[0], "nr_idle_states", &sge->nr_idle_states,
+			sizeof(int), 0644, proc_dointvec_minmax, false);
+	set_table_entry(&table[1], "idle_states", &sge->idle_states[0].power,
+			sge->nr_idle_states*sizeof(struct idle_state), 0644,
+			proc_doulongvec_minmax, false);
+	set_table_entry(&table[2], "nr_cap_states", &sge->nr_cap_states,
+			sizeof(int), 0644, proc_dointvec_minmax, false);
+	set_table_entry(&table[3], "cap_states", &sge->cap_states[0].cap,
+			sge->nr_cap_states*sizeof(struct capacity_state), 0644,
+			proc_doulongvec_minmax, false);
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
+
+static struct ctl_table *
 sd_alloc_ctl_domain_table(struct sched_domain *sd)
 {
-	struct ctl_table *table =3D sd_alloc_ctl_entry(14);
+	struct ctl_table *table;
+	unsigned int nr_entries =3D 14;
+
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
+
+	table =3D sd_alloc_ctl_entry(nr_entries);
=20
 	if (table =3D=3D NULL)
 		return NULL;
@@ -4966,7 +5017,19 @@ sd_alloc_ctl_domain_table(struct sched_domain *s=
d)
 		sizeof(long), 0644, proc_doulongvec_minmax, false);
 	set_table_entry(&table[12], "name", sd->name,
 		CORENAME_MAX_SIZE, 0444, proc_dostring, false);
-	/* &table[13] is terminator */
+	sg =3D sd->groups;
+	if (sg->sge) {
+		char buf[32];
+		struct ctl_table *entry =3D &table[13];
+
+		do {
+			snprintf(buf, 32, "group%d", i);
+			entry->procname =3D kstrdup(buf, GFP_KERNEL);
+			entry->mode =3D 0555;
+			entry->child =3D sd_alloc_ctl_group_table(sg);
+		} while (entry++, i++, sg =3D sg->next, sg !=3D sd->groups);
+	}
+	/* &table[nr_entries-1] is terminator */
=20
 	return table;
 }
--=20
1.7.9.5
