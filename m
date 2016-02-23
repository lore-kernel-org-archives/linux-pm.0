From: Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/1] intel_pstate: Increase hold-off time before samples are scaled v2
Date: Tue, 23 Feb 2016 14:29:44 +0000
Message-ID: <1456237784-17205-1-git-send-email-mgorman@techsingularity.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from outbound-smtp04.blacknight.com ([81.17.249.35]:59029 "EHLO
	outbound-smtp04.blacknight.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752500AbcBWO3r (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Feb 2016 09:29:47 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
	by outbound-smtp04.blacknight.com (Postfix) with ESMTPS id 4EDD4F4007
	for <linux-pm@vger.kernel.org>; Tue, 23 Feb 2016 14:29:45 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Doug Smythies <dsmythies@telus.net>, Stephane Gasparini <stephane.gasparini@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Dirk Brandewie <dirk.j.brandewie@intel.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Matt Fleming <matt@codeblueprint.co.uk>, Mike Galbraith <umgwanakikbuti@gmail.com>, Linux-PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@techsingularity.net>

Added a suggested change from Doug Smythies and can add a Signed-off-by
if Doug is ok with that.

Changelog since v1
o Remove divide that is likely unnecessary			(dsmythies)
o Rebase on top of linux-pm/linux-next

The PID relies on samples of equal time but this does not apply for
deferrable timers when the CPU is idle. intel_pstate checks if the actual
duration between samples is large and if so, the "busyness" of the CPU
is scaled.

This assumes the delay was a deferred timer but a workload may simply have
been idle for a short time if it's context switching between a server and
client or waiting very briefly on IO. It's compounded by the problem that
server/clients migrate between CPUs due to wake-affine trying to maximise
hot cache usage. In such cases, the cores are not considered busy and the
frequency is dropped prematurely.

This patch increases the hold-off value before the busyness is scaled. It
was selected based simply on testing until the desired result was found.
Tests were conducted with workloads that are either client/server based
or short-lived IO.

dbench4

                               4.5.0-rc4             4.5.0-rc4
                         pmnext-20160219           sample-v2r3
Hmean    mb/sec-1       322.84 (  0.00%)      322.40 ( -0.14%)
Hmean    mb/sec-2       604.32 (  0.00%)      615.03 (  1.77%)
Hmean    mb/sec-4       680.53 (  0.00%)      707.78 (  4.00%)
Hmean    mb/sec-8       705.40 (  0.00%)      742.36 (  5.24%)

           4.5.0-rc4   4.5.0-rc4
        pmnext-20160219 sample-v2r3
User         1483.79     1393.30
System       3847.87     3652.56
Elapsed      5406.79     5405.82

               4.5.0-rc4   4.5.0-rc4
            pmnext-20160219 sample-v2r3
Mean %Busy         27.59       26.21
Mean CPU%c1        43.37       44.21
Mean CPU%c3         7.30        7.67
Mean CPU%c6        21.74       21.91
Mean CPU%c7         0.00        0.00
Mean CorWatt        4.69        5.11
Mean PkgWatt        6.92        7.34

There performance boost is marginal but the system CPU usage is much reduced and overall the
impact on power usage is marginal.

iozone for small files and varying block sizes. Format is IOOperation-filessize-recordsize

                                           4.5.0-rc2             4.5.0-rc2
                                             vanilla           sample-v1r1
Hmean    SeqWrite-200704-1       745153.35 (  0.00%)   835705.87 ( 12.15%)
Hmean    SeqWrite-200704-2      1073584.72 (  0.00%)  1181464.54 ( 10.05%)
Hmean    SeqWrite-200704-4      1470279.09 (  0.00%)  1800606.95 ( 22.47%)
Hmean    SeqWrite-200704-8      1557199.39 (  0.00%)  1858933.62 ( 19.38%)
Hmean    SeqWrite-200704-16     1604615.45 (  0.00%)  1982299.77 ( 23.54%)
Hmean    SeqWrite-200704-32     1651599.28 (  0.00%)  1896837.26 ( 14.85%)
Hmean    SeqWrite-200704-64     1666177.22 (  0.00%)  2061195.61 ( 23.71%)
Hmean    SeqWrite-200704-128    1669019.85 (  0.00%)  1940620.93 ( 16.27%)
Hmean    SeqWrite-200704-256    1657685.15 (  0.00%)  2054770.87 ( 23.95%)
Hmean    SeqWrite-200704-512    1657502.45 (  0.00%)  2064537.12 ( 24.56%)
Hmean    SeqWrite-200704-1024   1658418.19 (  0.00%)  2065680.07 ( 24.56%)
Hmean    SeqWrite-401408-1       823115.74 (  0.00%)   873454.97 (  6.12%)
Hmean    SeqWrite-401408-2      1175839.58 (  0.00%)  1380834.12 ( 17.43%)
Hmean    SeqWrite-401408-4      1746819.22 (  0.00%)  1959568.79 ( 12.18%)
Hmean    SeqWrite-401408-8      1857904.68 (  0.00%)  2119305.42 ( 14.07%)
Hmean    SeqWrite-401408-16     1883956.56 (  0.00%)  2263314.65 ( 20.14%)
Hmean    SeqWrite-401408-32     1928933.02 (  0.00%)  2359131.00 ( 22.30%)
Hmean    SeqWrite-401408-64     1947503.44 (  0.00%)  2269170.03 ( 16.52%)
Hmean    SeqWrite-401408-128    1963530.81 (  0.00%)  2360367.91 ( 20.21%)
Hmean    SeqWrite-401408-256    1930490.52 (  0.00%)  2179920.99 ( 12.92%)
Hmean    SeqWrite-401408-512    1944400.52 (  0.00%)  2268039.39 ( 16.64%)
Hmean    SeqWrite-401408-1024   1930551.06 (  0.00%)  2294266.42 ( 18.84%)
Hmean    Rewrite-200704-1       1157432.45 (  0.00%)  1161993.50 (  0.39%)
Hmean    Rewrite-200704-2       1769952.94 (  0.00%)  1875955.03 (  5.99%)
Hmean    Rewrite-200704-4       2534237.50 (  0.00%)  2850813.95 ( 12.49%)
Hmean    Rewrite-200704-8       2739338.32 (  0.00%)  3069949.91 ( 12.07%)
Hmean    Rewrite-200704-16      2869980.18 (  0.00%)  3084573.49 (  7.48%)
Hmean    Rewrite-200704-32      2893382.66 (  0.00%)  3125994.45 (  8.04%)
Hmean    Rewrite-200704-64      2971476.80 (  0.00%)  3037778.64 (  2.23%)
Hmean    Rewrite-200704-128     2899499.67 (  0.00%)  3061961.77 (  5.60%)
Hmean    Rewrite-200704-256     2931964.78 (  0.00%)  3047588.38 (  3.94%)
Hmean    Rewrite-200704-512     2905287.39 (  0.00%)  2716185.78 ( -6.51%)
Hmean    Rewrite-200704-1024    2852964.56 (  0.00%)  2979784.30 (  4.45%)
Hmean    Rewrite-401408-1       1340119.25 (  0.00%)  1367559.86 (  2.05%)
Hmean    Rewrite-401408-2       2066152.00 (  0.00%)  2150180.25 (  4.07%)
Hmean    Rewrite-401408-4       2877697.54 (  0.00%)  3141556.92 (  9.17%)
Hmean    Rewrite-401408-8       3111565.24 (  0.00%)  3351724.68 (  7.72%)
Hmean    Rewrite-401408-16      3121552.56 (  0.00%)  3460645.54 ( 10.86%)
Hmean    Rewrite-401408-32      3156754.87 (  0.00%)  3689350.17 ( 16.87%)
Hmean    Rewrite-401408-64      3323557.00 (  0.00%)  3476782.18 (  4.61%)
Hmean    Rewrite-401408-128     3402701.75 (  0.00%)  3530951.84 (  3.77%)
Hmean    Rewrite-401408-256     3204914.57 (  0.00%)  3277704.44 (  2.27%)
Hmean    Rewrite-401408-512     3133442.60 (  0.00%)  3387768.91 (  8.12%)
Hmean    Rewrite-401408-1024    3143721.63 (  0.00%)  3341908.51 (  6.30%)

               4.5.0-rc4   4.5.0-rc4
            pmnext-20160219 sample-v2r3
Mean %Busy          3.45        3.32
Mean CPU%c1         5.44        6.01
Mean CPU%c3         0.13        0.09
Mean CPU%c6        90.98       90.58
Mean CPU%c7         0.00        0.00
Mean CorWatt        1.75        1.83
Mean PkgWatt        3.92        3.98
Max  %Busy         16.46       16.46
Max  CPU%c1        17.33       17.60
Max  CPU%c3         1.62        1.42
Max  CPU%c6        96.10       95.43
Max  CPU%c7         0.00        0.00
Max  CorWatt        5.47        5.54
Max  PkgWatt        7.60        7.63

The other operations are omitted as they showed either no or negligible performance difference.
For sequential writes and rewrites there is a massive gain in throughput
for very small files. The increase in power consumption is negligible.
It is known that the increase is not universal. Larger core machines see
a much smaller benefit so the rate of CPU migrations are a factor.

In all cases, there are some CPU migrations because wakers pull wakees
to nearby CPUs. It could be argued that such workloads should be pinned
but this puts a burden on the user that may not even be possible in all
cases. The scheduler could try keeping processes on the same CPUs but that
would impact cache hotness and cause a different class of issues. It is
inevitable that there will be some conflict between power management and
scheduling decisions but there is some gains from delaying idling slightly
without a severe impact on power consumption.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 drivers/cpufreq/intel_pstate.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index f4d85c2ae7b1..6f3bf1e68f63 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -975,17 +975,15 @@ static inline int32_t get_target_pstate_use_performance(struct cpudata *cpu)
 
 	/*
 	 * Since our utilization update callback will not run unless we are
-	 * in C0, check if the actual elapsed time is significantly greater (3x)
-	 * than our sample interval.  If it is, then we were idle for a long
-	 * enough period of time to adjust our busyness.
+	 * in C0, check if the actual elapsed time is significantly greater (12x)
+	 * than our sample interval.  If it is, then assume we were idle for a long
+	 * enough period of time to adjust our busyness. While the assumption
+	 * is not always true, it seems to be good enough.
 	 */
 	duration_ns = cpu->sample.time - cpu->last_sample_time;
-	if ((s64)duration_ns > pid_params.sample_rate_ns * 3
-	    && cpu->last_sample_time > 0) {
-		sample_ratio = div_fp(int_tofp(pid_params.sample_rate_ns),
-				      int_tofp(duration_ns));
-		core_busy = mul_fp(core_busy, sample_ratio);
-	}
+	if ((s64)duration_ns > pid_params.sample_rate_ns * 12
+	    && cpu->last_sample_time > 0)
+		core_busy = 0;
 
 	cpu->sample.busy_scaled = core_busy;
 	return cpu->pstate.current_pstate - pid_calc(&cpu->pid, core_busy);
-- 
2.6.4

