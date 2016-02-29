From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: qoriq: allow building as module with
 THERMAL=m
Date: Mon, 29 Feb 2016 21:56:11 +0530
Message-ID: <20160229162611.GU2791@vireshk-i7>
References: <1456761867-1742824-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35151 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754926AbcB2Q0Q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Feb 2016 11:26:16 -0500
Received: by mail-pa0-f41.google.com with SMTP id bj10so25177577pad.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Feb 2016 08:26:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1456761867-1742824-1-git-send-email-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 29-02-16, 17:04, Arnd Bergmann wrote:
> My previous patch to avoid link errors with the qoriq cpufreq
> driver disallowed all of the broken cases, but also prevented
> the driver from being built when CONFIG_THERMAL is a module.
> 
> This changes the dependency to allow the cpufreq driver to
> also be a module in this case, just not built-in.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: cpufreq: qoriq depends on thermal
> ---
> 
> If possible, please fold this change directly into the previous
> commit
> 
>  drivers/cpufreq/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index ca05037dd565..d5e11d24f72b 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -297,7 +297,7 @@ endif
>  config QORIQ_CPUFREQ
>  	tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
>  	depends on OF && COMMON_CLK && (PPC_E500MC || ARM)
> -	depends on !CPU_THERMAL || THERMAL=y
> +	depends on !CPU_THERMAL || THERMAL
>  	select CLK_QORIQ
>  	help
>  	  This adds the CPUFreq driver support for Freescale QorIQ SoCs

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
