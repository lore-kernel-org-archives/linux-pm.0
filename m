From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH V3 2/5] thermal: bcm2835: add thermal driver for bcm2835 soc
Date: Fri, 19 Aug 2016 11:59:51 -0700
Message-ID: <87inuwd1p4.fsf@eliezer.anholt.net>
References: <1463495753-967-1-git-send-email-kernel@martin.sperl.org> <1463495753-967-3-git-send-email-kernel@martin.sperl.org> <87mvn6qa2x.fsf@eliezer.anholt.net> <87r39lvs4v.fsf@eliezer.anholt.net> <1471591694.2691.39.camel@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471591694.2691.39.camel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> writes:

> On =E5=9B=9B, 2016-08-18 at 11:39 -0700, Eric Anholt wrote:
>> Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org> writes:
>>=20
>> >=20
>> > kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org writes:
>> >=20
>> > >=20
>> > > From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>> > >=20
>> > > Add basic thermal driver for bcm2835 SOC.
>> > >=20
>> > > This driver currently relies on the firmware setting up the
>> > > tsense HW block and does not set it up itself.
>> > >=20
>> > > Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>> > >=20
>> > > ChangeLog:
>> > > =C2=A0V1 -> V2: added specific settings depending on compatiblity
>> > > 	=C2=A0=C2=A0=C2=A0added trip point based on register
>> > > 	=C2=A0=C2=A0=C2=A0setting up ctrl-register if HW is not enabled by =
firmware
>> > > 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0as per recommendation of Eric (untest=
ed)
>> > > 	=C2=A0=C2=A0=C2=A0check that clock frequency is in range
>> > > 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(1.9 - 5MHz - as per comment in clk-b=
cm2835.c)
>> > > ---
>> > >=20
>> > > diff --git a/drivers/thermal/bcm/Makefile
>> > > b/drivers/thermal/bcm/Makefile
>> > > new file mode 100644
>> > > index 0000000..13456d2
>> > > --- /dev/null
>> > > +++ b/drivers/thermal/bcm/Makefile
>> > > @@ -0,0 +1 @@
>> > > +obj-$(CONFIG_BCM2835_THERMAL)		:=3D
>> > > bcm2835_thermal.o
>> > > diff --git a/drivers/thermal/bcm/bcm2835_thermal.c
>> > > b/drivers/thermal/bcm/bcm2835_thermal.c
>> > > new file mode 100644
>> > > index 0000000..73138cb
>> > > --- /dev/null
>> > > +++ b/drivers/thermal/bcm/bcm2835_thermal.c
>> > >=20
>> > > +static const struct of_device_id
>> > > bcm2835_thermal_of_match_table[];
>> > > +static int bcm2835_thermal_probe(struct platform_device *pdev)
>> > > +{
>> > >=20
>> > > +	/* enable clock and check rate */
>> > > +	clk_prepare_enable(data->clk);
>> > > +	rate =3D clk_get_rate(data->clk);
>> > > +	if ((rate < 1920000) || (rate > 5000000)) {
>> > > +		dev_warn(&pdev->dev,
>> > > +			=C2=A0"Clock %pCn is running at %pCr Hz,
>> > > which is outside the recommended range of 1.9 to 5.0 MHz\n",
>> > > +			=C2=A0data->clk, data->clk);
>> > > +	}
>> > > +
>> > > +	/* register it */
>> > > +	tz =3D thermal_zone_device_register("bcm2835_thermal",
>> > > +					=C2=A0=C2=A01, 0, data,
>> > > +					=C2=A0=C2=A0&bcm2835_thermal_ops,
>> > > +					=C2=A0=C2=A0NULL, 0, 0);
>> > I notice that the polling_delay is set to 0, but we're not using
>> > interrupts to trigger the trip.=C2=A0=C2=A0Is it valid to expose a trip
>> > without a
>> > polling_delay or interrupts?=C2=A0=C2=A0Should passive_delay be set as=
 well?
>> >=20
>> > This is up to the thermal maintainers.=C2=A0=C2=A0As far as I'm concer=
ned,
>> > it's:
>> >=20
>> > Acked-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
>> >=20
>> > One it lands I'll pull the defconfig and DT bits.
>> Ping on this question to thermal maintainers.=C2=A0=C2=A0I'd still love =
to see
>> this driver land.
>
> hmmm, how is this driver supposed to work?
> With this patch set, I think the only benefit is that we can get the
> temperature and trip point information via thermal sysfs interface, but
> kernel thermal control is a no-op here, right?

Yeah.  It seems useful to be able to get the information.  Once we land
this, I hope someone can add interrupt support so that there are actual
trip points.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJXt1coAAoJELXWKTbR/J7owQIP/3/0spqiZlaBMVcBONxQQLit
9Frcc9leUPIIJJX5ZqMHXbhUZCJvmc+aCSwKiV038F05hyq536sXoqDZFX5of/z8
03s9NUcBlQIo0Q2kJOmE81NxLUqIuYrwCztCVugv9Aiaz0+l8SsFV2D63MModsxZ
7s9QlIbuzrtwg0tjUqFOCwdGqXG+g3YuZnoqcGpoONt20RtE5zMkpYd2BKXpYlQ5
LPA/N45uMekyqmTOzvmnPPLHkiZsBVwTBNyjb4keKHfN5ODK1GfYIUqH5VrD+G4w
8T6QFhLelcxeBEsxspXQPyoRyz3s2CS3Y6QXHGNil4niMKwgCOrwZOaoHbX9a9dk
Wbq/oQVFle+cSoVl78BAG0Ptlilqh9cFAhs7gEo19k7MyvXb10b5MnFGdM9Xd9nU
x3DmW475dpene7NxabxAvIdxfMsprn0/3TUAyNNpO1oyDncAj+C3PSQr9iWqqheJ
O/JwiVQ6PcCk/sxtgyTdykslBNermNan1krry1GCcpF7MqZQO1boPbqOwBVYm0Lx
LoquV48aPiUvQVwjM4HqfcABBZFehZ5evexDc4/vIsTSoLVkBpcBT/LU/agUi2UD
B1cB6IzHWxv7fKMsV7ps5M4n+tXrV03TfQK3QlUasaL83099RI3C6IXCQn6DMRB4
iOyxnqYnestV80tvj2zJ
=+WhY
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
