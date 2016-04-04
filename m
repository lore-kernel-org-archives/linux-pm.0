From: Philippe Longepe <philippe.longepe@linux.intel.com>
Subject: [PATCH V4] intel_pstate: Use avg_pstate instead of current_pstate
Date: Mon,  4 Apr 2016 09:23:37 +0200
Message-ID: <1459754617-8872-2-git-send-email-philippe.longepe@linux.intel.com>
References: <1459754617-8872-1-git-send-email-philippe.longepe@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55996 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979AbcDDHXZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 4 Apr 2016 03:23:25 -0400
In-Reply-To: <1459754617-8872-1-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com, rafael@kernel.org, len.brown@intel.com

The result returned by pid_calc() is subtracted from current_pstate
(which is the pstate requested during the last period) in order to
obtain the target pstate for the current iteration.
However, current_pstate may not reflect the real current P-state of
the CPU.  In particular, that P-state may be higher because of the
frequency sharing per module.

The theory is:

- The load is the percentage of time spent in C0 and is related to
the average frequency during the same period (We'll not have the
same load at 1GHz or at 2GHz for the same task running).

- The current frequency can be completely different than the
average frequency (because of frequency sharing or throttling).

=3D> The frequency shift computed by the pid_calc is based on the
load, so it must be applied to the frequency with which the load
was measured.

Using the average pstate instead of current pstate solve some
migration issues (e.g when a task migrates from one core to another
in the same package/module and all of the cores in there except for
that particular one are basically idle).

Performance and power comparison with this patch on Android:

IPLoad+Avg-Pstate vs IP Load:

Benchmark               =E2=88=86Perf    =E2=88=86Power
=46ishTank                10.45%    3.1%
SmartBench-Gaming       -0.1%   -10.4%
SmartBench-Productivity -0.8%   -10.4%
CandyCrush                n/a   -17.4%
AngryBirds                n/a    -5.9%
videoPlayback             n/a   -13.9%
audioPlayback             n/a    -4.9%
IcyRocks-20-50           0.0%   -38.4%
iozone RR               -0.16%  -1.3%
iozone RW                0.74%  -1.3%

Comparison with the perf algorithm:
(this patch in cpu_load vs Core algorithm)

Benchmark               =E2=88=86Perf    =E2=88=86Power
SmartBench-Gaming       -0.58%   -22.8%
SmartBench-Productivity  0.82%
CandyCrush                n/a    -20.8%
AngryBirds                n/a    -37.0%
videoPlayback             n/a    -53.4%
audioPlayback             n/a     -2.1%
iozone RR               -0.55%   -13.29%
iozone RW                2.22%

=3D> No regression > 1% observed and a huge power improvement!

Signed-off-by: Philippe Longepe <philippe.longepe@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pst=
ate.c
index 4b64452..b998e1d 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -919,6 +919,12 @@ static inline int32_t get_avg_frequency(struct cpu=
data *cpu)
 		cpu->pstate.scaling, cpu->sample.mperf);
 }
=20
+static inline int32_t get_avg_pstate(struct cpudata *cpu)
+{
+	return div64_u64(cpu->pstate.max_pstate_physical * cpu->sample.aperf,
+		cpu->sample.mperf);
+}
+
 static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *c=
pu)
 {
 	struct sample *sample =3D &cpu->sample;
@@ -951,7 +957,7 @@ static inline int32_t get_target_pstate_use_cpu_loa=
d(struct cpudata *cpu)
 	cpu_load =3D div64_u64(int_tofp(100) * mperf, sample->tsc);
 	cpu->sample.busy_scaled =3D cpu_load;
=20
-	return cpu->pstate.current_pstate - pid_calc(&cpu->pid, cpu_load);
+	return get_avg_pstate(cpu) - pid_calc(&cpu->pid, cpu_load);
 }
=20
 static inline int32_t get_target_pstate_use_performance(struct cpudata=
 *cpu)
--=20
1.9.1

