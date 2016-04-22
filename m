From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 07/10] cpufreq: dt: Identify cpu-sharing for platforms
 without operating-points-v2
Date: Fri, 22 Apr 2016 15:27:36 -0700
Message-ID: <20160422222736.GU13149@codeaurora.org>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
 <e42f0fdd6b67461a631ca9d966a52357bbc6cc75.1461228504.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59557 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbcDVW1j (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2016 18:27:39 -0400
Content-Disposition: inline
In-Reply-To: <e42f0fdd6b67461a631ca9d966a52357bbc6cc75.1461228504.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, arnd.bergmann@linaro.org, andrew@lunn.ch, gregory.clement@free-electrons.com, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com, thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org

On 04/21, Viresh Kumar wrote:
> @@ -167,14 +167,16 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	/* Get OPP-sharing information from "operating-points-v2" bindings */
>  	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, policy->cpus);
>  	if (ret) {
> +		if (ret != -ENOENT)
> +			goto out_put_clk;
> +
>  		/*
>  		 * operating-points-v2 not supported, fallback to old method of
> -		 * finding shared-OPPs for backward compatibility.
> +		 * finding shared-OPPs for backward compatibility if the
> +		 * platform hasn't set sharing CPUs.
>  		 */
> -		if (ret == -ENOENT)
> -			opp_v1 = true;
> -		else
> -			goto out_put_clk;
> +		if (dev_pm_opp_get_sharing_cpus(cpu_dev, policy->cpus))
> +			fallback = true;

I'm sort of lost, we make the same call twice here. Why would the
return value change between the first time and the second?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
