From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Fri, 23 Oct 2015 08:33:10 +0900
Message-ID: <20151022233310.GD29919@sirena.org.uk>
References: <20151018195330.GB14956@sirena.org.uk>
 <CAAObsKB2BUZ-smid45wOdAQw6h2yNqCydk+azAFNk69ewHJtZQ@mail.gmail.com>
 <5627B677.5090109@gmail.com>
 <20151021162758.GP32054@sirena.org.uk>
 <5627D6E0.5020708@gmail.com>
 <CAL_Jsq+FPtCuBnte2HTgbdpNYM=v_kLaCRcOC1kMaCQwVC=5Kw@mail.gmail.com>
 <562808AF.7090406@gmail.com>
 <CAAObsKAkyjdvNOS3+nuT0N9sudUFLsZXFtcm6Y038p+HSdsZsg@mail.gmail.com>
 <20151022144405.GC21861@kroah.com>
 <20151022150213.GT32532@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J5MfuwkIyy7RmF4Q"
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151022150213.GT32532@n2100.arm.linux.org.uk>
Sender: linux-clk-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Felipe Balbi <balbi@ti>
List-Id: linux-pm@vger.kernel.org


--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 22, 2015 at 04:02:13PM +0100, Russell King - ARM Linux wrote:

> If it was such a problem, then in the _eight_ days that this has been
> discussed so far, _someone_ would have sent some data showing the
> problem.  I think the fact is, there is no data.

> Someone prove me wrong.  Someone post the verifiable data showing that
> there is a problem to be solved here.

> Someone show what the specific failure cases are that are hampering
> vendors moving forwards.  Someone show the long boot times by way of
> kernel message log.  Someone show some evidence of the problems that
> have been alluded to.

> If no one can show some evidence, there isn't a problem here. :)

Yeah, I'm not convinced the timing is *such* a big deal either - I do
think that the log spam is a real problem but I think something much
less invasive like the interface you proposed is good for addressing
that.

--J5MfuwkIyy7RmF4Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKXI1AAoJECTWi3JdVIfQz30H/RIVYugSpt5G4di2CHITc0BQ
yoflpyMikyLfYkdFzjloKeyEodeVohF661x1e/XN7zhOOoZQD712sSW2D8yBDUT6
yrEoEHZsxe6SlCqBTUpuev2KOXoQm11HOxNsYjop+0ZDBPfYrG6xIQfu2rRlQDXM
bSYvTXMmgOb2rTVHhORTbtwgZMAXj3K9BdybHilOAyenxrbCx1uX28RgHYJQ+QDc
bJvszKCOLJSBYYdn3QFCazwYtS3RtZ4PZtR+ZTfNmliT6dzi5rWcm14n+bIInG6+
XROzzllUhwfN/h4TKFS5+6PJGCE5lu8AobnBVyoSzSqBHk4uMij6zH7YWdHyHOs=
=HDzZ
-----END PGP SIGNATURE-----

--J5MfuwkIyy7RmF4Q--
