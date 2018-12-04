From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 06/14] regulator: axp20x: add software based soft_start
 for AXP209 LDO3
Date: Tue, 4 Dec 2018 15:09:54 +0000
Message-ID: <20181204150954.GC6809@sirena.org.uk>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <41cb1b4dac3a15595c89fa962b78d3f68f370021.1543245984.git-series.plaes@plaes.org>
 <20181127093619.72ensythkx2mhdf5@flea>
 <20181204133144.eqd3dk3jgqm4fbk4@plaes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181204133144.eqd3dk3jgqm4fbk4@plaes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Priit Laes <plaes@plaes.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>
List-Id: linux-pm@vger.kernel.org


--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 04, 2018 at 01:31:44PM +0000, Priit Laes wrote:

> Yes, makes sense. Although, should we then also distinguish between
> regulators which support soft-start in hardware and devices which emulate
> it by delay, like in this case?

Drivers should not be emulating soft start, if they need a ramp delay
they should set that in their descriptor and let the framework do it.

--qjNfmADvan18RZcF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwGmMEACgkQJNaLcl1U
h9CpFQf/SOm+w6bfzdiV1mRAj1uTKpc8/3V/4pVfrGTWO1zcbprN9Bhwx/eucEeR
hNTs3C6ApYsMW3cYqgbc/FhcNvsTCF4dLs73wkRpTOYV011dtkvJfnyFJZ0gD1ko
R+G/vg+PO7DAogzZVPbU2/LezobGagpma578ucZVUdesyv4PVOx6RB4Llg07sfIn
NFGEMfRjjOziJpg24raKgigiZBx54Cz9q7e0b19pJAeYl+Xb1I05QNN2C66Vf853
ZdLfvbyC+4ucB02jZmydtJqf1YYG58KwcI+2wcx4CCYxzbC7pP3yVGfUxlzLxZjR
0+ZWUI+2xKFwR1VBuHpWQJ9whgroQg==
=cKg0
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--
