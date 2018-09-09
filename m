From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 13/14] sched/topology: Make Energy Aware Scheduling
 depend on schedutil
Date: Sun, 9 Sep 2018 22:13:52 +0200
Message-ID: <CAJZ5v0gs1Fb-Y1FbjmnxLNHQR=CSHFX_=KpDEkqRCYDJ9EJByQ@mail.gmail.com>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <CAJZ5v0jL_k36RPc6e8yUHxAYGXp7HHWK+hLnBZWnu5Oi__7j3w@mail.gmail.com>
 <20180906143842.xlxcg5notwdaflww@queper01-lin> <1545744.fI5ZvP8FO0@aspire.rjw.lan>
 <20180907152923.oxsmcqciez4yhmkk@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180907152923.oxsmcqciez4yhmkk@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Thara Gopinath <thara.gopinath@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joel@joelfernandes.org>, Steve Muckle <smuckle@google.com>, adharm
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 7, 2018 at 5:29 PM Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Friday 07 Sep 2018 at 10:52:01 (+0200), Rafael J. Wysocki wrote:
> > On Thursday, September 6, 2018 4:38:44 PM CEST Quentin Perret wrote:
> > > Hi Rafael,
> > >
> > > On Thursday 06 Sep 2018 at 11:18:55 (+0200), Rafael J. Wysocki wrote:
> > > > I'm not a particular fan of notifiers to be honest and you don't need
> > > > to add an extra chain just in order to be able to register a callback
> > > > from a single user.
> > >
> > > Right. I agree there are alternatives to using notifiers. I used them
> > > because they're existing infrastructure, and because they let me do what
> > > I want without too much troubles, which are two important points.
> > >
> > > > That can be achieved with a single callback
> > > > pointer too, but also you could just call a function exported by the
> > > > scheduler directly from where in the cpufreq code it needs to be
> > > > called.
> > >
> > > Are you thinking about something comparable to what is done in
> > > cpufreq_add_update_util_hook() (kernel/sched/cpufreq.c) for example ?
> > > That would probably have the same drawback as my current implementation,
> > > that is that the scheduler is notified of _all_ governor changes, not
> > > only changes to/from sugov although this is the only thing we care about
> > > for EAS.
> >
> > Well, why don't you implement it as something like "if the governor changes
> > from sugov to something else (or the other way around), call this function
> > from the scheduler"?
>
> I just gave it a try and ended up with the diff below. It's basically
> the exact same patch with a direct function call instead of a notifier.
> (I also tried the sugov_start/stop thing I keep mentioning but it is
> more complex, so let's see if the simplest solution could work first).
>
> What do you think ?

This generally works for me from the cpufreq perspective, but I would
add "cpufreq" to the name of the new function, that is call it
something like sched_cpufreq_governor_change().

Also do you really need the extra work item?  Governor changes are
carried out in process context anyway.

Thanks,
Rafael
