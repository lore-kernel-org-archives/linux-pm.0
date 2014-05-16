From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V2 3/3] cpufreq: Tegra: implement intermediate frequency
 callbacks
Date: Fri, 16 May 2014 13:39:27 -0600
Message-ID: <5376696F.9090006@wwwdotorg.org>
References: <9e1ed1bf8c3610709436fe5ef8df3a63856f8f5c.1400230695.git.viresh.kumar@linaro.org> <b3e68b08ca8175fde81ef1a85db1fde506f835b9.1400230695.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:57529 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992428AbaEPTjb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 May 2014 15:39:31 -0400
In-Reply-To: <b3e68b08ca8175fde81ef1a85db1fde506f835b9.1400230695.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arvind.chauhan@arm.com, swarren@nvidia.com, nicolas.pitre@linaro.org, dianders@chromium.org, linux@arm.linux.org.uk, thomas.abraham@linaro.org, pdeschrijver@nvidia.com

On 05/16/2014 03:07 AM, Viresh Kumar wrote:
> Tegra had always been switching to intermediate frequency (pll_p_clk) since
> ever. CPUFreq core has better support for handling notifications for these
> frequencies and so we can adapt Tegra's driver to it.

You need to squash in the patch below in order for this series to work.
Once that's done,

Tested-by: Stephen Warren <swarren@nvidia.com>

>     Signed-off-by: Stephen Warren <swarren@nvidia.com>
> 
> diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra-cpufreq.c
> index 10b29ec99bdc..c04fec02ac6a 100644
> --- a/drivers/cpufreq/tegra-cpufreq.c
> +++ b/drivers/cpufreq/tegra-cpufreq.c
> @@ -49,13 +49,22 @@ static struct clk *emc_clk;
>  static unsigned int
>  tegra_get_intermediate(struct cpufreq_policy *policy, unsigned int index)
>  {
> -       return clk_get_rate(pll_p_clk);
> +       return clk_get_rate(pll_p_clk) / 1000; /* kHz */
>  }
>  
>  static int
>  tegra_target_intermediate(struct cpufreq_policy *policy, unsigned int frequency)
>  {
> +       WARN_ON(frequency != clk_get_rate(pll_p_clk) / 1000);
> +
> +       /*
> +        * Take an extra reference to the main pll so it doesn't turn
> +        * off when we move the cpu off of it
> +        */
> +       clk_prepare_enable(pll_x_clk);
> +
>         return clk_set_parent(cpu_clk, pll_p_clk);
> +       /* FIXME: if error, remove pll_x reference */
>  }
>  
>  static int tegra_target(struct cpufreq_policy *policy, unsigned int index)
> @@ -74,16 +83,10 @@ static int tegra_target(struct cpufreq_policy *policy, unsigned int index)
>         else
>                 clk_set_rate(emc_clk, 100000000);  /* emc 50Mhz */
>  
> -       /*
> -        * Take an extra reference to the main pll so it doesn't turn
> -        * off when we move the cpu off of it
> -        */
> -       clk_prepare_enable(pll_x_clk);
> -
>         if (rate == clk_get_rate(pll_p_clk))
>                 goto out;
>  
> -       ret = clk_set_rate(pll_x_clk, rate);
> +       ret = clk_set_rate(pll_x_clk, rate * 1000);
>         if (ret) {
>                 pr_err("Failed to change pll_x to %lu\n", rate);
>                 goto out;

