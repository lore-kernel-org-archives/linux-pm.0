From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv2 PATCH 03/23] sched: Introduce energy data structures
Date: Thu,  3 Jul 2014 17:25:50 +0100
Message-ID: <1404404770-323-4-git-send-email-morten.rasmussen@arm.com>
References: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, Dietmar.Eggemann@arm.com, pjt@google.com
List-Id: linux-pm@vger.kernel.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

The struct sched_group_energy represents the per sched_group related
data which is needed for energy aware scheduling. It contains:

  (1) atomic reference counter for scheduler internal bookkeeping of
      data allocation and freeing
  (2) number of elements of the idle state array
  (3) pointer to the idle state array which comprises 'power consumption
      and wakeup energy for the run->sleep->run cycle' tuples for each
      idle state
  (4) number of elements of the capacity state array
  (5) pointer to the capacity state array which comprises 'compute
      capacity and power consumption' tuples for each capacity state

Allocation and freeing of struct sched_group_energy utilizes the existing
infrastructure of the scheduler which is currently used for the other sd
hierarchy data structures (e.g. struct sched_domain) as well. That's why
struct sd_data is provisioned with a per cpu struct sched_group_energy
double pointer.

The struct sched_group obtains a pointer to a struct sched_group_energy.

The function pointer sched_domain_energy_f is introduced into struct
sched_domain_topology_level which will allow the arch to pass a particular
struct sched_group_energy from the topology shim layer into the scheduler
core.

The function pointer sched_domain_energy_f has an 'int cpu' parameter
since the folding of two adjacent sd levels via sd degenerate doesn't work
for all sd levels. I.e. it is not possible for example to use this feature
to provide per-cpu energy in sd level DIE on ARM's TC2 platform.

It was discussed that the folding of sd levels approach is preferable
over the cpu parameter approach, simply because the user (the arch
specifying the sd topology table) can introduce less errors. But since
it is not working, the 'int cpu' parameter is the only way out. It's
possible to use the folding of sd levels approach for
sched_domain_flags_f and the cpu parameter approach for the
sched_domain_energy_f at the same time though. With the use of the
'int cpu' parameter, an extra check function has to be provided to make
sure that all cpus spanned by a sched group are provisioned with the same
energy data.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 include/linux/sched.h |   21 +++++++++++++++++++++
 kernel/sched/sched.h  |    1 +
 2 files changed, 22 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b4f6bf9..1507390 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -909,6 +909,24 @@ struct sched_domain_attr {
=20
 extern int sched_domain_level_max;
=20
+struct capacity_state {
+=09unsigned long cap;=09/* compute capacity */
+=09unsigned long power;=09/* power consumption at this compute capacity */
+};
+
+struct idle_state {
+=09unsigned long power;=09 /* power consumption in this idle state */
+=09unsigned long wu_energy; /* energy for run->sleep->run cycle (<<10) */
+};
+
+struct sched_group_energy {
+=09atomic_t ref;
+=09unsigned int nr_idle_states;=09/* number of idle states */
+=09struct idle_state *idle_states;=09/* ptr to idle state array */
+=09unsigned int nr_cap_states;=09/* number of capacity states */
+=09struct capacity_state *cap_states; /* ptr to capacity state array */
+};
+
 struct sched_group;
=20
 struct sched_domain {
@@ -1007,6 +1025,7 @@ bool cpus_share_cache(int this_cpu, int that_cpu);
=20
 typedef const struct cpumask *(*sched_domain_mask_f)(int cpu);
 typedef const int (*sched_domain_flags_f)(void);
+typedef const struct sched_group_energy *(*sched_domain_energy_f)(int cpu)=
;
=20
 #define SDTL_OVERLAP=090x01
=20
@@ -1014,11 +1033,13 @@ struct sd_data {
 =09struct sched_domain **__percpu sd;
 =09struct sched_group **__percpu sg;
 =09struct sched_group_capacity **__percpu sgc;
+=09struct sched_group_energy **__percpu sge;
 };
=20
 struct sched_domain_topology_level {
 =09sched_domain_mask_f mask;
 =09sched_domain_flags_f sd_flags;
+=09sched_domain_energy_f energy;
 =09int=09=09    flags;
 =09int=09=09    numa_level;
 =09struct sd_data      data;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2f86361..d300a64 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -753,6 +753,7 @@ struct sched_group {
=20
 =09unsigned int group_weight;
 =09struct sched_group_capacity *sgc;
+=09struct sched_group_energy *sge;
=20
 =09/*
 =09 * The CPUs this group covers.
--=20
1.7.9.5
