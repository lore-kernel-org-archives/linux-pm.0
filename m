From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: stats: Make the stats code non-modular
Date: Thu, 26 May 2016 10:29:45 +0530
Message-ID: <20160526045945.GO17585@vireshk-i7>
References: <1482863.aVJEuqdboc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34434 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbcEZE7t (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2016 00:59:49 -0400
Received: by mail-pa0-f54.google.com with SMTP id qo8so25910532pab.1
        for <linux-pm@vger.kernel.org>; Wed, 25 May 2016 21:59:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1482863.aVJEuqdboc@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 26-05-16, 00:23, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
> While at it, clean up Kconfig help for the CPU_FREQ_STAT and
> CPU_FREQ_STAT_DETAILS options.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/Kconfig         |   13 +--
>  drivers/cpufreq/cpufreq.c       |    4 +
>  drivers/cpufreq/cpufreq_stats.c |  146 +++-------------------------------------
>  include/linux/cpufreq.h         |   12 +++
>  4 files changed, 34 insertions(+), 141 deletions(-)

Looks far better now :)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
