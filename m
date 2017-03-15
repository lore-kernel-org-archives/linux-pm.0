From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 1/2] power: supply: ltc2941-battery-gauge: Add OF
 device ID table
Date: Wed, 15 Mar 2017 22:10:22 +0100
Message-ID: <20170315211022.y4lwiniyr4ho4bxd@earth>
References: <20170315034349.8494-1-javier@osg.samsung.com>
 <20170315205518.sjzijt6likrrau7b@earth>
 <4554bede-4977-c0b3-d9d8-468b0faae3d0@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tkejqpefpalvfxo4"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751357AbdCOVKu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Mar 2017 17:10:50 -0400
Content-Disposition: inline
In-Reply-To: <4554bede-4977-c0b3-d9d8-468b0faae3d0@osg.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Mike Looijmans <mike.looijmans@topic.nl>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>


--tkejqpefpalvfxo4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Javier,

On Wed, Mar 15, 2017 at 05:59:24PM -0300, Javier Martinez Canillas wrote:
> Hello Sebastian,
>=20
> On 03/15/2017 05:55 PM, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Wed, Mar 15, 2017 at 12:43:48AM -0300, Javier Martinez Canillas wrot=
e:
> >> The driver doesn't have a struct of_device_id table but supported devi=
ces
> >> are registered via Device Trees. This is working on the assumption tha=
t a
> >> I2C device registered via OF will always match a legacy I2C device ID =
and
> >> that the MODALIAS reported will always be of the form i2c:<device>.
> >=20
> > I don't get hits for "grep -r ltc294[13]" in arch/.
> >
>=20
> There isn't a mainline DTS that use these but the compatible strings (wit=
hout a
> vendor prefix) are listed in the following DT binding document:
>=20
> Documentation/devicetree/bindings/power/supply/ltc2941.txt.

Looks like I didn't notice when I merged the binding document :(

> >> But this could change in the future so the correct approach is to have=
 an
> >> OF device ID table if the devices are registered via OF.
> >>
> >> The compatible strings don't have a vendor prefix because that's how i=
t's
> >> used currently, and changing this will be a Device Tree ABI break.
> >=20
> > I think the DT strings should have a vendor prefix.
> > So I will only queue this with an explicit Acked-By from Rob or Mark.
> >
>=20
> Yes, I agree with you. I don't know though what should happen with DT bin=
dings
> that mentions a compatible without a vendor prefix as the one for this dr=
iver.

Adding Rob, Mark (DT binding maintainers) and Mike (submitter of
the DT binding). I think we should add vendor prefix. If it is
actually used we could keep the variant without the vendor prefix
with a deprecation notice in the DT binding document.

-- Sebastian

> > -- Sebastian
> >=20
> >> Changes in v3:
> >> - Don't use of_match_ptr() to avoid build warning when CONFIG_OF is di=
sabled.
> >>
> >> Changes in v2:
> >>  Fix build warning reported by kbuild test robot.
> >> - Fix wrong compatible strings due a copy & paste error.
> >>
> >>  drivers/power/supply/ltc2941-battery-gauge.c | 19 +++++++++++++++++--
> >>  1 file changed, 17 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/po=
wer/supply/ltc2941-battery-gauge.c
> >> index 4adf2ba021ce..d3052be1bead 100644
> >> --- a/drivers/power/supply/ltc2941-battery-gauge.c
> >> +++ b/drivers/power/supply/ltc2941-battery-gauge.c
> >> @@ -9,6 +9,7 @@
> >>   */
> >>  #include <linux/kernel.h>
> >>  #include <linux/module.h>
> >> +#include <linux/of_device.h>
> >>  #include <linux/types.h>
> >>  #include <linux/errno.h>
> >>  #include <linux/swab.h>
> >> @@ -61,7 +62,7 @@ struct ltc294x_info {
> >>  	struct power_supply *supply;	/* Supply pointer */
> >>  	struct power_supply_desc supply_desc;	/* Supply description */
> >>  	struct delayed_work work;	/* Work scheduler */
> >> -	int num_regs;	/* Number of registers (chip type) */
> >> +	unsigned long num_regs;	/* Number of registers (chip type) */
> >>  	int charge;	/* Last charge register content */
> >>  	int r_sense;	/* mOhm */
> >>  	int Qlsb;	/* nAh */
> >> @@ -387,7 +388,7 @@ static int ltc294x_i2c_probe(struct i2c_client *cl=
ient,
> >> =20
> >>  	np =3D of_node_get(client->dev.of_node);
> >> =20
> >> -	info->num_regs =3D id->driver_data;
> >> +	info->num_regs =3D (unsigned long)of_device_get_match_data(&client->=
dev);
> >>  	info->supply_desc.name =3D np->name;
> >> =20
> >>  	/* r_sense can be negative, when sense+ is connected to the battery
> >> @@ -497,9 +498,23 @@ static const struct i2c_device_id ltc294x_i2c_id[=
] =3D {
> >>  };
> >>  MODULE_DEVICE_TABLE(i2c, ltc294x_i2c_id);
> >> =20
> >> +static const struct of_device_id ltc294x_i2c_of_match[] =3D {
> >> +	{
> >> +		.compatible =3D "ltc2941",
> >> +		.data =3D (void *)LTC2941_NUM_REGS
> >> +	},
> >> +	{
> >> +		.compatible =3D "ltc2943",
> >> +		.data =3D (void *)LTC2943_NUM_REGS
> >> +	},
> >> +	{ },
> >> +};
> >> +MODULE_DEVICE_TABLE(of, ltc294x_i2c_of_match);
> >> +
> >>  static struct i2c_driver ltc294x_driver =3D {
> >>  	.driver =3D {
> >>  		.name	=3D "LTC2941",
> >> +		.of_match_table =3D ltc294x_i2c_of_match,
> >>  		.pm	=3D LTC294X_PM_OPS,
> >>  	},
> >>  	.probe		=3D ltc294x_i2c_probe,
> >> --=20
> >> 2.9.3
> >>
>=20
> Best regards,
> --=20
> Javier Martinez Canillas
> Open Source Group
> Samsung Research America

--tkejqpefpalvfxo4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljJrbcACgkQ2O7X88g7
+ppsFQ//ddjFCRNPHkJS9ggFIR96XeQWx1bpWRZMLS2HiFJqWFaJu5Ca2fceC4Cb
51c4KZocrtXX7oaWjyye0PjZcvj2gorX6FWpGbaPvagX7HHSO/1L0qaNxUfO6RJU
ArpUxDH26FR0Q2x6rauKVMPr6cC/vJqPZ7bAIvGw7v/Dq6xhXevdCNKc4jUe+b+N
qddnh3DwOUTZI+XpaXiUyT2xPuPFJkaVQmrPocEAvrteuJsYQCof9g/zgXHu4/rW
TWBr+wvnovdbSV0Jpwlup2Pda1BXcIz/5ixg/1kS/DSB9QoV9KwsIFEvckpDd2h+
kRFNWNP8Te0p4VDg8ICxis7AQYDgpZP/Paco5upVM5Gj0v/4Ks26KZRcoW8yTjoJ
SDqgZW1AjnGSriy44UCTDdayEb8CSHjnClJheKGgEaQ35lTqLScwSs/2BT8uddDT
CqA9qSxxGzwD/l5y5+osFkwBRG0y6NUrnCPYnJF2N2Z+5RyE0tInDHe5jO11xQyd
0o7Y1W9k9VlkACjK1jFAqCQsDIYsh7bSAsiUleKySHNDUFNw2prnScdIvFNPTVgC
svBPQudX723dEJQYMYyfNfREIeR9ZyHnzNnO1wXXy0ewBvmQhKRsFfEJLj8Dx+YW
2iJWgspWQiwuma+DcYFKSsssTjG3DlLxkgy/QA8anJrgOlE/83E=
=o3kJ
-----END PGP SIGNATURE-----

--tkejqpefpalvfxo4--
