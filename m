From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpuidle: improve governor Kconfig options
Date: Tue, 28 May 2013 13:46:58 +0200
Message-ID: <1578834.dvFIpyCvrt@vostro.rjw.lan>
References: <1369688458-9114-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:53227 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932878Ab3E1LiF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 28 May 2013 07:38:05 -0400
In-Reply-To: <1369688458-9114-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org

On Monday, May 27, 2013 11:00:58 PM Daniel Lezcano wrote:
> Each governor is suitable for different kernel configurations: the menu
> governor suits better for a tickless system, while the ladder governor fits
> better for a periodic timer tick system.
> 
> The Kconfig does not allow to [un]select a governor, thus both are compiled in
> the kernel but the init order makes the menu governor to be the last one to be
> registered, so becoming the default. The only way to switch back to the ladder
> governor is to enable the sysfs governor switch in the kernel command line.
> 
> Because it seems nobody complained about this, the menu governor is used by
> default most of the time on the system, having both governors is not really
> necessary on a tickless system but there isn't a config option to disable one
> or another governor.
> 
> Create a submenu for cpuidle and add a label for each governor, so we can see
> the option in the menu config and enable/disable it.
> 
> The governors will be enabled depending on the CONFIG_NO_HZ option:
>  - If CONFIG_NO_HZ is set, then the menu governor is selected and the ladder
>    governor is optional, defaulting to 'no'

Why not defaulting to 'yes'?  That'd be backwards compatible, wouldn't it?

>  - If CONFIG_NO_HZ is not set, then the ladder governor is selected and the
>    menu governor is optional, defaulting to 'no'

Are you sure this is not going to introduce regressions with CONFIG_NO_HZ
unset?

Rafael


> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpuidle/Kconfig |   20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index c4cc27e..90c2f39 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -1,7 +1,9 @@
>  
> -config CPU_IDLE
> +menuconfig CPU_IDLE
>  	bool "CPU idle PM support"
>  	default y if ACPI || PPC_PSERIES
> +	select CPU_IDLE_GOV_LADDER if (!NO_HZ && !NO_HZ_IDLE)
> +	select CPU_IDLE_GOV_MENU if (NO_HZ || NO_HZ_IDLE)
>  	help
>  	  CPU idle is a generic framework for supporting software-controlled
>  	  idle processor power management.  It includes modular cross-platform
> @@ -9,9 +11,10 @@ config CPU_IDLE
>  
>  	  If you're using an ACPI-enabled platform, you should say Y here.
>  
> +if CPU_IDLE
> +
>  config CPU_IDLE_MULTIPLE_DRIVERS
>          bool "Support multiple cpuidle drivers"
> -        depends on CPU_IDLE
>          default n
>          help
>           Allows the cpuidle framework to use different drivers for each CPU.
> @@ -19,24 +22,19 @@ config CPU_IDLE_MULTIPLE_DRIVERS
>           states. If unsure say N.
>  
>  config CPU_IDLE_GOV_LADDER
> -	bool
> -	depends on CPU_IDLE
> -	default y
> +	bool "Ladder governor (for periodic timer tick)"
> +	default n if (NO_HZ || NO_HZ_IDLE)
>  
>  config CPU_IDLE_GOV_MENU
> -	bool
> -	depends on CPU_IDLE && NO_HZ
> -	default y
> +	bool "Menu governor (for tickless system)"
> +	default n if (!NO_HZ && !NO_HZ_IDLE)
>  
>  config ARCH_NEEDS_CPU_IDLE_COUPLED
>  	def_bool n
>  
> -if CPU_IDLE
> -
>  config CPU_IDLE_CALXEDA
>  	bool "CPU Idle Driver for Calxeda processors"
>  	depends on ARCH_HIGHBANK
>  	help
>  	  Select this to enable cpuidle on Calxeda processors.
> -
>  endif
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
