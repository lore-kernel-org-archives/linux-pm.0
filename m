From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 09/14] regulator: dts: add full voltage range to LDO4 on
 the Lime2
Date: Mon, 26 Nov 2018 16:57:38 +0000
Message-ID: <20181126165738.GI9715@sirena.org.uk>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <0b1aa5b28cb5efe17c04150a181ef1fa4027bc55.1543245984.git-series.plaes@plaes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SdaPbLtAangIkrMZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0b1aa5b28cb5efe17c04150a181ef1fa4027bc55.1543245984.git-series.plaes@plaes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Priit Laes <plaes@plaes.org>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>
List-Id: linux-pm@vger.kernel.org


--SdaPbLtAangIkrMZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2018 at 05:27:50PM +0200, Priit Laes wrote:

> In the defense of LDO3, LDO3 is the regulator that feeds port bank E,
> which has no other purpose then a CSI/TS interface, however the case
> may still be, that the connected IO may be just as well be 3.3 volts.
> The big misnomer is however, that the schematic names GPIO-2 pin4
> LDO3_2.8V, rather then VDD-CSI0 or similar.

In general you want to run regulators at the lowest voltage you can,
this tends to reduce power consumption.

> Ideally, we want to set a supply voltage for each port bank, but the
> monolithic nature of the sunxi pinctroller currently prevents this and
> as such, the board should at least configure the LDO4 with the proper
> ranges.

>  &reg_ldo4 {
> -	regulator-min-microvolt = <2800000>;
> -	regulator-max-microvolt = <2800000>;
> -	regulator-name = "vddio-csi1";
> +	regulator-always-on;
> +	regulator-min-microvolt = <1250000>;
> +	regulator-max-microvolt = <3300000>;
> +	regulator-name = "vdd-io-pg";
>  };

This is obviously broken even according to your analysis above - if you
have consumers for which 2.8V is too low allowing other consumers to set
even lower voltages is not going to help as soon as they start doing
that.

--SdaPbLtAangIkrMZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv8JgIACgkQJNaLcl1U
h9ChRgf/clrFo+5K7x0k5QWpV6PYmm8qGgoo8qB0vUwTCVr+WUf8MhjYsXuxULU7
EeUU0PVw+uepX1rpIZdPOGhfZ+j6BAYxQRiqm1T1mGtf8IlnQA+Tc1Yglf6ukLzs
11XdUj6xUXGQlqqghkJzN2UeDmkY/ldfpniY1endz7B3NNuGPuhjzmieDFp+o/NU
VnIHkDhDal5Iwg5Vb0f3iGKLlVnQFXpDtAKj/c9CBA0jHgWZmZgmiUC46da68eEz
dF10grh1qJZcWfrhPz26/b/l+epQTOEamU0H4jnfIxcsLxtsT2xYRKG7jxlQOtzZ
PW4lHjBRebLGl2z7PwEGh7oU9T/3Og==
=9htB
-----END PGP SIGNATURE-----

--SdaPbLtAangIkrMZ--
