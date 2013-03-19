From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 2/2] cpuidle / calxeda: remove redundant Kconfig option
Date: Tue, 19 Mar 2013 07:22:14 -0500
Message-ID: <51485876.307@gmail.com>
References: <1363080476-26555-1-git-send-email-daniel.lezcano@linaro.org> <1363080476-26555-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:52650 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754034Ab3CSMWS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Mar 2013 08:22:18 -0400
Received: by mail-oa0-f46.google.com with SMTP id k1so362813oag.19
        for <linux-pm@vger.kernel.org>; Tue, 19 Mar 2013 05:22:17 -0700 (PDT)
In-Reply-To: <1363080476-26555-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On 03/12/2013 04:27 AM, Daniel Lezcano wrote:
> When the CPU_IDLE and the ARCH_HIGHBANK options are set it is
> pointless to define a new option CPU_IDLE_CALXEDA because it
> is redundant.
> 
> The Makefile drivers directory contains a condition to compile
> the cpuidle drivers:
> 
> obj-$(CONFIG_CPU_IDLE)          += cpuidle/
> 
> Hence, if CPU_IDLE is not set we won't enter this directory.
> 
> This patch removes the useless Kconfig option and replaces the
> condition in the Makefile by CONFIG_ARCH_HIGHBANK.

If I have multiple platforms including highbank compiled in, but want to
disable cpuidle just for highbank, then you can't disable it at compile
time.

Also, with my PSCI support patches for highbank, it is no longer
dependent on ARCH_HIGHBANK which gives us better compile test coverage.

Rob

> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpuidle/Kconfig  |   10 ----------
>  drivers/cpuidle/Makefile |    2 +-
>  2 files changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index c4cc27e..234ae65 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -30,13 +30,3 @@ config CPU_IDLE_GOV_MENU
>  
>  config ARCH_NEEDS_CPU_IDLE_COUPLED
>  	def_bool n
> -
> -if CPU_IDLE
> -
> -config CPU_IDLE_CALXEDA
> -	bool "CPU Idle Driver for Calxeda processors"
> -	depends on ARCH_HIGHBANK
> -	help
> -	  Select this to enable cpuidle on Calxeda processors.
> -
> -endif
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index 0d8bd55..d1aba71 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -5,5 +5,5 @@
>  obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
>  obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
>  
> -obj-$(CONFIG_CPU_IDLE_CALXEDA) += cpuidle-calxeda.o
> +obj-$(CONFIG_ARCH_HIGHBANK) += cpuidle-calxeda.o
>  obj-$(CONFIG_ARCH_KIRKWOOD) += cpuidle-kirkwood.o
> 

