From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Tue, 20 Oct 2015 20:35:28 +0100
Message-ID: <20151020193528.GE32054@sirena.org.uk>
References: <CAAObsKChQN4gg91dCWJS_Co_MrYyBrB1J7gxgGo4hsPXNZRp3g@mail.gmail.com>
 <Pine.LNX.4.44L0.1510201311260.1855-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7fVr/IRGAG9sAW4J"
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1510201311260.1855-100000@iolanthe.rowland.org>
Sender: linux-clk-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Rob Herring <robh@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbary>
List-Id: linux-pm@vger.kernel.org


--7fVr/IRGAG9sAW4J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2015 at 01:14:46PM -0400, Alan Stern wrote:
> On Tue, 20 Oct 2015, Tomeu Vizoso wrote:

> > This iteration of the series would make this quite easy, as
> > dependencies are calculated before probes are attempted:

> > https://lkml.org/lkml/2015/6/17/311

> But what Rafael is proposing is quite general; it would apply to _all_
> dependencies as opposed to just those present in DT drivers or those=20
> affecting platform_devices.

We'll still need most of the DT bits that are there at the minute (the
ones strewn around the subsystems) AFAICT since it's at the point where
we parse the DT and work out what the dependencies are which we probably
want to do prior to getting the drivers up and will be different for
ACPI.  I think the level of DT dependency here looks a lot larger than
it actually is due to the fact that a lot of what's being modified is DT
parsing code.

--7fVr/IRGAG9sAW4J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWJpd/AAoJECTWi3JdVIfQyOUH/3aWMFomvCvS2CL4BvzIQDB4
BphbR2H9ODV06RJMlHiGXa91+iBfp+FxWHQeyoc0ySA1Jn2tzZp8YwHnkNB32MvM
lh9IOvlTQGwWOFxNNJZeExicoCW4ui3F1sQmcS3ycu9gHHUi/xdqczCFlIeJdJRX
mSuLTMmuJVsxwFPY/X7EmKZzJLG8eIHWwzkH66432AO4UpU9Bs/dZ5vPxCSCsL89
xEBG0PSdsFy/hL2Ag1zHZcu49cpEDLK/26vKrW96Ql6dklsfN5D3HDazZ4l0RE0r
5iF7s3G0fFNpopm+SgwuwWXN92NtcPiHMEfZwLFeekLgyA+fdXC8yesekx0zmVg=
=cBfe
-----END PGP SIGNATURE-----

--7fVr/IRGAG9sAW4J--
