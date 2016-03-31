From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Thu, 31 Mar 2016 11:05:56 +0200
Message-ID: <CADDKRnCQAcuA=fv+4g-3aVU3U_zwssMAcoek0mu_ip24mO-pDg@mail.gmail.com>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com>
	<CAJZ5v0i48Xxyp880SQ1iVDzct--vhTVggCS_wHHA7bt7D+_sFg@mail.gmail.com>
	<CADDKRnC1pp3Tfrfm8AsiiTJ4PR6X_qPbgLSxuBxNQJ60cO0BYQ@mail.gmail.com>
	<4695038.Xoqbuvkrbb@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4695038.Xoqbuvkrbb@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

2016-03-30 20:39 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
> On Wednesday, March 30, 2016 05:29:18 PM J=C3=B6rg Otte wrote:
>> 2016-03-30 13:05 GMT+02:00 Rafael J. Wysocki <rafael@kernel.org>:
>> > On Wed, Mar 30, 2016 at 12:17 PM, J=C3=B6rg Otte <jrg.otte@gmail.c=
om> wrote:
>> >> 2016-03-29 23:34 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
>> >>> On Tuesday, March 29, 2016 07:32:27 PM J=C3=B6rg Otte wrote:
>> >>>> 2016-03-29 19:24 GMT+02:00 J=C3=B6rg Otte <jrg.otte@gmail.com>:
>> >>>> > in v4.5 and earlier intel-pstate downscaled idle processors (=
load
>> >>>> > 0.1-0.2%) to minumum frequency, in my case 800MHz.
>> >>>> >
>> >>>> > Now in v4.6-rc1 the characteristic has dramatically changed. =
If in
>> >>>> > idle the processor frequency is more or less a few MHz around=
 2500Mhz.
>> >>>> > This is the maximum non turbo frequency.
>> >>>> >
>> >>>> > No difference between powersafe or performance governor.
>> >>>> >
>> >>>> > I currently use acpi_cpufreq which works as usual.
>> >>>> >
>> >>>> > Processor:
>> >>>> > Intel(R) Core(TM) i5-4200M CPU @ 2.50GHz (family: 0x6, model:=
 0x3c,
>> >>>> > stepping: 0x3)
>> >>>> >
>> >>>> > Last known good kernel is: 4.5.0-01127-g9256d5a
>> >>>> > First known bad kernel is: 4.5.0-02535-g09fd671
>> >>>> >
>> >>>> > There is
>> >>>> > commit 277edba Merge tag 'pm+acpi-4.6-rc1-1' of
>> >>>> > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
>> >>>> > in between, which brought a few changes in intel_pstate.
>> >>>
>> >>> Can you please check commit a4675fbc4a7a (cpufreq: intel_pstate:=
 Replace timers
>> >>> with utilization update callbacks)?
>> >>>
>> >> Yes , this solved the problem for me.
>> >> I had to resolve some conflicts myself when reverting that
>> >> commit. Hard work :).
>> >
>> > Thanks for doing this.  Can you please post the revert patch you h=
ave used?
>> >
>>
>> The patch is on top of 4.5.0-02535-g09fd671.
>> I'm not sure what gmail is doing with spaces and tabs,
>> so I attach the revert patch.
>
> That worked, thanks!
>
>> >> Here is a 10-seconds trace of the used frequencies when
>> >> in "desktop-idle":
>> >>
>> >> driver          cpu0 cpu1 cpu2 cpu3
>> >> -------------------------------------
>> >> intel_pstate (  800  928  941 1200) MHz   load:( 0.2)%
>> >> intel_pstate (  800  928 1181 1800) MHz   load:( 0.0)%
>> >> intel_pstate ( 1675 1576 1347  800) MHz   load:( 0.0)%
>> >> intel_pstate ( 1198 1576  842  800) MHz   load:( 0.5)%
>> >> intel_pstate (  800 1181 1113 1600) MHz   load:( 0.0)%
>> >> intel_pstate (  808 1181  805  800) MHz   load:( 0.5)%
>> >> intel_pstate (  844 1191  900 1082) MHz   load:( 0.3)%
>> >> intel_pstate (  816 1191  800  800) MHz   load:( 0.0)%
>> >> intel_pstate (  800  905  892 1082) MHz   load:( 0.2)%
>> >> intel_pstate (  945  905 1340  800) MHz   load:( 0.3)%
>> >
>> > Please also run turbostat with and without your revert patch appli=
ed.
>> >
>>
>> turbostat without revert
>> Kernel: 4.5.0-02535-g09fd671
>> -----------------------------
>> CPUID(7): No-SGX
>>      CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz
>>        -      13    0.53    2514    2495
>>        0      14    0.55    2518    2495
>>        1       8    0.33    2527    2495
>>        2      15    0.60    2506    2495
>>        3      16    0.62    2509    2495
>>
>> turbostat after revert of commit a4675fbc4a7a
>> kernel: 4.5.0-reva4675fbc4a7a-02536-g77225b1
>> ------------------------------
>> CPUID(7): No-SGX
>>      CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz
>>        -       4    0.35    1142    2494
>>        0       1    0.11    1016    2494
>>        1       2    0.17     961    2494
>>        2      10    0.82    1215    2494
>>        3       3    0.29    1086    2494
>>      CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz
>>        -       4    0.46     885    2494
>>        0       1    0.12     889    2494
>>        1       1    0.16     885    2494
>>        2      10    1.15     883    2494
>>        3       4    0.40     891    2494
>
> Clearly, there's something fishy here.
>
> I've simplified your revert patch somewhat.  Can you please test if t=
he one
> below still helps?
>
> ---
>  drivers/cpufreq/intel_pstate.c |   59 ++++++++++++++++++++++--------=
-----------
>  1 file changed, 32 insertions(+), 27 deletions(-)
>
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -71,7 +71,7 @@ struct sample {
>         u64 mperf;
>         u64 tsc;
>         int freq;
> -       u64 time;
> +       ktime_t time;
>  };
>
>  struct pstate_data {
> @@ -103,13 +103,13 @@ struct _pid {
>  struct cpudata {
>         int cpu;
>
> -       struct update_util_data update_util;
> +       struct timer_list timer;
>
>         struct pstate_data pstate;
>         struct vid_data vid;
>         struct _pid pid;
>
> -       u64     last_sample_time;
> +       ktime_t last_sample_time;
>         u64     prev_aperf;
>         u64     prev_mperf;
>         u64     prev_tsc;
> @@ -882,7 +882,7 @@ static inline void intel_pstate_calc_bus
>         sample->core_pct_busy =3D (int32_t)core_pct;
>  }
>
> -static inline bool intel_pstate_sample(struct cpudata *cpu, u64 time=
)
> +static inline bool intel_pstate_sample(struct cpudata *cpu)
>  {
>         u64 aperf, mperf;
>         unsigned long flags;
> @@ -899,7 +899,7 @@ static inline bool intel_pstate_sample(s
>         local_irq_restore(flags);
>
>         cpu->last_sample_time =3D cpu->sample.time;
> -       cpu->sample.time =3D time;
> +       cpu->sample.time =3D ktime_get();
>         cpu->sample.aperf =3D aperf;
>         cpu->sample.mperf =3D mperf;
>         cpu->sample.tsc =3D  tsc;
> @@ -957,7 +957,7 @@ static inline int32_t get_target_pstate_
>  static inline int32_t get_target_pstate_use_performance(struct cpuda=
ta *cpu)
>  {
>         int32_t core_busy, max_pstate, current_pstate, sample_ratio;
> -       u64 duration_ns;
> +       s64 duration_ns;
>
>         intel_pstate_calc_busy(cpu);
>
> @@ -978,14 +978,15 @@ static inline int32_t get_target_pstate_
>         core_busy =3D mul_fp(core_busy, div_fp(max_pstate, current_ps=
tate));
>
>         /*
> -        * Since our utilization update callback will not run unless =
we are
> -        * in C0, check if the actual elapsed time is significantly g=
reater (3x)
> -        * than our sample interval.  If it is, then we were idle for=
 a long
> -        * enough period of time to adjust our busyness.
> +        * Since we have a deferred timer, it will not fire unless
> +        * we are in C0.  So, determine if the actual elapsed time
> +        * is significantly greater (3x) than our sample interval.  I=
f it
> +        * is, then we were idle for a long enough period of time
> +        * to adjust our busyness.
>          */
> -       duration_ns =3D cpu->sample.time - cpu->last_sample_time;
> -       if ((s64)duration_ns > pid_params.sample_rate_ns * 3
> -           && cpu->last_sample_time > 0) {
> +       duration_ns =3D ktime_to_ns(ktime_sub(cpu->sample.time,
> +                                           cpu->last_sample_time));
> +       if (duration_ns > pid_params.sample_rate_ns * 3) {
>                 sample_ratio =3D div_fp(int_tofp(pid_params.sample_ra=
te_ns),
>                                       int_tofp(duration_ns));
>                 core_busy =3D mul_fp(core_busy, sample_ratio);
> @@ -1032,17 +1033,19 @@ static inline void intel_pstate_adjust_b
>                 get_avg_frequency(cpu));
>  }
>
> -static void intel_pstate_update_util(struct update_util_data *data, =
u64 time,
> -                                    unsigned long util, unsigned lon=
g max)
> +static void intel_pstate_timer_func(unsigned long __data)
>  {
> -       struct cpudata *cpu =3D container_of(data, struct cpudata, up=
date_util);
> -       u64 delta_ns =3D time - cpu->sample.time;
> +       struct cpudata *cpu =3D (struct cpudata *) __data;
> +       bool sample_taken =3D intel_pstate_sample(cpu);
>
> -       if ((s64)delta_ns >=3D pid_params.sample_rate_ns) {
> -               bool sample_taken =3D intel_pstate_sample(cpu, time);
> +       if (sample_taken) {
> +               int delay;
>
> -               if (sample_taken && !hwp_active)
> +               if (!hwp_active)
>                         intel_pstate_adjust_busy_pstate(cpu);
> +
> +               delay =3D msecs_to_jiffies(pid_params.sample_rate_ms)=
;
> +               mod_timer_pinned(&cpu->timer, jiffies + delay);
>         }
>  }
>
> @@ -1099,11 +1102,15 @@ static int intel_pstate_init_cpu(unsigne
>
>         intel_pstate_get_cpu_pstates(cpu);
>
> +       init_timer_deferrable(&cpu->timer);
> +       cpu->timer.data =3D (unsigned long)cpu;
> +       cpu->timer.expires =3D jiffies + HZ/100;
> +       cpu->timer.function =3D intel_pstate_timer_func;
> +
>         intel_pstate_busy_pid_reset(cpu);
> -       intel_pstate_sample(cpu, 0);
> +       intel_pstate_sample(cpu);
>
> -       cpu->update_util.func =3D intel_pstate_update_util;
> -       cpufreq_set_update_util_data(cpunum, &cpu->update_util);
> +       add_timer_on(&cpu->timer, cpunum);
>
>         pr_debug("intel_pstate: controlling: cpu %d\n", cpunum);
>
> @@ -1187,8 +1194,7 @@ static void intel_pstate_stop_cpu(struct
>
>         pr_debug("intel_pstate: CPU %d exiting\n", cpu_num);
>
> -       cpufreq_set_update_util_data(cpu_num, NULL);
> -       synchronize_sched();
> +       del_timer_sync(&all_cpu_data[cpu_num]->timer);
>
>         if (hwp_active)
>                 return;
> @@ -1455,8 +1461,7 @@ out:
>         get_online_cpus();
>         for_each_online_cpu(cpu) {
>                 if (all_cpu_data[cpu]) {
> -                       cpufreq_set_update_util_data(cpu, NULL);
> -                       synchronize_sched();
> +                       del_timer_sync(&all_cpu_data[cpu]->timer);
>                         kfree(all_cpu_data[cpu]);
>                 }
>         }
>

Yes, works for me.

CPUID(7): No-SGX
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz
       -      11    0.66    1682    2494
       0      11    0.60    1856    2494
       1       6    0.34    1898    2494
       2      13    0.82    1628    2494
       3      13    0.87    1528    2494
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz
       -       6    0.58     963    2494
       0       8    0.83     957    2494
       1       1    0.08     984    2494
       2      10    1.04     975    2494
       3       3    0.35     934    2494

Thanks, J=C3=B6rg
