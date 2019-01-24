From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 6/8] power: reset: at91-reset: add support for sam9x60 SoC
Date: Thu, 24 Jan 2019 18:11:58 +0100
Message-ID: <20190124171158.bi74cnxngsjcawwn@earth.universe>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
 <7e68a0298b8802edaead1f9c011f9c2e191ecf6a.1547629763.git.nicolas.ferre@microchip.com>
 <20190123183443.ppxdfstmau2xtodi@earth.universe>
 <a74956fc-6085-eec2-c1b8-ed116b2297d8@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3hmt5rtfj35e5bjm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a74956fc-6085-eec2-c1b8-ed116b2297d8@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas.Ferre@microchip.com
Cc: alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, linux-usb@vger.kernel.org, stern@rowland.harvard.edu, gregkh@linuxfoundation.org, robh+dt@kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--3hmt5rtfj35e5bjm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 24, 2019 at 10:34:50AM +0000, Nicolas.Ferre@microchip.com wrote:
> Hi Sebastian,
>=20
> On 23/01/2019 at 19:34, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Wed, Jan 16, 2019 at 10:57:42AM +0100, Nicolas Ferre wrote:
> >> Add support for additional reset causes and the proper compatibility
> >> string for sam9x60 SoC. The restart function is the same as the samx7.
> >>
> >> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> >> ---
> >>   drivers/power/reset/at91-reset.c | 13 +++++++++++++
> >>   1 file changed, 13 insertions(+)
> >>
> >> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at=
91-reset.c
> >> index f44a9ffcc2ab..44ca983a49a1 100644
> >> --- a/drivers/power/reset/at91-reset.c
> >> +++ b/drivers/power/reset/at91-reset.c
> >> @@ -44,6 +44,9 @@ enum reset_type {
> >>   	RESET_TYPE_WATCHDOG	=3D 2,
> >>   	RESET_TYPE_SOFTWARE	=3D 3,
> >>   	RESET_TYPE_USER		=3D 4,
> >> +	RESET_TYPE_CPU_FAIL	=3D 6,
> >> +	RESET_TYPE_XTAL_FAIL	=3D 7,
> >> +	RESET_TYPE_ULP2		=3D 8,
> >=20
> > what happened to 5? :)
>=20
> That a good question ;-)
>=20
> It's marked as "Reserved"... which opens up a whole new field of=20
> speculation :-)

Ok :)

> [..]
>=20
> >>   	{ .compatible =3D "atmel,samx7-rstc", .data =3D samx7_restart },
> >> +	{ .compatible =3D "microchip,sam9x60-rstc", .data =3D samx7_restart =
},
> >>   	{ /* sentinel */ }
> >>   };
> >>   MODULE_DEVICE_TABLE(of, at91_reset_of_match);
> >=20
> > Patch looks fine to me. But I will wait a bit with merging, so that
> > Alexandre or Ludovic have a chance to provide feedback.
>=20
> What about merging this patch with the whole series through the at91=20
> then arm-soc trees?

It seems to be possible to merge this standalone, but merging
through at91/arm-soc is also fine with me.

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

--3hmt5rtfj35e5bjm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxJ8d4ACgkQ2O7X88g7
+prYRw//eRpCrw2o9rSRDF1wuaqVT8k3sgEoM3G9V+hWk243agZ5b+ahgAG70hrw
I9eV6psmHguTnxDgmCowpaKc0r+Ep/g3wOSOJCD7Qnp9dtlyVJyPPUYfaIULKasN
MlAJp7zHydM+7o7H9hHpVDmq+X7LLX6ZXye5hbCOFjzFwfq3CAehZknRHPnOTMtZ
Mym/E+sqKemS49cBUyGxK+WDe2zQ/ZjTldaVvJ72zzwJTCqSevPZHs687uNYa0YE
K7fH1y3AtO6IDQC63nL/aZd2z/r00/2/7u9QdkgdAHI35+LtKfscyuUUxE64AERB
XXAvksjAYbEsIyMcxsFSDTrGzqg6PVxSTbXgGt08vosBaOTOhSCmxbb3THvWHWmG
uZBTHr6TSyDdti/epp0+PYocWcn5CxY2HhwqJIxFYO75o8K3jFtYefuRP8KgTccX
uiSwxWovPWj8cs3m5o87QL1kVAtsCn+Rib5pyZf8vdbmun4B3Rb01iCS1aam03oH
jvb0PQedQ/PpO5RsBOZtxihWeXhVjDPzTp4JAc8e8TAaeVVwCvCDQOW2Kcy2q9IU
fjEbQE0tFSUE6JcWriI1ZEszCLOWUdbxXv/eaxMjmAwALGYHv54WJQUMo1rlMRsu
1UMuorDWmoN6PBTMmmJR4+yWI9VSAdO8TTApCYTafu/byJh/pig=
=OZfk
-----END PGP SIGNATURE-----

--3hmt5rtfj35e5bjm--
