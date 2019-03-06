From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFT][Update][PATCH 2/2] cpufreq: intel_pstate: Update max CPU
 frequency on global turbo changes
Date: Wed, 6 Mar 2019 11:05:47 +0100
Message-ID: <CAJZ5v0jJxMw6_6Ep=fee8VGEbqpFKQtA2kX5t1scNwX3GhaTTg@mail.gmail.com>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan> <20190305104256.7kvedlttuovmptpc@queper01-lin>
 <2336151.IZk3Z8DVvP@aspire.rjw.lan> <6357319.Iupbu3ldGQ@aspire.rjw.lan>
 <20190305114406.GV32494@hirez.programming.kicks-ass.net> <20190305120040.y2vmnxrch6kgya3e@queper01-lin>
 <CAJZ5v0hYU763Jx0Ku0HsNMd261z7E0PhZ88_PH6MT=OLYYUAaQ@mail.gmail.com> <20190305173746.p32xolcpueudlzwn@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190305173746.p32xolcpueudlzwn@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 5, 2019 at 6:37 PM Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Tuesday 05 Mar 2019 at 18:02:25 (+0100), Rafael J. Wysocki wrote:
> > But that 128 needs to be compared to
> >
> > (SCHED_CAPACITY_SCALE * cpuinfo.min_freq) / cpuinfo.max_freq
> >
> > so with SCHED_CAPACITY_SCALE equal to 1024 this means max_freq 8x
> > higher than min_freq.  That is not totally unreasonable IMO and
> > because sg_cpu->iowait_boost grows exponentially, the difference
> > between 8x and, say, 4x is one iteration.
> >
> > > The first steps will all be below the min freq, so they'll just be
> > > transparent, while right now the iowait boost kicks in much faster :/
> >
> > There can be one iteration of a difference this way or that way AFAICS
> > and I'm not even sure how much of a performance difference that makes
> > in practice.
>
> Yeah I don't expect that to have a huge impact TBH but it'd be nice to
> actually get numbers to verify that, that's all I'm saying :-)
>
> You have 'funny' platforms like Juno r0 out there where the min/max
> frequencies are 450MHz/850Mhz. In this case, starting from 128 you'll
> need 3 wake-ups to reach what is currently the starting point. I'm not
> sure if the impact is visible or not, but it's worth checking.

Please recall that the iowait boosting algo was different to start
with, though: it jumped to the max right away and then backed off.
That turned out to be overly aggressive in general and led to some
undesired "jittery" behavior, which is why it was changed.

Thus it looks like the platforms on which it still jumps to the max
right away may actually benefit from changing it to more steps. :-)

In turn, the platforms where it takes more than 3 steps for the boost
to get to the max would get a slight performance improvement from this
changes and I'm not sure why that could be bad.

Moreover, it didn't depend on the min originally, just on the max and
just because I wanted the number of backoff steps needed to go back
down to zero to be independent of the platform IIRC.  The dependency
on the min is sort of artificial here and leads to arbitrary
differences in behavior between different platforms which isn't
particularly fortunate.

With all of that in mind, I would go right away to making the boost
independent of min and max (the final number of steps to reach the max
is TBD in practice, but 3 looks like a good enough compromise to me).

FWIW, the internal governor in intel_pstate has been changed along
these lines already (the changes is waiting for Linus to pull it ATM).
