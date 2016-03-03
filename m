From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 6/6] cpufreq: schedutil: New governor based on scheduler
 utilization data
Date: Thu, 3 Mar 2016 17:24:32 +0100
Message-ID: <CAJZ5v0ifY7V48Vh8PdErobxiB0_NAweQ3XiSaMgby54varMLkQ@mail.gmail.com>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
	<1842158.0Xhak3Uaac@vostro.rjw.lan>
	<CAKfTPtANvYp5ar8UkKyN9R25Ntrfp+bEEFw5M0=MA8q7zscSMw@mail.gmail.com>
	<CAJZ5v0jvStPbhKSJUHTwySkEXa0rKp3zE7YLWeCmGHeQt8xcrw@mail.gmail.com>
	<CAJZ5v0gC_S+a43FvgpB25WnpAANkDQk7agwSx4gRJvdmnPFkeQ@mail.gmail.com>
	<20160303122030.GN6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160303122030.GN6356@twins.programming.kicks-ass.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 3, 2016 at 1:20 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Mar 02, 2016 at 11:49:48PM +0100, Rafael J. Wysocki wrote:
>> >>> +       min_f = sg_policy->policy->cpuinfo.min_freq;
>> >>> +       max_f = sg_policy->policy->cpuinfo.max_freq;
>> >>> +       next_f = util > max ? max_f : min_f + util * (max_f - min_f) / max;
>
>> In case a more formal derivation of this formula is needed, it is
>> based on the following 3 assumptions:
>>
>> (1) Performance is a linear function of frequency.
>> (2) Required performance is a linear function of the utilization ratio
>> x = util/max as provided by the scheduler (0 <= x <= 1).
>
>> (3) The minimum possible frequency (min_freq) corresponds to x = 0 and
>> the maximum possible frequency (max_freq) corresponds to x = 1.
>>
>> (1) and (2) combined imply that
>>
>> f = a * x + b
>>
>> (f - frequency, a, b - constants to be determined) and then (3) quite
>> trivially leads to b = min_freq and a = max_freq - min_freq.
>
> 3 is the problem, that just doesn't make sense and is probably the
> reason why you see very little selection of the min freq.

It is about mapping the entire [0,1] interval to the available frequency range.

I till overprovision things (the smaller x the more), but then it may
help the race-to-idle a bit in theory.

> Suppose a machine with the following frequencies:
>
>         500, 750, 1000
>
> And a utilization of 0.4, how does asking for 500 + 0.4 * (1000-500) =
> 700 make any sense? Per your point 1, it should should be asking for
> 0.4 * 1000 = 400.
>
> Because, per 1, at 500 it runs exactly half as fast as at 1000, and we
> only need 0.4 times as much. Therefore 500 is more than sufficient.

OK, but then I don't see why this reasoning only applies to the lower
bound of the frequency range.  Is there any reason why x = 1 should be
the only point mapping to max_freq?

If not, then I think it's reasonable to map the middle of the
available frequency range to x = 0.5 and then we have b = 0 and a =
(max_freq + min_freq) / 2.

I'll try that and see how it goes.

> Note. we all know that 1 is a 'broken' assumption, but lacking anything
> better I think its a reasonable one to make.

Right.
