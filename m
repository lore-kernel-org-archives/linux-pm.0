From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: scpi: Add dependency on SCPI clk driver
Date: Wed, 18 Nov 2015 10:49:53 +0530
Message-ID: <20151118051953.GB7336@ubuntu>
References: <1447784059-22769-1-git-send-email-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33205 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbbKRFUM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2015 00:20:12 -0500
Received: by pabfh17 with SMTP id fh17so33839429pab.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2015 21:20:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1447784059-22769-1-git-send-email-punit.agrawal@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: sudeep.holla@arm.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, arnd@arndb.de, "Rafael J . Wysocki" <rjw@rjwysocki.net>

On 17-11-15, 18:14, Punit Agrawal wrote:
> The SCPI clk driver registers the virtual cpufreq device that kicks off
> initialisation of the SCPI cpufreq driver. Make the dependendency
> explicit in Kconfig.

That's not a dependency. Any other part of the kernel can add this
*virtual* cpufreq device to get it going.

But, we do have dependency the other way round. clk_get() will fail
for the cpufreq driver if SCPI-clk driver is missing and perhaps
that's what you need to mention in the changelog.

> Fixes: 8def31034d03 ("cpufreq: arm_big_little: add SCPI interface driver")
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/Kconfig.arm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 1582c1c..dadfdd4 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -201,7 +201,7 @@ config ARM_SA1110_CPUFREQ
>  
>  config ARM_SCPI_CPUFREQ
>          tristate "SCPI based CPUfreq driver"
> -	depends on ARM_BIG_LITTLE_CPUFREQ && ARM_SCPI_PROTOCOL
> +	depends on ARM_BIG_LITTLE_CPUFREQ && ARM_SCPI_PROTOCOL && COMMON_CLK_SCPI

This looks fine.

-- 
viresh
