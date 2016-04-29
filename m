From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/2] cpufreq: arm_big_little: use generic OPP
 functions for {init,free}_opp_table
Date: Fri, 29 Apr 2016 09:42:56 +0530
Message-ID: <20160429041256.GW2915@vireshk-i7>
References: <1461839114-29857-1-git-send-email-sudeep.holla@arm.com>
 <1461863237-12928-1-git-send-email-sudeep.holla@arm.com>
 <1461863237-12928-2-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:32865 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbcD2ENA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 Apr 2016 00:13:00 -0400
Received: by mail-pf0-f178.google.com with SMTP id 206so42833092pfu.0
        for <linux-pm@vger.kernel.org>; Thu, 28 Apr 2016 21:12:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1461863237-12928-2-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 28-04-16, 18:07, Sudeep Holla wrote:
> Currently when performing random hotplugs and suspend-to-ram(S2R) on
> systems using arm_big_little cpufreq driver, we get warnings similar to:
> 
> cpu cpu1: _opp_add: duplicate OPPs detected. Existing: freq: 600000000,
> 	volt: 800000, enabled: 1. New: freq: 600000000, volt: 800000, enabled: 1
> 
> This is mainly because the OPPs for the shared cpus are not set. We can
> just use dev_pm_opp_of_cpumask_add_table in case the OPPs are obtained
> from DT(arm_big_little_dt.c) or use dev_pm_opp_set_sharing_cpus if the
> OPPs are obtained by other means like firmware(e.g. scpi-cpufreq.c)
> 
> Also now that the generic dev_pm_opp_cpumask_remove_table can handle
> removal of opp table and entries for all associated CPUs, we can reuse
> dev_pm_opp_cpumask_remove_table as free_opp_table in cpufreq_arm_bL_ops.
> 
> This patch makes necessary changes to reuse the generic OPP functions for
> {init,free}_opp_table and thereby eliminating the warnings.
> 
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/arm_big_little.c       | 54 ++++++++++++++++++----------------
>  drivers/cpufreq/arm_big_little.h       |  4 +--
>  drivers/cpufreq/arm_big_little_dt.c    | 21 ++-----------
>  drivers/cpufreq/scpi-cpufreq.c         | 47 +++++++++++++----------------
>  drivers/cpufreq/vexpress-spc-cpufreq.c |  4 ++-
>  5 files changed, 56 insertions(+), 74 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
