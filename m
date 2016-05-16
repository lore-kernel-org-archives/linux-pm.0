From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] driver: cpufreq: simplified goto out in
 cpufreq_register_driver
Date: Mon, 16 May 2016 16:40:19 +0530
Message-ID: <20160516111019.GC2832@vireshk-i7>
References: <20160516110718.GA5005@pankajguptaubtnb.spreadtrum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35180 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642AbcEPLKX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 May 2016 07:10:23 -0400
Received: by mail-pa0-f42.google.com with SMTP id gj5so6288172pac.2
        for <linux-pm@vger.kernel.org>; Mon, 16 May 2016 04:10:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160516110718.GA5005@pankajguptaubtnb.spreadtrum.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Pankaj Gupta (Pankaj Gupta)" <Pankaj.Gupta@spreadtrum.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Yinghai Lu <yinghai@kernel.org>

On 16-05-16, 11:07, Pankaj Gupta (Pankaj Gupta) wrote:
> simplified goto out in cpufreq_register_driver for increasing
> code readability
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@spreadtrum.com>
> Signed-off-by: Sanjeev Yadav <sanjeev.yadav@spreadtrum.com>
> ---
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index b87596b..0bc23f6 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2370,10 +2370,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>  
>  	register_hotcpu_notifier(&cpufreq_cpu_notifier);
>  	pr_debug("driver %s up and running\n", driver_data->name);
> -
> -out:
> -	put_online_cpus();
> -	return ret;
> +	goto out;
>  
>  err_if_unreg:
>  	subsys_interface_unregister(&cpufreq_interface);
> @@ -2383,7 +2380,9 @@ err_null_driver:
>  	write_lock_irqsave(&cpufreq_driver_lock, flags);
>  	cpufreq_driver = NULL;
>  	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> -	goto out;
> +out:
> +	put_online_cpus();
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_register_driver);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
