From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 6/6] cpufreq: schedutil: New governor based on scheduler
 utilization data
Date: Thu, 10 Mar 2016 00:28:52 +0100
Message-ID: <CAJZ5v0iKn4dT4ta6WaEcPbdYmA7P08=bmKU+dwcMx+Msk7WRFg@mail.gmail.com>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
	<CAJZ5v0h47h-xW6a4jzwRuOOOSG+qsD9hegM7QCzbD8Wb-yPVKQ@mail.gmail.com>
	<56D8AEB7.2050100@linaro.org>
	<36459679.vzZnOsAVeg@vostro.rjw.lan>
	<20160308112759.GF6356@twins.programming.kicks-ass.net>
	<CAJZ5v0i+KFmpggrGKqtL_SB1=Fv=b_AbVeL-9jPfo4rYt6-q5A@mail.gmail.com>
	<20160308192640.GD6344@twins.programming.kicks-ass.net>
	<CAJZ5v0g=dXmoPr0jR6AVuynVYbSwJvnS2dFhb7QnUKq9LRRnrQ@mail.gmail.com>
	<20160309163930.GP6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160309163930.GP6356@twins.programming.kicks-ass.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 9, 2016 at 5:39 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Mar 08, 2016 at 09:05:50PM +0100, Rafael J. Wysocki wrote:
>> >> This means that on platforms where the utilization is frequency
>> >> invariant we should use
>> >>
>> >>   next_freq = a * x
>> >>
>> >> (where x is given by (2) above) and for platforms where the
>> >> utilization is not frequency invariant
>> >>
>> >>   next_freq = a * x * current_freq / max_freq
>> >>
>> >> and all boils down to finding a.
>> >
>> > Right.
>>
>> However, that doesn't seem to be in agreement with the Steve's results
>> posted earlier in this thread.
>
> I could not make anything of those numbers.
>
>> Also theoretically, with frequency invariant, the only way you can get
>> to 100% utilization is by running at the max frequency, so the closer
>> to 100% you get, the faster you need to run to get any further.  That
>> indicates nonlinear to me.
>
> I'm not seeing that, you get that by using a > 1. No need for
> non-linear.

OK

>> >> Now, it seems reasonable for a to be something like (1 + 1/n) *
>> >> max_freq, so for non-frequency invariant we get
>> >>
>> >>   nex_freq = (1 + 1/n) * current_freq * x

(*) (see below)

>> > This seems like a big leap; where does:
>> >
>> >   (1 + 1/n) * max_freq
>> >
>> > come from? And what is 'n'?
>
>> a = max_freq gives next_freq = max_freq for x = 1,
>
> next_freq = a        * x * current_freq / max_freq
>
>   [ a := max_freq, x := 1 ] ->
>
>           = max_freq * 1 * current_freq / max_freq
>           = current_freq
>
>           != max_freq
>
> But I think I see what you're saying; because at x = 1,
> current_frequency must be max_frequency. Per your earlier point.

Correct.

>> but with that choice of a you may never get to x = 1 with frequency
>> invariant because of the feedback effect mentioned above, so the 1/n
>> produces the extra boost needed for that (n is a positive integer).
>
> OK, so that gets us:
>
>         a = (1 + 1/n) ; n > 0
>
> [ I would not have chosen (1 + 1/n), but lets stick to that ]

Well, what would you choose then? :-)

> So for n = 4 that gets you: a = 1.25, which effectively gets you an 80%
> utilization tipping point. That is, 1.25 * .8 = 1, iow. you'll pick the
> next frequency (assuming RELATION_L like selection).
>
> Together this gets you:
>
>         next_freq = (1 + 1/n) * max_freq * x * current_freq / max_freq
>                   = (1 + 1/n) * x * current_freq

That seems to be what I said above (*), isn't it?

> Again, with n = 4, x > .8 will result in a next_freq > current_freq, and
> hence (RELATION_L) pick a higher one.

OK

>> Quite frankly, to me it looks like linear really is a better
>> approximation for "raw" utilization.  That is, for frequency invariant
>> x we should take:
>>
>>   next_freq = a * x * max_freq / current_freq
>
> (its very confusing how you use 'x' for both invariant and
> non-invariant).
>
> That doesn't make sense, remember:
>
>         util = \Sum_i u_i * freq_i / max_freq           (1)
>
> Which for systems where freq_i is constant reduces to:
>
>         util = util_raw * current_freq / max_freq       (2)
>
> But you cannot reverse this. IOW you cannot try and divide out
> current_freq on a frequency invariant metric.

I see.

> So going by:
>
>         next_freq = (1 + 1/n) * max_freq * util         (3)

I think that should be

  next_freq = (1 + 1/n) * max_freq * util / max

(where max is the second argument of cpufreq_update_util) or the
dimensions on both sides don't match.

> if we substitute (2) into (3) we get:
>
>                   = (1 + 1/n) * max_freq * util_raw * current_freq / max_freq
>                   = (1 + 1/n) * current_freq * util_raw (4)
>
> Which gets you two formula with the same general behaviour. As (2) is
> the only approximation of (1) we can make.

OK

So since utilization is not frequency invariant in the current
mainline (or linux-next for that matter) AFAIC, I'm going to use the
following in the next version of the schedutil patch series:

  next_freq = 1.25 * current_freq * util_raw / max

where util_raw and max are what I get from cpufreq_update_util().

1.25 is for the 80% tipping point which I think is reasonable.
