From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 10/10] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Fri, 4 Mar 2016 14:19:06 +0100
Message-ID: <CAJZ5v0hca7myrxs0Y7jHGykhafMHPo-UJJyDKBZaopmACLT_cg@mail.gmail.com>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
	<2409306.qzzMXcm4dm@vostro.rjw.lan>
	<4627718.FT18d2LR5p@vostro.rjw.lan>
	<20160304112639.GD4061@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f194.google.com ([209.85.217.194]:35399 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbcCDNTI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Mar 2016 08:19:08 -0500
In-Reply-To: <20160304112639.GD4061@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On Fri, Mar 4, 2016 at 12:26 PM, Juri Lelli <juri.lelli@arm.com> wrote:
> Hi Rafael,

Hi,

> On 04/03/16 04:35, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Add a new cpufreq scaling governor, called "schedutil", that uses
>> scheduler-provided CPU utilization information as input for making
>> its decisions.
>>
>> Doing that is possible after commit fe7034338ba0 (cpufreq: Add
>> mechanism for registering utilization update callbacks) that
>> introduced cpufreq_update_util() called by the scheduler on
>> utilization changes (from CFS) and RT/DL task status updates.
>> In particular, CPU frequency scaling decisions may be based on
>> the the utilization data passed to cpufreq_update_util() by CFS.
>>
>> The new governor is relatively simple.
>>
>> The frequency selection formula used by it is
>>
>>       next_freq = util * max_freq / max
>>
>> where util and max are the utilization and CPU capacity coming from CFS.
>>
>
> The formula looks better to me now. However, problem is that, if you
> have freq. invariance, util will slowly saturate to the current
> capacity. So, we won't trigger OPP changes for a task that for example
> starts light and then becomes big.
>
> This is the same problem we faced with schedfreq. The current solution
> there is to use a margin for calculating a threshold (80% of current
> capacity ATM). Once util goes above that threshold we trigger an OPP
> change.  Current policy is pretty aggressive, we go to max_f and then
> adapt to the "real" util during successive enqueues. This was also
> tought to cope with the fact that PELT seems slow to react to abrupt
> changes in tasks behaviour.
>
> I'm not saying this is the definitive solution, but I fear something
> along this line is needed when you add freq invariance in the mix.

I really would like to avoid adding factors that need to be determined
experimentally, because the result of that tends to depend on the
system where the experiment is carried out and tunables simply don't
work (99% or maybe even more users don't change the defaults anyway).

So I would really like to use a formula that's based on some science
and doesn't depend on additional input.

Now, since the equation generally is f = a * x + b (f - frequency, x =
util/max) and there are good arguments for b = 0, it all boils down to
what number to take as a.  a = max_freq is a good candidate (that's
what I'm using right now), but it may turn out to be too small.
Another reasonable candidate is a = min_freq + max_freq, because then
x = 0.5 selects the frequency in the middle of the available range,
but that may turn out to be way too big if min_freq is high (like
higher that 50% of max_freq).

I need to think more about that and admittedly my understanding of the
frequency invariance consequences is limited ATM.

Thanks,
Rafael
