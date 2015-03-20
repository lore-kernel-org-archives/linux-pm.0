From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/6] clocksource/sh_cmt.c: Fix !HAS_IOMEM build
Date: Fri, 20 Mar 2015 15:05:37 +0100
Message-ID: <550C2931.3010702@linaro.org>
References: <1426541230-928-1-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:33344 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158AbbCTOFm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2015 10:05:42 -0400
Received: by weop45 with SMTP id p45so82998079weo.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2015 07:05:41 -0700 (PDT)
In-Reply-To: <1426541230-928-1-git-send-email-richard@nod.at>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org, linux-pm@vger.kernel.org, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, jassisinghbrar@gmail.com, pmeerw@pmeerw.net, lars@metafoo.de, knaack.h@gmx.de, jic23@kernel.org, tglx@linutronix.de

On 03/16/2015 10:27 PM, Richard Weinberger wrote:
> Fixes:
> drivers/clocksource/sh_cmt.c: In function =E2=80=98sh_cmt_map_memory=E2=
=80=99:
> drivers/clocksource/sh_cmt.c:920:2: error: implicit declaration of fu=
nction =E2=80=98ioremap_nocache=E2=80=99 [-Werror=3Dimplicit-function-d=
eclaration]
>    cmt->mapbase =3D ioremap_nocache(mem->start, resource_size(mem));
>    ^
> drivers/clocksource/sh_cmt.c:920:15: warning: assignment makes pointe=
r from integer without a cast [enabled by default]
>    cmt->mapbase =3D ioremap_nocache(mem->start, resource_size(mem));
>                 ^
> drivers/clocksource/sh_cmt.c: In function =E2=80=98sh_cmt_setup=E2=80=
=99:
> drivers/clocksource/sh_cmt.c:1034:2: error: implicit declaration of f=
unction =E2=80=98iounmap=E2=80=99 [-Werror=3Dimplicit-function-declarat=
ion]
>    iounmap(cmt->mapbase);
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
> index 68161f7..c948f4e 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -192,6 +192,7 @@ config SYS_SUPPORTS_EM_STI
>   config SH_TIMER_CMT
>   	bool "Renesas CMT timer driver" if COMPILE_TEST
>   	depends on GENERIC_CLOCKEVENTS
> +	depends on HAS_IOMEM
>   	default SYS_SUPPORTS_SH_CMT
>   	help
>   	  This enables build of a clocksource and clockevent driver for
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

