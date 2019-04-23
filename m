From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] x86: tsc: Rework time_cpufreq_notifier()
Date: Tue, 23 Apr 2019 10:19:29 +0200
Message-ID: <CAJZ5v0iP4TGAdRKJ3WaXTTgg1ZyGWoYLm2cJZdww=BmYWZ2tUQ@mail.gmail.com>
References: <38900622.ao2n2t5aPS@kreacher> <20190422081709.i5mv4fbket5ls4xc@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190422081709.i5mv4fbket5ls4xc@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, x86 Maintainers <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 22, 2019 at 10:17 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-04-19, 16:11, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > There are problems with running time_cpufreq_notifier() on SMP
> > systems.
> >
> > First off, the rdtsc() called from there runs on the CPU executing
> > that code and not necessarily on the CPU whose sched_clock() rate is
> > updated which is questionable at best.
> >
> > Second, in the cases when the frequencies of all CPUs in an SMP
> > system are always in sync, it is not sufficient to update just
> > one of them or the set associated with a given cpufreq policy on
> > frequency changes - all CPUs in the system should be updated and
> > that would require more than a simple transition notifier.
> >
> > Note, however, that the underlying issue (the TSC rate depending on
> > the CPU frequency) has not been present in hardware shipping for the
> > last few years and in quite a few relevant cases (acpi-cpufreq in
> > particular) running time_cpufreq_notifier() will cause the TSC to
> > be marked as unstable anyway.
> >
> > For this reason, make time_cpufreq_notifier() simply mark the TSC
> > as unstable and give up when run on SMP and only try to carry out
> > any adjustments otherwise.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  arch/x86/kernel/tsc.c |   29 ++++++++++++++---------------
> >  1 file changed, 14 insertions(+), 15 deletions(-)
> >
> > Index: linux-pm/arch/x86/kernel/tsc.c
> > ===================================================================
> > --- linux-pm.orig/arch/x86/kernel/tsc.c
> > +++ linux-pm/arch/x86/kernel/tsc.c
> > @@ -185,8 +185,7 @@ static void __init cyc2ns_init_boot_cpu(
> >  /*
> >   * Secondary CPUs do not run through tsc_init(), so set up
> >   * all the scale factors for all CPUs, assuming the same
> > - * speed as the bootup CPU. (cpufreq notifiers will fix this
> > - * up if their speed diverges)
> > + * speed as the bootup CPU.
> >   */
> >  static void __init cyc2ns_init_secondary_cpus(void)
> >  {
> > @@ -937,12 +936,12 @@ void tsc_restore_sched_clock_state(void)
> >  }
> >
> >  #ifdef CONFIG_CPU_FREQ
> > -/* Frequency scaling support. Adjust the TSC based timer when the cpu frequency
> > +/*
> > + * Frequency scaling support. Adjust the TSC based timer when the CPU frequency
> >   * changes.
> >   *
> > - * RED-PEN: On SMP we assume all CPUs run with the same frequency.  It's
> > - * not that important because current Opteron setups do not support
> > - * scaling on SMP anyroads.
> > + * NOTE: On SMP the situation is not fixable in general, so simply mark the TSC
> > + * as unstable and give up in those cases.
> >   *
> >   * Should fix up last_tsc too. Currently gettimeofday in the
> >   * first tick after the change will be slightly wrong.
> > @@ -956,22 +955,22 @@ static int time_cpufreq_notifier(struct
> >                               void *data)
> >  {
> >       struct cpufreq_freqs *freq = data;
> > -     unsigned long *lpj;
> >
> > -     lpj = &boot_cpu_data.loops_per_jiffy;
> > -#ifdef CONFIG_SMP
> > -     if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> > -             lpj = &cpu_data(freq->cpu).loops_per_jiffy;
> > -#endif
> > +     if (num_online_cpus() > 1) {
>
> What about checking num_possible_cpus() instead ? So we reliably quit
> everytime even if some CPUs are offlined.

That would work too.

The point here is that the adjustments can work if the "additional"
CPUs never go online.

> And can we place this check before registering the notifier, so it
> never gets called ?

Well, in that case the TSC would need to be marked as unstable
upfront, but that really only would be necessary if cpufreq was
actually used.  If it wasn't used, whatever the reason, marking the
TSC as unstable here would be excessive.

We're talking about old HW, mind you, and I know about systems shipped
around that time frame that didn't support performance scaling at all
and had the TSC (see the Opteron comment removed by this patch, for
instance).

So I'd rather not change that part.
