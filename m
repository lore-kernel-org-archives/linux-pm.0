From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: dt-platdev: drop socionext,uniphier-ld6b from
 whitelist
Date: Thu, 14 Sep 2017 14:26:55 -0700
Message-ID: <20170914212655.GD11836@ubuntu>
References: <1504021023-12459-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:55724 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbdINV1M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Sep 2017 17:27:12 -0400
Received: by mail-pf0-f179.google.com with SMTP id r71so328731pfe.12
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2017 14:27:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1504021023-12459-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org

On 30-08-17, 00:37, Masahiro Yamada wrote:
> As you see arch/arm/boot/dts/uniphier-ld6b.dtsi, it includes
> uniphier-pxs2.dtsi, which uses "operating-points-v2" property
> and whose cpufreq device is automatically created.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index a020da7940d6..c344fc1c4eb8 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -83,8 +83,6 @@ static const struct of_device_id whitelist[] __initconst = {
>  	{ .compatible = "rockchip,rk3368", },
>  	{ .compatible = "rockchip,rk3399", },
>  
> -	{ .compatible = "socionext,uniphier-ld6b", },
> -
>  	{ .compatible = "st-ericsson,u8500", },
>  	{ .compatible = "st-ericsson,u8540", },
>  	{ .compatible = "st-ericsson,u9500", },

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
