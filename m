From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v10 0/9] support ROHM BD70528 PMIC
Date: Thu, 28 Feb 2019 11:40:26 +0000
Message-ID: <20190228114026.GA6802@sirena.org.uk>
References: <cover.1550148989.git.matti.vaittinen@fi.rohmeurope.com>
 <20190228070450.GB3773@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190228070450.GB3773@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: mazziesaccount@gmail.com, Guenter Roeck <linux@roeck-us.net>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, bogdan-petru.chircu-mare@nxp.com
List-Id: linux-pm@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 28, 2019 at 09:04:50AM +0200, Matti Vaittinen wrote:
> On Thu, Feb 14, 2019 at 03:02:37PM +0200, Matti Vaittinen wrote:

>> Patch series introducing support for ROHM BD70528 PMIC
>=20
> I was wondering if there is anything that could be done to allow the MFD
> part of this series to end up in upstream without having to wait the
> regmap-irq changes
> (https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git/commi=
t/?h=3Dtopic/irq)
>  to be merged from Linus' tree to MFD tree? If I see it correctly, the
> regmap-irq (main-irq-reg support) changes are not targeted to linux 5.1.
> To me it looks like getting them to MFD via Linus' tree will take a while.

They're targeted for v5.1 and I sent a pull request to Lee for that
branch IIRC.

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx3yKcACgkQJNaLcl1U
h9D7LQgAgBAtFp4ti3bwtZh4iVfn9N4nYX2Sy8YynfGs/Nfwxm+m+KAl+IiOOo6C
S1kWALtElOcido6myPacabi0EAyre1Q+Ne7tqUITOb4HQL0dGDpi/a1llthziX7d
ZG6Slh0JGjOlPVZ8dMyxqXzySEjtwbKUMY4FqMd9LpkQ64FCmo5WdI9R6dnu0BZn
DJjdUbHmqAbgNoxJ9M/U6mqDTXEviO2eqPhUCAnISc6GvabHA7UdRUxIzi770HjM
Zi+AFlBE8mWAGvzn3C5u0h+4dnZxCMxMpSpyGokXkL25v5MzHB7lXOpi7a37Zpvo
VBkTW0n5LezH7ejhsiqf90PtqfUptQ==
=/nOu
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
