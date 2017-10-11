From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/1] cpufreq: ti-cpufreq: add missing of_node_put()
Date: Wed, 11 Oct 2017 09:40:30 +0530
Message-ID: <20171011041030.GJ4031@vireshk-i7>
References: <1507642040-13646-1-git-send-email-zumeng.chen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:52093 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbdJKEKg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Oct 2017 00:10:36 -0400
Received: by mail-pg0-f51.google.com with SMTP id u144so335677pgb.8
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2017 21:10:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1507642040-13646-1-git-send-email-zumeng.chen@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zumeng Chen <zumeng.chen@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, d-gerlach@ti.com, tony@atomide.com

On 10-10-17, 21:27, Zumeng Chen wrote:
> call of_node_put to release the refcount of np.
> 
> Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
> ---
>  drivers/cpufreq/ti-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index ffcddcd..923317f 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -205,6 +205,7 @@ static int ti_cpufreq_init(void)
>  
>  	np = of_find_node_by_path("/");
>  	match = of_match_node(ti_cpufreq_of_match, np);
> +	of_node_put(np);
>  	if (!match)
>  		return -ENODEV;
>  

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
