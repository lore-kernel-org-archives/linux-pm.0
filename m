From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Sun, 18 Oct 2015 20:29:31 +0100
Message-ID: <20151018192931.GY14956@sirena.org.uk>
References: <561E1378.6000906@collabora.com>
 <20151017065750.GA18607@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UNRiu6AvOPumrTuJ"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151017065750.GA18607@kroah.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Felipe Balbi <balbi@ti.com>, Jin
List-Id: linux-pm@vger.kernel.org


--UNRiu6AvOPumrTuJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2015 at 11:57:50PM -0700, Greg Kroah-Hartman wrote:

> I can't see adding calls like this all over the tree just to solve a
> bus-specific problem, you are adding of_* calls where they aren't
> needed, or wanted, at all.

This isn't bus specific, I'm not sure what makes you say that?

> What is the root-problem of your delay in device probing?  I read your
> last patch series and I can't seem to figure out what the issue is that
> this is solving in any "better" way from the existing deferred probing.

So, I don't actually have any platforms that are especially bothered by
this (at least not for my use cases) so there's a bit of educated
guessing going on here but there's two broad things I'm aware of. =20

One is that regardless of the actual performance of the system when
deferred probe goes off it splats errors all over the console which
makes it look like something is going wrong even if everything is fine
in the end.  If lots of deferred probing happens then the volume gets
big too.  People find this distracting, noisy and ugly - it obscures
actual issues and trains people to ignore errors.  I do think this is a
reasonable concern and that it's worth trying to mitigate against
deferral for this reason alone.  We don't want to just ignore the errors
and not print anything either since if the resource doesn't appear the
user needs to know what is preventing the driver from instantiating so
they can try to fix it.

The other is that if you're printing to a serial console then that's not
an especially fast operation so if you're getting lots of messages being
printed simply physically outputting them takes measurable time.  I'm
not aware of any performance concerns outside of that, but like I say
I'm not affected by this myself in any great way.  Obviously this can be
configured but not having actual errors on the console isn't super
awesome either for systems that make use of the logging there and we
don't have a good way of telling what's from deferral and what's not.

--UNRiu6AvOPumrTuJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWI/MaAAoJECTWi3JdVIfQmtEH/i0fhCiTHqE0Nz3IsEG38cvR
kYDtb3pOGWST5b/UDQjf1OQqiV4KnXG4/yudegM8Dwl3nxqNEpusHjQU2oew9a1l
VpkzeB9eHfcvCnoT+h6YgIfjIzIFcfEwbNcDC8PXOQTYoTaOTLH/0zVHvJRFN1Rs
ufcwAI28sT1bHWRWBnzh3TStrN/z6ivL7Yg9qLVTyGBLTXbWUMFXmDW2WNK11Hn0
HWJTqVAuodvvKj+FPWK/+dJSJyhwRklDN5IV5TQY3MH2BmraO/H/IqMOqPiNkp1H
IIV2+WRRW+gxa4RYD0zzKfx+rr8ipcdD/3iqx9DWwz8yC3Gs64q9qwXI4ha7NPs=
=jM4R
-----END PGP SIGNATURE-----

--UNRiu6AvOPumrTuJ--
