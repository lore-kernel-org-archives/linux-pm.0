From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] intel_pstate: Set cpu number before accessing MSRs
Date: Mon, 07 Jul 2014 02:07:47 +0200
Message-ID: <25106545.Q549pKqXa7@vostro.rjw.lan>
References: <1404517893-30272-1-git-send-email-vincent@vincent-minet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57621 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751303AbaGFXtp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 6 Jul 2014 19:49:45 -0400
In-Reply-To: <1404517893-30272-1-git-send-email-vincent@vincent-minet.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Minet <vincent@vincent-minet.net>, Dirk Brandewie <dirk.j.brandewie@intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>

On Saturday, July 05, 2014 01:51:33 AM Vincent Minet wrote:
> Ensure that cpu->cpu is set before writing MSR_IA32_PERF_CTL during CPU
> initialization. Otherwise only cpu0 has its P-state set and all other
> cores are left with their values unchanged.
> 
> In most cases, this is not too serious because the P-states will be set
> correctly when the timer function is run.
> But when the default governor is set to performance, the per-cpu
> current_pstate stays the same forever and no attempts are made to write
> the MSRs again.
> 
> Signed-off-by: Vincent Minet <vincent@vincent-minet.net>

I'm queing this up as a fix for -rc5.

Dirk, please let me know if this is incorrect.

Rafael


> ---
>  drivers/cpufreq/intel_pstate.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 924bb2d..eff0f9a 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -696,9 +696,8 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
>  
>  	cpu = all_cpu_data[cpunum];
>  
> -	intel_pstate_get_cpu_pstates(cpu);
> -
>  	cpu->cpu = cpunum;
> +	intel_pstate_get_cpu_pstates(cpu);
>  
>  	init_timer_deferrable(&cpu->timer);
>  	cpu->timer.function = intel_pstate_timer_func;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
