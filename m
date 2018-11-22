From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v9 09/15] sched: Introduce sched_energy_present static key
Date: Thu, 22 Nov 2018 16:51:41 +0100
Message-ID: <CAJZ5v0iV9oKVHjPdv4UzEJbZt0gumd3a2=cJtFw04FHGbi73kA@mail.gmail.com>
References: <20181119141857.8625-1-quentin.perret@arm.com> <20181119141857.8625-10-quentin.perret@arm.com>
 <20181121130822.GE2113@hirez.programming.kicks-ass.net> <20181121151444.t3zye5l5iycfni2s@queper01-lin>
 <20181122091715.6kvhcbgoqrd54nbs@queper01-lin> <20181122093237.goxmr4p5l4h2izid@queper01-lin>
 <20181122102545.GQ2131@hirez.programming.kicks-ass.net> <20181122152538.jvgh3uvuo5a6lfs7@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122152538.jvgh3uvuo5a6lfs7@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Thara Gopinath <thara.gopinath@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joel@joelfernandes.org>, Steve Muckle <smuckle@google.com>, adharmap@codeaurora.org, Saravana Kannan <skann>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 22, 2018 at 4:25 PM Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Thursday 22 Nov 2018 at 11:25:45 (+0100), Peter Zijlstra wrote:
> > On Thu, Nov 22, 2018 at 09:32:39AM +0000, Quentin Perret wrote:
> > > Hmm, I went too fast, that's totally broken. But there's still something
> > > we can do with static_branch_{inc,dec} I think. I'll come back later
> > > with a better solution.
> >
> > Right; if you count the rd's that have pd set, it should work-ish. Yes,
> > much cleaner if you can get it to work.
>
> So, I came up with the following code which seems to work OK. It's not
> as I clean as I'd like, though. The fact that free_pd() can be called in
> softirq context is annoying to manipulate the static key ...
>
> An alternative to this work item workaround is to do static_branch_dec()
> from build_perf_domains() and next to the three call sites of
> free_rootdomain() in order to avoid the call_rcu() context. Not very
> pretty either.
>
> Or we can just stick with your original suggestion to carry a boolean
> around.

What's problematic with carrying a boolean around?
