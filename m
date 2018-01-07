From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V4] cpufreq: intel_pstate: allow trace in passive mode
Date: Mon, 08 Jan 2018 00:40:11 +0100
Message-ID: <4147417.kcaZgZAipQ@aspire.rjw.lan>
References: <1515190444-3254-1-git-send-email-dsmythies@telus.net> <000101d3870d$150c7960$3f256c20$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:47014 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754649AbeAGXlV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jan 2018 18:41:21 -0500
In-Reply-To: <000101d3870d$150c7960$3f256c20$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>

On Saturday, January 6, 2018 5:40:34 PM CET Doug Smythies wrote:
> On 2018.01.05 14:52 Rafael J. Wysocki wrote:
> > On Fri, Jan 5, 2018 at 11:14 PM, Doug Smythies <doug.smythies@gmail.com> wrote:
> 
> >> Allow use of the trace_pstate_sample trace function
> >> when the intel_pstate driver is in passive mode.
> >> Since the core_busy and scaled_busy fields are not
> >> used, and it might be desirable to know which path
> >> through the driver was used, either intel_cpufreq_target
> >> or intel_cpufreq_fast_switch, re-task the core_busy
> >> field as a flag indicator.
> >>
> >> The user can then use the intel_pstate_tracer.py utility
> >> to summarize and plot the trace.
> >>
> >> Sometimes, in passive mode, the driver is not called for
> >> many tens or even hundreds of seconds. The user
> >> needs to understand, and not be confused by, this limitation.
> >
> > The description of the changes between different versions should go
> > under the Signed-off-by: tag, separated by an extra "---" from it.
> 
> O.K. sorry.
> 
> > Also please see a couple of cosmetic comments below.
> >
> >> V4: Only execute the trace specific overhead code if trace
> >>     is enabled. Suggested by Srinivas Pandruvada.
> >>
> >> V3: Move largely duplicate code to a subroutine.
> >>     Suggested by Rafael J. Wysocki.
> >>
> >> V2: prepare for resend. Rebase to current kernel, 4.15-rc3.
> >> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> >> ---
> >>  drivers/cpufreq/intel_pstate.c | 35 +++++++++++++++++++++++++++++++++--
> >>  1 file changed, 33 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> >> index 93a0e88..53bb953 100644
> >> --- a/drivers/cpufreq/intel_pstate.c
> >> +++ b/drivers/cpufreq/intel_pstate.c
> >> @@ -1943,13 +1943,40 @@ static int intel_cpufreq_verify_policy(struct cpufreq_policy *policy)
> >>         return 0;
> >>  }
> >>
> >> +static void intel_cpufreq_trace(struct cpudata *cpu, int fast, int from)
> >
> > Please use "bool" for "fast" and I'd call it "fast_switch".
> 
> O.K. thanks.
> 
> >> +{
> >> +       struct sample *sample;
> >> +       u64 time;
> >> +
> >> +       time = ktime_get();
> >
> > It is pointless to evaluate ktime_get() if
> > trace_pstate_sample_enabled() returns "false".
> 
> Of course, thanks.
> 
> >> +       if (trace_pstate_sample_enabled()) {
> >> +               if (intel_pstate_sample(cpu, time)) {
> >
> > And the extra indentation here is not very useful, so I'd write it as
> >
> > if (!trace_pstate_sample_enabled())
> >        return;
> >
> > if (!intel_pstate_sample(cpu, ktime_get()))
> >        return;
> >
> > (note that you don't need the "time" variable any more with this).
> 
> That is much better, Thanks.
> 
> >> +                       sample = &cpu->sample;
> >> +                       /* In passvie mode the trace core_busy field is
> >
> > "passive" (typo)
> >
> >> +                        * re-assigned to indicate if the driver call
> >> +                        * was via the normal or fast switch path.
> >> +                        * The scaled_busy field is not used, set to 0.
> >> +                        */
> >> +                       trace_pstate_sample(fast,
> >> +                               0,
> >> +                               from,
> >> +                               cpu->pstate.current_pstate,
> >> +                               sample->mperf,
> >> +                               sample->aperf,
> >> +                               sample->tsc,
> >> +                               get_avg_frequency(cpu),
> >> +                               fp_toint(cpu->iowait_boost * 100));
> >> +               }
> >> +       }
> >> +}
> >> +
> >>  static int intel_cpufreq_target(struct cpufreq_policy *policy,
> >>                                 unsigned int target_freq,
> >>                                 unsigned int relation)
> >>  {
> >>         struct cpudata *cpu = all_cpu_data[policy->cpu];
> >>         struct cpufreq_freqs freqs;
> >> -       int target_pstate;
> >> +       int target_pstate, from;
> >
> > I would call the new variable "old_pstate" or "orig_pstate" (so that
> > it is visibly clear that it represents a P-state).
> 
> O.K.
> I used "from" because that is what Dirk called it in the trace buffer stuff. 
> 
> >>
> >>         update_turbo_state();
> >>
> >> @@ -1969,12 +1996,14 @@ static int intel_cpufreq_target(struct cpufreq_policy *policy,
> >>                 break;
> >>         }
> >>         target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
> >> +       from = cpu->pstate.current_pstate;
> >>         if (target_pstate != cpu->pstate.current_pstate) {
> >>                 cpu->pstate.current_pstate = target_pstate;
> >>                 wrmsrl_on_cpu(policy->cpu, MSR_IA32_PERF_CTL,
> >>                               pstate_funcs.get_val(cpu, target_pstate));
> >>         }
> >>         freqs.new = target_pstate * cpu->pstate.scaling;
> >> +       intel_cpufreq_trace(cpu, 0, from);
> >>         cpufreq_freq_transition_end(policy, &freqs, false);
> >>
> >>         return 0;
> >> @@ -1984,13 +2013,15 @@ static unsigned int intel_cpufreq_fast_switch(struct cpufreq_policy *policy,
> >>                                               unsigned int target_freq)
> >>  {
> >>         struct cpudata *cpu = all_cpu_data[policy->cpu];
> >> -       int target_pstate;
> >> +       int target_pstate, from;
> >>
> >>         update_turbo_state();
> >>
> >>         target_pstate = DIV_ROUND_UP(target_freq, cpu->pstate.scaling);
> >>         target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
> >> +       from = cpu->pstate.current_pstate;
> >>         intel_pstate_update_pstate(cpu, target_pstate);
> >> +       intel_cpufreq_trace(cpu, 100, from);
> >
> > Why are you passing 100 here?  Anything different from 0 should
> > suffice, 1 in particular.  And I'd pass "false" or "true" (they will
> > be converted to 0 and 1 for output anyway).
> 
> Well, I wanted to just re-use the existing graphs generated by
> tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> and so wanted to pass 0 or 100% to it. On purpose, those graphs
> do not autoscale on the y-axis.
> 
> When investigating, the graphs can be used as a way to determine
> where to look in more detail at the raw csv files.

OK, but that would require a comment at least.

I would #ifdef symbols for that, like INTEL_PSTATE_TRACE_FAST_SWITCH
and INTEL_PSTATE_TRACE_TARGET or similar and define them as 100 and 0,
respectively.

I would call the corresponding function argument "trace_type" or
similar (it should be u32 too) and I would explain in a comment
why INTEL_PSTATE_TRACE_FAST_SWITCH is 100.

Thanks,
Rafael
