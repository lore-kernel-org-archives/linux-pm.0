From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH v1 1/2] intel_pstate: Use the cpu load to determine the PercentPerformance
Date: Mon, 23 Nov 2015 17:33:39 -0800
Message-ID: <001c01d12658$266277e0$732767a0$@net>
References: <1446542840-14982-1-git-send-email-philippe.longepe@linux.intel.com> <1546343.Y03T7q8XC6@vostro.rjw.lan> <1446858868.5023.6.camel@linux.intel.com> <001701d12478$a65886b0$f3099410$@net> <5653149B.5090100@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta15.telus.net ([209.171.16.88]:39628 "EHLO cmta15.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752211AbbKXBdn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 23 Nov 2015 20:33:43 -0500
In-Reply-To: <5653149B.5090100@linux.intel.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'plongepe' <philippe.longepe@linux.intel.com>
Cc: linux-pm@vger.kernel.org, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Stephane Gasparini' <stephane.gasparini@linux.intel.com>

On 2015.11.23 05:29 plongepe wrote:
> On 21/11/2015 17:21, Doug Smythies wrote:
>> On 2015.11.06 17:14 Srinivas Pandruvada wrote:
>> On Sat, 2015-11-07 at 02:09 +0100, Rafael J. Wysocki wrote:
>>> On Tuesday, November 03, 2015 10:27:19 AM Philippe Longepe wrote:
>>>> Aperf and Mperf counter are not enough to determine the Target P
>>>> -state
>>>> because they measure performance only when the targeted processor
>>>> is
>>>> in the C0 state (active state).
>>>> Because of that, we were computing the average P-state during the
>>>> last
>>>> period which can be very different from the average frequency
>>>> (or percentage of performance).
>>>>
>>>> As defined in the SDM (section 14.2), the PercentPerformance is
>>>> defined by:
>>>>
>>>> PercentPerformance = PercentBusy * (delta_aperf / delta_mperf);
>>>>
>>>> The PercentBusy (or load) can be estimated as the ratio of the
>>>> mperf
>>>> counter running at a constant frequency only during active periods
>>>> (C0)
>>>> and the time stamp counter running at the same frequency but also
>>>> during idle.
>>>>
>>>> So, PercentBusy = 100 * (delta_mperf / delta_tsc)
>>>>
>>>> and, PercentPerformance = 100 * (delta_mperf / delta_tsc) *
>>>> 				(delta_aperf / delta_mperf)
>>>> That can be simplified with:
>>>> PercentPerformance = 100 * (delta_aperf / delta_tsc)
>>
>> Yes, but the last time I tried to bring back actual load calculations
>> In a similar way it was pointed out that one should not do it this way.
>> [1] SDM also states:
>>
>> "Only the IA32_APERF/IA32_MPERF ratio is architecturally defined;
>> software should not attach meaning to the content of the individual of IA32_APERF or IA32_MPERF MSRs."
>
> Individual counters are not architecturally defined but their ratio is 
> defined.
> MERF and TSC counters are both counting at the same frequency (max non 
> turbo freq)
> but MPERF is counting only in active state (C0) and TSC is counting all 
> the time.
> So, delta_mperf/delta_tsc is representing the load.

I agree.
However, Intel should decide once and for all if mperf / tsc is allowed or not.
It was used one time, then it was deleted, then I tried to bring it back,
then I was told it wasn't allowed, now you are trying to bring it back.

... Doug


