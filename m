From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/6] clocksource/sh_tmu.c: Fix !HAS_IOMEM build
Date: Fri, 20 Mar 2015 15:05:17 +0100
Message-ID: <550C291D.8090901@linaro.org>
References: <1426541230-928-1-git-send-email-richard@nod.at> <1426541230-928-3-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:34656 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbbCTOFV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2015 10:05:21 -0400
Received: by wegp1 with SMTP id p1so82947210weg.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2015 07:05:20 -0700 (PDT)
In-Reply-To: <1426541230-928-3-git-send-email-richard@nod.at>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org, linux-pm@vger.kernel.org, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, jassisinghbrar@gmail.com, pmeerw@pmeerw.net, lars@metafoo.de, knaack.h@gmx.de, jic23@kernel.org, tglx@linutronix.de

On 03/16/2015 10:27 PM, Richard Weinberger wrote:
> Fixes:
> drivers/clocksource/sh_tmu.c: In function =E2=80=98sh_tmu_map_memory=E2=
=80=99:
> drivers/clocksource/sh_tmu.c:506:2: error: implicit declaration of fu=
nction =E2=80=98ioremap_nocache=E2=80=99 [-Werror=3Dimplicit-function-d=
eclaration]
>    tmu->mapbase =3D ioremap_nocache(res->start, resource_size(res));
>    ^
> drivers/clocksource/sh_tmu.c:506:15: warning: assignment makes pointe=
r from integer without a cast [enabled by default]
>    tmu->mapbase =3D ioremap_nocache(res->start, resource_size(res));
>                 ^
> drivers/clocksource/sh_tmu.c: In function =E2=80=98sh_tmu_setup=E2=80=
=99:
> drivers/clocksource/sh_tmu.c:598:2: error: implicit declaration of fu=
nction =E2=80=98iounmap=E2=80=99 [-Werror=3Dimplicit-function-declarati=
on]
>    iounmap(tmu->mapbase);
>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---

Applied to my tree for v4.0 fix.

Thanks !

>   drivers/clocksource/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfi=
g
> index c4063a6..a0b036c 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -212,6 +212,7 @@ config SH_TIMER_MTU2
>   config SH_TIMER_TMU
>   	bool "Renesas TMU timer driver" if COMPILE_TEST
>   	depends on GENERIC_CLOCKEVENTS
> +	depends on HAS_IOMEM
>   	default SYS_SUPPORTS_SH_TMU
>   	help
>   	  This enables build of a clocksource and clockevent driver for
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

