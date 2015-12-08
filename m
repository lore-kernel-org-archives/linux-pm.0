From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 0/4] cpufreq governors and Intel P state driver compatibility
Date: Tue, 08 Dec 2015 15:35:37 +0100
Message-ID: <3480094.iq1rZTMoWu@skinner>
References: <1449274118-15575-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:32916 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756743AbbLHOfl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Dec 2015 09:35:41 -0500
In-Reply-To: <1449274118-15575-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org

On Friday, December 04, 2015 04:08:34 PM Srinivas Pandruvada wrote:
> Intel P State driver implements two policies, performance and powersave.
> The powersave policy is similar to ondemand cpufreq governor when using
> acpi-cpufreq. This causes lots of confusion among users. This results
> in invalid comparison of performance when acpi-cpufreq and Intel P state
> performance is compared.

After several years you want to change this again?

We released documentation for this for SLE 12 recently.
It was not that easy to phrase, but it would be wrong again with newer
kernels..., sigh.

But yeah, maybe this change should be finally made.
One idea, not sure it is better: Revert the powersave governor. Then it
is clear on which implemenation of intel_pstate you are running.
And you do not accidentially think you are adjusting freqs on powersave
governor but in real you are running fixed at lowest freq.

When you are looking at cleaning up intel_pstate driver here a
request/question from me on the cpufreq list from March 2014.
>From what I see, this is still valid and these pstate specific sysfs
knobs exist as general cpufreq files already. So the pstate ones should
vanish:

1) sysfs tunables:
   - max_perf_pct, min_perf_pct
     According to Documentation/cpu-freq/intel-pstate.txt this is:
      max_perf_pct: limits the maximum P state that will be requested by
      the driver stated as a percentage of the available performance.

      min_perf_pct: limits the minimum P state that will be  requested by
      the driver stated as a percentage of the available performance.

     Why is this needed, there already is:
     scaling_max_freq, scaling_min_freq

     How are both connected?
     For me those tunable are doing the same and intel_pstate specific ones
     should vanish to have one cpufreq min/max frequency interface exported
     to userspace on all archs/cpufreq drivers.

   - no_turbo: limits the driver to selecting P states below the turbo
     frequency range.

     Again, there is the general cpufreq "boost" tunable defined in cpufreq.c:
     ssize_t show_boost(..)
     static ssize_t store_boost(...)
     define_one_global_rw(boost);

     What is the difference, why does intel-pstate need its own tunable?

    Thomas
