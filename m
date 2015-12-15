From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 2/8] Documentation: arm: define DT cpu capacity
 bindings
Date: Tue, 15 Dec 2015 17:17:13 +0000
Message-ID: <20151215171713.GA5727@sirena.org.uk>
References: <20151210153004.GA26758@sirena.org.uk>
 <20151210175820.GE14571@e106622-lin>
 <20151211174940.GQ5727@sirena.org.uk>
 <20151214123616.GC3308@e106622-lin>
 <20151214165928.GV5727@sirena.org.uk>
 <20151215122238.GG16007@e106622-lin>
 <20151215133951.GY5727@sirena.org.uk>
 <20151215140135.GI31299@leverpostej>
 <20151215150813.GZ5727@sirena.org.uk>
 <20151215153218.GA7228@leverpostej>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TUp3RUwt6Yfp+hcS"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151215153218.GA7228@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Juri Lelli <juri.lelli@arm.com>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Olof Johansson <olof@lixom.net>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Paul Walmsley <paul@pwsan.com>, Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
List-Id: linux-pm@vger.kernel.org


--TUp3RUwt6Yfp+hcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 15, 2015 at 03:32:19PM +0000, Mark Rutland wrote:
> On Tue, Dec 15, 2015 at 03:08:13PM +0000, Mark Brown wrote:
> > On Tue, Dec 15, 2015 at 02:01:36PM +0000, Mark Rutland wrote:

> > > I really don't want to see a table of magic numbers in the kernel.

> > Right, there's pitfalls there too although not being part of an ABI
> > does make them more manageable. =20

> I think that people are very likely to treat them exactly like an ABI,
> w.r.t. any regressions in performance that result from their addition,
> modification, or removal. That becomes really horrible when new CPUs
> appear.

Obviously people are going to get upset if we introduce performance
regressions - but that's true always, we can also introduce problems
with numbers people have put in DT.  It seems like it'd be harder to
manage regressions due to externally provided magic numbers since
there's inherently less information there.

> > One thing it's probably helpful to establish here is how much the
> > specific numbers are going to matter in the grand scheme of things.  If
> > the specific numbers *are* super important then nobody is going to want
> > to touch them as they'll be prone to getting tweaked.  If instead the
> > numbers just need to be ballpark accurate so the scheduler starts off in
> > roughly the right place and the specific numbers don't matter it's a lot
> > easier and having a table in the kernel until we think of something
> > better (if that ever happens) gets a lot easier.

> I agree that we first need to figure out the importance of these
> numbers. I disagree that our first step should be to add a table.

My point there is that if we're not that concerned about the specific
number something in kernel is safer.

> > My expectation is that we just need good enough, not perfect, and that
> > seems to match what Juri is saying about the expectation that most of
> > the fine tuning is done via other knobs.

> My expectation is that if a ballpark figure is good enough, it should be
> possible to implement something trivial like bogomips / loop_per_jiffy
> calculation.

That does have the issue that we need to scale with regard to the
frequency the benchmark gets run at.  That's not an insurmountable
obstacle but it's not completely trivial either.

--TUp3RUwt6Yfp+hcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWcEsYAAoJECTWi3JdVIfQuZ0H/1DqrFL/9CdlArvGoLIlwC00
1XTMrrIYG7f+zE1CAEPUPiX3LYFPeZUIV6lukminBLOE8VCKZ7sQiJmruKaP0d/J
rCzzlgU2VSvR2kMR68cbDbDdAhmr971270Ks6BqGZBKbb7UYm/ABklOO+rvPdS+J
lhvCcK2BP9bmRj8ZK7ervwuZiSmnzDjqlZKGvntCT5ZW64QxaHzxYkjg5zLEkvR5
+dzETMvKUU+8soDj2jwH07BZre9dr21E1oE+mLVIA5WoeIXFz2x/3xFOORmNrTSV
hj6XqRfYr5FURY5eAWFYUFPW0Ivo7Ue15kYiKx9MfnOoJZjfLyjeWA2TmDq7tBI=
=J+PS
-----END PGP SIGNATURE-----

--TUp3RUwt6Yfp+hcS--
