From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V2 3/3] cpufreq: Tegra: implement intermediate frequency
 callbacks
Date: Fri, 16 May 2014 12:52:09 -0600
Message-ID: <53765E59.6090302@wwwdotorg.org>
References: <9e1ed1bf8c3610709436fe5ef8df3a63856f8f5c.1400230695.git.viresh.kumar@linaro.org> <b3e68b08ca8175fde81ef1a85db1fde506f835b9.1400230695.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:52391 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817AbaEPSwN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 May 2014 14:52:13 -0400
In-Reply-To: <b3e68b08ca8175fde81ef1a85db1fde506f835b9.1400230695.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arvind.chauhan@arm.com, swarren@nvidia.com, nicolas.pitre@linaro.org, dianders@chromium.org, linux@arm.linux.org.uk, thomas.abraham@linaro.org, pdeschrijver@nvidia.com

On 05/16/2014 03:07 AM, Viresh Kumar wrote:
> Tegra had always been switching to intermediate frequency (pll_p_clk) since
> ever. CPUFreq core has better support for handling notifications for these
> frequencies and so we can adapt Tegra's driver to it.

> diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra-cpufreq.c

> +static int
> +tegra_target_intermediate(struct cpufreq_policy *policy, unsigned int frequency)
> +{
> +	return clk_set_parent(cpu_clk, pll_p_clk);
> +}

I think you also need to move the following code from
tegra_cpu_clk_set_rate() to the start of tegra_target_intermediate().
Otherwise, pll_x will turn off, which judging by the comment in
tegra_cpu_clk_set_rate(), shouldn't be allowed to happen:

        /*
         * Take an extra reference to the main pll so it doesn't turn
         * off when we move the cpu off of it
         */
        clk_prepare_enable(pll_x_clk);

I'll go try this version anyway in a minute...
