From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 2/4] thermal: bcm2835: add thermal driver for bcm2835 soc
Date: Thu, 12 May 2016 16:23:46 -0700
Message-ID: <87shxmamil.fsf@eliezer.anholt.net>
References: <1463063738-11506-1-git-send-email-kernel@martin.sperl.org> <1463063738-11506-3-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463063738-11506-3-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain

kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org writes:

> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>
> Add basic thermal driver for bcm2835 SOC.
>
> This driver currently relies on the firmware setting up the
> tsense HW block and does not set it up itself.
>
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> ---
>  drivers/thermal/Kconfig               |   5 +
>  drivers/thermal/Makefile              |   1 +
>  drivers/thermal/bcm/Kconfig           |   4 +
>  drivers/thermal/bcm/Makefile          |   1 +
>  drivers/thermal/bcm/bcm2835_thermal.c | 205 ++++++++++++++++++++++++++++++++++
>  5 files changed, 216 insertions(+)
>  create mode 100644 drivers/thermal/bcm/Kconfig
>  create mode 100644 drivers/thermal/bcm/Makefile
>  create mode 100644 drivers/thermal/bcm/bcm2835_thermal.c
>

> diff --git a/drivers/thermal/bcm/bcm2835_thermal.c b/drivers/thermal/bcm/bcm2835_thermal.c
> new file mode 100644
> index 0000000..a1fdc84
> --- /dev/null
> +++ b/drivers/thermal/bcm/bcm2835_thermal.c
> @@ -0,0 +1,205 @@
> +/*
> + * Driver for Broadcom BCM2835 soc temperature sensor
> + *
> + * Copyright (C) 2015 Martin Sperl
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/thermal.h>
> +
> +#define BCM2835_TS_TSENSCTL			0x00
> +#define BCM2835_TS_TSENSSTAT			0x04
> +
> +#define BCM2835_TS_TSENSCTL_PRWDW		BIT(0)
> +#define BCM2835_TS_TSENSCTL_RSTB		BIT(1)
> +#define BCM2835_TS_TSENSCTL_CTRL		BIT(0)
> +#define BCM2835_TS_TSENSCTL_EN_INT		BIT(0)
> +#define BCM2835_TS_TSENSCTL_DIRECT		BIT(0)
> +#define BCM2835_TS_TSENSCTL_CLR_INT		BIT(0)

Bad bit definitions here.  CTRL is a field from 2:4, en_int is bit 5,
direct is bit 6, clr is bit 7.

> +#define BCM2835_TS_TSENSCTL_THOLD_SHIFT		8
> +#define BCM2835_TS_TSENSCTL_THOLD_BITS		10
> +#define BCM2835_TS_TSENSCTL_THOLD_MASK		     \
> +	GENMASK(BCM2835_TS_TSENSCTL_THOLD_BITS +     \
> +		BCM2835_TS_TSENSCTL_THOLD_SHIFT - 1, \
> +		BCM2835_TS_TSENSCTL_THOLD_SHIFT)
> +#define BCM2835_TS_TSENSCTL_RSTDELAY_SHIFT	18
> +#define BCM2835_TS_TSENSCTL_RSTDELAY_BITS	8
> +#define BCM2835_TS_TSENSCTL_REGULEN		BIT(26)
> +
> +#define BCM2835_TS_TSENSSTAT_DATA_BITS		10
> +#define BCM2835_TS_TSENSSTAT_DATA_SHIFT		0
> +#define BCM2835_TS_TSENSSTAT_DATA_MASK		     \
> +	GENMASK(BCM2835_TS_TSENSSTAT_DATA_BITS +     \
> +		BCM2835_TS_TSENSSTAT_DATA_SHIFT - 1, \
> +		BCM2835_TS_TSENSSTAT_DATA_SHIFT)

Optional: Just use GENMASK with the bit numbers and drop the BITS/SHIFT
definitions, since they aren't used.

> +#define BCM2835_TS_TSENSSTAT_VALID		BIT(10)
> +#define BCM2835_TS_TSENSSTAT_INTERRUPT		BIT(11)
> +
> +/* empirical linear approximation for conversion to temperature */
> +#define BCM2835_TS_VALUE_OFFSET			407000
> +#define BCM2835_TS_VALUE_SLOPE			-538

This matches for pi1/2.  However, apparently on Pi3 the sensor was
reporting low so the firmware adjusts the answer it up by 5C.  Not
required, but it would be nice to have a brcm,bcm2837-thermal compatible
string that increased the offset by 5C, so that we can enable this
driver right away for pi3.

> +struct bcm2835_thermal_data {
> +	void __iomem *regs;
> +	struct clk *clk;
> +	struct dentry *debugfsdir;
> +};
> +
> +static int bcm2835_thermal_get_temp(struct thermal_zone_device *tz,
> +				    int *temp)
> +{
> +	struct bcm2835_thermal_data *data = tz->devdata;
> +	u32 val = readl(data->regs + BCM2835_TS_TSENSSTAT);
> +
> +	/* mask the relevant bits */
> +	val &= BCM2835_TS_TSENSSTAT_DATA_MASK;
> +
> +	/* linear approximation */
> +	*temp = BCM2835_TS_VALUE_OFFSET +
> +		(val * BCM2835_TS_VALUE_SLOPE);
> +
> +	return 0;
> +}

You need to check if the VALID bit is set and do something appropriate
(I suspect just throw an error) if unset.

> +	/*
> +	 * for now we assume the firmware sets up the device,
> +	 * so we will not write to ctl, we just prepare the clock
> +	 */
> +	clk_prepare_enable(data->clk);

Optional setup: given the values you can read out of tsensctl set up by
the firmware currently, if at boot RSTB isn't set, then set the values
except for rstb in one writel, then OR in rstb in in the next writel.
Then the driver should be ready in case we ever get a firmware that does
less work.

Thanks for writing the driver!  With the bit definition fix and the
VALID check, I'll be ready to add a reviewed-by.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXNRCCAAoJELXWKTbR/J7ooFYP+wZXfzOv/DRe47A3uD1NKBJw
AKCk18J1QjRr/jqxPl1tVGtDNq6POgHzxiof/dRa8wX9CN1e3SHiYnfGh4gZaOhn
3mUWUguXvkbBFNdCCQjhSp3C0zYdpjBVL85H1wRYYpxyiNgyVB7O8RyV+ObypB9c
HYcPabyqY/qWfQRm2hmwNQTSCxPu6wijC3a2H+I+enXjtbeNuybAzxUFxZkwkSc9
UR9Izvn4v6DVxT+Kin8sEhdqHYH8VsLce4WzsETexNb23aTe1OonLs9A8iIlQRdz
0HFw1Fpiys9D1zFh3+szDxCjqy+zMLSYpqE+ZEMF0ZL0c3rzA16m+FqLUCoXGXgM
sEB7OzGRk3AOyEr9moziFed4fV922dWKchxEoZY2MkM+zJ450x2zueS9YjIPNvea
XmtMf+irvKE1+N4QyY2EoUrZlTsKX6qseRRQCscB0rrClpTOOs4oHlE6GjXQFx4f
ZVrtk9NUnRbqx5sd1Cm6O8mHO1UcgmOlH5t7lKoQ+8GVg50pXO735R9YT1qDW7uc
X/HG1yTh6/wITGxKjm3rk5LLTmKAhkr5z8OQkEmY3lNUhMnbMOGD1Q4A+or+xDP7
70mgExqVPvRh+c91fUNEGsLyawC9jtCGxii4op7iEdIlY6q6RRv6AOnRWFR8k2lz
dy7Utv2mFqTlIrCrk/UD
=pRq/
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
