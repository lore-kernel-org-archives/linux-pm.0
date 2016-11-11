From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 2/8] power: add power sequence library
Date: Fri, 11 Nov 2016 02:05:01 +0100
Message-ID: <CAJZ5v0ioqMqoaJqK0CTXafWRKoohmZSiOWKRgVZ9DR3_8+-YDw@mail.gmail.com>
References: <1478573472-29516-1-git-send-email-peter.chen@nxp.com> <1478573472-29516-3-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1478573472-29516-3-git-send-email-peter.chen-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 8, 2016 at 3:51 AM, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org> wrote:
> We have an well-known problem that the device needs to do some power
> sequence before it can be recognized by related host, the typical
> example like hard-wired mmc devices and usb devices.
>
> This power sequence is hard to be described at device tree and handled by
> related host driver, so we have created a common power sequence
> library to cover this requirement. The core code has supplied
> some common helpers for host driver, and individual power sequence
> libraries handle kinds of power sequence for devices. The pwrseq
> librares always need to allocate extra instance for compatible
> string match.
>
> pwrseq_generic is intended for general purpose of power sequence, which
> handles gpios and clocks currently, and can cover other controls in
> future. The host driver just needs to call of_pwrseq_on/of_pwrseq_off
> if only one power sequence is needed, else call of_pwrseq_on_list
> /of_pwrseq_off_list instead (eg, USB hub driver).
>
> For new power sequence library, it can add its compatible string
> to pwrseq_of_match_table, then the pwrseq core will match it with
> DT's, and choose this library at runtime.

In the first place, please document this stuff better than you have so
far.  To a minimum, add kerneldoc comments to all new non-trivial new
functions to document what they are for and how they are expected to
be used (especially the ones exported to drivers).

Also, is there any guidance available for people who may want to use it?

> Signed-off-by: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
> Tested-by: Maciej S. Szmigiero <mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org>
> Tested-by Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Reviewed-by: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Tested-by: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  MAINTAINERS                           |   9 ++
>  drivers/power/Kconfig                 |   1 +
>  drivers/power/Makefile                |   1 +
>  drivers/power/pwrseq/Kconfig          |  19 ++++
>  drivers/power/pwrseq/Makefile         |   2 +
>  drivers/power/pwrseq/core.c           | 191 ++++++++++++++++++++++++++++++++++
>  drivers/power/pwrseq/pwrseq_generic.c | 183 ++++++++++++++++++++++++++++++++
>  include/linux/power/pwrseq.h          |  72 +++++++++++++
>  8 files changed, 478 insertions(+)
>  create mode 100644 drivers/power/pwrseq/Kconfig
>  create mode 100644 drivers/power/pwrseq/Makefile
>  create mode 100644 drivers/power/pwrseq/core.c
>  create mode 100644 drivers/power/pwrseq/pwrseq_generic.c
>  create mode 100644 include/linux/power/pwrseq.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1cd38a7..5dab975 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9612,6 +9612,15 @@ F:       include/linux/pm_*
>  F:     include/linux/powercap.h
>  F:     drivers/powercap/
>
> +POWER SEQUENCE LIBRARY
> +M:     Peter Chen <Peter.Chen-3arQi8VN3Tc@public.gmane.org>
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
> +L:     linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/power/pwrseq/
> +F:     drivers/power/pwrseq/
> +F:     include/linux/power/pwrseq.h/
> +
>  POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS
>  M:     Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>  L:     linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 63454b5..c1bb046 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -1,3 +1,4 @@
>  source "drivers/power/avs/Kconfig"
>  source "drivers/power/reset/Kconfig"
>  source "drivers/power/supply/Kconfig"
> +source "drivers/power/pwrseq/Kconfig"
> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> index ff35c71..7db8035 100644
> --- a/drivers/power/Makefile
> +++ b/drivers/power/Makefile
> @@ -1,3 +1,4 @@
>  obj-$(CONFIG_POWER_AVS)                += avs/
>  obj-$(CONFIG_POWER_RESET)      += reset/
>  obj-$(CONFIG_POWER_SUPPLY)     += supply/
> +obj-$(CONFIG_POWER_SEQUENCE)   += pwrseq/
> diff --git a/drivers/power/pwrseq/Kconfig b/drivers/power/pwrseq/Kconfig
> new file mode 100644
> index 0000000..3859a67
> --- /dev/null
> +++ b/drivers/power/pwrseq/Kconfig
> @@ -0,0 +1,19 @@
> +#
> +# Power Sequence library
> +#
> +
> +config POWER_SEQUENCE
> +       bool
> +
> +menu "Power Sequence Support"
> +
> +config PWRSEQ_GENERIC
> +       bool "Generic power sequence control"
> +       depends on OF
> +       select POWER_SEQUENCE
> +       help
> +          It is used for drivers which needs to do power sequence
> +          (eg, turn on clock, toggle reset gpio) before the related
> +          devices can be found by hardware. This generic one can be
> +          used for common power sequence control.

I wouldn't set it up this way.

There are two problems here.

First, say a distro is going to ship a multiplatform generic kernel.
How they are going to figure out whether or not to set the new symbol
in that kernel?

Second, how users are supposed to know whether or not they will need
it even if they build the kernel by themselves?

It would be better IMO to set things up to select the new symbol from
places making use of the code depending on it.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
