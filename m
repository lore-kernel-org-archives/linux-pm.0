From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: Add Kconfig.arm and move calxeda and kirkwood
Date: Wed, 03 Jul 2013 09:38:45 +0200
Message-ID: <51D3D505.2060101@linaro.org>
References: <1372829199-27218-1-git-send-email-kpark3469@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:60334 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754228Ab3GCHi1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jul 2013 03:38:27 -0400
Received: by mail-we0-f179.google.com with SMTP id w59so5042966wes.10
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2013 00:38:26 -0700 (PDT)
In-Reply-To: <1372829199-27218-1-git-send-email-kpark3469@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kpark3469@gmail.com
Cc: linux-pm@vger.kernel.org, keun-o.park@windriver.com, rjw@sisk.pl

On 07/03/2013 07:26 AM, kpark3469@gmail.com wrote:
> From: Sahara <keun-o.park@windriver.com>
>=20
> This patch adds Kconfig.arm for cpuidle drivers for ARM. And, this
> also moves calxeda and kirkwood to Kconfig.arm. Like cpufreq menu,
> "CPU Idle" menu is added to drivers/cpuidle/Kconfig.
>=20
> Signed-off-by: Sahara <keun-o.park@windriver.com>
> ---

That sounds reasonable.

Please respin your patch on top of linux-pm-next and send it to me, I
will queue it in my tree. Rafael is not accepting any new material unti=
l
-rc1.

Thanks
  -- Daniel

>  drivers/cpuidle/Kconfig     |   11 ++++++-----
>  drivers/cpuidle/Kconfig.arm |   15 +++++++++++++++
>  drivers/cpuidle/Makefile    |    6 ++++--
>  3 files changed, 25 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/cpuidle/Kconfig.arm
>=20
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index c4cc27e..1f16116 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -1,3 +1,4 @@
> +menu "CPU Idle"
> =20
>  config CPU_IDLE
>  	bool "CPU idle PM support"
> @@ -33,10 +34,10 @@ config ARCH_NEEDS_CPU_IDLE_COUPLED
> =20
>  if CPU_IDLE
> =20
> -config CPU_IDLE_CALXEDA
> -	bool "CPU Idle Driver for Calxeda processors"
> -	depends on ARCH_HIGHBANK
> -	help
> -	  Select this to enable cpuidle on Calxeda processors.
> +menu "ARM CPU Idle Drivers"
> +depends on ARM
> +source "drivers/cpuidle/Kconfig.arm"
> +endmenu
> =20
>  endif
> +endmenu
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.ar=
m
> new file mode 100644
> index 0000000..d335dd8
> --- /dev/null
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -0,0 +1,15 @@
> +#
> +# ARM CPU Idle drivers
> +#
> +
> +config ARM_HIGHBANK_CPUIDLE
> +	bool "CPU Idle Driver for Calxeda processors"
> +	depends on ARCH_HIGHBANK
> +	help
> +	  Select this to enable cpuidle on Calxeda processors.
> +
> +config ARM_KIRKWOOD_CPUIDLE
> +	bool "CPU Idle Driver for Marvell Kirkwood SoCs"
> +	depends on ARCH_KIRKWOOD
> +	help
> +	  This adds the CPU Idle driver for Marvell Kirkwood SoCs.
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index 0d8bd55..1d7ba91 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -5,5 +5,7 @@
>  obj-y +=3D cpuidle.o driver.o governor.o sysfs.o governors/
>  obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) +=3D coupled.o
> =20
> -obj-$(CONFIG_CPU_IDLE_CALXEDA) +=3D cpuidle-calxeda.o
> -obj-$(CONFIG_ARCH_KIRKWOOD) +=3D cpuidle-kirkwood.o
> +####################################################################=
##############
> +# ARM SoC drivers
> +obj-$(CONFIG_ARM_HIGHBANK_CPUIDLE) +=3D cpuidle-calxeda.o
> +obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE) +=3D cpuidle-kirkwood.o
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

