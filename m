From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/2] thermal: cpu_cooling: use power models from the
 OPP library
Date: Wed, 17 Jan 2018 11:09:50 +0530
Message-ID: <20180117053950.GM22978@vireshk-i7>
References: <20180116165119.15168-1-quentin.perret@arm.com>
 <20180116165119.15168-3-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43815 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbeAQFjx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jan 2018 00:39:53 -0500
Received: by mail-pf0-f194.google.com with SMTP id y26so3385832pfi.10
        for <linux-pm@vger.kernel.org>; Tue, 16 Jan 2018 21:39:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180116165119.15168-3-quentin.perret@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, matthias.bgg@gmail.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, patrick.bellasi@arm.com, ionela.voinescu@arm.com, joelaf@google.com, tkjos@google.com

On 16-01-18, 16:51, Quentin Perret wrote:
> @@ -760,7 +746,7 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
>  {
>  	struct device_node *np = of_get_cpu_node(policy->cpu, NULL);
>  	struct thermal_cooling_device *cdev = NULL;
> -	u32 capacitance = 0;
> +	bool has_power;
>  
>  	if (!np) {
>  		pr_err("cpu_cooling: OF node not available for cpu%d\n",
> @@ -769,10 +755,9 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
>  	}
>  
>  	if (of_find_property(np, "#cooling-cells", NULL)) {
> -		of_property_read_u32(np, "dynamic-power-coefficient",
> -				     &capacitance);
> +		has_power = dev_pm_opp_has_power(get_cpu_device(policy->cpu));

Use of_find_property() here, as I pointed out in the other commit.

-- 
viresh
