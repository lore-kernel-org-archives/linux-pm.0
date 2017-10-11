From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2] PM / OPP: add missing of_node_put() for
 of_get_cpu_node()
Date: Wed, 11 Oct 2017 13:20:22 -0700
Message-ID: <20171011202011.GB25302@codeaurora.org>
References: <1507632519-19648-1-git-send-email-sudeep.holla@arm.com>
 <1507716661-27146-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56626 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752337AbdJKUUZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Oct 2017 16:20:25 -0400
Content-Disposition: inline
In-Reply-To: <1507716661-27146-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 10/11, Sudeep Holla wrote:
> @@ -603,7 +603,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
> @@ -614,10 +614,12 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
>  		/* Get OPP descriptor node */
>  		tmp_np = _opp_of_get_opp_desc_node(cpu_np);
>  		if (!tmp_np) {
> +			of_node_put(cpu_np);
>  			pr_err("%pOF: Couldn't find opp node\n", cpu_np);
>  			ret = -ENOENT;
>  			goto put_cpu_node;
>  		}
> +		of_node_put(cpu_np);
> 

Why not?


		tmp_np = _opp_of_get_opp_desc_node(cpu_np);
		of_node_put(cpu_np);
		if (!tmp_np) {
			pr_err("%pOF: Couldn't find opp node\n", cpu_np);
			ret = -ENOENT;
			goto put_cpu_node;
		}

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
