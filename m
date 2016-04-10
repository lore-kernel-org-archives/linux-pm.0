From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] intel_pstate: Avoid getting stuck in high P-states when idle
Date: Sun, 10 Apr 2016 06:09:45 +0200
Message-ID: <2256431.6LpmRCrGe6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:52190 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750851AbcDJEHK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 10 Apr 2016 00:07:10 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux PM list <linux-pm@vger.kernel.org>
Cc: =?ISO-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>, len.brown@intel.com

=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

J=C3=B6rg Otte reports that commit a4675fbc4a7a (cpufreq: intel_pstate:
Replace timers with utilization update callbacks) caused the CPUs in
his Haswell-based system to stay in the very high frequency region
even if the system is completely idle.

That turns out to be an existing problem in the intel_pstate driver's
P-state selection algorithm for Core processors.  Namely, all
decisions made by that algorithm are based on the average frequency
of the CPU between sampling events and on the P-state requested on
the last invocation, so it may get stuck at a very hight frequency
even if the utilization of the CPU is very low (in fact, it may get
stuck in a inadequate P-state regardless of the CPU utilization).
The only way to kick it out of that limbo is a sufficiently long idle
period (3 times longer than the prescribed sampling interval), but if
that doesn't happen often enough (eg. due to a timing change like
after the above commit), the P-state of the CPU may be inadequate
pretty much all the time.

To address the most egregious manifestations of that issue, reset the
core_busy value used to determine the next P-state to request if the
utilization of the CPU, determined with the help of the MPERF
feedback register and the TSC, is below 1%.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D115771
Reported-and-tested-by: J=C3=B6rg Otte <jrg.otte@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -995,6 +995,10 @@ static inline int32_t get_target_pstate_
 		sample_ratio =3D div_fp(int_tofp(pid_params.sample_rate_ns),
 				      int_tofp(duration_ns));
 		core_busy =3D mul_fp(core_busy, sample_ratio);
+	} else {
+		sample_ratio =3D div_fp(100 * cpu->sample.mperf, cpu->sample.tsc);
+		if (sample_ratio < int_tofp(1))
+			core_busy =3D 0;
 	}
=20
 	cpu->sample.busy_scaled =3D core_busy;

