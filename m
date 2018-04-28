From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC 05/10] i2c: s3c2410: Remove support for Exynos5440
Date: Sat, 28 Apr 2018 14:44:07 +0200
Message-ID: <20180428124407.bpc47bo7ojebahpz@ninjato>
References: <20180424203239.21885-1-krzk@kernel.org>
 <20180424203239.21885-6-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2ub5o5uu6wk62jsg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180424203239.21885-6-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tejun Heo <tj@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Russell King <linux@armlinux.org.uk>, Hans de Goede <hdegoede@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Alan Stern <stern@rowland.harvard.edu>, Greg
List-Id: linux-pm@vger.kernel.org


--2ub5o5uu6wk62jsg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 10:32:34PM +0200, Krzysztof Kozlowski wrote:
> The Exynos5440 is not actively developed, there are no development
> boards available and probably there are no real products with it.
> Remove wide-tree support for Exynos5440.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied to for-next, thanks!


--2ub5o5uu6wk62jsg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrkbJcACgkQFA3kzBSg
KbY0oBAAp5AZ22Iwc3g476LI/homGu6AP+TvzJ14ZHvvKXmBhKLST+eTqjibgy8y
ezyaVsMGoTAqZXpFAoPhMWB/ktsDNOM6QhshTyAR5EI634GhnTZ8j5quAXYwgPsL
Iugkw/DxGYGz+0iaPwvd7L4OnCHpufRomudIkx7wO5IObmbuFIAYiAvZIp6873Hq
UFWUlW4k67D+BcoYc+uVcvTteewzffXS/qyRim6TF4Xg2FKTPp9KRUjmL86xLHvl
FXDKa4djARTZz+HD0aQ27aOuv+g7yxLS9mfL4wSckymohGCtmDhHI6xdw3hyCDwM
yPElg4JICJDm4EuDjzYdYrcZlFjsXeuHN3RGaJfIRFnIhwC/CxiUnwtMosGCuWSK
BDU+esBF7qEXxherzLPJEJVPYW1z3XqLphkxoJ8Ma/9DpLDmItGythWIuMblLHWP
jWpb3DOgATifO3ZLkyNEp/6m4GMEZN29Xc81BLRgy+NMzaNPofgSflzW1QAHz8H8
qMtjIHp9zH9h4jn7LoUng1AsEBs4AW/xv5Bul8l4FhrfjSpzTCfb1+kF7QKAr8IW
0xuLrzW3GSd1/WC7BTnQMDD41d8sgd8YL8RyfFBYsst0L0TXvhgWLCLt7M40X42q
pUXIKPw/t0MR4uIsD8nQ9ZnWhb4chO2pzGSMabmZQDLeZQvGRBI=
=ObTl
-----END PGP SIGNATURE-----

--2ub5o5uu6wk62jsg--
