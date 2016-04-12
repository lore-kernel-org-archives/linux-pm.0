From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/5] cpufreq: Loongson1: Use dev_get_platdata() to get
 platform_data
Date: Tue, 12 Apr 2016 10:48:24 +0530
Message-ID: <20160412051824.GQ16238@vireshk-i7>
References: <1460375759-20705-1-git-send-email-keguang.zhang@gmail.com>
 <1460375759-20705-3-git-send-email-keguang.zhang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36397 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbcDLFS2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2016 01:18:28 -0400
Received: by mail-pf0-f172.google.com with SMTP id e128so6626854pfe.3
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2016 22:18:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1460375759-20705-3-git-send-email-keguang.zhang@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 11-04-16, 19:55, Keguang Zhang wrote:
> From: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> This patch uses dev_get_platdata() to get the platform_data
> instead of referencing it directly.
> 
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> ---
>  drivers/cpufreq/loongson1-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/loongson1-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
> index 2d83744..f0d40fd 100644
> --- a/drivers/cpufreq/loongson1-cpufreq.c
> +++ b/drivers/cpufreq/loongson1-cpufreq.c
> @@ -134,7 +134,7 @@ static int ls1x_cpufreq_remove(struct platform_device *pdev)
>  
>  static int ls1x_cpufreq_probe(struct platform_device *pdev)
>  {
> -	struct plat_ls1x_cpufreq *pdata = pdev->dev.platform_data;
> +	struct plat_ls1x_cpufreq *pdata = dev_get_platdata(&pdev->dev);
>  	struct clk *clk;
>  	int ret;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
