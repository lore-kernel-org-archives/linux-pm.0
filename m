From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: cppc: add ACPI_PROCESSOR dependency
Date: Wed, 15 Feb 2017 09:26:54 +0530
Message-ID: <20170215035654.GI3537@vireshk-i7>
References: <20170214211934.2663689-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33580 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbdBOD46 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2017 22:56:58 -0500
Received: by mail-pg0-f42.google.com with SMTP id 204so33009033pge.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2017 19:56:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170214211934.2663689-1-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 14-02-17, 22:19, Arnd Bergmann wrote:
> Without the Kconfig dependency, we can get this warning:
> 
> warning: ACPI_CPPC_CPUFREQ selects ACPI_CPPC_LIB which has unmet direct dependencies (ACPI && ACPI_PROCESSOR)
> 
> Fixes: 5477fb3bd1e8 ("ACPI / CPPC: Add a CPUFreq driver for use with CPPC")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/Kconfig.arm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 6d87742fc5aa..74fa5c5904d3 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -268,7 +268,7 @@ config ARM_PXA2xx_CPUFREQ
>  
>  config ACPI_CPPC_CPUFREQ
>  	tristate "CPUFreq driver based on the ACPI CPPC spec"
> -	depends on ACPI
> +	depends on ACPI_PROCESSOR
>  	select ACPI_CPPC_LIB
>  	default n
>  	help

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
