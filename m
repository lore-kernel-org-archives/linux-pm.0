From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFT][Update][PATCH 2/2] cpufreq: intel_pstate: Update max CPU
 frequency on global turbo changes
Date: Tue, 5 Mar 2019 18:02:25 +0100
Message-ID: <CAJZ5v0hYU763Jx0Ku0HsNMd261z7E0PhZ88_PH6MT=OLYYUAaQ@mail.gmail.com>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan> <20190305104256.7kvedlttuovmptpc@queper01-lin>
 <2336151.IZk3Z8DVvP@aspire.rjw.lan> <6357319.Iupbu3ldGQ@aspire.rjw.lan>
 <20190305114406.GV32494@hirez.programming.kicks-ass.net> <20190305120040.y2vmnxrch6kgya3e@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190305120040.y2vmnxrch6kgya3e@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 5, 2019 at 1:00 PM Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Tuesday 05 Mar 2019 at 12:44:06 (+0100), Peter Zijlstra wrote:
> > On Tue, Mar 05, 2019 at 11:58:37AM +0100, Rafael J. Wysocki wrote:
> > > So after the Peter's patch "sched/cpufreq: Fix 32bit math overflow"
> > > I will need to recompute sg_cpu->min in sugov_limits().
> >
> > So there's still an open question; do we want that ->min thing to depend
> > on available frequencies _at_all_ ?
> >
> > I'm thinking it might be a good thing to have the iowait boost curve be
> > independent of all that.
> >
> > Like said; if we set it at 128 (static), it takes 9 consequtive wake-ups
> > for it to reach 1024 (max). While now the curve depends on how wide the
> > gap is between min_freq and max_freq. And it seems weird to have this
> > behaviour depend on that. To me at least.
>
> I'm not conceptually against it, but that really wants testing I think.
> I can already see how we're gonna see regressions: 128 is much lower
> than 'min' on my juno for ex, so with the approach you suggest it's
> gonna take several wake-up before the iowait stuff does anything at all.

But that 128 needs to be compared to

(SCHED_CAPACITY_SCALE * cpuinfo.min_freq) / cpuinfo.max_freq

so with SCHED_CAPACITY_SCALE equal to 1024 this means max_freq 8x
higher than min_freq.  That is not totally unreasonable IMO and
because sg_cpu->iowait_boost grows exponentially, the difference
between 8x and, say, 4x is one iteration.

> The first steps will all be below the min freq, so they'll just be
> transparent, while right now the iowait boost kicks in much faster :/

There can be one iteration of a difference this way or that way AFAICS
and I'm not even sure how much of a performance difference that makes
in practice.

OTOH I fundamentally don't see why the iowait boost should ramp up
faster on CPUs having a higher max_freq to min_freq ratio.  Say you
have two platforms, both with max_freq of 2 GHz and with min_freq
equal to 250 MHz and 500 MHz, respectively.  The ratios in question
will be 8 and 4 then, so the first one will reliably react 50% slower
to iowait than the second one for no particular reason at all.

> OTOH, you also have platforms like the recent Snapdragons with 30+ OPPs,
> and for them starting at 128 will speed things up.
>
> So maybe what you want is to start at max(min, 128) ?

That's not just min, though, or is it?
