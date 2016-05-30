From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: stats: Make the stats code non-modular
Date: Mon, 30 May 2016 10:23:48 +0530
Message-ID: <20160530045348.GA26787@vireshk-i7>
References: <1482863.aVJEuqdboc@vostro.rjw.lan>
 <20160526045945.GO17585@vireshk-i7>
 <5665576.VhylybbIm6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34661 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbcE3Exw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 May 2016 00:53:52 -0400
Received: by mail-pa0-f45.google.com with SMTP id bz2so28675867pad.1
        for <linux-pm@vger.kernel.org>; Sun, 29 May 2016 21:53:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5665576.VhylybbIm6@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 28-05-16, 15:15, Rafael J. Wysocki wrote:
> It does, but there's a problem.
> 
> If fast frequency switching is in use, the stats attributes just sit there
> full of zeros (because the stats are not updated then) which is confusing.
> 
> Of course, the ultimate solution here would be to make the stats actually
> work with fast frequency switching, but that requires some major surgery of
> the stats code, so for now I'd like to simply make those attributes return
> nothing if fast frequency switching is enabled for the policy (returning
> -EBUSY from there, which would have been cleaner, unfortunately breaks
> powertop).

What's stopping us from doing that? Sorry I don't remember that well :(

I mean, why can't we call cpufreq_stats_record_transition() somehow via that
code ?

> Updated patch is below.
> 
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] cpufreq: stats: Make the stats code non-modular
> 
> The modularity of cpufreq_stats is quite problematic.
> 
> First off, the usage of policy notifiers for the initialization
> and cleanup in the cpufreq_stats module is inherently racy with
> respect to CPU offline/online and the initialization and cleanup
> of the cpufreq driver.
> 
> Second, fast frequency switching (used by the schedutil governor)
> cannot be enabled if any transition notifiers are registered, so
> if the cpufreq_stats module (that registers a transition notifier
> for updating transition statistics) is loaded, the schedutil governor
> cannot use fast frequency switching.
> 
> On the other hand, allowing cpufreq_stats to be built as a module
> doesn't really add much value.  Arguably, there's not much reason
> for that code to be modular at all.
> 
> For the above reasons, make the cpufreq stats code non-modular,
> modify the core to invoke functions provided by that code directly
> and drop the notifiers from it.
> 
> Make the stats sysfs attributes appear empty if fast frequency
> switching is enabled as the statistics will not be updated in that
> case anyway (and returning -EBUSY from those attributes breaks
> powertop).
> 
> While at it, clean up Kconfig help for the CPU_FREQ_STAT and
> CPU_FREQ_STAT_DETAILS options.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/Kconfig         |   13 +--
>  drivers/cpufreq/cpufreq.c       |    4 +
>  drivers/cpufreq/cpufreq_stats.c |  152 +++++-----------------------------------
>  include/linux/cpufreq.h         |   12 +++
>  4 files changed, 40 insertions(+), 141 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
