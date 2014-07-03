From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv2 PATCH 01/23] sched: Documentation for scheduler energy cost model
Date: Thu,  3 Jul 2014 17:25:48 +0100
Message-ID: <1404404770-323-2-git-send-email-morten.rasmussen@arm.com>
References: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, Dietmar.Eggemann@arm.com, pjt@google.com
List-Id: linux-pm@vger.kernel.org

This documentation patch provides an overview of the experimental
scheduler energy costing model, associated data structures, and a
reference recipe on how platforms can be characterized to derive energy
models.

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 Documentation/scheduler/sched-energy.txt |  439 ++++++++++++++++++++++++++=
++++
 1 file changed, 439 insertions(+)
 create mode 100644 Documentation/scheduler/sched-energy.txt

diff --git a/Documentation/scheduler/sched-energy.txt b/Documentation/sched=
uler/sched-energy.txt
new file mode 100644
index 0000000..7c0b4dc
--- /dev/null
+++ b/Documentation/scheduler/sched-energy.txt
@@ -0,0 +1,439 @@
+Energy cost model for energy-aware scheduling (EXPERIMENTAL)
+
+Introduction
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The basic energy model uses platform energy data stored in sched_group_ene=
rgy
+data structures attached to the sched_groups in the sched_domain hierarchy=
. The
+energy cost model offers three functions that can be used to guide schedul=
ing
+decisions:
+
+1.=09static int energy_diff_util(int cpu, int util, int wakeups)
+2.=09static int energy_diff_task(int cpu, struct task_struct *p)
+3.=09static int energy_diff_cpu(int dst_cpu, int src_cpu)
+
+All three of them return the energy cost delta caused by adding/removing
+utilization or a task to/from specific cpus. To be more precise:
+
+util: The signed utilization delta. That is, the amount of cpu utilization=
 we
+want to add or remove from the cpu, basically how much more/less is the cp=
u
+expected to be busy. The current metric used to represent utilization is t=
he
+actual per-entity runnable time averaged over time using a geometric serie=
s.
+Very similar to the existing per-entity load-tracking, but _not_ scaled by=
 task
+priority. energy_diff_util() calculates the energy implications of
+adding/removing a specific amount of utilization (which could be the combi=
ned
+utilization of a number of tasks), while energy_diff_task() calculates the
+energy implications of adding a specific task to a specific cpu.
+
+wakeups: Represents the wakeups (task enqueues, not idle exits) caused by =
the
+utilization we are about to add/remove to/from the cpu. As with utilizatio=
n,
+the wakeup rate is averaged over time using a geometric series. The energy
+model estimates (in a fairly naive way) the proportion of the wakeups that
+causes cpu wakeups (idle exits). This metric is particularly important for
+short but frequently running tasks as the wakeup cost (energy) for these c=
an be
+substantial if placed on an idle cpu.
+
+Background and Terminology
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+
+To make it clear from the start:
+
+energy =3D [joule] (resource like a battery on powered devices)
+power =3D energy/time =3D [joule/second] =3D [watt]
+
+The goal of energy-aware scheduling is to minimize energy, while still get=
ting
+the job done. That is, we want to maximize:
+
+=09performance [inst/s]
+=09--------------------
+=09    power [W]
+
+which is equivalent to minimizing:
+
+=09energy [J]
+=09-----------
+=09instruction
+
+while still getting 'good' performance. It is essentially an alternative
+optimization objective to the current performance-only objective for the
+scheduler. This alternative considers two objectives: energy-efficiency an=
d
+performance. Hence, there needs to be a user controllable knob to switch t=
he
+objective. Since it is early days, this is currently a sched_feature
+(ENERGY_AWARE).
+
+The idea behind introducing an energy cost model is to allow the scheduler=
 to
+evaluate the implications of its decisions rather than applying energy-sav=
ing
+techniques blindly that may only have positive effects on some platforms. =
At
+the same time, the energy cost model must be as simple as possible to mini=
mize
+the scheduler latency impact.
+
+Platform topology
+------------------
+
+The system topology (cpus, caches, and NUMA information, not peripherals) =
is
+represented in the scheduler by the sched_domain hierarchy which has
+sched_groups attached at each level that covers one or more cpus (see
+sched-domains.txt for more details). To add energy awareness to the schedu=
ler
+we need to consider power and frequency domains.
+
+Power domain:
+
+A power domain is a part of the system that can be powered on/off
+independently. Power domains are typically organized in a hierarchy where =
you
+may be able to power down just a cpu or a group of cpus along with any
+associated resources (e.g.  shared caches). Powering up a cpu means that a=
ll
+power domains it is a part of in the hierarchy must be powered up. Hence, =
it is
+more expensive to power up the first cpu that belongs to a higher level po=
wer
+domain than powering up additional cpus in the same high level domain. Two
+level power domain hierarchy example:
+
+=09=09Power source
+=09=09         +-------------------------------+----...
+per group PD=09=09 G                               G
+=09=09         |           +----------+        |
+=09=09    +--------+-------| Shared   |  (other groups)
+per-cpu PD=09    G        G       | resource |
+=09=09    |        |       +----------+
+=09=09+-------+ +-------+
+=09=09| CPU 0 | | CPU 1 |
+=09=09+-------+ +-------+
+
+Frequency domain:
+
+Frequency domains (P-states) typically cover the same group of cpus as one=
 of
+the power domain levels. That is, there might be several smaller power dom=
ains
+sharing the same frequency (P-state) or there might be a power domain span=
ning
+multiple frequency domains.
+
+From a scheduling point of view there is no need to know the actual freque=
ncies
+[Hz]. All the scheduler cares about is the compute capacity available at t=
he
+current state (P-state) the cpu is in and any other available states. For =
that
+reason, and to also factor in any cpu micro-architecture differences, comp=
ute
+capacity scaling states are called 'capacity states' in this document. For=
 SMP
+systems this is equivalent to P-states. For mixed micro-architecture syste=
ms
+(like ARM big.LITTLE) it is P-states scaled according to the micro-archite=
cture
+performance relative to the other cpus in the system.
+
+Energy modelling:
+------------------
+
+Due to the hierarchical nature of the power domains, the most obvious way =
to
+model energy costs is therefore to associate power and energy costs with
+domains (groups of cpus). Energy costs of shared resources are associated =
with
+the group of cpus that share the resources, only the cost of powering the
+cpu itself and any private resources (e.g. private L1 caches) is associate=
d
+with the per-cpu groups (lowest level).
+
+For example, for an SMP system with per-cpu power domains and a cluster le=
vel
+(group of cpus) power domain we get the overall energy costs to be:
+
+=09energy =3D energy_cluster + n * energy_cpu
+
+where 'n' is the number of cpus powered up and energy_cluster is the cost =
paid
+as soon as any cpu in the cluster is powered up.
+
+The power and frequency domains can naturally be mapped onto the existing
+sched_domain hierarchy and sched_groups by adding the necessary data to th=
e
+existing data structures.
+
+The energy model considers energy consumption from three contributors (sho=
wn in
+the illustration below):
+
+1. Busy energy: Energy consumed while a cpu and the higher level groups th=
at it
+belongs to are busy running tasks. Busy energy is associated with the stat=
e of
+the cpu, not an event. The time the cpu spends in this state varies. Thus,=
 the
+most obvious platform parameter for this contribution is busy power
+(energy/time).
+
+2. Idle energy: Energy consumed while a cpu and higher level groups that i=
t
+belongs to are idle (in a C-state). Like busy energy, idle energy is assoc=
iated
+with the state of the cpu. Thus, the platform parameter for this contribut=
ion
+is idle power (energy/time).
+
+3. Wakeup energy: Energy consumed for a transition from an idle-state (C-s=
tate)
+to a busy state (P-state) and back again, that is, a full run->sleep->run =
cycle
+(they always come in pairs, transitions between idle-states are not modell=
ed).
+This energy is associated with an event with a fixed duration (at least
+roughly). The most obvious platform parameter for this contribution is
+therefore wakeup energy. Wakeup energy is depicted by the areas under the =
power
+graph for the transition phases in the illustration.
+
+
+=09Power
+=09^
+=09|            busy->idle             idle->busy
+=09|            transition             transition
+=09|
+=09|                _                      __
+=09|               / \                    /  \__________________
+=09|______________/   \                  /
+=09|                   \                /
+=09|  Busy              \    Idle      /        Busy
+=09|  low P-state        \____________/         high P-state
+=09|
+=09+------------------------------------------------------------> time
+
+Busy    |--------------|                          |-----------------|
+
+Wakeup                 |------|            |------|
+
+Idle                          |------------|
+
+
+The basic algorithm
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The basic idea is to determine the total energy impact when utilization is
+added or removed by estimating the impact at each level in the sched_domai=
n
+hierarchy starting from the bottom (sched_group contains just a single cpu=
).
+The energy cost comes from three sources: busy time (sched_group is awake
+because one or more cpus are busy), idle time (in an idle-state), and wake=
ups
+(idle state exits). Power and energy numbers account for energy costs
+associated with all cpus in the sched_group as a group. In some cases it i=
s
+possible to bail out early without having go to the top of the hierarchy i=
f the
+additional/removed utilization doesn't affect the busy time of higher leve=
ls.
+
+=09for_each_domain(cpu, sd) {
+=09=09sg =3D sched_group_of(cpu)
+=09=09energy_before =3D curr_util(sg) * busy_power(sg)
+=09=09=09=09+ (1-curr_util(sg)) * idle_power(sg)
+=09=09energy_after =3D new_util(sg) * busy_power(sg)
+=09=09=09=09+ (1-new_util(sg)) * idle_power(sg)
+=09=09=09=09+ (1-new_util(sg)) * wakeups * wakeup_energy(sg)
+=09=09energy_diff +=3D energy_before - energy_after
+
+=09=09if (energy_before =3D=3D energy_after)
+=09=09=09break;
+=09}
+
+=09return energy_diff
+
+{curr, new}_util: The cpu utilization at the lowest level and the overall
+non-idle time for the entire group for higher levels. Utilization is in th=
e
+range 0.0 to 1.0 in the pseudo-code.
+
+busy_power: The power consumption of the sched_group.
+
+idle_power: The power consumption of the sched_group when idle.
+
+wakeups: Average wakeup rate of the task(s) being added/removed. To predic=
t how
+many of the wakeups are wakeups that causes idle exits we scale the number=
 by
+the unused utilization (assuming that wakeups are uniformly distributed).
+
+wakeup_energy: The energy consumed for a run->sleep->run cycle for the
+sched_group.
+
+Note: It is a fundamental assumption that the utilization is (roughly) sca=
le
+invariant. Task utilization tracking factors in any frequency scaling and
+performance scaling differences due to difference cpu microarchitectures s=
uch
+that task utilization can be used across the entire system. This is _not_ =
in
+place yet.
+
+Platform energy data
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+struct sched_group_energy can be attached to sched_groups in the sched_dom=
ain
+hierarchy and has the following members:
+
+cap_states:
+=09List of struct capacity_state representing the supported capacity state=
s
+=09(P-states). struct capacity_state has two members: cap and power, which
+=09represents the compute capacity and the busy_power of the state. The
+=09list must be ordered by capacity low->high.
+
+nr_cap_states:
+=09Number of capacity states in cap_states list.
+
+idle_states:
+=09List of struct idle_state containing idle_state related costs for each
+=09idle-state support by the sched_group. struct idle_state has two
+=09members: power and wu_energy. The former is the idle-state power
+=09consumption, while the latter is the wakeup energy for an
+=09run->sleep->run cycle for that particular sched_group idle-state.
+=09Note that the list should only contain idle-states where the affected
+=09cpu matches the members of the sched_group. That is, per-cpu idle
+=09states are associated with sched_groups at the lowest level, and
+=09package/cluster idle-states are listed for sched_group's further up the
+=09hierarchy.
+
+nr_idle_states:
+=09Number of idle states in idle_states list.
+
+There are no unit requirements for the energy cost data. Data can be norma=
lized
+with any reference, however, the normalization must be consistent across a=
ll
+energy cost data. That is, one bogo-joule/watt must be the same quantity f=
or
+data, but we don't care what it is.
+
+A recipe for platform characterization
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Obtaining the actual model data for a particular platform requires some wa=
y of
+measuring power/energy. There isn't a tool to help with this (yet). This
+section provides a recipe for use as reference. It covers the steps used t=
o
+characterize the ARM TC2 development platform. This sort of measurements i=
s
+expected to be done anyway when tuning cpuidle and cpufreq for a given
+platform.
+
+The energy model needs three types of data (struct sched_group_energy hold=
s
+these) for each sched_group where energy costs should be taken into accoun=
t:
+
+1. Capacity state information
+
+A list containing the compute capacity and power consumption when fully
+utilized attributed to the group as a whole for each available capacity st=
ate.
+At the lowest level (group contains just a single cpu) this is the power o=
f the
+cpu alone without including power consumed by resources shared with other =
cpus.
+It basically needs to fit the basic modelling approach described in "Backg=
round
+and Terminology" section:
+
+=09energy_system =3D energy_shared + n * energy_cpu
+
+for a system containing 'n' busy cpus. Only 'energy_cpu' should be include=
d at
+the lowest level. 'energy_shared' is included at the next level which
+represents the group of cpus among which the resources are shared.
+
+This model is, of course, a simplification of reality. Thus, power/energy
+attributions might not always exactly represent how the hardware is design=
ed.
+Also, busy power is likely to depend on the workload. It is therefore
+recommended to use a representative mix of workloads when characterizing t=
he
+capacity states.
+
+If the group has no capacity scaling support, the list will contain a sing=
le
+state where power is the busy power attributed to the group. The capacity
+should be set to a default value (1024).
+
+When frequency domains include multiple power domains, the group represent=
ing
+the frequency domain and all child groups share capacity states. This must=
 be
+indicated by setting the SD_SHARE_CAP_STATES sched_domain flag. All groups=
 at
+all levels that share the capacity state must have the list of capacity st=
ates
+with the power set to the contribution of the individual group.
+
+2. Idle power information
+
+The first member of idle-state information stored in the idle_states list.=
 The
+power number is the group idle power consumption. Due to the way the energ=
y
+model is defined, the idle power of the deepest group idle state can
+alternatively be accounted for in the parent group busy power. In that cas=
e the
+group idle state power values are offset such that the idle power of the
+deepest state is zero. It is less intuitive, but it is easier to measure a=
s
+idle power consumed by the group and the busy/idle power of the parent gro=
up
+cannot be distinguished without per group measurement points.
+
+3. Wakeup energy information
+
+The second member of the idle-state information stored in the idle_states =
list.
+The wakeup energy is the total energy consumed during the transition from =
a
+specific idle state to busy (some P-state) and back again. It is not easy =
to
+measure them individually and they always occur in pairs anyway. Exit from=
 one
+idle state and going back into a different one is not modelled.
+
+The energy model estimates wakeup energy based on the tracked average wake=
up
+rate. Assuming that all task wakeups result in idle exits, the wakeup ener=
gy
+consumed per time unit (~ energy rate ~ power) is:
+
+=09wakeup_energy_rate =3D wakeup_energy * wakeup_rate
+
+The wakeup_rate is a geometric series similar to the per entity load track=
ing.
+To simplify the math in the scheduler the wakeup_energy parameter must be
+pre-scaled to take the geometric series into account. wakeup_rate =3D
+LOAD_AVG_MAX (=3D47742) is equivalent to a true wakeup rate of 1000 wakeup=
s per
+second. The wu_energy stored in each struct idle_state in the
+sched_group_energy data structure must therefore be scaled accordingly:
+
+=09wakeup_energy =3D 1000/47742 * true_wakeup_energy
+
+Measuring capacity states and idle power:
+
+The capacity states' capacity and power can be estimated by running a benc=
hmark
+workload at each available capacity state. By restricting the benchmark to=
 run
+on subsets of cpus it is possible to extrapolate the power consumption of
+shared resources.
+
+ARM TC2 has two clusters of two and three cpus respectively. Each cluster =
has a
+shared L2 cache. TC2 has on-chip energy counters per cluster. Running a
+benchmark workload on just one cpu in a cluster means that power is consum=
ed in
+the cluster (higher level group) and a single cpu (lowest level group). Ad=
ding
+another benchmark task to another cpu increases the power consumption by t=
he
+amount consumed by the additional cpu. Hence, it is possible to extrapolat=
e the
+cluster busy power.
+
+For platforms that don't have energy counters or equivalent instrumentatio=
n
+built-in, it may be possible to use an external DAQ to acquire similar dat=
a.
+
+If the benchmark includes some performance score (for example sysbench cpu
+benchmark), this can be used to record the compute capacity.
+
+Measuring idle power requires insight into the idle state implementation o=
n the
+particular platform. Specifically, if the platform has coupled idle-states=
 (or
+package states). To measure non-coupled per-cpu idle-states it is necessar=
y to
+keep one cpu busy to keep any shared resources alive to isolate the idle p=
ower
+of the cpu from idle/busy power of the shared resources. The cpu can be tr=
icked
+into different per-cpu idle states by disabling the other states. Based on
+various combinations of measurements with specific cpus busy and disabling
+idle-states it is possible to extrapolate the idle-state power.
+
+Measuring wakeup energy again requires knowledge about the supported platf=
orm
+idle-states, particularly about target residencies. Wakeup energy is a ver=
y
+small quantity that might be difficult to distinguish from noise. One way =
to
+measure it is to use a synthetic test case that periodically wakes up a ta=
sk on
+a specific cpu. The task should immediately block/go to sleep again. The
+wake-up rate should be as high as the target residency for the idle-state
+allows. Based on cpuidle statistics and knowledge about coupled idle-state=
s the
+wakeup energy can be determined.
+
+The following wakeup generator test was used for the ARM TC2 profiling.
+
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+volatile int busy_loops =3D 1;
+volatile useconds_t alarm_rate =3D 100000;
+
+void
+waste_time(int loops)
+{
+=09int i;
+=09int t =3D 0;
+=09for (i=3D0;i<loops;i++)
+=09=09t++;
+}
+
+/* The signal handler just clears the flag and re-enables itself. */
+void catch_alarm (int sig)
+{
+=09waste_time(busy_loops);
+=09signal(sig, catch_alarm);
+}
+
+int main(int argc, char **argv)
+{
+=09if (argc !=3D 3) {
+=09=09printf("Usage: timerload <alarm_rate> <busy_loops>\n");
+=09=09printf("alarm_rate:\tBusy loop invocation rate [us]. ");
+=09=09printf("(Doesn't work for rate >=3D 1s)\n");
+=09=09printf("busy_loops:\tbusy loop iterations per invocation.\n");
+=09=09exit(0);
+=09}
+
+=09if (atoi(argv[1]) >=3D 1000000){
+=09=09printf("alarm_rate must be less than 1000000\n");
+=09}
+
+=09alarm_rate =3D (useconds_t) atoi(argv[1]);
+=09busy_loops =3D atoi(argv[2]);
+=09printf("alarm_rate =3D %d\nbusy_loops =3D %d\n",alarm_rate,busy_loops);
+
+=09/* Establish a handler for SIGALRM signals. */
+=09signal(SIGALRM, catch_alarm);
+
+=09/* Set an alarm to go off in a little while. */
+=09ualarm(alarm_rate,alarm_rate);
+
+=09while (1) {
+=09=09pause();
+=09}
+
+=09return EXIT_SUCCESS;
+}
--=20
1.7.9.5
