From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 04/16] cpufreq: cpu0: use cpufreq_generic_get() routine
Date: Thu, 29 Aug 2013 21:07:27 +0800
Message-ID: <20130829130725.GL18729@S2101-09.ap.freescale.net>
References: <cover.1377272740.git.viresh.kumar@linaro.org>
 <6ae0de783646c5356717d761903502f354abfe84.1377272740.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6ae0de783646c5356717d761903502f354abfe84.1377272740.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 23, 2013 at 09:20:39PM +0530, Viresh Kumar wrote:
> We have common infrastructure available with us for getting a CPUs clk rate.
> Lets use it for this driver.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>

Both this and imx6q one,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-cpu0.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
> index 7273bfc..62e52e3 100644
> --- a/drivers/cpufreq/cpufreq-cpu0.c
> +++ b/drivers/cpufreq/cpufreq-cpu0.c
> @@ -29,11 +29,6 @@ static struct clk *cpu_clk;
>  static struct regulator *cpu_reg;
>  static struct cpufreq_frequency_table *freq_table;
>  
> -static unsigned int cpu0_get_speed(unsigned int cpu)
> -{
> -	return clk_get_rate(cpu_clk) / 1000;
> -}
> -
>  static int cpu0_set_target(struct cpufreq_policy *policy, unsigned int index)
>  {
>  	struct opp *opp;
> @@ -99,6 +94,7 @@ static int cpu0_set_target(struct cpufreq_policy *policy, unsigned int index)
>  
>  static int cpu0_cpufreq_init(struct cpufreq_policy *policy)
>  {
> +	policy->clk = cpu_clk;
>  	return cpufreq_generic_init(policy, freq_table, transition_latency);
>  }
>  
> @@ -106,7 +102,7 @@ static struct cpufreq_driver cpu0_cpufreq_driver = {
>  	.flags = CPUFREQ_STICKY,
>  	.verify = cpufreq_generic_frequency_table_verify,
>  	.target_index = cpu0_set_target,
> -	.get = cpu0_get_speed,
> +	.get = cpufreq_generic_get,
>  	.init = cpu0_cpufreq_init,
>  	.exit = cpufreq_generic_exit,
>  	.name = "generic_cpu0",
> -- 
> 1.7.12.rc2.18.g61b472e
> 
