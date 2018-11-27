From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 10/14] regulator: dts: set proper lradc vref on OLinuXino
 Lime2
Date: Tue, 27 Nov 2018 10:37:35 +0100
Message-ID: <20181127093735.amfqfcsxzreajte4@flea>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <b27515a1cfe3512253a3fbcda04a3367818520b9.1543245984.git-series.plaes@plaes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gxurvkzd35bhwvqz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b27515a1cfe3512253a3fbcda04a3367818520b9.1543245984.git-series.plaes@plaes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Priit Laes <plaes@plaes.org>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>
List-Id: linux-pm@vger.kernel.org


--gxurvkzd35bhwvqz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2018 at 05:27:51PM +0200, Priit Laes wrote:
> From: Olliver Schinagl <oliver@schinagl.nl>
>=20
> The lradc's analog reference voltage is set to 3.0 volt in the
> hardware. This is more or less set in copper for at least lradc0. Set the
> property in the dts to ensure the lradc is referenced properly.
>=20
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Priit Laes <plaes@plaes.org>

I'm not sure why that patch is part of this series, but I applied
it. Thanks!

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--gxurvkzd35bhwvqz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/0QXgAKCRDj7w1vZxhR
xU51AQCL4HIM87ezLgid7C4FmtPyydSlRECZ5jFdr6azvBmRGQEAyD2o7X+6vCvJ
LE5MPQQX3u8QI3ZZEmk3PhI/BCHJowg=
=njvD
-----END PGP SIGNATURE-----

--gxurvkzd35bhwvqz--
