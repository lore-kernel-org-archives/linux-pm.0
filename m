From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Fri, 1 Apr 2016 16:06:34 +0200
Message-ID: <CADDKRnBBuSfU4P2QsJU42_422Ebs_qJxrx7cgBJsa=LFp158mw@mail.gmail.com>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com>
	<2727017.UmaUvtBLeX@vostro.rjw.lan>
	<CADDKRnCs8vWbqOBbk0T+A5_VSzC5ENfND=NLwb3G0XjTvF9DQA@mail.gmail.com>
	<3623107.tlAuqH4F7s@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=94eb2c123020036a68052f6ce38e
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3623107.tlAuqH4F7s@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

--94eb2c123020036a68052f6ce38e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2016-04-01 14:40 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
> On Friday, April 01, 2016 11:20:42 AM J=C3=B6rg Otte wrote:
>> 2016-03-31 17:43 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
>> > On Thursday, March 31, 2016 05:25:18 PM J=C3=B6rg Otte wrote:
>> >> 2016-03-31 13:42 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
>> >> > On Thursday, March 31, 2016 11:05:56 AM J=C3=B6rg Otte wrote:
>> >> >
>> >> > [cut]
>> >> >
>> >> >> >
>> >> >>
>> >> >> Yes, works for me.
>> >> >>
>> >> >> CPUID(7): No-SGX
>> >> >>      CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz
>> >> >>        -      11    0.66 1682 2494
>> >> >>        0      11    0.60 1856 2494
>> >> >>        1       6    0.34    1898    2494
>> >> >>        2      13    0.82    1628    2494
>> >> >>        3      13    0.87    1528    2494
>> >> >>      CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz
>> >> >>        -       6    0.58     963    2494
>> >> >>        0       8    0.83     957    2494
>> >> >>        1       1    0.08     984    2494
>> >> >>        2      10    1.04     975    2494
>> >> >>        3       3    0.35     934    2494
>> >> >>
>> >> >
>> >
>> > [cut]
>> >
>> >> >
>> >>
>> >> No, this patch doesn't help.
>> >
>> > Well, more work to do then.
>> >
>> > I've just noticed a bug in this patch, which is not relevant for the r=
esults,
>> > but below is a new version.
>> >
>> >> CPUID(7): No-SGX
>> >>       CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz
>> >>        -       8    0.32    2507    2495
>> >>        0      13    0.53    2505    2495
>> >>        1       3    0.11    2523    2495
>> >>        2       1    0.06    2555    2495
>> >>        3      15    0.59    2500    2495
>> >>      CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz
>> >>        -       8    0.33    2486    2495
>> >>        0      12    0.50    2482    2495
>> >>        1       5    0.22    2489    2495
>> >>        2       1    0.04    2492    2495
>> >>        3      15    0.59    2487    2495
>> >
>
> [cut]
>
>>
>> here they are.
>>
>
> Thanks!
>
> First of all, the sampling mechanics works as expected in the failing cas=
e,
> which is the most important thing I wanted to know.  However, there are a=
nomalies
> in the failing case trace.  The core_busy column is clearly suspicious an=
d it
> looks like CPUs 2 and 3 never really go idle.  I guess we'll need to find=
 out
> why they don't go idle to get to the bottom of this, but it firmly falls =
into
> the weird stuff territory already.
>
> In the meantime, below is one more patch to test, on top of the previous =
one
> (that is, https://patchwork.kernel.org/patch/8714401/).
>
> Again, this is a change I'd like to make regardless, so it would be good =
to
> know if anything more has to be done before we go further.
>
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] intel_pstate: Avoid extra invocation of intel_pstate_sam=
ple()
>
> The initialization of intel_pstate for a given CPU involves populating
> the fields of its struct cpudata that represent the previous sample,
> but currently that is done in a problematic way.
>
> Namely, intel_pstate_init_cpu() makes an extra call to
> intel_pstate_sample() so it reads the current register values that
> will be used to populate the "previous sample" record during the
> next invocation of intel_pstate_sample().  However, after commit
> a4675fbc4a7a (cpufreq: intel_pstate: Replace timers with utilization
> update callbacks) that doesn't work for last_sample_time, because
> the time value is passed to intel_pstate_sample() as an argument now.
> Passing 0 to it from intel_pstate_init_cpu() is problematic, because
> that causes cpu->last_sample_time =3D=3D 0 to be visible in
> get_target_pstate_use_performance() (and hence the extra
> cpu->last_sample_time > 0 check in there) and effectively allows
> the first invocation of intel_pstate_sample() from
> intel_pstate_update_util() to happen immediately after the
> initialization which may lead to a significant "turn on"
> effect in the governor algorithm.
>
> To mitigate that issue, rework the initialization to avoid the
> extra intel_pstate_sample() call from intel_pstate_init_cpu().
> Instead, make intel_pstate_sample() return false if it has been
> called with cpu->sample.time equal to zero, which will make
> intel_pstate_update_util() skip the sample in that case, and
> reset cpu->sample.time from intel_pstate_set_update_util_hook()
> to make the algorithm start properly every time the hook is set.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c |   21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -910,7 +910,14 @@ static inline bool intel_pstate_sample(s
>         cpu->prev_aperf =3D aperf;
>         cpu->prev_mperf =3D mperf;
>         cpu->prev_tsc =3D tsc;
> -       return true;
> +       /*
> +        * First time this function is invoked in a given cycle, all of t=
he
> +        * previous sample data fields are equal to zero or stale and the=
y must
> +        * be populated with meaningful numbers for things to work, so as=
sume
> +        * that sample.time will always be reset before setting the utili=
zation
> +        * update hook and make the caller skip the sample then.
> +        */
> +       return !!cpu->last_sample_time;
>  }
>
>  static inline int32_t get_avg_frequency(struct cpudata *cpu)
> @@ -984,8 +991,7 @@ static inline int32_t get_target_pstate_
>          * enough period of time to adjust our busyness.
>          */
>         duration_ns =3D cpu->sample.time - cpu->last_sample_time;
> -       if ((s64)duration_ns > pid_params.sample_rate_ns * 3
> -           && cpu->last_sample_time > 0) {
> +       if ((s64)duration_ns > pid_params.sample_rate_ns * 3) {
>                 sample_ratio =3D div_fp(int_tofp(pid_params.sample_rate_n=
s),
>                                       int_tofp(duration_ns));
>                 core_busy =3D mul_fp(core_busy, sample_ratio);
> @@ -1100,7 +1106,6 @@ static int intel_pstate_init_cpu(unsigne
>         intel_pstate_get_cpu_pstates(cpu);
>
>         intel_pstate_busy_pid_reset(cpu);
> -       intel_pstate_sample(cpu, 0);
>
>         cpu->update_util.func =3D intel_pstate_update_util;
>
> @@ -1121,9 +1126,13 @@ static unsigned int intel_pstate_get(uns
>         return get_avg_frequency(cpu);
>  }
>
> -static void intel_pstate_set_update_util_hook(unsigned int cpu)
> +static void intel_pstate_set_update_util_hook(unsigned int cpu_num)
>  {
> -       cpufreq_set_update_util_data(cpu, &all_cpu_data[cpu]->update_util=
);
> +       struct cpudata *cpu =3D all_cpu_data[cpu_num];
> +
> +       /* Prevent intel_pstate_update_util() from using stale data. */
> +       cpu->sample.time =3D 0;
> +       cpufreq_set_update_util_data(cpu_num, &cpu->update_util);
>  }
>
>  static void intel_pstate_clear_update_util_hook(unsigned int cpu)
>

Done. Attached the tracer.
For me it looks like the previous one of the failing case.

Thanks, J=C3=B6rg

--94eb2c123020036a68052f6ce38e
Content-Type: application/x-xz; name="intel_pstate_tracer_3.xz"
Content-Disposition: attachment; filename="intel_pstate_tracer_3.xz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_imhs9q270

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
--94eb2c123020036a68052f6ce38e--
