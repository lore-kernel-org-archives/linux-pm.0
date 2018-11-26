From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 07/14] dt-bindings: mfd: axp20x: Add software based
 soft_start for AXP209 LDO3
Date: Mon, 26 Nov 2018 16:58:22 +0000
Message-ID: <20181126165822.GJ9715@sirena.org.uk>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <2cd75ee27982f3be0d86104d80eaa13efeb2c65d.1543245984.git-series.plaes@plaes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sT9gWZPUZYhvPS56"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2cd75ee27982f3be0d86104d80eaa13efeb2c65d.1543245984.git-series.plaes@plaes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Priit Laes <plaes@plaes.org>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>
List-Id: linux-pm@vger.kernel.org


--sT9gWZPUZYhvPS56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2018 at 05:27:48PM +0200, Priit Laes wrote:

> +- regulator-soft-start:	enable the output at the lowest possible voltage and
> +			only then set the desired voltage
> +			AXP20x/LDO3

This is a generic property, there is no need to document it in each
device binding.

--sT9gWZPUZYhvPS56
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv8Ji0ACgkQJNaLcl1U
h9DqpQf9FKk4EThhuaS+THyVIZabmB4UD5ThkwDPpdFPWnjv6ojusIg73Aqj0lnu
orthck0CTz+PCMPEXpdguWKQ7G9RjfgT9m+alt6294RpLM42RUVWfFPkzQjPFChb
CfTd2inKqv/5lzN3yS5EDZXT4CxLzGnn6QYFQ4DCeTYriqVjRq/LzZZ2ut6KiaH2
RfB22HvE8+Lp6qSwUc8yYyZ/Ri5HfjhKuDFSkzLXXSG2c35kZTY4k20V2dwfPLp/
J6RuZMpIW7qzbtg1SNqXN98AKvSmrBXuKvAbZV+6nRe1RBkpQiQeZOBMbfMFImtX
6nHUGaVsTpsiIxyE2J/jjlEJb0eIpg==
=gYOf
-----END PGP SIGNATURE-----

--sT9gWZPUZYhvPS56--
