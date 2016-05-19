From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Drop the 'initialized' field from struct
 cpufreq_governor
Date: Thu, 19 May 2016 07:40:23 +0530
Message-ID: <20160519021023.GF24777@vireshk-i7>
References: <1835934.f0fzDcHWum@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33390 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbcESCK1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2016 22:10:27 -0400
Received: by mail-pa0-f53.google.com with SMTP id xk12so23612034pac.0
        for <linux-pm@vger.kernel.org>; Wed, 18 May 2016 19:10:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1835934.f0fzDcHWum@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 18-05-16, 22:59, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The 'initialized' field in struct cpufreq_governor is only used by
> the conservative governor (as a usage counter) and the way that
> happens is far from straightforward and arguably incorrect.
> 
> Namely, the value of 'initialized' is checked by
> cpufreq_dbs_governor_init() and cpufreq_dbs_governor_exit() and
> the results of those checks are passed (as the second argument) to
> the ->init() and ->exit() callbacks in struct dbs_governor.  Those
> callbacks are only implemented by the ondemand and conservative
> governors and ondemand doesn't use their second argument at all.
> In turn, the conservative governor uses it to decide whether or not
> to either register or unregister a transition notifier.
> 
> That whole mechanism is not only unnecessarily convoluted, but also
> racy, because the 'initialized' field of struct cpufreq_governor is
> updated in cpufreq_init_governor() and cpufreq_exit_governor() under
> policy->rwsem which doesn't help if one of these functions is run
> twice in parallel for different policies (which isn't impossible in
> principle), for example.
> 
> Instead of it, add a proper usage counter to the conservative
> governor and update it from cs_init() and cs_exit() which is
> guaranteed to be non-racy, as those functions are only called
> under gov_dbs_data_mutex which is global.
> 
> With that in place, drop the 'initialized' field from struct
> cpufreq_governor as it is not used any more.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is on top of https://patchwork.kernel.org/patch/9094021/
> 
> ---
>  drivers/cpufreq/cpufreq.c              |    3 --
>  drivers/cpufreq/cpufreq_conservative.c |   44 +++++++++++++++++++++------------
>  drivers/cpufreq/cpufreq_governor.c     |    6 ++--
>  drivers/cpufreq/cpufreq_governor.h     |    4 +--
>  drivers/cpufreq/cpufreq_ondemand.c     |    4 +--
>  include/linux/cpufreq.h                |    1 
>  6 files changed, 36 insertions(+), 26 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
