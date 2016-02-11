From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V5 0/6] cpufreq: Locking fixes and cleanups
Date: Thu, 11 Feb 2016 23:17:40 +0100
Message-ID: <363810055.yE8txbZKdD@vostro.rjw.lan>
References: <cover.1455191663.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46795 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751808AbcBKWQ0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2016 17:16:26 -0500
In-Reply-To: <cover.1455191663.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: juri.lelli@arm.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shilpa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org

On Thursday, February 11, 2016 05:31:10 PM Viresh Kumar wrote:
> Hi Rafael,
> 
> These are rest of the patches that fix some more locking issues with
> policy->rwsem and do some minor optimization/cleanups.
> 
> V4->V5:
> - Changelog updated for 1-2 as suggested by Rafael
> - 4th patch is dropped, which moved common tunable callbacks to
>   cpufreq_governor.c
> - 5-7 are resend on the V5 sent earlier, as reply to V4 of the series.
> 
> Viresh Kumar (6):
>   cpufreq: Merge cpufreq_offline_prepare/finish routines
>   cpufreq: Call __cpufreq_governor() with policy->rwsem held
>   cpufreq: Remove cpufreq_governor_lock
>   cpufreq: governor: No need to manage state machine now
>   cpufreq: conservative: Update sample_delay_ns immediately
>   cpufreq: ondemand: Rearrange od_dbs_timer() to avoid updating delay
> 
>  drivers/cpufreq/cpufreq.c              | 93 ++++++++++++++++------------------
>  drivers/cpufreq/cpufreq_conservative.c | 14 -----
>  drivers/cpufreq/cpufreq_governor.c     | 90 ++++++++++++++++++++++++--------
>  drivers/cpufreq/cpufreq_governor.h     |  3 +-
>  drivers/cpufreq/cpufreq_ondemand.c     | 78 ++--------------------------
>  5 files changed, 117 insertions(+), 161 deletions(-)

OK, queued up for 0-day testing with some rebase and changelog (sigh) fixups.

Thanks,
Rafael

