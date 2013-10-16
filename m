From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpfreq/intel_pstate: Fix max_perf_pct on resume
Date: Wed, 16 Oct 2013 02:04:46 +0200
Message-ID: <2450441.bQP5HndsJe@vostro.rjw.lan>
References: <1381860374-29681-1-git-send-email-dirk.j.brandewie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53755 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759784Ab3JOXw5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2013 19:52:57 -0400
In-Reply-To: <1381860374-29681-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: dirk.brandewie@gmail.com
Cc: linux-pm@vger.kernel.org, Dirk Brandewie <dirk.j.brandewie@intel.com>, stable@vger.kernel.org

On Tuesday, October 15, 2013 11:06:14 AM dirk.brandewie@gmail.com wrote:
> From: Dirk Brandewie <dirk.j.brandewie@intel.com>
> 
> If the system is suspended while max_perf_pct is less than 100 percent
> or no_turbo set policy->{min,max} will be set incorrectly with scaled
> values which turn the scaled values into hard limits.
> 
> Fixes https://bugzilla.kernel.org/show_bug.cgi?id=61241
> 
> Reported-by: Patrick Bartels <petzicus@googlemail.com>
> Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
> Cc: stable@vger.kernel.org

Applied, but I modified it to drop min_state and max_state too which are not
used any more.

Thanks!

> ---
>  drivers/cpufreq/intel_pstate.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 32b3479..3335f55 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -652,9 +652,8 @@ static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
>  	else
>  		policy->policy = CPUFREQ_POLICY_POWERSAVE;
>  
> -	intel_pstate_get_min_max(cpu, &min_pstate, &max_pstate);
> -	policy->min = min_pstate * 100000;
> -	policy->max = max_pstate * 100000;
> +	policy->min = cpu->pstate.min_pstate * 100000;
> +	policy->max = cpu->pstate.turbo_pstate * 100000;
>  
>  	/* cpuinfo and default policy values */
>  	policy->cpuinfo.min_freq = cpu->pstate.min_pstate * 100000;
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
