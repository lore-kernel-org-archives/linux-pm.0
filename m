From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq-dt: Delete an unnecessary check before the function call "cpufreq_cooling_unregister"
Date: Wed, 04 Feb 2015 15:42:03 +0100
Message-ID: <10630643.iI9BHrsotK@vostro.rjw.lan>
References: <5307CAA2.8060406@users.sourceforge.net> <5317A59D.4@users.sourceforge.net> <54D112A3.1050507@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52096 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751271AbbBDOTJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Feb 2015 09:19:09 -0500
In-Reply-To: <54D112A3.1050507@users.sourceforge.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

On Tuesday, February 03, 2015 07:25:39 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 3 Feb 2015 19:21:21 +0100
> 
> The cpufreq_cooling_unregister() function tests whether its argument is NULL
> and then returns immediately. Thus the test around the call is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Queued up for 3.20, thanks!

> ---
>  drivers/cpufreq/cpufreq-dt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index fde97d6..bab67db 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -320,8 +320,7 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
>  {
>  	struct private_data *priv = policy->driver_data;
>  
> -	if (priv->cdev)
> -		cpufreq_cooling_unregister(priv->cdev);
> +	cpufreq_cooling_unregister(priv->cdev);
>  	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
>  	of_free_opp_table(priv->cpu_dev);
>  	clk_put(policy->clk);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
