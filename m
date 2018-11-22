From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v9 08/15] sched/topology: Make Energy Aware Scheduling
 depend on schedutil
Date: Thu, 22 Nov 2018 15:56:03 +0000
Message-ID: <20181122155601.nf6egzo3aicqv33y@queper01-lin>
References: <20181119141857.8625-1-quentin.perret@arm.com>
 <20181119141857.8625-9-quentin.perret@arm.com>
 <20181122140432.GH2113@hirez.programming.kicks-ass.net>
 <CAJZ5v0g0cca+wuZocwwt5y+a7FS6Y8qDDf27KftRQ_1Dy6-7XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g0cca+wuZocwwt5y+a7FS6Y8qDDf27KftRQ_1Dy6-7XQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Thara Gopinath <thara.gopinath@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joel@joelfernandes.org>, Steve Muckle <smuckle@google.com>, adharmap@codeaurora.org, Saravana Kannan <skann>
List-Id: linux-pm@vger.kernel.org

On Thursday 22 Nov 2018 at 16:49:04 (+0100), Rafael J. Wysocki wrote:
> On Thu, Nov 22, 2018 at 3:05 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Nov 19, 2018 at 02:18:50PM +0000, Quentin Perret wrote:
> > > +                     if (rd->pd)
> > > +                             pr_warn("rd %*pbl: Disabling EAS, schedutil is mandatory\n",
> > > +                                             cpumask_pr_args(cpu_map));
> > > +                     goto free;
> >
> > I would have preferred just not allowing the governor to change at all,
> > but if you want to allow that, this is, I suppose, the best you can do.
> >
> > Rafael, are you otherwise OK with the grubbing inside cpufreq?
> 
> Sort of. :-)
> 
> I would put the sched_cpufreq_governor_change() header (and the static
> inline stub of it) into linux/cpufreq.h (instead of
> linux/sched/cpufreq.h) so that cpufreq.c doesn't have to include
> linux/sched/cpufreq.h which is kind of confusing.

That works for me.

Thanks,
Quentin
