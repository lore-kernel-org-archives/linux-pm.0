From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: imx: fix regulator_get error handling
Date: Sun, 18 Oct 2015 21:25:09 +0530
Message-ID: <20151018155509.GD19018@linux>
References: <56237C1C.80109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36839 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978AbbJRPzO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 18 Oct 2015 11:55:14 -0400
Received: by pacfv9 with SMTP id fv9so68896446pac.3
        for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2015 08:55:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <56237C1C.80109@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 18-10-15, 13:01, Heiner Kallweit wrote:
>  	arm_reg = regulator_get(cpu_dev, "arm");
> +	if (IS_ERR(arm_reg)) {
> +		ret = PTR_ERR(arm_reg);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(cpu_dev, "failed to get regulator arm\n");
> +		goto put_reg;

So you will error out even for other errors, but that wasn't the case
earlier. Are you sure this is what you want?

> +	}
> +
>  	pu_reg = regulator_get_optional(cpu_dev, "pu");

Why don't we do error checking for this as well ?

> +
>  	soc_reg = regulator_get(cpu_dev, "soc");
> -	if (IS_ERR(arm_reg) || IS_ERR(soc_reg)) {
> -		dev_err(cpu_dev, "failed to get regulators\n");
> -		ret = -ENOENT;
> +	if (IS_ERR(soc_reg)) {
> +		ret = PTR_ERR(soc_reg);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(cpu_dev, "failed to get regulator soc\n");
>  		goto put_reg;
>  	}
>  
> -- 
> 2.6.1

-- 
viresh
