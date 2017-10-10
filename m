From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: use of_cpu_device_node_get() instead of
 of_get_cpu_node()
Date: Tue, 10 Oct 2017 17:15:43 +0530
Message-ID: <20171010114543.GI4031@vireshk-i7>
References: <1507632519-19648-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:49055 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756205AbdJJLps (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2017 07:45:48 -0400
Received: by mail-pf0-f182.google.com with SMTP id b79so4651118pfk.5
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2017 04:45:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1507632519-19648-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 10-10-17, 11:48, Sudeep Holla wrote:
> Commit 762792913f8c ("PM / OPP: Fix get sharing CPUs when hotplug is used")
> moved away from using cpu_dev->of_node because of some limitations.
> However commit 7467c9d95989 ("of: return of_get_cpu_node from
> of_cpu_device_node_get if CPUs are not registered") added support to
> falls back to of_get_cpu_node if called if CPUs are not registered yet.
> 
> This patch moves back to use of_cpu_device_node_get in
> dev_pm_opp_of_get_sharing_cpus to avoid scanning the device tree again.
> It also adds the missing of_node_put for the CPU device nodes.
> 
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Fixes: 762792913f8c ("PM / OPP: Fix get sharing CPUs when hotplug is used")
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/base/power/opp/of.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
> index 0b718886479b..3505193043fe 100644
> --- a/drivers/base/power/opp/of.c
> +++ b/drivers/base/power/opp/of.c
> @@ -603,13 +603,14 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
>  		if (cpu == cpu_dev->id)
>  			continue;
> 
> -		cpu_np = of_get_cpu_node(cpu, NULL);
> +		cpu_np = of_cpu_device_node_get(cpu);
>  		if (!cpu_np) {
>  			dev_err(cpu_dev, "%s: failed to get cpu%d node\n",
>  				__func__, cpu);
>  			ret = -ENOENT;
>  			goto put_cpu_node;
>  		}
> +		of_node_put(cpu_np);
> 
>  		/* Get OPP descriptor node */
>  		tmp_np = _opp_of_get_opp_desc_node(cpu_np);

This line is going to use cpu_np, how can we put cpu_np before this ?

And you need to rebase this on pm/linux-next.

-- 
viresh
