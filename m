From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 2/8] Documentation: arm: define DT cpu capacity
 bindings
Date: Tue, 15 Dec 2015 15:08:13 +0000
Message-ID: <20151215150813.GZ5727@sirena.org.uk>
References: <1448288921-30307-3-git-send-email-juri.lelli@arm.com>
 <20151124020631.GA15165@rob-hp-laptop>
 <20151210153004.GA26758@sirena.org.uk>
 <20151210175820.GE14571@e106622-lin>
 <20151211174940.GQ5727@sirena.org.uk>
 <20151214123616.GC3308@e106622-lin>
 <20151214165928.GV5727@sirena.org.uk>
 <20151215122238.GG16007@e106622-lin>
 <20151215133951.GY5727@sirena.org.uk>
 <20151215140135.GI31299@leverpostej>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j8HTHu8OFBZ8oR7J"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:49028 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbbLOPIs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2015 10:08:48 -0500
Content-Disposition: inline
In-Reply-To: <20151215140135.GI31299@leverpostej>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Juri Lelli <juri.lelli@arm.com>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Olof Johansson <olof@lixom.net>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Paul Walmsley <paul@pwsan.com>, Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>


--j8HTHu8OFBZ8oR7J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 15, 2015 at 02:01:36PM +0000, Mark Rutland wrote:

> I really don't want to see a table of magic numbers in the kernel.

Right, there's pitfalls there too although not being part of an ABI
does make them more manageable. =20

One thing it's probably helpful to establish here is how much the
specific numbers are going to matter in the grand scheme of things.  If
the specific numbers *are* super important then nobody is going to want
to touch them as they'll be prone to getting tweaked.  If instead the
numbers just need to be ballpark accurate so the scheduler starts off in
roughly the right place and the specific numbers don't matter it's a lot
easier and having a table in the kernel until we think of something
better (if that ever happens) gets a lot easier.

My expectation is that we just need good enough, not perfect, and that
seems to match what Juri is saying about the expectation that most of
the fine tuning is done via other knobs.

> The relative performance and efficiency of cores will vary depending on
> uArch-specific configuration (e.g. sizing of L1/L2 caches) in addition
> to general uArch differences, and integration too (e.g. if the memory
> system gives priority to one cluster over another for whatever reason).
> I've heard of pseudo-heterogeneous platforms with different
> configuration of the same uArch across clusters.

> We also don't necessarily have the CPU clock frequencies, or the ability
> to scale them. Maybe we simply give up in that case, though.

These variables all sound like the sort of thing we can get people to
put in the DT where they matter, and the more we talk about multiple
subtle variables feeding into a single number the more this starts to
sound like tuning (with all the problems that brings, especially when
you're into things like the behaviour with the clusters competing for
resources).  Who knows, at some point the scheduler may even want to
directly act on some of these parameters?

> If we cannot rely on external information, and want this information to
> be derived by the kernel, then we need to perform some dynamic
> benchmark. That would work for future CPUs the kernel knows nothing
> about yet, and would cater for the pseudo-heterogeneous cases too.

Runtime benchmarking (or gradual tuning based on observed performance of
the scheduler) would work as well of course.  I'd expect something like
that to be part of any end point we get to here, the more the system is
able to self tune the better.

--j8HTHu8OFBZ8oR7J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWcCzdAAoJECTWi3JdVIfQnvAH/jb5R112ayaZU/DeGHU/9+Ng
r2cQeR3KYdWMthlhnLveoq1xzsCiOKHwNQRCGS2DSt5r9r0yoSud6sjXzuUqx1Mb
97euEI8noqxTn6goog6idqF1Z4XuIRz4845EAFpi7EKpqZJqA/+//pdvW+5xlN3a
8kJ1iL7DdkTnWCPYGhHI7gMAQ4WBChaBZzzm4vYYHl/V0a2dh15kK8rdJyOhaf6l
kIsvvgAcPTQ8qocI3Dygy41nFZ5W9nZWTEMguoNNzHvSOc8Uq2u3JhU3FndH1x0a
bhKSvb25fOjmfCRMr0ji6y7ItcqxpcRaMjP31+nOa0MOHc3q5W61P9alR8RW1n0=
=sAO9
-----END PGP SIGNATURE-----

--j8HTHu8OFBZ8oR7J--
