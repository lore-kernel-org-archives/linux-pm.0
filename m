From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFC PATCH 03/16] sched: Introduce sd energy data structures
Date: Fri, 23 May 2014 19:16:30 +0100
Message-ID: <1400869003-27769-4-git-send-email-morten.rasmussen@arm.com>
References: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

The struct sched_energy represents the per scheduler group related data
which is needed for the energy aware scheduler.

It contains a pointer to a struct capacity_state array which contains
(compute capacity, power consumption @ this compute capacity) tuples.

The struct sched_group_energy wraps struct sched_energy and an atomic
reference counter, latter is used for scheduler internal bookkeeping of
data allocation and freeing.

Allocation and freeing of struct sched_group_energy uses the existing
infrastructure of the scheduler which is currently used for the other sd
hierarchy data structures (e.g. struct sched_domain).  That's why struct
sd_data is provisioned with a per cpu struct sched_group_energy double
pointer.

The struct sched_group gets a pointer to a struct sched_group_energy.

The function ptr sched_domain_energy_f is introduced into struct
sched_domain_topology_level which will allow the arch to set a pass a
particular struct sd_energy from the topology shim layer into the
scheduler core.

The function ptr sched_domain_energy_f has an 'int cpu' parameter since
the folding of two adjacent sd levels via sd degenerate doesn't work
for all sd levels.  E.g. it is not possible to use this feature to
provide per-cpu sd energy in sd level DIE (former CPU) on ARM's TC2
platform.

It was discussed that the folding of sd levels approach is preferable
over the cpu parameter approach, simply because the user (the arch
specifying the sd topology table) can introduce less errors.  But since
it is not working, the 'int cpu' parameter is the only way out.  It's
possible to use the folding of sd levels approach for
sched_domain_flags_f and the cpu parameter approach for the
sched_domain_energy_f at the same time set-up though.  With the use of
the 'int cpu' parameter, an extra check function has to be provided to
make sure that all cpus spanned by a scheduler building block (e.g a
sched domain or a group) are provisioned with the same energy data.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 include/linux/sched.h |   24 ++++++++++++++++++++++++
 kernel/sched/sched.h  |   10 ++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 261a419..4eb149b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -909,6 +909,21 @@ struct sched_domain_attr {
=20
 extern int sched_domain_level_max;
=20
+#ifdef CONFIG_SCHED_ENERGY
+struct capacity_state {
+=09int cap;=09/* compute capacity */
+=09int power;=09/* power consumption at this compute capacity */
+};
+
+struct sched_energy {
+=09long max_capacity;=09/* maximal compute capacity */
+=09int idle_power;=09=09/* power consumption in idle state */
+=09int wakeup_energy;=09/* energy for wakeup->sleep cycle (x1024) */
+=09int nr_cap_states;=09/* number of capacity states */
+=09struct capacity_state *cap_states; /* ptr to capacity state array */
+};
+#endif
+
 struct sched_group;
=20
 struct sched_domain {
@@ -1007,6 +1022,9 @@ bool cpus_share_cache(int this_cpu, int that_cpu);
=20
 typedef const struct cpumask *(*sched_domain_mask_f)(int cpu);
 typedef const int (*sched_domain_flags_f)(void);
+#ifdef CONFIG_SCHED_ENERGY
+typedef const struct sched_energy *(*sched_domain_energy_f)(int cpu);
+#endif
=20
 #define SDTL_OVERLAP=090x01
=20
@@ -1014,11 +1032,17 @@ struct sd_data {
 =09struct sched_domain **__percpu sd;
 =09struct sched_group **__percpu sg;
 =09struct sched_group_power **__percpu sgp;
+#ifdef CONFIG_SCHED_ENERGY
+=09struct sched_group_energy **__percpu sge;
+#endif
 };
=20
 struct sched_domain_topology_level {
 =09sched_domain_mask_f mask;
 =09sched_domain_flags_f sd_flags;
+#ifdef CONFIG_SCHED_ENERGY
+=09sched_domain_energy_f energy;
+#endif
 =09int=09=09    flags;
 =09int=09=09    numa_level;
 =09struct sd_data      data;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 456e492..c566f5e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -755,12 +755,22 @@ struct sched_group_power {
 =09unsigned long cpumask[0]; /* iteration mask */
 };
=20
+#ifdef CONFIG_SCHED_ENERGY
+struct sched_group_energy {
+=09atomic_t ref;
+=09struct sched_energy data;
+};
+#endif
+
 struct sched_group {
 =09struct sched_group *next;=09/* Must be a circular list */
 =09atomic_t ref;
=20
 =09unsigned int group_weight;
 =09struct sched_group_power *sgp;
+#ifdef CONFIG_SCHED_ENERGY
+=09struct sched_group_energy *sge;
+#endif
=20
 =09/*
 =09 * The CPUs this group covers.
--=20
1.7.9.5
