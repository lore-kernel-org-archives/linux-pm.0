From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH v1 03/13] regulator: bd718x7 use chip specific and
 generic data structs
Date: Thu, 24 Jan 2019 10:24:54 +0000
Message-ID: <20190124102454.GA5641@sirena.org.uk>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <3fb3eab3a8a2767404588d0a0a531273fddfc659.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <20190123155121.GB7503@sirena.org.uk>
 <20190124071635.GE2559@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190124071635.GE2559@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: mazziesaccount@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, linux@roeck-us.net, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-pm@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 24, 2019 at 09:16:35AM +0200, Matti Vaittinen wrote:

> Yes. If we don't want to break the compilation between commits then
> the patches 2, 3 and 4 should be squashed into one. I sent them as
> separare changes for easier review. I can squash them and send them
> squashed if they are Ok to Lee and Stephen. Please just let me know
> whose tree I should use as the basis so I can do rebasing if needed.
> (Or is there some better way to do changes like this?)

I'd guess Lee's but check with him and Stephen.

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxJknMACgkQJNaLcl1U
h9Dtlgf/SsJMyLuFfn78Xh+NzwTORnNG0kgbZhy+ZOar3p3fo+pGb9I3n38ZSfnm
Yjr++oIq5gaGs8+0r+FsSQ0EuTOZfFkiq0zC7syPSP4JfRl67gAocUi0/drX6mxU
O9HzjoF+57LKb0a40VTVwBxy4cHxJ2fBVBabVgXpaSyR8F93P2E3USs6CbzKo0AP
KxFOXFeVwmRA4y/Jl7doUHKpEOFW6ey99iG11j3pXojvMamjEN8JMMYkaW2BBUqM
KTXbSb4GLqTQBjF9KESSZrz+nccDutK2XqUnHrg+7si69AWpkbxlfvyOv995BLXY
2XtqxvG+S+MrH1Kghsn7giXoZl6KlA==
=o2ie
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
