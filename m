From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: imx6q: Fix error handling code
Date: Mon, 10 Apr 2017 10:59:12 +0530
Message-ID: <20170410052912.GD4377@vireshk-i7>
References: <20170409073352.8227-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34837 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbdDJF3P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2017 01:29:15 -0400
Received: by mail-pg0-f41.google.com with SMTP id 81so100016860pgh.2
        for <linux-pm@vger.kernel.org>; Sun, 09 Apr 2017 22:29:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170409073352.8227-1-christophe.jaillet@wanadoo.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On 09-04-17, 09:33, Christophe JAILLET wrote:
> According to the previous error handling code, it is likely that
> 'goto out_free_opp' is expected here in order to avoid a memory leak in
> error handling path.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 7719b02e04f5..b14117dcfff5 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -255,7 +255,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
>  	if (ret) {
>  		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
> -		goto put_reg;
> +		goto out_free_opp;
>  	}
>  
>  	/* Make imx6_soc_volt array's size same as arm opp number */

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
