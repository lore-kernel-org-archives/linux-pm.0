From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH, RFC 03/22] cpuidle: calxeda: select ARM_CPU_SUSPEND
Date: Thu, 02 May 2013 23:31:01 +0200
Message-ID: <5182DB15.2060006@linaro.org>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de> <1367507786-505303-4-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:39164 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758797Ab3EBVbL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2013 17:31:11 -0400
Received: by mail-we0-f177.google.com with SMTP id u3so837438wey.36
        for <linux-pm@vger.kernel.org>; Thu, 02 May 2013 14:31:09 -0700 (PDT)
In-Reply-To: <1367507786-505303-4-git-send-email-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org

On 05/02/2013 05:16 PM, Arnd Bergmann wrote:
> Like other ARM specific drivers, this one requires ARM_CPU_SUSPEND,
> as shown by this linker error:
>=20
> drivers/built-in.o: In function `calxeda_pwrdown_idle':
> drivers/cpuidle/cpuidle-calxeda.c:84: undefined reference to `cpu_sus=
pend'
> drivers/cpuidle/cpuidle-calxeda.c:86: undefined reference to `cpu_res=
ume'
>=20
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/cpuidle/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index c4cc27e..e21cdfa 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -36,6 +36,7 @@ if CPU_IDLE
>  config CPU_IDLE_CALXEDA
>  	bool "CPU Idle Driver for Calxeda processors"
>  	depends on ARCH_HIGHBANK
> +	select ARM_CPU_SUSPEND
>  	help
>  	  Select this to enable cpuidle on Calxeda processors.
> =20
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

