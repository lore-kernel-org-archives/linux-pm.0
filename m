From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC/RFT][PATCH v4 1/2] cpufreq: New governor using utilization
 data from the scheduler
Date: Wed, 2 Mar 2016 19:20:38 -0800
Message-ID: <56D7AD86.8080702@linaro.org>
References: <5059413.77KZsd2lep@vostro.rjw.lan>
 <1825489.pc33SqXSIB@vostro.rjw.lan> <56D1270F.4010106@linaro.org>
 <2754630.1sRldKdOu8@vostro.rjw.lan> <56D5161F.1030701@linaro.org>
 <CAJZ5v0hi+RZUkWFGDPpftWxcCP-1v6675FY14j19AoRM=e=13Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35336 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbcCCDUl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2016 22:20:41 -0500
Received: by mail-pa0-f46.google.com with SMTP id bj10so6172003pad.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Mar 2016 19:20:41 -0800 (PST)
In-Reply-To: <CAJZ5v0hi+RZUkWFGDPpftWxcCP-1v6675FY14j19AoRM=e=13Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>

On 03/01/2016 12:20 PM, Rafael J. Wysocki wrote:
>> I'm specifically worried about the check below where we omit a CPU's
>> capacity request if its last update came before the last sample time.
>>
>> Say there are 2 CPUs in a frequency domain, HZ is 100 and the sample
>> delay here is 4ms.
> 
> Yes, that's the case I clearly didn't take into consideration. :-)
> 
> My assumption was that the sample delay would always be greater than
> the typical update rate which of course need not be the case.
> 
> The reason I added the check at all was that the numbers from the
> other CPUs may become stale if those CPUs are idle for too long, so at
> one point the contributions from them need to be discarded.  Question
> is when that point is and since sample delay may be arbitrary, that
> mechanism has to be more complex.

Yeah this has been an open issue on our end as well. Sampling-based
governors of course solved this primarily via their fundamental nature
and sampling rate. The interactive governor also has a separate tunable
IIRC which specified how long a CPU may have its sampling timer deferred
due to idle when running @ > fmin (the "slack timer").

Decoupling the CPU update staleness limit from the freq change rate
limit via a separate tunable would be valuable IMO. Would you be
amenable to a patch that did that?

>>> Like I said in my reply to Peter in that thread, using RELATION_L here is likely
>>> to make us avoid the min frequency almost entirely even if the system is almost
>>> completely idle.  I don't think that would be OK really.
>>>
>>> That said my opinion about this particular item isn't really strong.
>>
>> I think the calculation for required CPU bandwidth needs tweaking.
> 
> The reason why I used that particular formula was that ondemand used
> it.  Of course, the input to it is different in ondemand, but the idea
> here is to avoid departing from it too much.
> 
>> Aside from always wanting something past fmin, currently the amount of
>> extra CPU capacity given for a particular % utilization depends on how
>> high the platform's fmin happens to be, even if the fmax speeds are the
>> same. For example given two platforms with the following available
>> frequencies (MHz):
>>
>> platform A: 100, 300, 500, 700, 900, 1100
>> platform B: 500, 700, 900, 1100
> 
> The frequencies may not determine raw performance, though, so 500 MHz
> in platform A may correspond to 700 MHz in platform B.  You never
> know.

My example here was solely intended to illustrate that the current
algorithm itself introduces an inconsistency in policy when other things
are equal. Depending on the fmin value, this ondemand-style calculation
will give a more or less generous amount of CPU bandwidth headroom to a
platform with a higher fmin.

It'd be good to be able to express the desired amount of CPU bandwidth
headroom in such a way that it doesn't depend on the platform's fmin
value, since CPU headroom is a critical factor in tuning a platform's
governor for optimal power and performance.

> 
>>
>> A 50% utilization load on platform A will want 600 MHz (rounding up to
>> 700 MHz perhaps) whereas platform B will want 800 MHz (again likely
>> rounding up to 900 MHz), even though the load consumes 550 MHz on both
>> platforms.
>>
>> One possibility would be something like we had in schedfreq, getting the
>> absolute CPU bw requirement (util/max) * fmax and then adding some %
>> margin, which I think is more consistent. It is true that it means
>> figuring out what the right margin is and now there's a magic number
>> (and potentially a tunable), but it would be more consistent.
>>
> 
> What the picture is missing is the information on how much more
> performance you get by running in a higher P-state (or OPP if you
> will).  We don't have that information, however, and relying on
> frequency values here generally  doesn't help.

Why does the frequency value not help? It is true there may be issues of
a workload being memory bound and not responding quite linearly to
increasing frequency, but that would pose a problem for the current
algorithm also. Surely it's better to attempt a consistent policy which
doesn't vary based on a platform's fmin value?

> Moreover, since 0 utilization gets you to run in f_min no matter what,
> if you treat f_max as an absolute, you're going to underutilize the
> P-states in the upper half of the available range.

Sorry I didn't follow. What do you mean by underutilize the upper half
of the range? I don't see how using RELATION_L with (util/max) * fmax *
(headroom) wouldn't be correct in that regard.

thanks,
Steve

