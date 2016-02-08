From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3 00/13] cpufreq: governors: Fix ABBA lockups
Date: Mon, 8 Feb 2016 22:43:43 +0100
Message-ID: <CAJZ5v0gMD81nwrbuf0sb3gELZ0F4AP3svkiMJustM8sqCfOgzQ@mail.gmail.com>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:33486 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755817AbcBHVno (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 16:43:44 -0500
In-Reply-To: <cover.1454931188.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi,

On Mon, Feb 8, 2016 at 12:39 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi Rafael,
>
> Things look much much better now. I have rebased this series over
> pm/bleeding-edge, that has all your patches.
>
> I have moved ahead and done few more changes in this series, that should
> get rid of all the lockdeps we were getting earlier, that includes
> fixing lockdep issue in update_sampling_rate() that we were chasing.
>
> These are pushed here again:
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/governor-kobject
>
> @Juri/Shilpa: Can you please confirm if all the issues got resolved now
> ?
>
> V2->V3:
> - The first patch from V2, that was moving min_sampling_rate to
>   per governor structure was dropped, as you suggested.
> - Also, I have moved common tunables to struct dbs_data now, which you
>   also suggested sometime back.
> - Last 5 patches are all new and fix rest of the issues we were facing.
>
> --
> viresh
>
> Viresh Kumar (13):
>   cpufreq: governor: Create generic macro for global tuners
>   cpufreq: governor: Move common tunables to 'struct dbs_data'
>   cpufreq: governor: New sysfs show/store callbacks for governor
>     tunables
>   cpufreq: governor: Drop unused macros for creating governor tunable
>     attributes
>   Revert "cpufreq: Drop rwsem lock around CPUFREQ_GOV_POLICY_EXIT"
>   cpufreq: Merge cpufreq_offline_prepare/finish routines
>   cpufreq: Call __cpufreq_governor() with policy->rwsem held
>   cpufreq: Remove cpufreq_governor_lock
>   cpufreq: governor: Move common sysfs tunables to cpufreq_governor.c
>   cpufreq: governor: No need to manage state machine now
>   cpufreq: governor: Keep list of policy_dbs within dbs_data
>   cpufreq: ondemand: Traverse list of policy_dbs in
>     update_sampling_rate()
>   cpufreq: conservative: Update sample_delay_ns immediately

This is OK overall, but we'll need to reorder it somewhat.

I have reviewed patches [1-5,12/13].  Where I didn't send comments, I had none.

In my opinion, those 6 patches should go in first.  At least I don't
see why [12/13] cannot be reworked on top of [1-5/13].  If there is
any fundamental reason, please let me know what it is.  Otherwise,
please first send new versions of those 6 patches, preferably as a new
series.

The rest of the patchset will require more review time, so please send
them again later, when you're done with the first item.

Thanks,
Rafael
