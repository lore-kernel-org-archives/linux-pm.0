From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [patch] cpufreq: s3c2416: double free on driver init error path
Date: Thu, 09 Feb 2017 13:44:11 +0100
Message-ID: <4549666.o9M1oGfALz@diego>
References: <20170207131906.GD27416@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:36722 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751939AbdBIODB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Feb 2017 09:03:01 -0500
In-Reply-To: <20170207131906.GD27416@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org

Hi Dan,

Am Dienstag, 7. Februar 2017, 16:19:06 CET schrieb Dan Carpenter:
> The "goto err_armclk;" error path already does a clk_put(s3c_freq->hclk);
> so this is a double free.
> 
> Fixes: 34ee55075265 ("[CPUFREQ] Add S3C2416/S3C2450 cpufreq driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Interesting, you found a mistake I made 5 years ago.
It always amazes me how much time I already spent in kernel-land :-) .

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


Thanks for finding and fixing this
Heiko

> diff --git a/drivers/cpufreq/s3c2416-cpufreq.c
> b/drivers/cpufreq/s3c2416-cpufreq.c index d6d425773fa4..5b2db3c6568f 100644
> --- a/drivers/cpufreq/s3c2416-cpufreq.c
> +++ b/drivers/cpufreq/s3c2416-cpufreq.c
> @@ -400,7 +400,6 @@ static int s3c2416_cpufreq_driver_init(struct
> cpufreq_policy *policy) rate = clk_get_rate(s3c_freq->hclk);
>  	if (rate < 133 * 1000 * 1000) {
>  		pr_err("cpufreq: HCLK not at 133MHz\n");
> -		clk_put(s3c_freq->hclk);
>  		ret = -EINVAL;
>  		goto err_armclk;
>  	}


