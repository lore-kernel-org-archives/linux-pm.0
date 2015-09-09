From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: tegra20: remove superfluous CONFIG_PM ifdefs
Date: Wed, 9 Sep 2015 07:57:35 +0530
Message-ID: <20150909022735.GG7639@linux>
References: <1441732403-7248-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33113 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbbIIC1j (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2015 22:27:39 -0400
Received: by pacex6 with SMTP id ex6so141449234pac.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2015 19:27:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1441732403-7248-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 08-09-15, 19:13, Bartlomiej Zolnierkiewicz wrote:
> CONFIG_PM ifdefs are superfluous and can be removed.
> 
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/cpufreq/tegra20-cpufreq.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
> index 8084c7f..2bd6284 100644
> --- a/drivers/cpufreq/tegra20-cpufreq.c
> +++ b/drivers/cpufreq/tegra20-cpufreq.c
> @@ -175,9 +175,7 @@ static struct cpufreq_driver tegra_cpufreq_driver = {
>  	.exit			= tegra_cpu_exit,
>  	.name			= "tegra",
>  	.attr			= cpufreq_generic_attr,
> -#ifdef CONFIG_PM
>  	.suspend		= cpufreq_generic_suspend,
> -#endif
>  };
>  
>  static int __init tegra_cpufreq_init(void)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
