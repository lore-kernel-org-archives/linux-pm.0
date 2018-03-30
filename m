From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: cppc: Use transition_delay_us depending on the transition_latency
Date: Fri, 30 Mar 2018 12:17:03 +0200
Message-ID: <2363055.ek83znc87k@aspire.rjw.lan>
References: <1521801031-158659-1-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521801031-158659-1-git-send-email-george.cherian@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: George Cherian <george.cherian@cavium.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, viresh.kumar@linaro.org
List-Id: linux-pm@vger.kernel.org

On Friday, March 23, 2018 11:30:31 AM CEST George Cherian wrote:
> With commit e948bc8fbee0 ("cpufreq: Cap the default transition delay
> value to 10 ms")  the cpufreq was not honouring the delay passed via
> ACPI (PCCT). Due to which on ARM based platforms using CPPC the cpufreq
> governor tries to change the frequency of CPU faster than expeted.
> 
> This leads to continuous error messages like the following.
> " ACPI CPPC: PCC check channel failed. Status=0 "
> 
> Earlier (without above commit) the default transition delay was
> taken form the value passed from PCCT. Use the same value provided by PCCT
> to set the transition_delay_us.
> 
> Fixes: e948bc8fbee0 (cpufreq: Cap the default transition delay value to 10 ms)
> Signed-off-by: George Cherian <george.cherian@cavium.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index a1c3025..dcb1cb9 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -20,6 +20,7 @@
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
>  #include <linux/dmi.h>
> +#include <linux/time.h>
>  #include <linux/vmalloc.h>
>  
>  #include <asm/unaligned.h>
> @@ -162,6 +163,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	policy->cpuinfo.max_freq = cppc_dmi_max_khz;
>  
>  	policy->cpuinfo.transition_latency = cppc_get_transition_latency(cpu_num);
> +	policy->transition_delay_us = cppc_get_transition_latency(cpu_num) /
> +		NSEC_PER_USEC;
>  	policy->shared_type = cpu->shared_type;
>  
>  	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
> 

Applied, thanks!
