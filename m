From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/6] clocksource/sh_mtu2.c: Fix !HAS_IOMEM build
Date: Fri, 20 Mar 2015 15:04:52 +0100
Message-ID: <550C2904.3040702@linaro.org>
References: <1426541230-928-1-git-send-email-richard@nod.at> <1426541230-928-2-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426541230-928-2-git-send-email-richard-/L3Ra7n9ekc@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 03/16/2015 10:27 PM, Richard Weinberger wrote:
> Fixes:
> drivers/clocksource/sh_mtu2.c: In function =E2=80=98sh_mtu2_map_memor=
y=E2=80=99:
> drivers/clocksource/sh_mtu2.c:391:2: error: implicit declaration of f=
unction =E2=80=98ioremap_nocache=E2=80=99 [-Werror=3Dimplicit-function-=
declaration]
>    mtu->mapbase =3D ioremap_nocache(res->start, resource_size(res));
>    ^
> drivers/clocksource/sh_mtu2.c:391:15: warning: assignment makes point=
er from integer without a cast [enabled by default]
>    mtu->mapbase =3D ioremap_nocache(res->start, resource_size(res));
>                 ^
> drivers/clocksource/sh_mtu2.c: In function =E2=80=98sh_mtu2_setup=E2=80=
=99:
> drivers/clocksource/sh_mtu2.c:448:2: error: implicit declaration of f=
unction =E2=80=98iounmap=E2=80=99 [-Werror=3Dimplicit-function-declarat=
ion]
>    iounmap(mtu->mapbase);
>
> Signed-off-by: Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>
> ---

Thanks applied to my tree for v4.0 fix.

>   drivers/clocksource/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfi=
g
> index c948f4e..c4063a6 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -202,6 +202,7 @@ config SH_TIMER_CMT
>   config SH_TIMER_MTU2
>   	bool "Renesas MTU2 timer driver" if COMPILE_TEST
>   	depends on GENERIC_CLOCKEVENTS
> +	depends on HAS_IOMEM
>   	default SYS_SUPPORTS_SH_MTU2
>   	help
>   	  This enables build of a clockevent driver for the Multi-Function
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
