From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] regulator: max77693: Also manipulate the fast charge
 current
Date: Tue, 27 Sep 2016 09:15:02 -0700
Message-ID: <20160927161502.ygfa26xk7sdj2uot@sirena.org.uk>
References: <20160927080357.GA4394@kozik-lap>
 <878tudwixy.fsf@machinist.wiedmeyer.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bxfcqwt7t2m5uf2o"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <878tudwixy.fsf@machinist.wiedmeyer.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, cw00.choi@samsung.com, b.zolnierkie@samsung.com, lgirdwood@gmail.com, lee.jones@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--bxfcqwt7t2m5uf2o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 27, 2016 at 03:50:42PM +0200, Wolfgang Wiedmeyer wrote:

> When charging is disabled (e.g. by removing the USB cable) the charge
> current is not reset to zero. So if I expose the current by the
> CURRENT_NOW property, it incorrectly reports the current that was set
> when charging was enabled, although there is no charging going on
> anymore. So I felt the need to update the charge current every time the
> charger gets enabled or disabled.
> Initially, the charge current is set to zero, so I think it needs to be
> set at least at the beginning to enable charging.

Are you sure that the register value you're looking at is the actual
charge current right now and not just the maximum that the charger will
try to use depending on the conditions (supply available, battery
state...)?  It seems like you're acting as though it's the latter but
that's not what the chip is doing.

--bxfcqwt7t2m5uf2o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX6psFAAoJECTWi3JdVIfQXPoH/jZc65hrxBbelsBVh/zHwIsJ
1diGay8AZePQnBcMYpv+dBKSv4lekQBejQcKqum3ix1ZTntBG2doVVExKopiWziM
R5opRO/Sl0TrXb/ZZr/vBah9Td8eiA4v2khzw/zNAuwRe9fY7NfIRMTxWDBrRqxT
ijQaB3XR6772nwrzc+riJ6SjE8T631/Gu2GBgaBu+CBt8gPsTuoegzUX6bIpfb8Y
9sQRTuz1ETiBNzwUUfSoIUHPLiCzsApqwxQjGZ0+drUNArzMHT1RZ0AhOUogPU7k
SIvCIMY1YVhxRWtTD/BKqU8PWhazlOEecqQB90KZrLw0m9bNLCgArsGxrZG/XtA=
=fw8D
-----END PGP SIGNATURE-----

--bxfcqwt7t2m5uf2o--
