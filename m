From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH V2 Resend 2/5] PM / OPP: Prefix exported opp routines
 with dev_pm_opp_
Date: Tue, 1 Sep 2015 21:03:21 +0200
Message-ID: <20150901190321.GA6123@amd>
References: <cover.1441083292.git.viresh.kumar@linaro.org>
 <7c5fd48b6e94fb84f44eb1e79d4518cbf3de6909.1441083292.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40865 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753466AbbIATDY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2015 15:03:24 -0400
Content-Disposition: inline
In-Reply-To: <7c5fd48b6e94fb84f44eb1e79d4518cbf3de6909.1441083292.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, khilman@linaro.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>

Hi!

> -EXPORT_SYMBOL_GPL(of_cpumask_init_opp_table);
> +EXPORT_SYMBOL_GPL(dev_pm_opp_cpumask_init_opp);

Well... it starts to be rather long and repetitive.

> @@ -237,7 +237,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	 *
>  	 * OPPs might be populated at runtime, don't check for error here
>  	 */
> -	of_cpumask_init_opp_table(policy->cpus);
> +	dev_pm_opp_cpumask_init_opp(policy->cpus);
>  
>  	if (need_update) {
>  		struct cpufreq_dt_platform_data *pd = cpufreq_get_driver_data();
...
> @@ -356,7 +356,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  out_free_priv:
>  	kfree(priv);
>  out_free_opp:
> -	of_cpumask_free_opp_table(policy->cpus);
> +	dev_pm_opp_cpumask_free_table(policy->cpus);
>  out_node_put:
>  	of_node_put(np);
>  out_put_reg_clk:

Is ..._free_table opposite of ..._init_opp? If so, you might want to
name them such that it is clear...

Thanks,
										Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
