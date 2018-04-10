From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC PATCH 2/6] sched: Introduce energy models of CPUs
Date: Tue, 10 Apr 2018 08:55:14 +0200
Message-ID: <CAJZ5v0hEvQ1jJYErGCa2d6pcydMYrD9_+uh7eM2F6v08NyGQ6Q@mail.gmail.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-3-dietmar.eggemann@arm.com> <20180409120111.GA4043@hirez.programming.kicks-ass.net>
 <20180409134510.GA4577@e108498-lin.cambridge.arm.com> <20180409153233.GA4082@hirez.programming.kicks-ass.net>
 <20180409164205.GA3520@e108498-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180409164205.GA3520@e108498-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thara Gopinath <thara.gopinath@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 9, 2018 at 6:42 PM, Quentin Perret <quentin.perret@arm.com> wrote:
> On Monday 09 Apr 2018 at 17:32:33 (+0200), Peter Zijlstra wrote:
>> On Mon, Apr 09, 2018 at 02:45:11PM +0100, Quentin Perret wrote:
>>
>> > In this specific patch, we are basically trying to figure out the
>> > boundaries of frequency domains, and the power consumed by each CPU
>> > at each OPP, to make them available to the scheduler. The important
>> > thing here is that, in both cases, we rely on the OPP library to
>> > keep the code as platform-agnostic as possible.
>>
>> AFAICT the only users of this PM_OPP stuff is a bunch of ARM platforms.
>
> That's correct.
>
>> Granted, body else has build a big.little style system, so that might
>> all be fine I suppose.
>>
>> It won't be until some !ARM chip comes along that we'll know how
>> generically usable any of this really is.
>>
>
> Right. There is already a lot of diversity in the Arm ecosystem that has
> to be managed. That's what I meant by platform-agnostic. Now, I agree
> that it should be discussed whether or not this is enough for other
> archs ...

Even for ARM64 w/ ACPI, mind you.

> It might be reasonable to expect from the archs who want to use EAS that
> they expose their OPPs in the OPP lib. That should be harmless, and EAS
> needs to know about the OPPs, so they should be made visible, ideally
> somewhere generic. Otherwise, that means the interface with the
> EAS has to be defined only by the energy model data structures, and the
> actual energy model loading procedure becomes free-form arch code.
>
> I quiet like the first idea from a pure design standpoint, but I could
> also understand if maintainers of other archs were reluctant to
> have new dependencies on PM_OPP ...

Not just reluctant I would think.

Depending on PM_OPP directly here is like depending on ACPI directly.
Would you agree with the latter?

>> > In the case of the frequency domains for example, the cpufreq driver is
>> > in charge of specifying the CPUs that are sharing frequencies. That
>> > information can come from DT, or SCPI, or SCMI, or whatever -- we
>> > probably shouldn't have to care about that from the scheduler's
>> > standpoint. That's why using dev_pm_opp_get_sharing_cpus() is handy,
>> > the OPP library gives us the digested information we need.
>>
>> So I kinda would've expected to just ask cpufreq, that after all already
>> knows these things. Why did we need to invent this pm_opp thing?
>
> Yes, we can definitely rely on cpufreq for this one. There is a "strong"
> dependency on PM_OPP to get power values, so I decided to use PM_OPP for
> the frequency domains as well, for consistency. But I can change that if
> needed.

Yes, please.

>>
>> Cpufreq has a tons of supported architectures, pm_opp not so much.
>>
>> > The power values (dev_pm_opp_get_power) we use right now are those
>> > already used by the thermal subsystem (IPA), which means we don't have
>>
>> I love an IPA style beer, but I'm thinking that's not the same IPA,
>> right :-)
>
> Well, both can help to chill down in a way ... :-)
>
> The IPA I'm talking about means Intelligent Power Allocator. It's a
> thermal governor that uses a power model of the platform to allocate
> power budgets to CPUs & GPUs using a control loop. The code is in
> drivers/thermal/power_allocator.c if this is of interest.
>
>>
>> > to introduce any new DT binding whatsoever. In a close future, the power
>> > values could also come from other sources (SCMI for ex), and again it's
>> > probably not the scheduler's job to care about those things, so the OPP
>> > library is helping us again. As mentioned in the notes, as of today, this
>> > approach has dependencies on other patches relating to these things which
>> > are already on the list [1].
>>
>> Is there any !ARM thermal driver? (clearly I'm not up-to-date on things
>> thermal).
>
> I don't think so.

No, there isn't, AFAICS.

Thanks!
