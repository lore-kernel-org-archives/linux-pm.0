From: Yuyang Du <yuyang.du@intel.com>
Subject: =?UTF-8?q?=5BRFC=20PATCH=200/9=20v4=5D=20A=20new=20CPU=20load=20metric=20for=20power-efficient=20scheduler=3A=20CPU=20ConCurrency?=
Date: Wed, 25 Jun 2014 08:35:59 +0800
Message-ID: <1403656568-32445-1-git-send-email-yuyang.du@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com, peterz@infradead.org, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: arjan.van.de.ven@intel.com, len.brown@intel.com, alan.cox@intel.com, mark.gross@intel.com, morten.rasmussen@arm.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rajeev.d.muralidhar@intel.com, vishwesh.m.rudramuni@intel.com, nicole.chalhoub@intel.com, ajaya.durg@intel.com, harinarayanan.seshadri@intel.com, jacob.jun.pan@linux.intel.com, Yuyang Du <yuyang.du@intel.com>
List-Id: linux-pm@vger.kernel.org

The current scheduler=E2=80=99s load balancing is completely work-conse=
rving. In some
workload, generally low CPU utilization but immersed with CPU bursts of
transient tasks, migrating task to engage all available CPUs for
work-conserving can lead to significant overhead: cache locality loss,
idle/active HW state transitional latency and power, shallower idle sta=
te,
etc, which are both power and performance inefficient especially for to=
day=E2=80=99s
low power processors in mobile.=20

This RFC introduces a sense of idleness-conserving into work-conserving=
 (by
all means, we really don=E2=80=99t want to be overwhelming in only one =
way). But to
what extent the idleness-conserving should be, bearing in mind that we =
don=E2=80=99t
want to sacrifice performance? We first need a load/idleness indicator =
to that
end.

Thanks to CFS=E2=80=99s =E2=80=9Cmodel an ideal, precise multi-tasking =
CPU=E2=80=9D, tasks can be seen
as concurrently running (the tasks in the runqueue). So it is natural t=
o use
task concurrency as load indicator. Having said that, we do two things:

1) Divide continuous time into periods of time, and average task concur=
rency
in period, for tolerating the transient bursts:
a =3D sum(concurrency * time) / period
2) Exponentially decay past periods, and synthesize them all, for hyste=
resis
to load drops or resilience to load rises (let f be decaying factor, an=
d a_x
the xth period average since period 0):
s =3D a_n + f^1 * a_n-1 + f^2 * a_n-2 +, ..., + f^(n-1) * a_1 + f^n * a=
_0

We name this load indicator as CPU ConCurrency (CC): task concurrency
determines how many CPUs are needed to be running concurrently.

Another two ways of how to interpret CC:

1) the current work-conserving load balance also uses CC, but instantan=
eous
CC.

2) CC vs. CPU utilization. CC is runqueue-length-weighted CPU utilizati=
on. If
we change: "a =3D sum(concurrency * time) / period" to "a' =3D sum(1 * =
time) /
period". Then a' is just about the CPU utilization. And the way we weig=
ht
runqueue-length is the simplest one (excluding the exponential decays, =
and you
may have other ways).

To track CC, we intercept the scheduler in 1) enqueue, 2) dequeue, 3)
scheduler tick, and 4) enter/exit idle.

After CC, in the consolidation part, we do 1) attach the CPU topology t=
o be
adaptive beyond our experimental platforms, and 2) intercept the curren=
t load
balance for load and load balancing containment.

Currently, CC is per CPU. To consolidate, the formula is based on a heu=
ristic.
Suppose we have 2 CPUs, their task concurrency over time is ('-' means =
no
task, 'x' having tasks):

1)
CPU0: ---xxxx---------- (CC[0])
CPU1: ---------xxxx---- (CC[1])

2)
CPU0: ---xxxx---------- (CC[0])
CPU1: ---xxxx---------- (CC[1])

If we consolidate CPU0 and CPU1, the consolidated CC will be: CC' =3D C=
C[0] +
CC[1] for case 1 and CC'' =3D (CC[0] + CC[1]) * 2 for case 2. For the c=
ases in
between case 1 and 2 in terms of how xxx overlaps, the CC should be bet=
ween
CC' and CC''. So, we uniformly use this condition for consolidation (su=
ppose
we consolidate m CPUs to n CPUs, m > n):

(CC[0] + CC[1] + ... + CC[m-2] + CC[m-1]) * (n + log(m-n)) >=3D<? (1 * =
n) * n *
consolidating_coefficient

The consolidating_coefficient could be like 100% or more or less.

By CC, we implemented a Workload Consolidation (WC) patch on two Intel =
mobile
platforms (a quad-core composed of two dual-core modules): contain load=
 and
load balancing in the first dual-core when aggregated CC low, and if no=
t in
the full quad-core. Results show that we got power savings and no subst=
antial
performance regression (even gains for some). The workloads we used to
evaluate the Workload Consolidation include 1) 50+ perf/ux benchmarks (=
almost
all of the magazine ones), and 2) ~10 power workloads, of course, they =
are the
easiest ones, such as browsing, audio, video, recording, imaging, etc.

v4:
- Reuse per task load average to calculate CC
- Enable SD_WORKLOAD_CONSOLIDATION in sched_domain initialization
- Reuse active_load_balance_cpu_stop

v3:
- Removed rq->avg first, and base our patch on it
- Removed all CONFIG_CPU_CONCURRENCY and CONFIG_WORKLOAD_CONSOLIDATION
- CPU CC will be updated mandatory
- CPU WC can be enabled/disabled by flags per domain level on the fly=20
- CPU CC and WC is completely fair scheduler thing, don't touch RT anym=
ore
=20
v2:
- Data type defined in formation

Patchset against linux-next v3.16-rc2.

Yuyang Du (9):
  sched: Remove update_rq_runnable_avg
  sched: Precise accumulated time and acount runnable number in
    update_entity_runnable_avg
  How CPU ConCurrency (CC) accrues with runqueue change and time
  Define SD_WORKLOAD_CONSOLIDATION and attach to sched_domain
  Workload Consolidation: Consolidating workload to a subset of CPUs if
    possible
  Implement Workload Consolidation in wakeup/fork/exec
  Implement Workload Consolidation in idle_balance
  Implement Workload Consolidation in nohz_idle_balance
  Implement Workload Consolidation in periodic load balance

 include/linux/sched.h        |    9 +-
 include/linux/sched/sysctl.h |    4 +
 kernel/sched/core.c          |   46 +++-
 kernel/sched/debug.c         |    8 -
 kernel/sched/fair.c          |  576 ++++++++++++++++++++++++++++++++++=
+++++---
 kernel/sched/sched.h         |   17 +-
 kernel/sysctl.c              |    9 +
 7 files changed, 612 insertions(+), 57 deletions(-)

--=20
1.7.9.5
