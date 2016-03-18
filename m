From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: Re: intel_pstate oopses and lockdep report with Linux v4.5-1822-g63e30271b04c
Date: Fri, 18 Mar 2016 13:35:27 -0400
Message-ID: <CA+5PVA4LEd=QmH4=u9CO9dGHU0kY+Yz1BoZDR+KhY3WJe5cMXA@mail.gmail.com>
References: <CA+5PVA5=CJ=yf0EAZqNJX0XMc+ofDDJ-CHBrwuaANQwdhh2XbA@mail.gmail.com>
	<10670722.U2p4NnYGsS@vostro.rjw.lan>
	<CA+5PVA78uXrqgm5a9h5ytbrd5sun4mVU5+u9V9GnY1V6rizhzg@mail.gmail.com>
	<6130650.QZM8FIW1Fl@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33200 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbcCRRf2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2016 13:35:28 -0400
In-Reply-To: <6130650.QZM8FIW1Fl@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Philippe Longepe <philippe.longepe@linux.intel.com>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>

On Fri, Mar 18, 2016 at 10:36 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, March 18, 2016 08:37:15 AM Josh Boyer wrote:
>> On Thu, Mar 17, 2016 at 8:20 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > On Thursday, March 17, 2016 12:44:54 PM Josh Boyer wrote:
>> >> On Thu, Mar 17, 2016 at 10:07 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> >> > On Thursday, March 17, 2016 09:02:29 AM Josh Boyer wrote:
>> >> >> Hello,
>> >> >
>> >> > Hi,
>> >> >
>> >> >> I have an Intel Atom based NUC that is producing the following
>> >> >> backtraces on boot of Linus' tree as of last evening.  This does not
>> >> >> happen with a tree with top level commit 271ecc5253e2, but does happen
>> >> >> when using the tree mentioned in the subject with top level commit
>> >> >> 63e30271b04c.
>> >> >>
>> >> >> The first backtrace appears to be a warning because the intel_pstate
>> >> >> driver is calling wrmsrl_on_cpu when interrupts are disabled?  Not
>> >> >> sure on that one.
>> >> >>
>> >> >> The second backtrace is a lockdep report.  Both are from the same boot.
>> >> >
>> >> > OK, thanks for the report.
>> >> >
>> >> > Can you please try the patch below?
>> >> >
>> >> > I'm actually unsure if we can do that safely in general for Atom because
>> >> > of the initialization, but that's what Core does anyway.
>> >> >
>> >> > Srinivas, Philippe, why exactly do we need the wrmsrl_on_cpu() in
>> >> > atom_set_pstate()?  core_set_pstate() uses wrmsrl() and seems to be doing fine.
>> >> >
>> >> > ---
>> >> >  drivers/cpufreq/intel_pstate.c |    2 +-
>> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >> >
>> >> > Index: linux-pm/drivers/cpufreq/intel_pstate.c
>> >> > ===================================================================
>> >> > --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
>> >> > +++ linux-pm/drivers/cpufreq/intel_pstate.c
>> >> > @@ -587,7 +587,7 @@ static void atom_set_pstate(struct cpuda
>> >> >
>> >> >         val |= vid;
>> >> >
>> >> > -       wrmsrl_on_cpu(cpudata->cpu, MSR_IA32_PERF_CTL, val);
>> >> > +       wrmsrl(MSR_IA32_PERF_CTL, val);
>> >> >  }
>> >> >
>> >> >  static int silvermont_get_scaling(void)
>> >> >
>> >>
>> >> I applied this on top of commit 09fd671ccb24 and the backtrace and
>> >> lockdep report both go away.  So yes, this seems to clear up the
>> >> issue.  I tested it on a variety of different CPU types and didn't
>> >> notice anything wrong on them either.
>> >
>> > The problems may show up during initialization and cleanup where one CPU
>> > may be running code trying to configure a different one.  In those cases
>> > wrmsrl_on_cpu() needs to be used.
>> >
>> > Let me cut a patch taking that into account.
>>
>> OK.  Happy to test when you have it ready.
>
> Thanks!
>
> Please test the patch below.
>
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] intel_pstate: Do not call wrmsrl_on_cpu() with disabled interrupts
>
> After commit a4675fbc4a7a (cpufreq: intel_pstate: Replace timers with
> utilization update callbacks) wrmsrl_on_cpu() cannot be called in the
> intel_pstate_adjust_busy_pstate() path as that is executed with
> disabled interrupts.  However, atom_set_pstate() called from there
> via intel_pstate_set_pstate() uses wrmsrl_on_cpu() to update the
> IA32_PERF_CTL MSR which triggers the WARN_ON_ONCE() in
> smp_call_function_single().
>
> The reason why wrmsrl_on_cpu() is used by atom_set_pstate() is
> because intel_pstate_set_pstate() calling it is also invoked during
> the initialization and cleanup of the driver and in those cases it is
> not guaranteed to be run on the CPU that is being updated.  However,
> in the case when intel_pstate_set_pstate() is called by
> intel_pstate_adjust_busy_pstate(), wrmsrl() can be used to update
> the register safely.  Moreover, intel_pstate_set_pstate() already
> contains code that only is executed if the function is called by
> intel_pstate_adjust_busy_pstate() and there is a special argument
> passed to it because of that.
>
> To fix the problem at hand, rearrange the code taking the above
> observations into account.
>
> First, replace the ->set() callback in struct pstate_funcs with a
> ->get_val() one that will return the value to be written to the
> IA32_PERF_CTL MSR without updating the register.
>
> Second, split intel_pstate_set_pstate() into two functions,
> intel_pstate_update_pstate() to be called by
> intel_pstate_adjust_busy_pstate() that will contain all of the
> intel_pstate_set_pstate() code which only needs to be executed in
> that case and will use wrmsrl() to update the MSR (after obtaining
> the value to write to it from the ->get_val() callback), and
> intel_pstate_set_min_pstate() to be invoked during the
> initialization and cleanup that will set the P-state to the
> minimum one and will update the MSR using wrmsrl_on_cpu().
>
> Finally, move the code shared between intel_pstate_update_pstate()
> and intel_pstate_set_min_pstate() to a new static inline function
> intel_pstate_record_pstate() and make them both call it.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Fixes: a4675fbc4a7a (cpufreq: intel_pstate: Replace timers with utilization update callbacks)

Tested-by: Josh Boyer <jwboyer@fedoraproject.org>

This worked fine on the original problem machine, and the other
machines I also tested.  No backtrace or lockdeps reported.

josh

> ---
>  drivers/cpufreq/intel_pstate.c |   73 ++++++++++++++++++++++++-----------------
>  1 file changed, 43 insertions(+), 30 deletions(-)
>
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -134,7 +134,7 @@ struct pstate_funcs {
>         int (*get_min)(void);
>         int (*get_turbo)(void);
>         int (*get_scaling)(void);
> -       void (*set)(struct cpudata*, int pstate);
> +       u64 (*get_val)(struct cpudata*, int pstate);
>         void (*get_vid)(struct cpudata *);
>         int32_t (*get_target_pstate)(struct cpudata *);
>  };
> @@ -565,7 +565,7 @@ static int atom_get_turbo_pstate(void)
>         return value & 0x7F;
>  }
>
> -static void atom_set_pstate(struct cpudata *cpudata, int pstate)
> +static u64 atom_get_val(struct cpudata *cpudata, int pstate)
>  {
>         u64 val;
>         int32_t vid_fp;
> @@ -585,9 +585,7 @@ static void atom_set_pstate(struct cpuda
>         if (pstate > cpudata->pstate.max_pstate)
>                 vid = cpudata->vid.turbo;
>
> -       val |= vid;
> -
> -       wrmsrl_on_cpu(cpudata->cpu, MSR_IA32_PERF_CTL, val);
> +       return val | vid;
>  }
>
>  static int silvermont_get_scaling(void)
> @@ -711,7 +709,7 @@ static inline int core_get_scaling(void)
>         return 100000;
>  }
>
> -static void core_set_pstate(struct cpudata *cpudata, int pstate)
> +static u64 core_get_val(struct cpudata *cpudata, int pstate)
>  {
>         u64 val;
>
> @@ -719,7 +717,7 @@ static void core_set_pstate(struct cpuda
>         if (limits->no_turbo && !limits->turbo_disabled)
>                 val |= (u64)1 << 32;
>
> -       wrmsrl(MSR_IA32_PERF_CTL, val);
> +       return val;
>  }
>
>  static int knl_get_turbo_pstate(void)
> @@ -750,7 +748,7 @@ static struct cpu_defaults core_params =
>                 .get_min = core_get_min_pstate,
>                 .get_turbo = core_get_turbo_pstate,
>                 .get_scaling = core_get_scaling,
> -               .set = core_set_pstate,
> +               .get_val = core_get_val,
>                 .get_target_pstate = get_target_pstate_use_performance,
>         },
>  };
> @@ -769,7 +767,7 @@ static struct cpu_defaults silvermont_pa
>                 .get_max_physical = atom_get_max_pstate,
>                 .get_min = atom_get_min_pstate,
>                 .get_turbo = atom_get_turbo_pstate,
> -               .set = atom_set_pstate,
> +               .get_val = atom_get_val,
>                 .get_scaling = silvermont_get_scaling,
>                 .get_vid = atom_get_vid,
>                 .get_target_pstate = get_target_pstate_use_cpu_load,
> @@ -790,7 +788,7 @@ static struct cpu_defaults airmont_param
>                 .get_max_physical = atom_get_max_pstate,
>                 .get_min = atom_get_min_pstate,
>                 .get_turbo = atom_get_turbo_pstate,
> -               .set = atom_set_pstate,
> +               .get_val = atom_get_val,
>                 .get_scaling = airmont_get_scaling,
>                 .get_vid = atom_get_vid,
>                 .get_target_pstate = get_target_pstate_use_cpu_load,
> @@ -812,7 +810,7 @@ static struct cpu_defaults knl_params =
>                 .get_min = core_get_min_pstate,
>                 .get_turbo = knl_get_turbo_pstate,
>                 .get_scaling = core_get_scaling,
> -               .set = core_set_pstate,
> +               .get_val = core_get_val,
>                 .get_target_pstate = get_target_pstate_use_performance,
>         },
>  };
> @@ -839,25 +837,24 @@ static void intel_pstate_get_min_max(str
>         *min = clamp_t(int, min_perf, cpu->pstate.min_pstate, max_perf);
>  }
>
> -static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate, bool force)
> +static inline void intel_pstate_record_pstate(struct cpudata *cpu, int pstate)
>  {
> -       int max_perf, min_perf;
> -
> -       if (force) {
> -               update_turbo_state();
> -
> -               intel_pstate_get_min_max(cpu, &min_perf, &max_perf);
> -
> -               pstate = clamp_t(int, pstate, min_perf, max_perf);
> -
> -               if (pstate == cpu->pstate.current_pstate)
> -                       return;
> -       }
>         trace_cpu_frequency(pstate * cpu->pstate.scaling, cpu->cpu);
> -
>         cpu->pstate.current_pstate = pstate;
> +}
>
> -       pstate_funcs.set(cpu, pstate);
> +static void intel_pstate_set_min_pstate(struct cpudata *cpu)
> +{
> +       int pstate = cpu->pstate.min_pstate;
> +
> +       intel_pstate_record_pstate(cpu, pstate);
> +       /*
> +        * Generally, there is no guarantee that this code will always run on
> +        * the CPU being updated, so force the register update to run on the
> +        * right CPU.
> +        */
> +       wrmsrl_on_cpu(cpu->cpu, MSR_IA32_PERF_CTL,
> +                     pstate_funcs.get_val(cpu, pstate));
>  }
>
>  static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
> @@ -870,7 +867,8 @@ static void intel_pstate_get_cpu_pstates
>
>         if (pstate_funcs.get_vid)
>                 pstate_funcs.get_vid(cpu);
> -       intel_pstate_set_pstate(cpu, cpu->pstate.min_pstate, false);
> +
> +       intel_pstate_set_min_pstate(cpu);
>  }
>
>  static inline void intel_pstate_calc_busy(struct cpudata *cpu)
> @@ -997,6 +995,21 @@ static inline int32_t get_target_pstate_
>         return cpu->pstate.current_pstate - pid_calc(&cpu->pid, core_busy);
>  }
>
> +static inline void intel_pstate_update_pstate(struct cpudata *cpu, int pstate)
> +{
> +       int max_perf, min_perf;
> +
> +       update_turbo_state();
> +
> +       intel_pstate_get_min_max(cpu, &min_perf, &max_perf);
> +       pstate = clamp_t(int, pstate, min_perf, max_perf);
> +       if (pstate == cpu->pstate.current_pstate)
> +               return;
> +
> +       intel_pstate_record_pstate(cpu, pstate);
> +       wrmsrl(MSR_IA32_PERF_CTL, pstate_funcs.get_val(cpu, pstate));
> +}
> +
>  static inline void intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
>  {
>         int from, target_pstate;
> @@ -1006,7 +1019,7 @@ static inline void intel_pstate_adjust_b
>
>         target_pstate = pstate_funcs.get_target_pstate(cpu);
>
> -       intel_pstate_set_pstate(cpu, target_pstate, true);
> +       intel_pstate_update_pstate(cpu, target_pstate);
>
>         sample = &cpu->sample;
>         trace_pstate_sample(fp_toint(sample->core_pct_busy),
> @@ -1180,7 +1193,7 @@ static void intel_pstate_stop_cpu(struct
>         if (hwp_active)
>                 return;
>
> -       intel_pstate_set_pstate(cpu, cpu->pstate.min_pstate, false);
> +       intel_pstate_set_min_pstate(cpu);
>  }
>
>  static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
> @@ -1255,7 +1268,7 @@ static void copy_cpu_funcs(struct pstate
>         pstate_funcs.get_min   = funcs->get_min;
>         pstate_funcs.get_turbo = funcs->get_turbo;
>         pstate_funcs.get_scaling = funcs->get_scaling;
> -       pstate_funcs.set       = funcs->set;
> +       pstate_funcs.get_val   = funcs->get_val;
>         pstate_funcs.get_vid   = funcs->get_vid;
>         pstate_funcs.get_target_pstate = funcs->get_target_pstate;
>
>
