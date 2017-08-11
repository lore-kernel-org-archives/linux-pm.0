From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/4] cpufreq: enable the DT cpufreq driver on the Ux500
Date: Fri, 11 Aug 2017 10:47:22 +0530
Message-ID: <20170811051722.GF3638@vireshk-i7>
References: <20170810125221.25818-1-linus.walleij@linaro.org>
 <20170810125221.25818-3-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35730 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbdHKFRZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2017 01:17:25 -0400
Received: by mail-pg0-f47.google.com with SMTP id v189so11468619pgd.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2017 22:17:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170810125221.25818-3-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Lee Jones <lee.jones@linaro.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>

On 10-08-17, 14:52, Linus Walleij wrote:
> This enables the generic DT and OPP-based cpufreq driver on the
> ST-Ericsson Ux500 series.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 1c262923fe58..d80300251bc4 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -88,6 +88,11 @@ static const struct of_device_id machines[] __initconst = {
>  	{ .compatible = "socionext,uniphier-ld11", },
>  	{ .compatible = "socionext,uniphier-ld20", },
>  
> +	{ .compatible = "st-ericsson,u8500", },
> +	{ .compatible = "st-ericsson,u8540", },
> +	{ .compatible = "st-ericsson,u9500", },
> +	{ .compatible = "st-ericsson,u9540", },
> +
>  	{ .compatible = "ti,omap2", },
>  	{ .compatible = "ti,omap3", },
>  	{ .compatible = "ti,omap4", },

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
