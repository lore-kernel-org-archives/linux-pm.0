From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH V3 2/5] thermal: bcm2835: add thermal driver for bcm2835 soc
Date: Tue, 31 May 2016 12:52:22 -0700
Message-ID: <87mvn6qa2x.fsf@eliezer.anholt.net>
References: <1463495753-967-1-git-send-email-kernel@martin.sperl.org> <1463495753-967-3-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463495753-967-3-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
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
>
> ChangeLog:
>  V1 -> V2: added specific settings depending on compatiblity
> 	   added trip point based on register
> 	   setting up ctrl-register if HW is not enabled by firmware
> 	     as per recommendation of Eric (untested)
> 	   check that clock frequency is in range
> 	     (1.9 - 5MHz - as per comment in clk-bcm2835.c)
> ---

> diff --git a/drivers/thermal/bcm/Makefile b/drivers/thermal/bcm/Makefile
> new file mode 100644
> index 0000000..13456d2
> --- /dev/null
> +++ b/drivers/thermal/bcm/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_BCM2835_THERMAL)		:= bcm2835_thermal.o
> diff --git a/drivers/thermal/bcm/bcm2835_thermal.c b/drivers/thermal/bcm/bcm2835_thermal.c
> new file mode 100644
> index 0000000..73138cb
> --- /dev/null
> +++ b/drivers/thermal/bcm/bcm2835_thermal.c

> +static const struct of_device_id bcm2835_thermal_of_match_table[];
> +static int bcm2835_thermal_probe(struct platform_device *pdev)
> +{

> +	/* enable clock and check rate */
> +	clk_prepare_enable(data->clk);
> +	rate = clk_get_rate(data->clk);
> +	if ((rate < 1920000) || (rate > 5000000)) {
> +		dev_warn(&pdev->dev,
> +			 "Clock %pCn is running at %pCr Hz, which is outside the recommended range of 1.9 to 5.0 MHz\n",
> +			 data->clk, data->clk);
> +	}
> +
> +	/* register it */
> +	tz = thermal_zone_device_register("bcm2835_thermal",
> +					  1, 0, data,
> +					  &bcm2835_thermal_ops,
> +					  NULL, 0, 0);

I notice that the polling_delay is set to 0, but we're not using
interrupts to trigger the trip.  Is it valid to expose a trip without a
polling_delay or interrupts?  Should passive_delay be set as well?

This is up to the thermal maintainers.  As far as I'm concerned, it's:

Acked-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>

One it lands I'll pull the defconfig and DT bits.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXTet2AAoJELXWKTbR/J7oEmEP/A1xYhCWiI+u3U+l4BQlirmK
FF5V+X8YC1jGLKmat81WeCkhplnpDdZsCiOchLN4qLDEQJK17bY3BY3lUt+7bmgC
cElaNw2AKR1D8fZuewkFtQ7prnB765p8LTg88VhyJ3XFxAJ1P5KourAwaSq6Vi+D
kFdWnXJYTQ8+KzxwQBieGzJV5filXayOsi+rNl6e4Ag788JW99kl1uKLUkInNQJj
5uGus9y06+tfe7sRk7aGehUxdYDHSEy2wZctc6R0OvOHY4k5rOMepCGGA8E4PFak
nv/ZBLQz+nOa9UJ3hSKwNAhVOXCsr3/PxoxMOjVjkBt9AXJw4VxYNEXpywCsdt07
HI0GBYnQY/xUQxHXSLP8MWG3RDPruX5wPKfaUo5zcE4TJLHIOn8276k9x5GtKI6s
nzIAuTb8Em0QNAnvPZ/baTKAXXbaji6nQWrx1NSnFdTfHTdAmNLsKGotM1/v1ZYo
asTMhiHMR5wcwDuYwFWmJDwdWLnNNy6Uzr7cYldwHhT/nHmtP8OUgo3OHcXTM99/
ynlEP9FksIH1wAC97bBNz3jrt4L6Xm7QGBFZwpvuz3YGCQdW5QlljYuWSUXtipL+
PtU4PNFeRBbvY0pEqV9GjSnn1504n/9snyOLDBXrlPtPKBllvey/eG+zZckwAz21
bCIoQ+lAIOf/v/LXp2yz
=3koQ
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
