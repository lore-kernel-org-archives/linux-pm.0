From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 2/8] Documentation: arm: define DT cpu capacity
 bindings
Date: Tue, 15 Dec 2015 17:45:16 +0000
Message-ID: <20151215174516.GB5727@sirena.org.uk>
References: <20151211174940.GQ5727@sirena.org.uk>
 <20151214123616.GC3308@e106622-lin>
 <20151214165928.GV5727@sirena.org.uk>
 <20151215122238.GG16007@e106622-lin>
 <20151215133951.GY5727@sirena.org.uk>
 <20151215140135.GI31299@leverpostej>
 <20151215150813.GZ5727@sirena.org.uk>
 <20151215153218.GA7228@leverpostej>
 <20151215171713.GA5727@sirena.org.uk>
 <20151215172837.GD8012@leverpostej>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RQipzlYdbiO9/NWI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151215172837.GD8012@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Juri Lelli <juri.lelli@arm.com>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Olof Johansson <olof@lixom.net>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Paul Walmsley <paul@pwsan.com>, Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
List-Id: linux-pm@vger.kernel.org


--RQipzlYdbiO9/NWI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 15, 2015 at 05:28:37PM +0000, Mark Rutland wrote:
> On Tue, Dec 15, 2015 at 05:17:13PM +0000, Mark Brown wrote:

> > Obviously people are going to get upset if we introduce performance
> > regressions - but that's true always, we can also introduce problems
> > with numbers people have put in DT.  It seems like it'd be harder to
> > manage regressions due to externally provided magic numbers since
> > there's inherently less information there.

> It's certainly still possible to have regressions in that case. Those
> regressions would be due to code changes in the kernel, given the DT
> didn't change.

> I'm not sure I follow w.r.t. "inherently less information", unless you
> mean trying to debug without access to that DTB?

If what the kernel knows about the system is that it's got a bunch of
cores with numbers assigned to them then all it's really got is those
numbers.  If something changes that causes problems for some systems
(eg, because the numbers have been picked poorly but in a way that
happened to work well with the old code) that's not a lot to go on, the
more we know about the system the more likely it is that we'll be able
to adjust the assumptions in whatever new thing we do that causes
problems for any particular systems where we run into trouble.

> > My point there is that if we're not that concerned about the specific
> > number something in kernel is safer.

> I don't entirely disagree there. I think an in-kernel benchmark is
> likely safer.

Yes, I think that something where we just observe the system performance
at runtime is likely one of the best solutions if we can get something
that gives reasonable results.

> > That does have the issue that we need to scale with regard to the
> > frequency the benchmark gets run at.  That's not an insurmountable
> > obstacle but it's not completely trivial either.

> If we change clock frequency, then regardless of where the information
> comes from we need to perform scaling, no?

Yes, it's just a question of making the benchmarking bit talk to the
scaling bit so we know where we're at when we do the benchmark.  Like I
say it should be doable.

> One nice thing about doing a benchmark to derive the numbers is that
> when the kernel is that when the frequency is fixed but the kernel
> cannot query it, the numbers will be representative.

Definitely.

--RQipzlYdbiO9/NWI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWcFGrAAoJECTWi3JdVIfQ1mgH+gNbzplRXvGXj4rJDQs44+IH
7BZTdfOzMhHBkp3yTRQSkRDOjZZqJxwW2VO2/u2eqopmw0DcK8dkL5NKWNJNbw4w
uFvRdtT6gHKrmnk8M7Wt2m/OSgPcpccefc/CGIr5Aa1q++PffoCRhklmzQHgzNfn
26dj1DsBojH+D0DZ8wEFYLfAYSgldjk3G/6ZXPTKbI0Tsd5SV/OsYj0qXi4ifhnE
kP4PWaNiLJFs3/vBFday+Y3V4IiVUHG+mdmEFjHqgFOT8ejtJWJif4xNONrHUVJL
wY1VMU68AHRAHj02whPcg4E9lMRLOfk9/F8jb15jpOPra3mvKOiInP4gJFyCdnE=
=oZLz
-----END PGP SIGNATURE-----

--RQipzlYdbiO9/NWI--
