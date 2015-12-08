From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 0/4] cpufreq governors and Intel P state driver
 compatibility
Date: Tue, 08 Dec 2015 09:43:03 -0800
Message-ID: <1449596583.3240.158.camel@spandruv-desk3.jf.intel.com>
References: <1449274118-15575-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <3480094.iq1rZTMoWu@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:60892 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751645AbbLHRoI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Dec 2015 12:44:08 -0500
In-Reply-To: <3480094.iq1rZTMoWu@skinner>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: rjw@rjwysocki.net, len.brown@intel.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org

On Tue, 2015-12-08 at 15:35 +0100, Thomas Renninger wrote:
> On Friday, December 04, 2015 04:08:34 PM Srinivas Pandruvada wrote:
> > Intel P State driver implements two policies, performance and powersave.
> > The powersave policy is similar to ondemand cpufreq governor when using
> > acpi-cpufreq. This causes lots of confusion among users. This results
> > in invalid comparison of performance when acpi-cpufreq and Intel P state
> > performance is compared.
> 
> After several years you want to change this again?
This is based on feedback. But again, if this breaks some users, then we
need to think.
> 
> We released documentation for this for SLE 12 recently.
> It was not that easy to phrase, but it would be wrong again with newer
> kernels..., sigh.
Will this patchset break SLE 12?
Are you defaulting to "powersave" policy of Intel P state?
> 
> But yeah, maybe this change should be finally made.
> One idea, not sure it is better: Revert the powersave governor. Then it
> is clear on which implemenation of intel_pstate you are running.
> And you do not accidentially think you are adjusting freqs on powersave
> governor but in real you are running fixed at lowest freq.
So If we don't implement powersave policy ("running at lowest
frequency") and publish "performance ondemand". Unless userspace is not
explicitly setting "performance" or using CONFIG_DEFAULT_PERF.., we will
always use "ondemand", so customers won't notice any difference. Is this
OK?

Also question: Do you see issue in calling "ondemand" policy?

> 
> When you are looking at cleaning up intel_pstate driver here a
> request/question from me on the cpufreq list from March 2014.
> From what I see, this is still valid and these pstate specific sysfs
> knobs exist as general cpufreq files already. So the pstate ones should
> vanish:
> 
There is some history to this and certification tests are relying on
this. So I am planning to better document these as first step.
The idea is to move away from the concept of a frequency to a P state,
which is an operating point (frequency and voltage pair). Nothing stops
having two P states with same frequency but different voltage point.
> 1) sysfs tunables:
>    - max_perf_pct, min_perf_pct
>      According to Documentation/cpu-freq/intel-pstate.txt this is:
>       max_perf_pct: limits the maximum P state that will be requested by
>       the driver stated as a percentage of the available performance.
> 
>       min_perf_pct: limits the minimum P state that will be  requested by
>       the driver stated as a percentage of the available performance.
> 
>      Why is this needed, there already is:
>      scaling_max_freq, scaling_min_freq
This is not enough to show which range out of this belongs to turbo
region and which not. The Intel P state tunable have extra attributes to
know this. Since the range is opportunistic, it is not good to
explicitly publish using scaling_available_frequencies.
> 
>      How are both connected?
>      For me those tunable are doing the same and intel_pstate specific ones
>      should vanish to have one cpufreq min/max frequency interface exported
>      to userspace on all archs/cpufreq drivers.
> 
>    - no_turbo: limits the driver to selecting P states below the turbo
>      frequency range.
> 
>      Again, there is the general cpufreq "boost" tunable defined in cpufreq.c:
>      ssize_t show_boost(..)
>      static ssize_t store_boost(...)
>      define_one_global_rw(boost);
> 
>      What is the difference, why does intel-pstate need its own tunable?
> 
Thanks,
Srinivas

>     Thomas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


