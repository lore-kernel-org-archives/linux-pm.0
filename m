From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Tue, 20 Oct 2015 16:36:12 +0100
Message-ID: <20151020153612.GB32054@sirena.org.uk>
References: <CAL_JsqJuu5_Osqi+X6M6UeRDZFQB+_8riYDF1gvsGayk5-4SFw@mail.gmail.com>
 <Pine.LNX.4.44L0.1510201036290.1855-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yda//aIZIMrd7mir"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1510201036290.1855-100000@iolanthe.rowland.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Rob Herring <robh@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbary>
List-Id: linux-pm@vger.kernel.org


--yda//aIZIMrd7mir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2015 at 10:40:03AM -0400, Alan Stern wrote:

> Furthermore, that applies only to devices that use synchronous suspend. =
=20
> Async suspend is becoming common, and there the only restrictions are=20
> parent-child relations plus whatever explicit requirements that drivers=
=20
> impose by calling device_pm_wait_for_dev().

Hrm, this is the first I'd noticed that feature though I see the initial
commit dates from January.  It looks like most of the users are PCs at
the minute but we should be using it more widely for embedded things,
there's definitely some cases I'm aware of where it will allow us to
remove some open coding.

It does seem like we want to be feeding dependency information we
discover for probing way into the suspend dependencies...

--yda//aIZIMrd7mir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWJl9rAAoJECTWi3JdVIfQnkIH/2GzqyZNrVrsXXUVXs+4Shdt
ktptYpVn9emNkSaj6aqYpyoVmHnvFpXnM5NLdQOURsDRCpkq5+b/yesGl7rqAqH/
THvORSPwBV0dFdb9TpLYI6dfuOxDl8ufyiMUjxM5l17G636RfipKStJBK5UGHKBK
8uGvTrUdX+9TpG5tNeC7BOjp/bGjrtKHaiyHbcBjrtUwO4kixDnVvD1qomuwIiIt
RAHlPGdo4sO6IW0I5HurTI44EWxDxASqNYD4crMFdWgbo5J86QRgzkWJ7yh2d2wm
P7eRo9qYZkqhKhMc2pKJdiZ7dTnM77cqd17uzOiNDfCRWsvCUP7+2QE2rcyDeZk=
=XKiJ
-----END PGP SIGNATURE-----

--yda//aIZIMrd7mir--
