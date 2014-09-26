From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: dt: fix potential double put of cpu OF node
Date: Sat, 27 Sep 2014 00:14:14 +0200
Message-ID: <1703114.zkNSWdhuh9@vostro.rjw.lan>
References: <1411738426-18375-1-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58365 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755134AbaIZVyY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Sep 2014 17:54:24 -0400
In-Reply-To: <1411738426-18375-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

On Friday, September 26, 2014 03:33:46 PM Lucas Stach wrote:
> If cpufreq_generic_init() fails we jump into the resource
> cleanup path which contains a of_node_put() call. Another
> instance of this has already been called at that time
> resulting a double decrement of the refcount.
> 
> Fix this by calling of_node_put() only after we are sure
> that nothing has gone wrong.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

-stable material?

> ---
>  drivers/cpufreq/cpufreq-dt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index e00265066a75..6bbb8b913446 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -259,7 +259,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  		else
>  			priv->cdev = cdev;
>  	}
> -	of_node_put(np);
>  
>  	priv->cpu_dev = cpu_dev;
>  	priv->cpu_reg = cpu_reg;
> @@ -270,6 +269,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	if (ret)
>  		goto out_cooling_unregister;
>  
> +	of_node_put(np);
> +
>  	return 0;
>  
>  out_cooling_unregister:
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
