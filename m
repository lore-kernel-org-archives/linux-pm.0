From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 7/7] MAINTAINERS: Include DA9150 files in Dialog
 Semiconductor support list.
Date: Thu, 28 Aug 2014 12:17:41 +0100
Message-ID: <20140828111741.GK24579@lee--X1>
References: <cover.1409145187.git.Adam.Thomson.Opensource@diasemi.com>
 <09b13677b1e2d1cf02e4eb43e2777f8081ec9597.1409145187.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <09b13677b1e2d1cf02e4eb43e2777f8081ec9597.1409145187.git.Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thu, 28 Aug 2014, Adam Thomson wrote:

> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

> diff --git a/MAINTAINERS b/MAINTAINERS
> index aefa948..6dc0aee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2883,12 +2883,15 @@ S:	Supported
>  F:	Documentation/hwmon/da90??
>  F:	drivers/gpio/gpio-da90??.c
>  F:	drivers/hwmon/da90??-hwmon.c
> +F:	drivers/iio/adc/da91??-*.c
>  F:	drivers/input/misc/da90??_onkey.c
>  F:	drivers/input/touchscreen/da9052_tsi.c
>  F:	drivers/leds/leds-da90??.c
>  F:	drivers/mfd/da903x.c
>  F:	drivers/mfd/da90??-*.c
> +F:	drivers/mfd/da91??-*.c
>  F:	drivers/power/da9052-battery.c
> +F:	drivers/power/da91??-*.c
>  F:	drivers/regulator/da903x.c
>  F:	drivers/regulator/da9???-regulator.[ch]
>  F:	drivers/rtc/rtc-da90??.c
> @@ -2898,6 +2901,7 @@ F:	include/linux/mfd/da903x.h
>  F:	include/linux/mfd/da9052/
>  F:	include/linux/mfd/da9055/
>  F:	include/linux/mfd/da9063/
> +F:	include/linux/mfd/da9150/
>  F:	include/sound/da[79]*.h
>  F:	sound/soc/codecs/da[79]*.[ch]
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
