From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH v1 03/13] regulator: bd718x7 use chip specific and
 generic data structs
Date: Wed, 23 Jan 2019 15:51:21 +0000
Message-ID: <20190123155121.GB7503@sirena.org.uk>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <3fb3eab3a8a2767404588d0a0a531273fddfc659.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3fb3eab3a8a2767404588d0a0a531273fddfc659.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: mazziesaccount@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, linux@roeck-us.net, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-pm@vger.kernel.org


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 22, 2019 at 11:43:28AM +0200, Matti Vaittinen wrote:
> Header rohm-bd718x7.h was split to generic and component specific
> parts. This changed the struct bd718x7. Adapt the regulator driver to
> these changes.

Acked-by: Mark Brown <broonie@kernel.org>

Does this need to be squashed into the earlier commit for bisection?

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxIjXgACgkQJNaLcl1U
h9A/Twf8Cy6U369BDxcnv/21rcw0n0Uj1AO6jYJvFLlzmp5afcCluF69AVR0MDaA
CqMU/8FU5UJ49/CUW9IP1pq3ZPiUB/6ro7fty0LmKuAvJ52BdzEXIAaSyFO/qBuI
urEIErNz+20P439mtrwRXjwelnkOvOTq1UcIqRGSFvQIgDJzHrqfwvG/gDTPz+zy
FfZ3Cwg/FzkGEy9BMxgfObERG0xQ3TMzBVjFf4AWw/aqhoU8xl6wt6lu4sy16GM+
k9/OZ0vcgINI1RW+/xedkwvvgx/OpyLpiLyxevKVxMaQIGPBRq4cBjEs39SnWo8z
PbDTVv2+1yyNZGTzEh7mg47Aic1MvQ==
=nP4q
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
