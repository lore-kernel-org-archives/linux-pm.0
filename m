From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/2] cpuidle / calxeda: remove redundant Kconfig option
Date: Tue, 19 Mar 2013 12:49:12 +0100
Message-ID: <514850B8.70707@linaro.org>
References: <1363080476-26555-1-git-send-email-daniel.lezcano@linaro.org> <1363080476-26555-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:60633 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409Ab3CSLtR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Mar 2013 07:49:17 -0400
Received: by mail-bk0-f50.google.com with SMTP id jg9so183104bkc.37
        for <linux-pm@vger.kernel.org>; Tue, 19 Mar 2013 04:49:15 -0700 (PDT)
In-Reply-To: <1363080476-26555-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rob.herring@calxeda.com
Cc: rjw@sisk.pl, linux-pm@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org

On 03/12/2013 10:27 AM, Daniel Lezcano wrote:
> When the CPU_IDLE and the ARCH_HIGHBANK options are set it is
> pointless to define a new option CPU_IDLE_CALXEDA because it
> is redundant.
>=20
> The Makefile drivers directory contains a condition to compile
> the cpuidle drivers:
>=20
> obj-$(CONFIG_CPU_IDLE)          +=3D cpuidle/
>=20
> Hence, if CPU_IDLE is not set we won't enter this directory.
>=20
> This patch removes the useless Kconfig option and replaces the
> condition in the Makefile by CONFIG_ARCH_HIGHBANK.
>=20
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Hi Rob,

sorry I missed to add you in Cc for this patch.

Regards
  -- Daniel


>  drivers/cpuidle/Kconfig  |   10 ----------
>  drivers/cpuidle/Makefile |    2 +-
>  2 files changed, 1 insertion(+), 11 deletions(-)
>=20
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index c4cc27e..234ae65 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -30,13 +30,3 @@ config CPU_IDLE_GOV_MENU
> =20
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
>  obj-y +=3D cpuidle.o driver.o governor.o sysfs.o governors/
>  obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) +=3D coupled.o
> =20
> -obj-$(CONFIG_CPU_IDLE_CALXEDA) +=3D cpuidle-calxeda.o
> +obj-$(CONFIG_ARCH_HIGHBANK) +=3D cpuidle-calxeda.o
>  obj-$(CONFIG_ARCH_KIRKWOOD) +=3D cpuidle-kirkwood.o
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

