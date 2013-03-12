From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 1/2] cpuidle / kirkwood: remove redundant Kconfig option
Date: Tue, 12 Mar 2013 07:22:35 -0400
Message-ID: <20130312112235.GE12700@titan.lakedaemon.net>
References: <1363080476-26555-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:58844 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752623Ab3CLLWn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Mar 2013 07:22:43 -0400
Content-Disposition: inline
In-Reply-To: <1363080476-26555-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On Tue, Mar 12, 2013 at 10:27:55AM +0100, Daniel Lezcano wrote:
> When the CPU_IDLE and the ARCH_KIRKWOOD options are set it is
> pointless to define a new option CPU_IDLE_KIRKWOOD because it
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
> condition in the Makefile by CONFIG_ARCH_KIRKWOOD.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/configs/kirkwood_defconfig |    1 -
>  drivers/cpuidle/Kconfig             |    6 ------
>  drivers/cpuidle/Makefile            |    2 +-
>  3 files changed, 1 insertion(+), 8 deletions(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

> 
> diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
> index 13482ea..93f3794 100644
> --- a/arch/arm/configs/kirkwood_defconfig
> +++ b/arch/arm/configs/kirkwood_defconfig
> @@ -56,7 +56,6 @@ CONFIG_AEABI=y
>  CONFIG_ZBOOT_ROM_TEXT=0x0
>  CONFIG_ZBOOT_ROM_BSS=0x0
>  CONFIG_CPU_IDLE=y
> -CONFIG_CPU_IDLE_KIRKWOOD=y
>  CONFIG_NET=y
>  CONFIG_PACKET=y
>  CONFIG_UNIX=y
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index 071e2c3..c4cc27e 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -39,10 +39,4 @@ config CPU_IDLE_CALXEDA
>  	help
>  	  Select this to enable cpuidle on Calxeda processors.
>  
> -config CPU_IDLE_KIRKWOOD
> -	bool "CPU Idle Driver for Kirkwood processors"
> -	depends on ARCH_KIRKWOOD
> -	help
> -	  Select this to enable cpuidle on Kirkwood processors.
> -
>  endif
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index 24c6e7d..0d8bd55 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -6,4 +6,4 @@ obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
>  obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
>  
>  obj-$(CONFIG_CPU_IDLE_CALXEDA) += cpuidle-calxeda.o
> -obj-$(CONFIG_CPU_IDLE_KIRKWOOD) += cpuidle-kirkwood.o
> +obj-$(CONFIG_ARCH_KIRKWOOD) += cpuidle-kirkwood.o
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
