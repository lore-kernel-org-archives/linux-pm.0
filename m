From: plongepe <philippe.longepe@linux.intel.com>
Subject: Re: [PATCH v1 1/2] intel_pstate: Use the cpu load to determine the
 PercentPerformance
Date: Mon, 23 Nov 2015 14:28:59 +0100
Message-ID: <5653149B.5090100@linux.intel.com>
References: <1446542840-14982-1-git-send-email-philippe.longepe@linux.intel.com>
 <1546343.Y03T7q8XC6@vostro.rjw.lan> <1446858868.5023.6.camel@linux.intel.com>
 <001701d12478$a65886b0$f3099410$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:30200 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755061AbbKWN17 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 23 Nov 2015 08:27:59 -0500
In-Reply-To: <001701d12478$a65886b0$f3099410$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>, 'Stephane Gasparini' <stephane.gasparini@linux.intel.com>
Cc: linux-pm@vger.kernel.org, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>

Hi Smythies,

Yes, the cpu load gives good results for almost all use cases except IO 
workloads
(it needs an additionnal patch to boost the IOs).

That's why we will enable it only on Atoms first but not yet on 
core/servers (more
validation is needed).


On 21/11/2015 17:21, Doug Smythies wrote:
> Philippe, Stephane,
>
> The resulting load / CPU frequency response curve has some interesting qualities.
> The resulting step function load response time is much much faster than
> the current solution, and yet there is not much tendency for the system to oscillate,
> or at least the oscillation magnitude is smallish.
>
> I agree that some sort of real load calculation needs to be brought back to the intel_pstate driver.
>    
> On 2015.11.06 17:14 Srinivas Pandruvada wrote:
> On Sat, 2015-11-07 at 02:09 +0100, Rafael J. Wysocki wrote:
>> On Tuesday, November 03, 2015 10:27:19 AM Philippe Longepe wrote:
>>> Aperf and Mperf counter are not enough to determine the Target P
>>> -state
>>> because they measure performance only when the targeted processor
>>> is
>>> in the C0 state (active state).
>>> Because of that, we were computing the average P-state during the
>>> last
>>> period which can be very different from the average frequency
>>> (or percentage of performance).
>>>
>>> As defined in the SDM (section 14.2), the PercentPerformance is
>>> defined by:
>>>
>>> PercentPerformance = PercentBusy * (delta_aperf / delta_mperf);
>>>
>>> The PercentBusy (or load) can be estimated as the ratio of the
>>> mperf
>>> counter running at a constant frequency only during active periods
>>> (C0)
>>> and the time stamp counter running at the same frequency but also
>>> during idle.
>>>
>>> So, PercentBusy = 100 * (delta_mperf / delta_tsc)
>>>
>>> and, PercentPerformance = 100 * (delta_mperf / delta_tsc) *
>>> 				(delta_aperf / delta_mperf)
>>> That can be simplified with:
>>> PercentPerformance = 100 * (delta_aperf / delta_tsc)
> Yes, but the last time I tried to bring back actual load calculations
> In a similar way it was pointed out that one should not do it this way.
> [1] SDM also states:
>
> "Only the IA32_APERF/IA32_MPERF ratio is architecturally defined;
> software should not attach meaning to the content of the individual of IA32_APERF or IA32_MPERF MSRs."
Individual counters are not architecturally defined but their ratio is 
defined.
MERF and TSC counters are both counting at the same frequency (max non 
turbo freq)
but MPERF is counting only in active state (C0) and TSC is counting all 
the time.
So, delta_mperf/delta_tsc is representing the load.
>
> Note that I have been working on a "legal" way to calculate load [2] and
> I have been using the method for about a month now. (note based on a
> different patch set starting point).
>
>>> -	duration_us = ktime_us_delta(cpu->sample.time,
>>> -				     cpu->last_sample_time);
>>> -	if (duration_us > sample_time * 3) {
>>> -		sample_ratio = div_fp(int_tofp(sample_time),
>>> -				      int_tofp(duration_us));
>>> -		core_busy = mul_fp(core_busy, sample_ratio);
> While the duration stuff has issues that can sometimes result in incorrectly driving the
> target pstate downwards, rather than deleting it there might still be value in fixing
> it using the actual load information.
>
> References:
> [1] http://marc.info/?l=linux-pm&m=143094005601231&w=2
> [2] double u double u double u .dot smythies dot com/~doug/linux/intel_pstate/build58/0006-intel_pstate-Change-utilization-calculation-to-a-leg.txt
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

