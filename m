From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v10 1/3] cpufreq: Add mechanism for registering
 utilization update callbacks
Date: Mon, 22 Feb 2016 16:15:34 +0530
Message-ID: <20160222104534.GM28226@vireshk-i7>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <1455900129.7375.231.camel@linux.intel.com>
 <20160219172545.GA27380@e106622-lin>
 <1882532.OhsNMeyWOd@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35324 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341AbcBVKpy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2016 05:45:54 -0500
Received: by mail-pf0-f180.google.com with SMTP id c10so93932484pfc.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Feb 2016 02:45:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1882532.OhsNMeyWOd@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Juri Lelli <juri.lelli@arm.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On 19-02-16, 23:26, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] cpufreq: Rework the scheduler hooks for triggering updates
> 
> Commit fe7034338ba0 (cpufreq: Add mechanism for registering
> utilization update callbacks) added cpufreq_update_util() to be
> called by the scheduler (from the CFS part) on utilization updates.
> The goal was to allow CFS to pass utilization information to cpufreq
> and to trigger it to evaluate the frequency/voltage configuration
> (P-state) of every CPU on a regular basis.
> 
> However, the last two arguments of that function are never used by
> the current code, so CFS might simply call cpufreq_trigger_update()
> instead of it.
> 
> For this reason, drop the last two arguments of cpufreq_update_util(),
> rename it to cpufreq_trigger_update() and modify CFS to call it.
> 
> Moreover, since the utilization is not involved in that now, rename
> data types, functions and variables related to cpufreq_trigger_update()
> to reflect that (eg. struct update_util_data becomes struct
> freq_update_hook and so on).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c          |   48 ++++++++++++++++++++++---------------
>  drivers/cpufreq/cpufreq_governor.c |   27 ++++++++++----------
>  drivers/cpufreq/cpufreq_governor.h |    2 -
>  drivers/cpufreq/intel_pstate.c     |   15 +++++------
>  include/linux/cpufreq.h            |   32 +++---------------------
>  kernel/sched/deadline.c            |    2 -
>  kernel/sched/fair.c                |   13 +---------
>  kernel/sched/rt.c                  |    2 -
>  8 files changed, 58 insertions(+), 83 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
