From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: scpi: Depend on SCPI clk driver
Date: Wed, 18 Nov 2015 19:35:04 +0530
Message-ID: <20151118140504.GI7336@ubuntu>
References: <1447854764-9865-1-git-send-email-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35548 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbbKROFJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2015 09:05:09 -0500
Received: by pacej9 with SMTP id ej9so46004857pac.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2015 06:05:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1447854764-9865-1-git-send-email-punit.agrawal@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, arnd@arndb.de, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>

On 18-11-15, 13:52, Punit Agrawal wrote:
> The SCPI clk driver registers the virtual cpufreq device that kicks off
> initialisation of the SCPI cpufreq driver. Also, clk_get() will fail for
> the cpufreq driver if the scpi clk driver is missing.
> 
> Fix this by making the scpi cpufreq driver explicitly depend on the scpi
> clk driver.
> 
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
>          help
>  	  This adds the CPUfreq driver support for ARM big.LITTLE platforms
>  	  using SCPI protocol for CPU power management.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
