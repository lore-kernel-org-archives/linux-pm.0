From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v10 03/27] timer: Export next wakeup time of a CPU
Date: Fri, 25 Jan 2019 11:18:53 +0100
Message-ID: <CAJZ5v0hiC-FJMR4_QSBEgCKLbj2QHBRB3ReABFmQ_8wF4=-mcQ@mail.gmail.com>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-4-ulf.hansson@linaro.org> <119031115.C8gHTGbYmQ@aspire.rjw.lan>
 <CAPDyKFqQQnMKFNpGyi_dkP_Rm8qo-1WjPfVkp2unOxyXRa2wbA@mail.gmail.com>
 <CAJZ5v0iY7j5SThQhtq5xP+g5yNiHQ+cMWxq-tdVh3t5wJ_s3Tw@mail.gmail.com>
 <CAPDyKFr6nD6hazmsGqT-Z-Z67oime75Yavr+SuL0P_MZF3HZGQ@mail.gmail.com> <CAPDyKFoRZyTpccWaE7TZXM=E2xRevqX9MxMGnuq6P=qfYQfBtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoRZyTpccWaE7TZXM=E2xRevqX9MxMGnuq6P=qfYQfBtg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 25, 2019 at 11:04 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> [...]
>
> > > > > > +/**
> > > > > > + * tick_nohz_get_next_wakeup - return the next wake up of the CPU
> > > > > > + * @cpu: the particular CPU to get next wake up for
> > > > > > + *
> > > > > > + * Called for idle CPUs only.
> > > > > > + */
> > > > > > +ktime_t tick_nohz_get_next_wakeup(int cpu)
> > > > > > +{
> > > > > > +     struct clock_event_device *dev = per_cpu(tick_cpu_device.evtdev, cpu);
> > > > > > +
> > > > > > +     return dev->next_event;
> > > > > > +}
> > > > > > +
> > > > > >  static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
> > > > > >  {
> > > > > >  #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
> > > > > >
> > > > >
> > > > > Well, I have concerns regarding this one.
> > > > >
> > > > > I don't believe it is valid to call this new function for non-idle CPUs and
> > > > > the kerneldoc kind of says so, but the next patch doesn't actually prevent
> > > > > it from being called for a non-idle CPU (at the time it is called in there
> > > > > the target CPU may not be idle any more AFAICS).
> > > >
> > > > You are correct, but let me clarify things.
> > > >
> > > > We are calling this new API from the new genpd governor, which may
> > > > have a cpumask indicating there is more than one CPU attached to its
> > > > PM domain+sub-PM domains. In other words, we may call the API for
> > > > another CPU than the one we are executing on.
> > > >
> > > > When the new genpd governor is called, all CPUs in the cpumask of the
> > > > genpd in question, are already runtime suspended and will remain so
> > > > throughout the decisions made by the governor.
> > > >
> > > > However, because of the race condition, which needs to be manged by
> > > > the genpd backend driver and its corresponding FW, one of the CPU in
> > > > the genpd cpumask could potentially wake up from idle when the genpd
> > > > governor runs. However, as a part of exiting from idle, that CPU needs
> > > > to wait for the call to pm_runtime_get_sync() to return before
> > > > completing the exit patch of idle. This also means waiting for the
> > > > genpd governor to finish.
> > >
> > > OK, so the CPU spins on a spin lock inside of the idle loop with interrupts off.
> >
> > Correct.
> >
> > This is the part that is not very nice, but ideally it should be a
> > rather rare condition as it only happens during the last man standing
> > point.
> >
> > >
> > > > The point is, no matter what decision the governor takes under these
> > > > circumstances, the genpd backend driver and its FW must manage this
> > > > race condition during the last man standing. For PSCI OSI mode, it
> > > > means that if a cluster idle state is suggested by Linux during these
> > > > circumstances, it must be prevented and aborted.
> > >
> > > I would suggest putting a comment to explain that somewhere as it is
> > > not really obvious.
> >
> > Let me see if can squeeze in that somewhere, probably it's best suited
> > in the new genpd governor code somewhere.
> >
> > >
> > > > >
> > > > > In principle, the cpuidle core can store this value, say in struct
> > > > > cpuidle_device of the given CPU, and expose a helper to access it from
> > > > > genpd, but that would be extra overhead totally unnecessary on everthing
> > > > > that doesn't use genpd for cpuidle.
> > > > >
> > > > > So maybe the driver could store it in its ->enter callback?  After all,
> > > > > the driver knows that genpd is going to be used later.
> > > >
> > > > This would work, but it wouldn't really change much when it comes to
> > > > the race condition described above.
> > >
> > > No, it wouldn't make the race go away.
> > >
> > > > Of course it would turn the code
> > > > into being more cpuidle specific, which seems reasonable to me.
> > > >
> > > > Anyway, if I understand your suggestion, in principle it means
> > > > changing $subject patch in such way that the API should not take "int
> > > > cpu" as an in-parameter, but instead only use __this_cpu() to read out
> > > > the next event for current idle CPU.
> > >
> > > Yes.
>
> I have looked closer to this and it turned out that it seems that I
> should probably not need introduce an entirely new thing here. Instead
> I should likely be able to re-factor the current
> tick_nohz_get_sleep_length() and tick_nohz_next_event(), as those are
> in principle doing the similar things as I need. So I started hacking
> on that, when Daniel Lezcano told me that he already have a patch
> doing exactly what I want. :-) However, in the context of his "next
> wakeup prediction" work, but that shouldn't matter.
>
> If I can make it work, I will fold in his patch in the next version of
> the series instead.
>
> Please tell if you already at this point, see any issues with this approach.

Not in principle as long as you do that in the context of the cpuidle
framework.  That is, I still would like to have this  "cpuidle, give
me the wakeup time of this CPU" I/F to the genpd governor, but you can
do the above to implement it as long as I'm concerned.
