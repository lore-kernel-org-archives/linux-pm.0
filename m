From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC/RFT][PATCH v4 1/2] cpufreq: New governor using utilization
 data from the scheduler
Date: Thu, 3 Mar 2016 20:20:06 +0100
Message-ID: <CAJZ5v0jwbNXF4bOmcqOB-w4Axr5kd-pOT0EGUGYzSLAO_vVC+Q@mail.gmail.com>
References: <5059413.77KZsd2lep@vostro.rjw.lan>
	<1825489.pc33SqXSIB@vostro.rjw.lan>
	<56D1270F.4010106@linaro.org>
	<2754630.1sRldKdOu8@vostro.rjw.lan>
	<56D5161F.1030701@linaro.org>
	<CAJZ5v0hi+RZUkWFGDPpftWxcCP-1v6675FY14j19AoRM=e=13Q@mail.gmail.com>
	<56D7AD86.8080702@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f196.google.com ([209.85.217.196]:36858 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089AbcCCTUJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Mar 2016 14:20:09 -0500
In-Reply-To: <56D7AD86.8080702@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>

On Thu, Mar 3, 2016 at 4:20 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
> On 03/01/2016 12:20 PM, Rafael J. Wysocki wrote:
>>> I'm specifically worried about the check below where we omit a CPU's
>>> capacity request if its last update came before the last sample time.
>>>
>>> Say there are 2 CPUs in a frequency domain, HZ is 100 and the sample
>>> delay here is 4ms.
>>
>> Yes, that's the case I clearly didn't take into consideration. :-)
>>
>> My assumption was that the sample delay would always be greater than
>> the typical update rate which of course need not be the case.
>>
>> The reason I added the check at all was that the numbers from the
>> other CPUs may become stale if those CPUs are idle for too long, so at
>> one point the contributions from them need to be discarded.  Question
>> is when that point is and since sample delay may be arbitrary, that
>> mechanism has to be more complex.
>
> Yeah this has been an open issue on our end as well. Sampling-based
> governors of course solved this primarily via their fundamental nature
> and sampling rate. The interactive governor also has a separate tunable
> IIRC which specified how long a CPU may have its sampling timer deferred
> due to idle when running @ > fmin (the "slack timer").
>
> Decoupling the CPU update staleness limit from the freq change rate
> limit via a separate tunable would be valuable IMO. Would you be
> amenable to a patch that did that?

Yes, I would.

It still would be better, though, if that didn't have to be a tunable.

What do you think about my idea to use NSEC_PER_SEC / HZ as the
staleness limit (like in https://patchwork.kernel.org/patch/8477261/)?

[cut]

>> Moreover, since 0 utilization gets you to run in f_min no matter what,
>> if you treat f_max as an absolute, you're going to underutilize the
>> P-states in the upper half of the available range.
>
> Sorry I didn't follow. What do you mean by underutilize the upper half
> of the range? I don't see how using RELATION_L with (util/max) * fmax *
> (headroom) wouldn't be correct in that regard.

Suppose all of the util values from 0 to max are equally probable (or
equally frequent) and the available frequencies are close enough to
each other that it doesn't really matter whether _C or _L is used.

Say f_min is 400 and f_max is 1000.

Then, if you take next_freq = f_max * util / max, 50% of requests will
fall into the 400-500 section of the available frequency range.  Of
course, 40% of them will fall to f_min, but that means that the other
available states will be used less frequently, on the average.

I would prefer that to be more balanced.

Thanks,
Rafael
