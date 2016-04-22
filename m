From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1] cpufreq: intel_pstate: Use average P-State instead of current P-State
Date: Fri, 22 Apr 2016 11:46:09 -0700
Message-ID: <1461350769-5947-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33524 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751831AbcDVStq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 22 Apr 2016 14:49:46 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Philippe Longepe <philippe.longepe@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

=46rom: Philippe Longepe <philippe.longepe@linux.intel.com>

The result returned by pid_calc() is subtracted from current_pstate (wh=
ich
is the P-State requested during the last period) in order to obtain the
target P-State for the current iteration.
However, current_pstate may not reflect the real current P-State of the
CPU. In particular, that P-State may be higher because of the frequency
sharing per module.

The theory is:
- The load is the percentage of time spent in C0 and is related to the
average P-State during the same period.
- The last requested P-State can be completely different than the avera=
ge
P-State (because of frequency sharing or throttling).
- The P-State shift computed by the pid_calc is based on the load compu=
ted
at average P-State, so the shift must be relative to this average P-Sta=
te.

Using the average P-State instead of current P-State improves =E2=88=86=
Power
without significant performance penalty in cases when a task migrates
from one core to other core sharing frequency and voltage.

Performance and power comparison with this patch on Cherry Trail platfo=
rm
using Android:

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

Signed-off-by: Philippe Longepe <philippe.longepe@linux.intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com=
>
---
v1:
-Patch version V4 was only posted upstream, so the this update is
version v1 not v5.
-No change in source code logic. Only formatting and commit description
change.

 drivers/cpufreq/intel_pstate.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pst=
ate.c
index 30fe323..1b2767d 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1061,6 +1061,12 @@ static inline int32_t get_avg_frequency(struct c=
pudata *cpu)
 		cpu->pstate.scaling, cpu->sample.mperf);
 }
=20
+static inline int32_t get_avg_pstate(struct cpudata *cpu)
+{
+	return div64_u64(cpu->pstate.max_pstate_physical * cpu->sample.aperf,
+			 cpu->sample.mperf);
+}
+
 static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *c=
pu)
 {
 	struct sample *sample =3D &cpu->sample;
@@ -1093,7 +1099,7 @@ static inline int32_t get_target_pstate_use_cpu_l=
oad(struct cpudata *cpu)
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
2.5.0

