From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [query] cpufreq: intel_pstate: diverge of current_pstate and
 actual P state
Date: Tue, 20 May 2014 14:31:46 -0700
Message-ID: <537BC9C2.6030801@intel.com>
References: <537BC4E8.60500@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34224 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbaETVeQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 May 2014 17:34:16 -0400
Received: by mail-pd0-f174.google.com with SMTP id r10so687192pdi.5
        for <linux-pm@vger.kernel.org>; Tue, 20 May 2014 14:34:16 -0700 (PDT)
In-Reply-To: <537BC4E8.60500@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: dirk.j.brandewie@intel.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 05/20/2014 02:11 PM, Stratos Karafotis wrote:
> Hi all,
>
> Currently, we use the current P state to calculate the busy_scaled factor
> and then the next P state.
>
> We also read the MSR_TURBO_RATIO_LIMIT to get the turbo ratio limit as the
> turbo_pstate. But, we always read bits 7:0 ("Maximum turbo ratio limit of 1
> core active").
>
> So, in processor families that have different turbo ratio limit
> depending on active cores the current P state as it's considered
> by the driver might be different from the actual current P state.
>
> For example, I use an i7-3770 which reports as maximum turbo ratio limits
> with 1/2/3/4 actives cores the values 39/39/38/37. So, in some cases
> we will calculate as the next P state the value 39. If the active cores
> at that time was 3 or 4 the actual P state will be 38 or 37.
> The current_pstate variable will have the value 39 and this will lead
> to wrong calculation at the next sampling interval.
>
> Trying to find a solution to the above I couldn't find an MSR that
> we could use to get the number of active cores and use the respective
> turbo ratio limit.
>
> I also thought to use the IA32_PERF_STATUS to get the current P state
> and use it in the calculations, but its scope is per core and not per
> thread.
>
> Am I missing something? If the above is correct, any idea how this
> could be resolved?

The above is correct except the requested pstate is calculated using
max_pstate and turbo_pstate is used as the upper limit when calling
intel_pstate_set_pstate.

The value written to (MSR_IA32_PPERF_CTL is a request that is processed by the
CPU and is clipped internally to the current state of the CPU.  Whether or
not any turbo is available is decided by the CPU asking for the top
turbo bin says give me all that is available.

Asking for more than the CPU has to give ATM is harmless.

>
>
> Thanks in advance,
> Stratos
>

