From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [intel-pstate driver regression] processor frequency very high even if in idle
Date: Fri, 01 Apr 2016 14:40:15 +0200
Message-ID: <3623107.tlAuqH4F7s@vostro.rjw.lan>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com> <2727017.UmaUvtBLeX@vostro.rjw.lan> <CADDKRnCs8vWbqOBbk0T+A5_VSzC5ENfND=NLwb3G0XjTvF9DQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADDKRnCs8vWbqOBbk0T+A5_VSzC5ENfND=NLwb3G0XjTvF9DQA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On Friday, April 01, 2016 11:20:42 AM J=C3=B6rg Otte wrote:
> 2016-03-31 17:43 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
> > On Thursday, March 31, 2016 05:25:18 PM J=C3=B6rg Otte wrote:
> >> 2016-03-31 13:42 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
> >> > On Thursday, March 31, 2016 11:05:56 AM J=C3=B6rg Otte wrote:
> >> >
> >> > [cut]
> >> >
> >> >> >
> >> >>
> >> >> Yes, works for me.
> >> >>
> >> >> CPUID(7): No-SGX
> >> >>      CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz
> >> >>        -      11    0.66 1682 2494
> >> >>        0      11    0.60 1856 2494
> >> >>        1       6    0.34    1898    2494
> >> >>        2      13    0.82    1628    2494
> >> >>        3      13    0.87    1528    2494
> >> >>      CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz
> >> >>        -       6    0.58     963    2494
> >> >>        0       8    0.83     957    2494
> >> >>        1       1    0.08     984    2494
> >> >>        2      10    1.04     975    2494
> >> >>        3       3    0.35     934    2494
> >> >>
> >> >
> >
> > [cut]
> >
> >> >
> >>
> >> No, this patch doesn't help.
> >
> > Well, more work to do then.
> >
> > I've just noticed a bug in this patch, which is not relevant for th=
e results,
> > but below is a new version.
> >
> >> CPUID(7): No-SGX
> >>       CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz
> >>        -       8    0.32    2507    2495
> >>        0      13    0.53    2505    2495
> >>        1       3    0.11    2523    2495
> >>        2       1    0.06    2555    2495
> >>        3      15    0.59    2500    2495
> >>      CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz
> >>        -       8    0.33    2486    2495
> >>        0      12    0.50    2482    2495
> >>        1       5    0.22    2489    2495
> >>        2       1    0.04    2492    2495
> >>        3      15    0.59    2487    2495
> >

[cut]

>=20
> here they are.
>=20

Thanks!

=46irst of all, the sampling mechanics works as expected in the failing=
 case,
which is the most important thing I wanted to know.  However, there are=
 anomalies
in the failing case trace.  The core_busy column is clearly suspicious =
and it
looks like CPUs 2 and 3 never really go idle.  I guess we'll need to fi=
nd out
why they don't go idle to get to the bottom of this, but it firmly fall=
s into
the weird stuff territory already.

In the meantime, below is one more patch to test, on top of the previou=
s one
(that is, https://patchwork.kernel.org/patch/8714401/).

Again, this is a change I'd like to make regardless, so it would be goo=
d to
know if anything more has to be done before we go further.

---
=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] intel_pstate: Avoid extra invocation of intel_pstate_s=
ample()

The initialization of intel_pstate for a given CPU involves populating
the fields of its struct cpudata that represent the previous sample,
but currently that is done in a problematic way.

Namely, intel_pstate_init_cpu() makes an extra call to
intel_pstate_sample() so it reads the current register values that
will be used to populate the "previous sample" record during the
next invocation of intel_pstate_sample().  However, after commit
a4675fbc4a7a (cpufreq: intel_pstate: Replace timers with utilization
update callbacks) that doesn't work for last_sample_time, because
the time value is passed to intel_pstate_sample() as an argument now.
Passing 0 to it from intel_pstate_init_cpu() is problematic, because
that causes cpu->last_sample_time =3D=3D 0 to be visible in
get_target_pstate_use_performance() (and hence the extra
cpu->last_sample_time > 0 check in there) and effectively allows
the first invocation of intel_pstate_sample() from
intel_pstate_update_util() to happen immediately after the
initialization which may lead to a significant "turn on"
effect in the governor algorithm.

To mitigate that issue, rework the initialization to avoid the
extra intel_pstate_sample() call from intel_pstate_init_cpu().
Instead, make intel_pstate_sample() return false if it has been
called with cpu->sample.time equal to zero, which will make
intel_pstate_update_util() skip the sample in that case, and
reset cpu->sample.time from intel_pstate_set_update_util_hook()
to make the algorithm start properly every time the hook is set.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -910,7 +910,14 @@ static inline bool intel_pstate_sample(s
 	cpu->prev_aperf =3D aperf;
 	cpu->prev_mperf =3D mperf;
 	cpu->prev_tsc =3D tsc;
-	return true;
+	/*
+	 * First time this function is invoked in a given cycle, all of the
+	 * previous sample data fields are equal to zero or stale and they mu=
st
+	 * be populated with meaningful numbers for things to work, so assume
+	 * that sample.time will always be reset before setting the utilizati=
on
+	 * update hook and make the caller skip the sample then.
+	 */
+	return !!cpu->last_sample_time;
 }
=20
 static inline int32_t get_avg_frequency(struct cpudata *cpu)
@@ -984,8 +991,7 @@ static inline int32_t get_target_pstate_
 	 * enough period of time to adjust our busyness.
 	 */
 	duration_ns =3D cpu->sample.time - cpu->last_sample_time;
-	if ((s64)duration_ns > pid_params.sample_rate_ns * 3
-	    && cpu->last_sample_time > 0) {
+	if ((s64)duration_ns > pid_params.sample_rate_ns * 3) {
 		sample_ratio =3D div_fp(int_tofp(pid_params.sample_rate_ns),
 				      int_tofp(duration_ns));
 		core_busy =3D mul_fp(core_busy, sample_ratio);
@@ -1100,7 +1106,6 @@ static int intel_pstate_init_cpu(unsigne
 	intel_pstate_get_cpu_pstates(cpu);
=20
 	intel_pstate_busy_pid_reset(cpu);
-	intel_pstate_sample(cpu, 0);
=20
 	cpu->update_util.func =3D intel_pstate_update_util;
=20
@@ -1121,9 +1126,13 @@ static unsigned int intel_pstate_get(uns
 	return get_avg_frequency(cpu);
 }
=20
-static void intel_pstate_set_update_util_hook(unsigned int cpu)
+static void intel_pstate_set_update_util_hook(unsigned int cpu_num)
 {
-	cpufreq_set_update_util_data(cpu, &all_cpu_data[cpu]->update_util);
+	struct cpudata *cpu =3D all_cpu_data[cpu_num];
+
+	/* Prevent intel_pstate_update_util() from using stale data. */
+	cpu->sample.time =3D 0;
+	cpufreq_set_update_util_data(cpu_num, &cpu->update_util);
 }
=20
 static void intel_pstate_clear_update_util_hook(unsigned int cpu)
