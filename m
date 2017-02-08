From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [patch] cpufreq: s3c2416: double free on driver init error path
Date: Wed, 8 Feb 2017 08:54:21 +0530
Message-ID: <20170208032421.GC14503@vireshk-i7>
References: <20170207131906.GD27416@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36257 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753207AbdBHDY2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Feb 2017 22:24:28 -0500
Received: by mail-pg0-f53.google.com with SMTP id v184so44457997pgv.3
        for <linux-pm@vger.kernel.org>; Tue, 07 Feb 2017 19:24:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170207131906.GD27416@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Kukjin Kim <kgene@kernel.org>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org

On 07-02-17, 16:19, Dan Carpenter wrote:
> The "goto err_armclk;" error path already does a clk_put(s3c_freq->hclk);
> so this is a double free.
> 
> Fixes: 34ee55075265 ("[CPUFREQ] Add S3C2416/S3C2450 cpufreq driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/cpufreq/s3c2416-cpufreq.c b/drivers/cpufreq/s3c2416-cpufreq.c
> index d6d425773fa4..5b2db3c6568f 100644
> --- a/drivers/cpufreq/s3c2416-cpufreq.c
> +++ b/drivers/cpufreq/s3c2416-cpufreq.c
> @@ -400,7 +400,6 @@ static int s3c2416_cpufreq_driver_init(struct cpufreq_policy *policy)
>  	rate = clk_get_rate(s3c_freq->hclk);
>  	if (rate < 133 * 1000 * 1000) {
>  		pr_err("cpufreq: HCLK not at 133MHz\n");
> -		clk_put(s3c_freq->hclk);
>  		ret = -EINVAL;
>  		goto err_armclk;
>  	}

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
