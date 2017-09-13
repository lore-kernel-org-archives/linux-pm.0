From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: dt: add support for rockchip rv1108
Date: Wed, 13 Sep 2017 12:18:40 -0700
Message-ID: <20170913191840.GB11836@ubuntu>
References: <1503306404-28876-1-git-send-email-andy.yan@rock-chips.com>
 <1503306624-28937-1-git-send-email-andy.yan@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:45483 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751885AbdIMTSm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Sep 2017 15:18:42 -0400
Received: by mail-pg0-f50.google.com with SMTP id 188so2132447pgb.2
        for <linux-pm@vger.kernel.org>; Wed, 13 Sep 2017 12:18:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1503306624-28937-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, heiko@sntech.de

On 21-08-17, 17:10, Andy Yan wrote:
> Add the compatible string to support the generic device tree
> cpufreq-dt driver on rockchip rv1108 soc.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 1c26292..2d71c09 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -69,6 +69,7 @@ static const struct of_device_id machines[] __initconst = {
>  	{ .compatible = "renesas,r8a7794", },
>  	{ .compatible = "renesas,sh73a0", },
>  
> +	{ .compatible = "rockchip,rv1108", },
>  	{ .compatible = "rockchip,rk2928", },
>  	{ .compatible = "rockchip,rk3036", },
>  	{ .compatible = "rockchip,rk3066a", },

You use operating-points-v2 or the V1 bindings for this SoC? The SoCs using
operating-points-v2 don't need such changes anymore.

-- 
viresh
