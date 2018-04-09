From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 2/6] sched: Introduce energy models of CPUs
Date: Mon, 9 Apr 2018 17:32:33 +0200
Message-ID: <20180409153233.GA4082@hirez.programming.kicks-ass.net>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-3-dietmar.eggemann@arm.com>
 <20180409120111.GA4043@hirez.programming.kicks-ass.net>
 <20180409134510.GA4577@e108498-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180409134510.GA4577@e108498-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 09, 2018 at 02:45:11PM +0100, Quentin Perret wrote:

> In this specific patch, we are basically trying to figure out the
> boundaries of frequency domains, and the power consumed by each CPU
> at each OPP, to make them available to the scheduler. The important
> thing here is that, in both cases, we rely on the OPP library to
> keep the code as platform-agnostic as possible.

AFAICT the only users of this PM_OPP stuff is a bunch of ARM platforms.
Granted, body else has build a big.little style system, so that might
all be fine I suppose.

It won't be until some !ARM chip comes along that we'll know how
generically usable any of this really is.

> In the case of the frequency domains for example, the cpufreq driver is
> in charge of specifying the CPUs that are sharing frequencies. That
> information can come from DT, or SCPI, or SCMI, or whatever -- we
> probably shouldn't have to care about that from the scheduler's
> standpoint. That's why using dev_pm_opp_get_sharing_cpus() is handy,
> the OPP library gives us the digested information we need.

So I kinda would've expected to just ask cpufreq, that after all already
knows these things. Why did we need to invent this pm_opp thing?

Cpufreq has a tons of supported architectures, pm_opp not so much.

> The power values (dev_pm_opp_get_power) we use right now are those
> already used by the thermal subsystem (IPA), which means we don't have

I love an IPA style beer, but I'm thinking that's not the same IPA,
right :-)

> to introduce any new DT binding whatsoever. In a close future, the power
> values could also come from other sources (SCMI for ex), and again it's
> probably not the scheduler's job to care about those things, so the OPP
> library is helping us again. As mentioned in the notes, as of today, this
> approach has dependencies on other patches relating to these things which
> are already on the list [1].

Is there any !ARM thermal driver? (clearly I'm not up-to-date on things
thermal).
