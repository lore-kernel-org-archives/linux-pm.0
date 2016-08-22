From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RFC][PATCH 7/7] cpufreq: intel_pstate: Change P-state
 selection algorithm for Core
Date: Mon, 22 Aug 2016 11:53:46 -0700
Message-ID: <1471892026.3745.77.camel@linux.intel.com>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan>
         <1572483.RZjvRFdxPx@vostro.rjw.lan> <001b01d1ee1c$e6a6a170$b3f3e450$@net>
         <10156236.RI1knH5Wfs@vostro.rjw.lan> <000301d1f57b$9e1fed10$da5fc730$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000301d1f57b$9e1fed10$da5fc730$@net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Peter Zijlstra' <peterz@infradead.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Steve Muckle' <steve.muckle@linaro.org>, 'Juri Lelli' <juri.lelli@arm.com>, 'Ingo Molnar' <mingo@kernel.org>, 'Linux PM list' <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Doug,

I am not able to apply this patch. Can you send as a patch on top of
Rafael's RFC 7/7. Since test takes long time, I want to apply correct
patch.

Thanks,
Srinivas

On Sat, 2016-08-13 at 08:59 -0700, Doug Smythies wrote:
> On 2016.08.05 17:02 Rafael J. Wysocki wrote:
> > 
> > > 
> > > On 2016.08.03 21:19 Doug Smythies wrote:
> > > > 
> > > > On 2016.07.31 16:49 Rafael J. Wysocki wrote:
> > > > 
> > > > The PID-base P-state selection algorithm used by intel_pstate
> > > > for
> > > > Core processors is based on very weak foundations.
> > > ...[cut]...
> > > 
> > > > 
> > > > +static inline int32_t get_target_pstate_default(struct cpudata
> > > > *cpu)
> > > > +{
> > > > +	struct sample *sample = &cpu->sample;
> > > > +	int32_t busy_frac;
> > > > +	int pstate;
> > > > +
> > > > +	busy_frac = div_fp(sample->mperf, sample->tsc);
> > > > +	sample->busy_scaled = busy_frac * 100;
> > > > +
> > > > +	if (busy_frac < cpu->iowait_boost)
> > > > +		busy_frac = cpu->iowait_boost;
> > > > +
> > > > +	cpu->iowait_boost >>= 1;
> > > > +
> > > > +	pstate = cpu->pstate.turbo_pstate;
> > > > +	return fp_toint((pstate + (pstate >> 2)) * busy_frac);
> > > > +}
> > > > +
> My previous replies (and see below) have suggested that some
> filtering
> is needed on the target pstate, otherwise, and dependant on the type
> of
> workload, it tends to oscillate.
> 
> I added the IIR (Infinite Impulse Response) filter that I have
> suggested in the past:
> 
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index c43ef55..262ec5f 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -98,6 +98,7 @@ static inline u64 div_ext_fp(u64 x, u64 y)
>   * @tsc:               Difference of time stamp counter between last
> and
>   *                     current sample
>   * @time:              Current time from scheduler
> + * @target:            target pstate filtered.
>   *
>   * This structure is used in the cpudata structure to store
> performance sample
>   * data for choosing next P State.
> @@ -108,6 +109,7 @@ struct sample {
>         u64 aperf;
>         u64 mperf;
>         u64 tsc;
> +       u64 target;
>         u64 time;
>  };
> 
> @@ -1168,6 +1170,7 @@ static void intel_pstate_get_cpu_pstates(struct
> cpudata *cpu)
>                 pstate_funcs.get_vid(cpu);
> 
>         intel_pstate_set_min_pstate(cpu);
> +       cpu->sample.target = int_tofp(cpu->pstate.min_pstate);
>  }
> 
>  static inline void intel_pstate_calc_avg_perf(struct cpudata *cpu)
> @@ -1301,8 +1304,10 @@ static inline int32_t
> get_target_pstate_use_performance(struct cpudata *cpu)
>  static inline int32_t get_target_pstate_default(struct cpudata *cpu)
>  {
>         struct sample *sample = &cpu->sample;
> +       int64_t scaled_gain, unfiltered_target;
>         int32_t busy_frac;
>         int pstate;
> +       u64 duration_ns;
> 
>         busy_frac = div_fp(sample->mperf, sample->tsc);
>         sample->busy_scaled = busy_frac * 100;
> @@ -1313,7 +1318,74 @@ static inline int32_t
> get_target_pstate_default(struct cpudata *cpu)
>         cpu->iowait_boost >>= 1;
> 
>         pstate = cpu->pstate.turbo_pstate;
> -       return fp_toint((pstate + (pstate >> 2)) * busy_frac);
> +       /* To Do: I think the above should be:
> +        *
> +        * if (limits.no_turbo || limits.turbo_disabled)
> +        *      pstate = cpu->pstate.max_pstate;
> +        * else
> +        *      pstate = cpu->pstate.turbo_pstate;
> +        *
> +        * figure it out.
> +        *
> +        * no clamps. Pre-filter clamping was needed in past
> implementations.
> +        * To Do: Is any pre-filter clamping needed here? */
> +
> +       unfiltered_target = (pstate + (pstate >> 2)) * busy_frac;
> +
> +       /*
> +        * Idle check.
> +        * We have a deferrable timer. Very long durations can be
> +        * either due to long idle (C0 time near 0),
> +        * or due to short idle times that spanned jiffy boundaries
> +        * (C0 time not near zero).
> +        *
> +        * To Do: As of the utilization stuff, I do not think the
> +        * spanning jiffy boundaries thing is true anymore.
> +        * Check, and fix the comment.
> +        *
> +        * The very long durations are 0.4 seconds or more.
> +        * Either way, a very long duration will effectively flush
> +        * the IIR filter, otherwise falling edge load response times
> +        * can be on the order of tens of seconds, because this
> driver
> +        * runs very rarely. Furthermore, for higher periodic loads
> that
> +        * just so happen to not be in the C0 state on jiffy
> boundaries,
> +        * the long ago history should be forgotten.
> +        * For cases of durations that are a few times the set sample
> +        * period, increase the IIR filter gain so as to weight
> +        * the current sample more appropriately.
> +        *
> +        * To Do: sample_time should be forced to be accurate. For
> +        * example if the kernel is a 250 Hz kernel, then a
> +        * sample_rate_ms of 10 should result in a sample_time of 12.
> +        *
> +        * To Do: Check that the IO Boost case is not filtered too
> much.
> +        *        It might be that a filter by-pass is needed for the
> boost case.
> +        *        However, the existing gain = f(duration) might be
> good enough.
> +        */
> +
> +       duration_ns = cpu->sample.time - cpu->last_sample_time;
> +
> +       scaled_gain = div_u64(int_tofp(duration_ns) *
> +               int_tofp(pid_params.p_gain_pct),
> int_tofp(pid_params.sample_rate_ns));
> +       if (scaled_gain > int_tofp(100))
> +               scaled_gain = int_tofp(100);
> +       /*
> +        * This code should not be required,
> +        * but short duration times have been observed
> +        * To Do: Check if this code is actually still needed. I
> don't think so.
> +        */
> +       if (scaled_gain < int_tofp(pid_params.p_gain_pct))
> +               scaled_gain = int_tofp(pid_params.p_gain_pct);
> +
> +       /*
> +        * Bandwidth limit the output. For now, re-task p_gain_pct
> for this purpose.
> +        * Use a smple IIR (Infinite Impulse Response) filter.
> +        */
> +       cpu->sample.target = div_u64((int_tofp(100) - scaled_gain) *
> +                       cpu->sample.target + scaled_gain *
> +                       unfiltered_target, int_tofp(100));
> +
> +       return fp_toint(cpu->sample.target + (1 << (FRAC_BITS-1)));
>  }
> 
>  static inline void intel_pstate_update_pstate(struct cpudata *cpu,
> int pstate)
> @@ -1579,6 +1651,7 @@ static void intel_pstate_stop_cpu(struct
> cpufreq_policy *policy)
>                 return;
> 
>         intel_pstate_set_min_pstate(cpu);
> +       cpu->sample.target = int_tofp(cpu->pstate.min_pstate);
>  }
> 
>  static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
> 
> The filter introduces a trade-off between step function load response
> time
> and the tendency for the target pstate to oscillate.
> 
> ...[cut]...
> 
> > 
> > > 
> > > Several tests were done with this patch set.
> > > The patch set would not apply to kernel 4.7, but did apply fine
> > > to a 4.7+ kernel
> > > (I did as of 7a66ecf) from a few days ago.
> > > 
> > > Test 1: Phoronix ffmpeg test (less time is better):
> > > Reason: Because it suffers from rotating amongst CPUs in an odd
> > > way, challenging for CPU frequency scaling drivers.
> > > This test tends to be an indicator of potential troubles with
> > > some games.
> > > Criteria: (Dirk Brandewie): Must match or better acpi_cpufreq -
> > > ondemand.
> > > With patch set: 15.8 Seconds average and 24.51 package watts.
> > > Without patch set: 11.61 Seconds average and 27.59 watts.
> > > Conclusion: Significant reduction in performance with proposed
> > > patch set.
> With the filter this become even worse at ~18 seconds.
> I used to fix this by moving the response curve to the left.
> I have not tested this:
> 
> +       unfiltered_target = (pstate + (pstate >> 1)) * busy_frac;
> 
> which moves the response curve left a little, yet. I will test it.
> 
> ...[cut]...
> 
> > 
> > > 
> > > Test 9: Doug's_specpower simulator (20% load):
> > > Time is fixed, less energy is better.
> > > Reason: During the long
> > > "[intel-pstate driver regression] processor frequency very high
> > > even if in idle"
> > > and subsequent https://bugzilla.kernel.org/show_bug.cgi?id=115771
> > > discussion / thread(s), some sort of test was needed to try to
> > > mimic what Srinivas
> > > was getting on his fancy SpecPower test platform. So far at
> > > least, this test does that.
> > > Only the 20% load case was created, because that was the biggest
> > > problem case back then.
> > > With patch set: 4 tests at an average of 7197 Joules per test,
> > > relatively high CPU frequencies.
> > > Without the patch set: 4 tests at an average of 5956 Joules per
> > > test, relatively low CPU frequencies.
> > > Conclusion: 21% energy regression with the patch set.
> > > Note: Newer processors might do better than my older i7-2600K.
> Patch set + above and IIR gain = 10%: 5670 Joules.
> Conclusion: Energy regression eliminated.
> 
> Other gains:
> 
> gain =  5%: 5342 Joules; Busy MHz: 2172
> gain = 10%: 5670 Joules; Busy MHz: 2285
> gain = 20%: 6126 Joules; Busy MHz: 2560
> gain = 30%: 6426 Joules; Busy MHz: 2739
> gain = 40%: 6674 Joules; Busy MHz: 2912
> gain = 70%: 7109 Joules; Busy MHz: 3199
> 
> locked at minimum pstate (reference): 4653 Joules; Busy MHz: 1600
> Performance mode (reference): 7808 Joules; Busy MHz: 3647
> 
> > 
> > > 
> > > Test 10: measure the frequency response curve, fixed work packet
> > > method,
> > > 75 hertz work / sleep frequency (all CPU, no IOWAIT):
> > > Reason: To compare to some older data and observe overall.
> > > png graph NOT attached.
> > > Conclusions: Tends to oscillate, suggesting some sort of damping
> > > is needed.
> > > However, any filtering tends to increase the step function load
> > > rise time
> > > (see test 11 below, I think there is some wiggle room here).
> > > See also graph which has: with and without patch set; performance
> > > mode (for reference);
> > > Philippe Longepe's cpu_load method also with setpoint 40 (for
> > > reference); one of my previous
> > > attempts at a load related patch set from quite some time ago
> > > (for reference).
> As expected, the filter damps out the oscillation.
> New graphs will be sent to Rafael and Srinivas off-list.
> 
> > 
> > > 
> > > 
> > > Test 11: Look at the step function load response. From no load to
> > > 100% on one CPU (CPU load only, no IO).
> > > While there is a graph, it is not attached:
> > > Conclusion: The step function response is greatly improved
> > > (virtually one sample time max).
> > > It would probably be O.K. to slow it down a little with a filter
> > > so as to reduce the
> > > tendency to oscillate under periodic load conditions (to a point,
> > > at least. A low enough frequency will
> > > always oscillate) (see the graph for test10).
> I haven't done this test yet, but from previous work, a gain setting
> of 10 to 15% gives a
> load step function response time similar to the current PID based
> filter.
> 
> The other tests gave similar results with or without the filter.
> 
> ... Doug
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
