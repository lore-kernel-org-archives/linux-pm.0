From: Stephane Gasparini <stephane.gasparini@linux.intel.com>
Subject: Re: [PATCH 1/1] intel_pstate: Increase hold-off time before busyness is scaled
Date: Fri, 19 Feb 2016 12:11:46 +0100
Message-ID: <E45553FF-63B3-4E5B-92A0-B5B00353F6F8@linux.intel.com>
References: <1455793883-14214-1-git-send-email-mgorman@techsingularity.net>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: multipart/mixed; boundary="Apple-Mail=_DBC38626-6483-4E5E-87CC-4628820FAAA9"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:42326 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1424430AbcBSLLu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 19 Feb 2016 06:11:50 -0500
In-Reply-To: <1455793883-14214-1-git-send-email-mgorman@techsingularity.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Dirk Brandewie <dirk.j.brandewie@intel.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Matt Fleming <matt@codeblueprint.co.uk>, Mike Galbraith <umgwanakikbuti@gmail.com>, Linux-PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>


--Apple-Mail=_DBC38626-6483-4E5E-87CC-4628820FAAA9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

The issue you are reporting looks like one we improved on android by =
using=20
the average pstate instead of using the last requested pstate

We know that this is improving the ffmpeg encoding performance when =
using the
load algorithm.

see patch attached

This patch is only applied on get_target_pstate_use_cpu_load however you =
can give
it a try on get_target_pstate_use_performance

IPLoad+Avg-Pstate vs IP Load:

Benchmark               =E2=88=86Perf    =E2=88=86Power
SmartBench-Gaming       -0.1%   -10.4%
SmartBench-Productivity -0.8%   -10.4%
CandyCrush                n/a   -17.4%
AngryBirds                n/a    -5.9%
videoPlayback             n/a   -13.9%
audioPlayback             n/a    -4.9%
IcyRocks-0-0             0.0%    -4.0%
IcyRocks-20-50           0.0%   -38.4%
IcyRocks-40-100          0.1%    -2.8%
IcyRocks-60-150          1.4%    -0.6%
IcyRocks-80-200          2.9%     0.7%
IcyRocks-100-250         1.1%     0.4%
iozone RR               -2.7%    -4.2%
iozone RW               -8.8%    -4.2%
Drystone                -0.2%    -0.8%
Coremark                 0.5%     0.2%


Signed-off-by: Philippe Longepe <philippe.longepe@linux.intel.com>
---
drivers/cpufreq/intel_pstate.c | 11 ++++++++---
1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c =
b/drivers/cpufreq/intel_pstate.c
index cd83d47..6ba8cab 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -908,8 +908,6 @@ static inline void intel_pstate_sample(struct =
cpudata *cpu)
	cpu->sample.mperf -=3D cpu->prev_mperf;
	cpu->sample.tsc -=3D cpu->prev_tsc;

-	intel_pstate_calc_busy(cpu);
-
	cpu->prev_aperf =3D aperf;
	cpu->prev_mperf =3D mperf;
	cpu->prev_tsc =3D tsc;
@@ -931,6 +929,12 @@ static inline void =
intel_pstate_set_sample_time(struct cpudata *cpu)
	mod_timer_pinned(&cpu->timer, jiffies + delay);
}

+static inline int32_t get_avg_pstate(struct cpudata *cpu)
+{
+	return div64_u64(cpu->pstate.max_pstate * cpu->sample.aperf,
+		cpu->sample.mperf);
+}
+
static inline int32_t get_target_pstate_use_cpu_load(struct cpudata =
*cpu)
{
	struct sample *sample =3D &cpu->sample;
@@ -964,7 +968,7 @@ static inline int32_t =
get_target_pstate_use_cpu_load(struct cpudata *cpu)
	cpu_load =3D div64_u64(int_tofp(100) * mperf, sample->tsc);
	cpu->sample.busy_scaled =3D cpu_load;

-	return cpu->pstate.current_pstate - pid_calc(&cpu->pid, =
cpu_load);
+	return get_avg_pstate(cpu) - pid_calc(&cpu->pid, cpu_load);
}

static inline int32_t get_target_pstate_use_performance(struct cpudata =
*cpu)
@@ -973,6 +977,7 @@ static inline int32_t =
get_target_pstate_use_performance(struct cpudata *cpu)
	s64 duration_us;
	u32 sample_time;

+	intel_pstate_calc_busy(cpu);
	/*
	 * core_busy is the ratio of actual performance to max
	 * max_pstate is the max non turbo pstate available
=E2=80=94
Steph




> On Feb 18, 2016, at 12:11 PM, Mel Gorman <mgorman@techsingularity.net> =
wrote:
>=20
> (cc'ing pm and scheduler people as the problem could be blamed on =
either
> subsystem depending on your point of view)
>=20
> The PID relies on samples of equal time but this does not apply for
> deferrable timers when the CPU is idle. intel_pstate checks if the =
actual
> duration between samples is large and if so, the "busyness" of the CPU
> is scaled.
>=20
> This assumes the delay was a deferred timer but a workload may simply =
have
> been idle for a short time if it's context switching between a server =
and
> client or waiting very briefly on IO. It's compounded by the problem =
that
> server/clients migrate between CPUs due to wake-affine trying to =
maximise
> hot cache usage. In such cases, the cores are not considered busy and =
the
> frequency is dropped prematurely.
>=20
> This patch increases the hold-off value before the busyness is scaled. =
It
> was selected based simply on testing until the desired result was =
found.
> Tests were conducted with workloads that are either client/server =
based
> or short-lived IO.
>=20
> dbench4
>                               4.5.0-rc2             4.5.0-rc2
>                                 vanilla           sample-v1r1
> Hmean    mb/sec-1       309.82 (  0.00%)      327.01 (  5.55%)
> Hmean    mb/sec-2       594.92 (  0.00%)      613.02 (  3.04%)
> Hmean    mb/sec-4       669.17 (  0.00%)      712.27 (  6.44%)
> Hmean    mb/sec-8       700.82 (  0.00%)      724.04 (  3.31%)
> Hmean    mb/sec-64      425.38 (  0.00%)      448.02 (  5.32%)
>=20
>               4.5.0-rc2   4.5.0-rc2
>                 vanilla sample-v1r1
> Mean %Busy         27.28       26.81
> Mean CPU%c1        42.50       44.29
> Mean CPU%c3         7.16        7.14
> Mean CPU%c6        23.05       21.76
> Mean CPU%c7         0.00        0.00
> Mean CorWatt        4.60        5.08
> Mean PkgWatt        6.83        7.32
>=20
> There is fairly sizable performance boost from the modification and =
while
> the percentage of time spent in C1 is increased, it is not by a =
substantial
> amount and the power usage increase is tiny.
>=20
> iozone for small files and varying block sizes. Format is =
IOOperation-filessize-recordsize
>=20
>                                           4.5.0-rc2             =
4.5.0-rc2
>                                             vanilla           =
sample-v1r1
> Hmean    SeqWrite-200704-1       740152.30 (  0.00%)   748432.35 (  =
1.12%)
> Hmean    SeqWrite-200704-2      1052506.25 (  0.00%)  1169065.30 ( =
11.07%)
> Hmean    SeqWrite-200704-4      1450716.41 (  0.00%)  1725335.69 ( =
18.93%)
> Hmean    SeqWrite-200704-8      1523917.72 (  0.00%)  1881610.25 ( =
23.47%)
> Hmean    SeqWrite-200704-16     1572519.89 (  0.00%)  1750277.07 ( =
11.30%)
> Hmean    SeqWrite-200704-32     1611078.69 (  0.00%)  1923796.62 ( =
19.41%)
> Hmean    SeqWrite-200704-64     1656755.37 (  0.00%)  1892766.99 ( =
14.25%)
> Hmean    SeqWrite-200704-128    1641739.24 (  0.00%)  1952081.27 ( =
18.90%)
> Hmean    SeqWrite-200704-256    1660046.05 (  0.00%)  1931237.50 ( =
16.34%)
> Hmean    SeqWrite-200704-512    1634394.86 (  0.00%)  1860369.95 ( =
13.83%)
> Hmean    SeqWrite-200704-1024   1629526.38 (  0.00%)  1810320.92 ( =
11.09%)
> Hmean    SeqWrite-401408-1       828943.43 (  0.00%)   876152.50 (  =
5.70%)
> Hmean    SeqWrite-401408-2      1231519.20 (  0.00%)  1368986.18 ( =
11.16%)
> Hmean    SeqWrite-401408-4      1724109.56 (  0.00%)  1838265.22 (  =
6.62%)
> Hmean    SeqWrite-401408-8      1806615.84 (  0.00%)  1969611.74 (  =
9.02%)
> Hmean    SeqWrite-401408-16     1859268.96 (  0.00%)  2003005.51 (  =
7.73%)
> Hmean    SeqWrite-401408-32     1887759.67 (  0.00%)  2415913.37 ( =
27.98%)
> Hmean    SeqWrite-401408-64     1941717.11 (  0.00%)  1971929.24 (  =
1.56%)
> Hmean    SeqWrite-401408-128    1919515.58 (  0.00%)  2127647.53 ( =
10.84%)
> Hmean    SeqWrite-401408-256    1908766.57 (  0.00%)  2067473.02 (  =
8.31%)
> Hmean    SeqWrite-401408-512    1908999.37 (  0.00%)  2195587.56 ( =
15.01%)
> Hmean    SeqWrite-401408-1024   1912232.98 (  0.00%)  2150068.56 ( =
12.44%)
> Hmean    Rewrite-200704-1       1151067.57 (  0.00%)  1155309.64 (  =
0.37%)
> Hmean    Rewrite-200704-2       1786824.53 (  0.00%)  1837093.18 (  =
2.81%)
> Hmean    Rewrite-200704-4       2539338.19 (  0.00%)  2649019.78 (  =
4.32%)
> Hmean    Rewrite-200704-8       2687411.53 (  0.00%)  2785202.26 (  =
3.64%)
> Hmean    Rewrite-200704-16      2709445.97 (  0.00%)  2805580.76 (  =
3.55%)
> Hmean    Rewrite-200704-32      2735718.43 (  0.00%)  2807532.87 (  =
2.63%)
> Hmean    Rewrite-200704-64      2782754.97 (  0.00%)  2952024.38 (  =
6.08%)
> Hmean    Rewrite-200704-128     2791889.73 (  0.00%)  2805048.02 (  =
0.47%)
> Hmean    Rewrite-200704-256     2711596.34 (  0.00%)  2828896.54 (  =
4.33%)
> Hmean    Rewrite-200704-512     2665066.25 (  0.00%)  2868058.05 (  =
7.62%)
> Hmean    Rewrite-200704-1024    2675375.89 (  0.00%)  2685664.19 (  =
0.38%)
> Hmean    Rewrite-401408-1       1350713.78 (  0.00%)  1358762.21 (  =
0.60%)
> Hmean    Rewrite-401408-2       2079420.61 (  0.00%)  2097399.02 (  =
0.86%)
> Hmean    Rewrite-401408-4       2889535.90 (  0.00%)  2912795.03 (  =
0.80%)
> Hmean    Rewrite-401408-8       3068155.32 (  0.00%)  3090915.84 (  =
0.74%)
> Hmean    Rewrite-401408-16      3103789.43 (  0.00%)  3162486.65 (  =
1.89%)
> Hmean    Rewrite-401408-32      3112447.72 (  0.00%)  3243067.63 (  =
4.20%)
> Hmean    Rewrite-401408-64      3232651.39 (  0.00%)  3227701.02 ( =
-0.15%)
> Hmean    Rewrite-401408-128     3149556.47 (  0.00%)  3165694.24 (  =
0.51%)
> Hmean    Rewrite-401408-256     3093348.93 (  0.00%)  3104229.97 (  =
0.35%)
> Hmean    Rewrite-401408-512     3026305.45 (  0.00%)  3121151.02 (  =
3.13%)
> Hmean    Rewrite-401408-1024    3005431.18 (  0.00%)  3046910.32 (  =
1.38%)
>=20
>               4.5.0-rc2   4.5.0-rc2
>                 vanilla sample-v1r1
> Mean %Busy          3.10        3.09
> Mean CPU%c1         6.16        5.55
> Mean CPU%c3         0.08        0.10
> Mean CPU%c6        90.65       91.26
> Mean CPU%c7         0.00        0.00
> Mean CorWatt        1.71        1.74
> Mean PkgWatt        3.88        3.91
> Max  %Busy         16.51       16.22
> Max  CPU%c1        17.03       21.99
> Max  CPU%c3         2.57        2.15
> Max  CPU%c6        96.39       96.31
> Max  CPU%c7         0.00        0.00
> Max  CorWatt        5.40        5.42
> Max  PkgWatt        7.53        7.56
>=20
> The other operations are omitted as they showed no performance =
difference.
> For sequential writes and rewrites there is a massive gain in =
throughput
> for very small files. The increase in power consumption is negligible.
> It is known that the increase is not universal. Larger core machines =
see
> a much smaller benefit so the rate of CPU migrations are a factor.
>=20
> netperf-UDP_STREAM
>=20
>                                4.5.0-rc2             4.5.0-rc2
>                                  vanilla           sample-v1r1
> Hmean    send-64         233.96 (  0.00%)      244.76 (  4.61%)
> Hmean    send-128        466.74 (  0.00%)      479.16 (  2.66%)
> Hmean    send-256        929.12 (  0.00%)      964.00 (  3.75%)
> Hmean    send-1024      3631.36 (  0.00%)     3781.89 (  4.15%)
> Hmean    send-2048      6984.60 (  0.00%)     7169.60 (  2.65%)
> Hmean    send-3312     10792.94 (  0.00%)    11103.42 (  2.88%)
> Hmean    send-4096     12895.57 (  0.00%)    13112.58 (  1.68%)
> Hmean    send-8192     23057.34 (  0.00%)    23443.80 (  1.68%)
> Hmean    send-16384    37871.11 (  0.00%)    38292.60 (  1.11%)
> Hmean    recv-64         233.89 (  0.00%)      244.71 (  4.63%)
> Hmean    recv-128        466.63 (  0.00%)      479.09 (  2.67%)
> Hmean    recv-256        928.88 (  0.00%)      963.74 (  3.75%)
> Hmean    recv-1024      3630.54 (  0.00%)     3780.96 (  4.14%)
> Hmean    recv-2048      6983.20 (  0.00%)     7167.55 (  2.64%)
> Hmean    recv-3312     10790.92 (  0.00%)    11100.63 (  2.87%)
> Hmean    recv-4096     12891.37 (  0.00%)    13110.35 (  1.70%)
> Hmean    recv-8192     23054.79 (  0.00%)    23438.27 (  1.66%)
> Hmean    recv-16384    37866.79 (  0.00%)    38283.73 (  1.10%)
>=20
>               4.5.0-rc2   4.5.0-rc2
>                 vanilla sample-v1r1
> Mean %Busy         37.30       37.10
> Mean CPU%c1        37.52       37.30
> Mean CPU%c3         0.10        0.10
> Mean CPU%c6        25.08       25.49
> Mean CPU%c7         0.00        0.00
> Mean CorWatt       11.20       11.18
> Mean PkgWatt       13.30       13.28
> Max  %Busy         50.64       51.73
> Max  CPU%c1        49.80       50.53
> Max  CPU%c3         9.14        8.95
> Max  CPU%c6        62.46       63.48
> Max  CPU%c7         0.00        0.00
> Max  CorWatt       16.46       16.44
> Max  PkgWatt       18.58       18.55
>=20
> In this test, the client/server are pinned to cores so the scheduler
> decisions are not a factor. There is still a mild performance boost
> with no impact on power consumption.
>=20
> cyclictest-pinned
>                            4.5.0-rc2             4.5.0-rc2
>                              vanilla           sample-v1r1
> Amean    LatAvg        3.00 (  0.00%)        2.64 ( 11.94%)
> Amean    LatMax      156.93 (  0.00%)      106.89 ( 31.89%)
>=20
>               4.5.0-rc2   4.5.0-rc2
>                 vanilla sample-v1r1
> Mean %Busy         99.74       99.73
> Mean CPU%c1         0.02        0.02
> Mean CPU%c3         0.00        0.01
> Mean CPU%c6         0.23        0.24
> Mean CPU%c7         0.00        0.00
> Mean CorWatt        5.06        5.92
> Mean PkgWatt        7.12        7.99
> Max  %Busy        100.00      100.00
> Max  CPU%c1         3.88        3.50
> Max  CPU%c3         0.71        0.99
> Max  CPU%c6        41.79       43.17
> Max  CPU%c7         0.00        0.00
> Max  CorWatt        6.80        8.66
> Max  PkgWatt        8.85       10.71
>=20
> This test measures how quickly a task wakes up after a timeout. The =
test
> could be defeated by selecting a different timeout value that is =
outside
> the new hold-off value. Furthermore, a workload that is very sensitive =
to
> wakeup latencies should use the performance governor.  Nevertheless =
it's
> interesting to note the impact of increasing the hold-off value.  =
There is
> an increase in power usage because the CPU remains active during sleep =
times.
>=20
> In all cases, there are some CPU migrations because wakers pull wakees =
to
> nearby CPUs. It could be argued that the workload should be pinned but =
this
> puts a burden on the user that may not even be possible in all cases. =
The
> scheduler could try keeping processes on the same CPUs but that would =
impact
> cache hotness and cause a different class of issues. It is inevitable =
that
> there will be some conflict between power management and scheduling =
decisions
> but there is some gains from delaying idling slightly without a severe =
impact
> on power consumption.
>=20
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
> drivers/cpufreq/intel_pstate.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/cpufreq/intel_pstate.c =
b/drivers/cpufreq/intel_pstate.c
> index cd83d477e32d..54250084174a 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -999,7 +999,7 @@ static inline int32_t =
get_target_pstate_use_performance(struct cpudata *cpu)
> 	sample_time =3D pid_params.sample_rate_ms  * USEC_PER_MSEC;
> 	duration_us =3D ktime_us_delta(cpu->sample.time,
> 				     cpu->last_sample_time);
> -	if (duration_us > sample_time * 3) {
> +	if (duration_us > sample_time * 12) {
> 		sample_ratio =3D div_fp(int_tofp(sample_time),
> 				      int_tofp(duration_us));
> 		core_busy =3D mul_fp(core_busy, sample_ratio);
> --=20
> 2.6.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--Apple-Mail=_DBC38626-6483-4E5E-87CC-4628820FAAA9
Content-Disposition: attachment;
	filename*0="[linux-power-mgmt] [PATCH 1_3] cpufreq: intel_pstate: Use avg_ps";
	filename*1="tate instead of current_pstate"
Content-Type: application/octet-stream;
	name="[linux-power-mgmt] [PATCH 1_3] cpufreq: intel_pstate: Use avg_pstate instead of current_pstate"
Content-Transfer-Encoding: quoted-printable

Return-Path:=20<linux-power-mgmt-owner@scymls02.sc.intel.com>=0A=
X-Original-To:=20stephane.gasparini@linux.intel.com=0ADelivered-To:=20=
stephane.gasparini@linux.intel.com=0AReceived:=20from=20=
scymls02.sc.intel.com=20(scymls02.sc.intel.com=20[10.82.194.2])=0A=09=
(using=20TLSv1=20with=20cipher=20DHE-RSA-AES256-SHA=20(256/256=20bits))=0A=
=09(No=20client=20certificate=20requested)=0A=09by=20linux.intel.com=20=
(Postfix)=20with=20ESMTP=20id=20CF0DE6A4006;=0A=09Mon,=2011=20Jan=202016=20=
07:16:06=20-0800=20(PST)=0AReceived:=20from=20scymls02.sc.intel.com=20=
(localhost=20[127.0.0.1])=0A=09by=20scymls02.sc.intel.com=20with=20ESMTP=20=
id=20u0BES88a027634;=0A=09Mon,=2011=20Jan=202016=2006:28:08=20-0800=0A=
Received:=20(from=20sys_eclists@localhost)=0A=09by=20=
scymls02.sc.intel.com=20with=20=9C=20id=20u0BES8QV027630;=0A=09Mon,=2011=20=
Jan=202016=2006:28:08=20-0800=0AX-Authentication-Warning:=20=
scymls02.sc.intel.com:=20sys_eclists=20set=20sender=20to=20=
linux-power-mgmt-owner@eclists.intel.com=20using=20-f=0AReceived:=20from=20=
orsmga001.jf.intel.com=20(orsmga001.jf.intel.com=20[10.7.209.18])=0A=09=
by=20scymls02.sc.intel.com=20with=20ESMTP=20id=20u0BERwr6027475=0A=09for=20=
<linux-power-mgmt@eclists.intel.com>;=20Mon,=2011=20Jan=202016=20=
06:28:02=20-0800=0AX-ExtLoop1:=201=0AX-IronPort-AV:=20=
E=3DSophos;i=3D"5.20,553,1444719600";=20=0A=20=20=20=
d=3D"scan'208";a=3D"858170435"=0AReceived:=20from=20=
tllab185.tl.intel.com=20([10.102.161.63])=0A=20=20by=20=
orsmga001.jf.intel.com=20with=20ESMTP;=2011=20Jan=202016=2006:28:01=20=
-0800=0AFrom:=20Philippe=20Longepe=20<philippe.longepe@linux.intel.com>=0A=
To:=20linux-power-mgmt@eclists.intel.com=0ACc:=20rjw@rjwysocki.net,=20=
srinivas.pandruvada@linux.intel.com=0ADate:=20Mon,=2011=20Jan=202016=20=
15:29:02=20+0100=0AMessage-Id:=20=
<1452522544-9787-3-git-send-email-philippe.longepe@linux.intel.com>=0A=
X-Mailer:=20git-send-email=201.9.1=0AIn-Reply-To:=20=
<1452522544-9787-1-git-send-email-philippe.longepe@linux.intel.com>=0A=
References:=20=
<1452522544-9787-1-git-send-email-philippe.longepe@linux.intel.com>=0A=
MIME-Version:=201.0=0AContent-Type:=20text/plain;=20charset=3DUTF-8=0A=
Content-Transfer-Encoding:=208bit=0ASubject:=20[linux-power-mgmt]=20=
[PATCH=201/3]=20cpufreq:=20intel_pstate:=20Use=0A=20avg_pstate=20instead=20=
of=20current_pstate=0AReply-To:=20Philippe=20Longepe=20=
<philippe.longepe@linux.intel.com>=0AX-Loop:=20=
linux-power-mgmt@eclists.intel.com=0AX-Sequence:=20595=0AErrors-to:=20=
linux-power-mgmt-owner@eclists.intel.com=0APrecedence:=20list=0A=
Precedence:=20bulk=0ASender:=20=
linux-power-mgmt-request@eclists.intel.com=0AX-no-archive:=20yes=0A=
List-Id:=20<linux-power-mgmt.eclists.intel.com>=0AList-Archive:=20=
<https://eclists.intel.com/sympa/arc/linux-power-mgmt>=0AList-Help:=20=
<mailto:sympa@eclists.intel.com?subject=3Dhelp>=0AList-Owner:=20=
<mailto:linux-power-mgmt-request@eclists.intel.com>=0AList-Post:=20=
<mailto:linux-power-mgmt@eclists.intel.com>=0AList-Subscribe:=20=
<mailto:sympa@eclists.intel.com?subject=3Dsubscribe%20linux-power-mgmt>=0A=
List-Unsubscribe:=20=
<mailto:sympa@eclists.intel.com?subject=3Dunsubscribe%20linux-power-mgmt>=0A=
=0AThe=20number=20of=20pstates=20computed=20by=20pid_calc=20was=20=
applied=20to=20the=0Acurrent_pstate=20which=20is=20the=20last=20=
requested=20pstate=20during=20the=20last=0Aperiod.=20However,=20the=20=
real=20pstate=20can=20be=20completely=20different=0A(generally=20higher)=20=
because=20of=20the=20frequency=20sharing=20per=20module.=0A=0AI=20=
observed=20some=20performance=20and=20power=20impacts=20during=20thread=0A=
migrations:=20For=20example=20when=20there=20is=20a=20load=20of=20100%=20=
on=20cpu0=20and=0A5%=20on=20cpu1,=20the=20current=20pstate=20was=20=
turbo_pstate=20on=20cpu0=20and=20it=20was=0ALFM=20on=20cpu1,=20but=20the=20=
real=20pstate=20was=20also=20turbo=20on=20cpu1=20in=20case=0Athey=20are=20=
in=20the=20same=20module.=20If=20the=20main=20thread=20migrates=20from=20=
cpu0=0Ato=20cpu1,=20the=20load=20becomes=20high=20on=20cpu1=20and=20it=20=
will=20take=20several=0Aperiods=20before=20we=20reach=20again=20turbo.=0A=
=0AUsing=20the=20average=20pstate=20instead=20of=20current=20pstate=20=
solve=20this=20issue.=0A=0AAlso=20I=20moved=20the=20=
intel_pstate_calc_busy=20function=20because=20it=20was=20used=0Aonly=20=
for=20the=20performance=20algorithm.=0A=0APerformance=20and=20power=20=
comparison=20with=20this=20patch=20on=20Android:=0A=0AIPLoad+Avg-Pstate=20=
vs=20IP=20Load:=0A=0ABenchmark=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=E2=88=86Perf=20=20=20=20=E2=88=86Power=0ASmartBench-Gaming=20=20=20=20=20=
=20=20-0.1%=20=20=20-10.4%=0ASmartBench-Productivity=20-0.8%=20=20=20=
-10.4%=0ACandyCrush=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20n/a=20=
=20=20-17.4%=0AAngryBirds=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
n/a=20=20=20=20-5.9%=0AvideoPlayback=20=20=20=20=20=20=20=20=20=20=20=20=20=
n/a=20=20=20-13.9%=0AaudioPlayback=20=20=20=20=20=20=20=20=20=20=20=20=20=
n/a=20=20=20=20-4.9%=0AIcyRocks-0-0=20=20=20=20=20=20=20=20=20=20=20=20=20=
0.0%=20=20=20=20-4.0%=0AIcyRocks-20-50=20=20=20=20=20=20=20=20=20=20=20=
0.0%=20=20=20-38.4%=0AIcyRocks-40-100=20=20=20=20=20=20=20=20=20=200.1%=20=
=20=20=20-2.8%=0AIcyRocks-60-150=20=20=20=20=20=20=20=20=20=201.4%=20=20=20=
=20-0.6%=0AIcyRocks-80-200=20=20=20=20=20=20=20=20=20=202.9%=20=20=20=20=20=
0.7%=0AIcyRocks-100-250=20=20=20=20=20=20=20=20=201.1%=20=20=20=20=20=
0.4%=0Aiozone=20RR=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20-2.7%=20=20=
=20=20-4.2%=0Aiozone=20RW=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
-8.8%=20=20=20=20-4.2%=0ADrystone=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20-0.2%=20=20=20=20-0.8%=0ACoremark=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=200.5%=20=20=20=20=200.2%=0A=0ASigned-off-by:=20Philippe=20=
Longepe=20<philippe.longepe@linux.intel.com>=0A---=0A=20=
drivers/cpufreq/intel_pstate.c=20|=2011=20++++++++---=0A=201=20file=20=
changed,=208=20insertions(+),=203=20deletions(-)=0A=0Adiff=20--git=20=
a/drivers/cpufreq/intel_pstate.c=20b/drivers/cpufreq/intel_pstate.c=0A=
index=20cd83d47..6ba8cab=20100644=0A---=20=
a/drivers/cpufreq/intel_pstate.c=0A+++=20=
b/drivers/cpufreq/intel_pstate.c=0A@@=20-908,8=20+908,6=20@@=20static=20=
inline=20void=20intel_pstate_sample(struct=20cpudata=20*cpu)=0A=20=09=
cpu->sample.mperf=20-=3D=20cpu->prev_mperf;=0A=20=09cpu->sample.tsc=20-=3D=
=20cpu->prev_tsc;=0A=20=0A-=09intel_pstate_calc_busy(cpu);=0A-=0A=20=09=
cpu->prev_aperf=20=3D=20aperf;=0A=20=09cpu->prev_mperf=20=3D=20mperf;=0A=20=
=09cpu->prev_tsc=20=3D=20tsc;=0A@@=20-931,6=20+929,12=20@@=20static=20=
inline=20void=20intel_pstate_set_sample_time(struct=20cpudata=20*cpu)=0A=20=
=09mod_timer_pinned(&cpu->timer,=20jiffies=20+=20delay);=0A=20}=0A=20=0A=
+static=20inline=20int32_t=20get_avg_pstate(struct=20cpudata=20*cpu)=0A=
+{=0A+=09return=20div64_u64(cpu->pstate.max_pstate=20*=20=
cpu->sample.aperf,=0A+=09=09cpu->sample.mperf);=0A+}=0A+=0A=20static=20=
inline=20int32_t=20get_target_pstate_use_cpu_load(struct=20cpudata=20=
*cpu)=0A=20{=0A=20=09struct=20sample=20*sample=20=3D=20&cpu->sample;=0A=
@@=20-964,7=20+968,7=20@@=20static=20inline=20int32_t=20=
get_target_pstate_use_cpu_load(struct=20cpudata=20*cpu)=0A=20=09cpu_load=20=
=3D=20div64_u64(int_tofp(100)=20*=20mperf,=20sample->tsc);=0A=20=09=
cpu->sample.busy_scaled=20=3D=20cpu_load;=0A=20=0A-=09return=20=
cpu->pstate.current_pstate=20-=20pid_calc(&cpu->pid,=20cpu_load);=0A+=09=
return=20get_avg_pstate(cpu)=20-=20pid_calc(&cpu->pid,=20cpu_load);=0A=20=
}=0A=20=0A=20static=20inline=20int32_t=20=
get_target_pstate_use_performance(struct=20cpudata=20*cpu)=0A@@=20-973,6=20=
+977,7=20@@=20static=20inline=20int32_t=20=
get_target_pstate_use_performance(struct=20cpudata=20*cpu)=0A=20=09s64=20=
duration_us;=0A=20=09u32=20sample_time;=0A=20=0A+=09=
intel_pstate_calc_busy(cpu);=0A=20=09/*=0A=20=09=20*=20core_busy=20is=20=
the=20ratio=20of=20actual=20performance=20to=20max=0A=20=09=20*=20=
max_pstate=20is=20the=20max=20non=20turbo=20pstate=20available=0A--=20=0A=
1.9.1=0A=0A-------------------------------------=0A=
linux-power-mgmt@eclists.intel.com=0A=
https://eclists.intel.com/sympa/info/linux-power-mgmt=0AUnsubscribe=20by=20=
sending=20email=20to=20sympa@eclists.intel.com=20with=20subject=20=
"Unsubscribe=20linux-power-mgmt"=0A=

--Apple-Mail=_DBC38626-6483-4E5E-87CC-4628820FAAA9--
