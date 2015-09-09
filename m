From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: s5pv210: remove superfluous CONFIG_PM ifdefs
Date: Wed, 9 Sep 2015 07:57:50 +0530
Message-ID: <20150909022750.GH7639@linux>
References: <1441731732-8624-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33376 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754061AbbIIC1y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2015 22:27:54 -0400
Received: by pacex6 with SMTP id ex6so141455708pac.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2015 19:27:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1441731732-8624-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 08-09-15, 19:02, Bartlomiej Zolnierkiewicz wrote:
> CONFIG_PM ifdefs are superfluous and can be removed.
> 
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/cpufreq/s5pv210-cpufreq.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> index 9e231f5..ef5282b 100644
> --- a/drivers/cpufreq/s5pv210-cpufreq.c
> +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> @@ -576,10 +576,8 @@ static struct cpufreq_driver s5pv210_driver = {
>  	.get		= cpufreq_generic_get,
>  	.init		= s5pv210_cpu_init,
>  	.name		= "s5pv210",
> -#ifdef CONFIG_PM
>  	.suspend	= cpufreq_generic_suspend,
>  	.resume		= cpufreq_generic_suspend, /* We need to set SLEEP FREQ again */
> -#endif
>  };
>  
>  static struct notifier_block s5pv210_cpufreq_reboot_notifier = {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
