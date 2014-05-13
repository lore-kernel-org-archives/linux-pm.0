From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RFC PATCH 00/12 v2] A new CPU load metric for power-efficient
 scheduler: CPU ConCurrency
Date: Tue, 13 May 2014 15:23:33 +0200
Message-ID: <1399987413.16665.4.camel@AMDC1943>
References: <1399832221-8314-1-git-send-email-yuyang.du@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1399832221-8314-1-git-send-email-yuyang.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yuyang Du <yuyang.du@intel.com>
Cc: mingo@redhat.com, peterz@infradead.org, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, arjan.van.de.ven@intel.com, len.brown@intel.com, alan.cox@intel.com, mark.gross@intel.com, morten.rasmussen@arm.com, vincent.guittot@linaro.org, rajeev.d.muralidhar@intel.com, vishwesh.m.rudramuni@intel.com, nicole.chalhoub@intel.com, ajaya.durg@intel.com, harinarayanan.seshadri@intel.com, jacob.jun.pan@linux.intel.com, fengguang.wu@intel.com
List-Id: linux-pm@vger.kernel.org

On pon, 2014-05-12 at 02:16 +0800, Yuyang Du wrote:
> Hi Ingo, PeterZ, Rafael, and others,
>=20
> The current scheduler=C3=A2=E2=82=AC=E2=84=A2s load balancing is comp=
letely work-conserving. In some
> workload, generally low CPU utilization but immersed with CPU bursts =
of
> transient tasks, migrating task to engage all available CPUs for
> work-conserving can lead to significant overhead: cache locality loss=
,
> idle/active HW state transitional latency and power, shallower idle s=
tate,
> etc, which are both power and performance inefficient especially for =
today=C3=A2=E2=82=AC=E2=84=A2s
> low power processors in mobile.=20
>=20
> This RFC introduces a sense of idleness-conserving into work-conservi=
ng (by
> all means, we really don=C3=A2=E2=82=AC=E2=84=A2t want to be overwhel=
ming in only one way). But to
> what extent the idleness-conserving should be, bearing in mind that w=
e don=C3=A2=E2=82=AC=E2=84=A2t
> want to sacrifice performance? We first need a load/idleness indicato=
r to that
> end.
>=20
> Thanks to CFS=C3=A2=E2=82=AC=E2=84=A2s =C3=A2=E2=82=AC=C5=93model an =
ideal, precise multi-tasking CPU=C3=A2=E2=82=AC=C2=9D, tasks can be see=
n
> as concurrently running (the tasks in the runqueue). So it is natural=
 to use
> task concurrency as load indicator. Having said that, we do two thing=
s:
>=20
> 1) Divide continuous time into periods of time, and average task conc=
urrency
> in period, for tolerating the transient bursts:
> a =3D sum(concurrency * time) / period
> 2) Exponentially decay past periods, and synthesize them all, for hys=
teresis
> to load drops or resilience to load rises (let f be decaying factor, =
and a_x
> the xth period average since period 0):
> s =3D a_n + f^1 * a_n-1 + f^2 * a_n-2 +, ..., + f^(n-1) * a_1 + f^n *=
 a_0
>=20
> We name this load indicator as CPU ConCurrency (CC): task concurrency
> determines how many CPUs are needed to be running concurrently.
>=20
> Another two ways of how to interpret CC:
>=20
> 1) the current work-conserving load balance also uses CC, but instant=
aneous
> CC.
>=20
> 2) CC vs. CPU utilization. CC is runqueue-length-weighted CPU utiliza=
tion. If
> we change: "a =3D sum(concurrency * time) / period" to "a' =3D sum(1 =
* time) /
> period". Then a' is just about the CPU utilization. And the way we we=
ight
> runqueue-length is the simplest one (excluding the exponential decays=
, and you
> may have other ways).
>=20
> To track CC, we intercept the scheduler in 1) enqueue, 2) dequeue, 3)
> scheduler tick, and 4) enter/exit idle.
>=20
> After CC, in the consolidation part, we do 1) attach the CPU topology=
 to be
> adaptive beyond our experimental platforms, and 2) intercept the curr=
ent load
> balance for load and load balancing containment.
>=20
> Currently, CC is per CPU. To consolidate, the formula is based on a h=
euristic.
> Suppose we have 2 CPUs, their task concurrency over time is ('-' mean=
s no
> task, 'x' having tasks):
>=20
> 1)
> CPU0: ---xxxx---------- (CC[0])
> CPU1: ---------xxxx---- (CC[1])
>=20
> 2)
> CPU0: ---xxxx---------- (CC[0])
> CPU1: ---xxxx---------- (CC[1])
>=20
> If we consolidate CPU0 and CPU1, the consolidated CC will be: CC' =3D=
 CC[0] +
> CC[1] for case 1 and CC'' =3D (CC[0] + CC[1]) * 2 for case 2. For the=
 cases in
> between case 1 and 2 in terms of how xxx overlaps, the CC should be b=
etween
> CC' and CC''. So, we uniformly use this condition for consolidation (=
suppose
> we consolidate m CPUs to n CPUs, m > n):
>=20
> (CC[0] + CC[1] + ... + CC[m-2] + CC[m-1]) * (n + log(m-n)) >=3D<? (1 =
* n) * n *
> consolidating_coefficient
>=20
> The consolidating_coefficient could be like 100% or more or less.
>=20
> By CC, we implemented a Workload Consolidation patch on two Intel mob=
ile
> platforms (a quad-core composed of two dual-core modules): contain lo=
ad and
> load balancing in the first dual-core when aggregated CC low, and if =
not in
> the full quad-core. Results show that we got power savings and no sub=
stantial
> performance regression (even gains for some). The workloads we used t=
o
> evaluate the Workload Consolidation include 1) 50+ perf/ux benchmarks=
 (almost
> all of the magazine ones), and 2) ~10 power workloads, of course, the=
y are the
> easiest ones, such as browsing, audio, video, recording, imaging, etc=
=2E The
> current half-life is 1 period, and the period was 32ms, and now 64ms =
for more
> aggressive consolidation.

Hi,

Could you share some more numbers for energy savings and impact on
performance? I am also interested in these 10 power workloads - what
they are exactly?

Best regards,
Krzysztof




> v2:
> - Data type defined in formation
>=20
> Yuyang Du (12):
>   CONFIG for CPU ConCurrency
>   Init CPU ConCurrency
>   CPU ConCurrency calculation
>   CPU ConCurrency tracking
>   CONFIG for Workload Consolidation
>   Attach CPU topology to specify each sched_domain's workload
>     consolidation
>   CPU ConCurrency API for Workload Consolidation
>   Intercept wakeup/fork/exec load balancing
>   Intercept idle balancing
>   Intercept periodic nohz idle balancing
>   Intercept periodic load balancing
>   Intercept RT scheduler
>=20
>  arch/x86/Kconfig             |   21 +
>  include/linux/sched.h        |   13 +
>  include/linux/sched/sysctl.h |    8 +
>  include/linux/topology.h     |   16 +
>  kernel/sched/Makefile        |    1 +
>  kernel/sched/concurrency.c   |  928 ++++++++++++++++++++++++++++++++=
++++++++++
>  kernel/sched/core.c          |   46 +++
>  kernel/sched/fair.c          |  131 +++++-
>  kernel/sched/rt.c            |   25 ++
>  kernel/sched/sched.h         |   36 ++
>  kernel/sysctl.c              |   16 +
>  11 files changed, 1232 insertions(+), 9 deletions(-)
>  create mode 100644 kernel/sched/concurrency.c
>=20
