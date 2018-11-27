From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 09/14] regulator: dts: add full voltage range to LDO4 on
 the Lime2
Date: Tue, 27 Nov 2018 10:38:52 +0100
Message-ID: <20181127093852.2iavgo4xipjnu25l@flea>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <0b1aa5b28cb5efe17c04150a181ef1fa4027bc55.1543245984.git-series.plaes@plaes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s266jt4lvjzpsbth"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0b1aa5b28cb5efe17c04150a181ef1fa4027bc55.1543245984.git-series.plaes@plaes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Priit Laes <plaes@plaes.org>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>
List-Id: linux-pm@vger.kernel.org


--s266jt4lvjzpsbth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2018 at 05:27:50PM +0200, Priit Laes wrote:
> From: Olliver Schinagl <oliver@schinagl.nl>
>=20
> With commit b43776d65a33b46092 ("ARM: dts: sunxi: Use axp209.dtsi for
> Olinuxino Lime2") we force them an arbitrary 2.8 volts. Granted, for
> LDO3 this may be less arbitrary, but for LDO4 this is just wrong.
>=20
> In the defense of LDO3, LDO3 is the regulator that feeds port bank E,
> which has no other purpose then a CSI/TS interface, however the case
> may still be, that the connected IO may be just as well be 3.3 volts.
> The big misnomer is however, that the schematic names GPIO-2 pin4
> LDO3_2.8V, rather then VDD-CSI0 or similar.
>=20
> This is much worse for LDO4 however, which is not referenced on any
> pin, is now set to 2.8 volts, but port bank G can also support various
> other peripherals such as UARTS etc.
>=20
> By having 2.8 volts however for LDO4, we thus now have peripherals that
> no longer function properly all of the time.
>=20
> Ideally, we want to set a supply voltage for each port bank, but the
> monolithic nature of the sunxi pinctroller currently prevents this and
> as such, the board should at least configure the LDO4 with the proper
> ranges.
>=20
> Until we can set the consumer at the port bank level, a child
> device-tree has to do something like:
>=20
> &reg_ldo4 {
>     regulator-min-microvolt =3D <3300000>;
>     regulator-max-microvolt =3D <3300000>;
> };
>=20
> While doing this the same way results in the same solution currently,
> we force the hack into the final devicetree rather then having it wrong
> at the board level.
>=20
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/b=
oot/dts/sun7i-a20-olinuxino-lime2.dts
> index ffafe97..1b9867f 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> @@ -250,9 +250,10 @@
>  };
> =20
>  &reg_ldo4 {
> -	regulator-min-microvolt =3D <2800000>;
> -	regulator-max-microvolt =3D <2800000>;
> -	regulator-name =3D "vddio-csi1";
> +	regulator-always-on;
> +	regulator-min-microvolt =3D <1250000>;
> +	regulator-max-microvolt =3D <3300000>;
> +	regulator-name =3D "vdd-io-pg";

As we discussed on the U-Boot ML already, this shouldn't be made
always-on but tied to the consumer device (the pinctrl one) instead.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--s266jt4lvjzpsbth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/0QrAAKCRDj7w1vZxhR
xZZnAPwIkVhLkkgCn/HCrcBTkkjwKsYRgF/IguR7rOKWCTFwbwEAxJShw5bv1q7y
rGkR9lCewrTvrbD4r/hWHDcD0z0CZwQ=
=gn1w
-----END PGP SIGNATURE-----

--s266jt4lvjzpsbth--
