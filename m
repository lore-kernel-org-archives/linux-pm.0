From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: powerpc: replace CPUFREQ_ETERNAL with cpufreq transition latency for FSL e500mc Socs
Date: Wed, 19 Mar 2014 02:42:15 +0100
Message-ID: <2143464.l2G8tITm4N@vostro.rjw.lan>
References: <1395034168-7342-1-git-send-email-Zhuoyu.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1395034168-7342-1-git-send-email-Zhuoyu.Zhang@freescale.com>
Sender: cpufreq-owner@vger.kernel.org
To: Zhuoyu Zhang <Zhuoyu.Zhang@freescale.com>
Cc: viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Yuantian.Tang@freescale.com
List-Id: linux-pm@vger.kernel.org

On Monday, March 17, 2014 01:29:28 PM Zhuoyu Zhang wrote:
> According to the data provided by HW Team, at least 12 internal platform clock cycles are required to 
> stabilize a DFS clock switch on FSL e500mc Socs. This patch replaces the CPUFREQ_ETERNAL with 
> appropriate HW clock transition latency to make DFS governors work normally on Freescale e500mc boards.

Please sign off the patch.  I can't apply it without your sign-off.

> ---
>  drivers/cpufreq/ppc-corenet-cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
> index 051000f..ff7b625 100644
> --- a/drivers/cpufreq/ppc-corenet-cpufreq.c
> +++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
> @@ -21,6 +21,7 @@
>  #include <linux/of.h>
>  #include <linux/slab.h>
>  #include <linux/smp.h>
> +#include <sysdev/fsl_soc.h>
>  
>  /**
>   * struct cpu_data - per CPU data struct
> @@ -205,7 +206,7 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	for_each_cpu(i, per_cpu(cpu_mask, cpu))
>  		per_cpu(cpu_data, i) = data;
>  
> -	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
> +	policy->cpuinfo.transition_latency = (12 * NSEC_PER_SEC) / fsl_get_sys_freq();
>  	of_node_put(np);
>  
>  	return 0;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
