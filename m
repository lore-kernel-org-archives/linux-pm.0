From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: cpufreq: Intel P state driver: add cycle counter for clock
 frequency monitoring
Date: Mon, 18 Jul 2016 09:29:42 -0700
Message-ID: <1468859382.13661.167.camel@linux.intel.com>
References: <66b88042-0f03-893b-33ac-c4e6df17534c@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:28215 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499AbcGRQ35 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 18 Jul 2016 12:29:57 -0400
In-Reply-To: <66b88042-0f03-893b-33ac-c4e6df17534c@osadl.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Carsten Emde <C.Emde@osadl.org>, Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM mailing list <linux-pm@vger.kernel.org>

Hi Carsten,

On Sun, 2016-07-17 at 23:51 +0200, Carsten Emde wrote:
> Most cpufreq drivers contain an interface to the cpufreq_stats plugin
> that counts the time the processor stays in a given P state. The
> Intel P
> state driver, however, does not work on discrete P states but allows
> to
> run the processor at arbitrary clock frequencies within the allowed
> range. Even if the frequencies were reduced to steps of 100 MHz, this
> would result in too many P states.
This is true even using acpi-cpufreq driver on Intel x86 processors for
a while. Due to HW coordination, power limits, TDP the requested P
state may not be honored for a given CPU. The stats shows, P states
which are just requests.


>  This patch, therefore, introduces the
> additional cpufreq variable kcycles that contains the number of clock
> cycles divided by 1000 since the most recent reboot. This allows to
> monitor the average clock frequency during a defined time interval by
> simply calculating the derivative.=20
Can you not use turbostat?

> With this patch, there are no longer
> Intel processors around that do not provide a way to monitor the
> clock
> frequency. Such monitoring is important to fine tune a system's
> energy
> efficiency and to debug clock frequency modulation.
What about using powercap/rapl? That will give more information about
energy.

>=20
> (Earlier kernel versions can immediately use the now abandoned
> function
> intel_pstate_calc_freq(). I had to resuscitate it for kernel versions
> where it disappeared.)
Since the sampling function is called from scheduler hot path, we don't
want any additional calculation. The place we really calculate when
request from cpufreq callback or for tracing is enabled?

Thanks,
Srinivas

>=20
> Signed-off-by: Carsten Emde <C.Emde@osadl.org>
>=20
> ---
> =C2=A0drivers/cpufreq/cpufreq.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=
=A0=C2=A0=C2=A015 +++++++++++++++
> =C2=A0drivers/cpufreq/intel_pstate.c |=C2=A0=C2=A0=C2=A039
> ++++++++++++++++++++++++++++++++++++---
> =C2=A0include/linux/cpufreq.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A02 ++
> =C2=A03 files changed, 53 insertions(+), 3 deletions(-)
>=20
> Index: linux-4.7.0-rc3+/drivers/cpufreq/cpufreq.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-4.7.0-rc3+.orig/drivers/cpufreq/cpufreq.c
> +++ linux-4.7.0-rc3+/drivers/cpufreq/cpufreq.c
> @@ -815,6 +815,19 @@ static ssize_t show_bios_limit(struct cp
> =C2=A0	return sprintf(buf, "%u\n", policy->cpuinfo.max_freq);
> =C2=A0}
> =C2=A0
> +/**
> + * show_scaling_kcycles - show number of accumulated CPU cycles by
> 1000
> + */
> +static ssize_t show_scaling_kcycles(struct cpufreq_policy *policy,
> +					char *buf)
> +{
> +	if (cpufreq_driver && cpufreq_driver->kcycles) {
> +		u64 kcycles =3D cpufreq_driver->kcycles(policy->cpu);
> +		return sprintf(buf, "%llu\n", kcycles);
> +	} else
> +		return sprintf(buf, "<unsupported>");
> +}
> +
> =C2=A0cpufreq_freq_attr_ro_perm(cpuinfo_cur_freq, 0400);
> =C2=A0cpufreq_freq_attr_ro(cpuinfo_min_freq);
> =C2=A0cpufreq_freq_attr_ro(cpuinfo_max_freq);
> @@ -829,6 +842,7 @@ cpufreq_freq_attr_rw(scaling_min_freq);
> =C2=A0cpufreq_freq_attr_rw(scaling_max_freq);
> =C2=A0cpufreq_freq_attr_rw(scaling_governor);
> =C2=A0cpufreq_freq_attr_rw(scaling_setspeed);
> +cpufreq_freq_attr_ro(scaling_kcycles);
> =C2=A0
> =C2=A0static struct attribute *default_attrs[] =3D {
> =C2=A0	&cpuinfo_min_freq.attr,
> @@ -842,6 +856,7 @@ static struct attribute *default_attrs[]
> =C2=A0	&scaling_driver.attr,
> =C2=A0	&scaling_available_governors.attr,
> =C2=A0	&scaling_setspeed.attr,
> +	&scaling_kcycles.attr,
> =C2=A0	NULL
> =C2=A0};
> =C2=A0
> Index: linux-4.7.0-rc3+/drivers/cpufreq/intel_pstate.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-4.7.0-rc3+.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-4.7.0-rc3+/drivers/cpufreq/intel_pstate.c
> @@ -96,7 +96,6 @@ static inline u64 div_ext_fp(u64 x, u64
> =C2=A0 *			read from MPERF MSR between last and
> current sample
> =C2=A0 * @tsc:		Difference of time stamp counter between
> last and
> =C2=A0 *			current sample
> - * @freq:		Effective frequency calculated from
> APERF/MPERF
> =C2=A0 * @time:		Current time from scheduler
> =C2=A0 *
> =C2=A0 * This structure is used in the cpudata structure to store
> performance sample
> @@ -108,8 +107,8 @@ struct sample {
> =C2=A0	u64 aperf;
> =C2=A0	u64 mperf;
> =C2=A0	u64 tsc;
> -	int freq;
> =C2=A0	u64 time;
> +	u64 kcycles;
> =C2=A0};
> =C2=A0
> =C2=A0/**
> @@ -1154,11 +1153,26 @@ static inline void intel_pstate_calc_avg
> =C2=A0	sample->core_avg_perf =3D div_ext_fp(sample->aperf, sample-
> >mperf);
> =C2=A0}
> =C2=A0
> +static inline int intel_pstate_calc_freq(struct cpudata *cpu)
> +{
> +	struct sample *sample =3D &cpu->sample;
> +	int64_t core_pct;
> +
> +	core_pct =3D int_tofp(sample->aperf) * int_tofp(100);
> +	core_pct =3D div64_u64(core_pct, int_tofp(sample->mperf));
> +
> +	return fp_toint(mul_fp(int_tofp(
> +			cpu->pstate.max_pstate_physical *
> +			cpu->pstate.scaling / 100),
> +			core_pct));
> +}
> +
> =C2=A0static inline bool intel_pstate_sample(struct cpudata *cpu, u64
> time)
> =C2=A0{
> -	u64 aperf, mperf;
> +	u64 aperf, mperf, interval;
> =C2=A0	unsigned long flags;
> =C2=A0	u64 tsc;
> +	int freq;
> =C2=A0
> =C2=A0	local_irq_save(flags);
> =C2=A0	rdmsrl(MSR_IA32_APERF, aperf);
> @@ -1179,6 +1193,12 @@ static inline bool intel_pstate_sample(s
> =C2=A0	cpu->sample.mperf -=3D cpu->prev_mperf;
> =C2=A0	cpu->sample.tsc -=3D cpu->prev_tsc;
> =C2=A0
> +	freq =3D intel_pstate_calc_freq(cpu);
> +	interval =3D (cpu->sample.time - cpu->last_sample_time) /
> +		=C2=A0=C2=A0=C2=A0NSEC_PER_MSEC;
> +	cpu->sample.kcycles +=3D ((u64) freq * interval) /
> +		1000ULL;
> +
> =C2=A0	cpu->prev_aperf =3D aperf;
> =C2=A0	cpu->prev_mperf =3D mperf;
> =C2=A0	cpu->prev_tsc =3D tsc;
> @@ -1436,6 +1456,18 @@ static void intel_pstate_set_performance
> =C2=A0	limits->min_sysfs_pct =3D 0;
> =C2=A0}
> =C2=A0
> +static u64 intel_pstate_kcycles_get(unsigned int cpu_num)
> +{
> +	struct sample *sample;
> +	struct cpudata *cpu;
> +
> +	cpu =3D all_cpu_data[cpu_num];
> +	if (!cpu)
> +		return 0;
> +	sample =3D &cpu->sample;
> +	return sample->kcycles;
> +}
> +
> =C2=A0static int intel_pstate_set_policy(struct cpufreq_policy *polic=
y)
> =C2=A0{
> =C2=A0	struct cpudata *cpu;
> @@ -1569,6 +1601,7 @@ static struct cpufreq_driver intel_pstat
> =C2=A0	.setpolicy	=3D intel_pstate_set_policy,
> =C2=A0	.resume		=3D intel_pstate_hwp_set_policy,
> =C2=A0	.get		=3D intel_pstate_get,
> +	.kcycles	=3D intel_pstate_kcycles_get,
> =C2=A0	.init		=3D intel_pstate_cpu_init,
> =C2=A0	.exit		=3D intel_pstate_cpu_exit,
> =C2=A0	.stop_cpu	=3D intel_pstate_stop_cpu,
> Index: linux-4.7.0-rc3+/include/linux/cpufreq.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-4.7.0-rc3+.orig/include/linux/cpufreq.h
> +++ linux-4.7.0-rc3+/include/linux/cpufreq.h
> @@ -275,6 +275,8 @@ struct cpufreq_driver {
> =C2=A0	unsigned int	(*get)(unsigned int cpu);
> =C2=A0
> =C2=A0	/* optional */
> +	u64		(*kcycles) (unsigned int cpu);
> +
> =C2=A0	int		(*bios_limit)(int cpu, unsigned int
> *limit);
> =C2=A0
> =C2=A0	int		(*exit)(struct cpufreq_policy *policy);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-in=
fo.html
