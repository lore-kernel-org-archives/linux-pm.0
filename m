From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RFC/RFT] [PATCH 05/10] cpufreq: intel_pstate: HWP boost
 performance on IO Wake
Date: Wed, 16 May 2018 12:28:09 -0700
Message-ID: <1526498889.61700.82.camel@linux.intel.com>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
         <20180516044911.28797-6-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0jSfZyGoKJKHEQCZRgQtiNt+_D0_sY+K2p3nQ9xdg3qKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jSfZyGoKJKHEQCZRgQtiNt+_D0_sY+K2p3nQ9xdg3qKg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mel Gorman <mgorman@techsingularity.net>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2018-05-16 at 11:45 +0200, Rafael J. Wysocki wrote:

[...]
> 
> > +               if (time_before64(time, cpu->last_io_update + 2 *
> > TICK_NSEC) &&
> > +                   intel_pstate_check_boost_threhold(cpu))
> > +                       cpu->iowait_boost = true;
> > +
> > +               cpu->last_io_update = time;
> > +               cpu->last_update = time;
> 
> This is a shared data structure and it gets updated without
> synchronization, unless I'm missing something.
Good point.

> 
> How much does the cross-CPU case matter?
I was under impression that IOWAIT flag is set on local CPU calls only,
but I see IOWAIT flags set for remote CPU all the time. So we will miss
if we don't take care of cross CPU calls.

But I can lump them as part of smp async call for all cross cpu updates
to avoid sync issue.

> 
> > +       }
> > 
> > +       /*
> > +        * If the boost is active, we will remove it after timeout
> > on local
> > +        * CPU only.
> > +        */
> > +       if (cpu->hwp_boost_active) {
> > +               if (smp_processor_id() == cpu->cpu) {
> > +                       bool expired;
> > +
> > +                       expired = time_after64(time, cpu-
> > >last_update +
> > +                                              (hwp_boost_hold_time
> > _ms * NSEC_PER_MSEC));
> > +                       if (expired) {
> > +                               intel_pstate_hwp_boost_down(cpu);
> > +                               cpu->hwp_boost_active = false;
> > +                               cpu->iowait_boost = false;
> > +                       }
> > +               }
> > +               return;
> > +       }
> > +
> > +       cpu->last_update = time;
> > +
> > +       if (cpu->iowait_boost) {
> > +               cpu->hwp_boost_active = true;
> > +               if (smp_processor_id() == cpu->cpu)
> > +                       intel_pstate_hwp_boost_up(cpu);
> > +               else
> > +                       smp_call_function_single_async(cpu->cpu,
> > &cpu->csd);
> > +       }
> >  }
> > 
> >  static inline void intel_pstate_calc_avg_perf(struct cpudata *cpu)
> > --
> > 2.9.5
> > 
