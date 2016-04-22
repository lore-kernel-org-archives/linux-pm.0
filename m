From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 08/10] mvebu: Use dev_pm_opp_set_sharing_cpus() to mark
 OPP tables as shared
Date: Fri, 22 Apr 2016 15:24:47 -0700
Message-ID: <20160422222447.GS13149@codeaurora.org>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
 <3808dbeda9c233026ed78fa3ec94c0bbd898875c.1461228504.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58799 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbcDVWYu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2016 18:24:50 -0400
Content-Disposition: inline
In-Reply-To: <3808dbeda9c233026ed78fa3ec94c0bbd898875c.1461228504.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, arnd.bergmann@linaro.org, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 04/21, Viresh Kumar wrote:
> @@ -683,10 +678,15 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
>  			clk_put(clk);
>  			return ret;
>  		}
> +
> +		ret = dev_pm_opp_set_sharing_cpus(cpu_dev,
> +				(struct cpumask *) cpumask_of(cpu_dev->id));

This cast doesn't look good. Why are we casting away const?
Shouldn't dev_pm_opp_set_sharing_cpus() take a const mask anyway?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
