From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 06/10] PM / OPP: Add dev_pm_opp_get_sharing_cpus()
Date: Fri, 22 Apr 2016 15:21:06 -0700
Message-ID: <20160422222106.GP13149@codeaurora.org>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
 <63f1a01a5a5a93a316ce95953efdd320a20a9cc6.1461228504.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58192 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbcDVWVK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2016 18:21:10 -0400
Content-Disposition: inline
In-Reply-To: <63f1a01a5a5a93a316ce95953efdd320a20a9cc6.1461228504.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, andrew@lunn.ch, gregory.clement@free-electrons.com, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com, thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org

On 04/21, Viresh Kumar wrote:
> diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
> index 55cbf9bd8707..9c4eb90759fb 100644
> --- a/drivers/base/power/opp/cpu.c
> +++ b/drivers/base/power/opp/cpu.c
> @@ -329,3 +329,48 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_set_sharing_cpus);
> +
> +/**
> + * dev_pm_opp_get_sharing_cpus() - Get cpumask of CPUs sharing OPPs with @cpu_dev
> + * @cpu_dev:	CPU device for which we do this operation
> + * @cpumask:	cpumask to update with information of sharing CPUs
> + *
> + * This updates the @cpumask with CPUs that are sharing OPPs with @cpu_dev.
> + *
> + * Returns -ENODEV if OPP table isn't already present.
> + *
> + * Locking: The internal opp_table and opp structures are RCU protected.
> + * Hence this function internally uses RCU updater strategy with mutex locks
> + * to keep the integrity of the internal data structures. Callers should ensure
> + * that this function is *NOT* called under RCU protection or in contexts where
> + * mutex cannot be locked.
> + */
> +int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)

Is there a reason we use cpumask_var_t instead of struct cpumask *
here? My understanding is that cpumask_var_t is for stack
declarations.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
