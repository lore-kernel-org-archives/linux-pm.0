From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH v2 0/4] CPUs capacity information for heterogeneous
 systems
Date: Tue, 19 Jan 2016 17:50:38 +0000
Message-ID: <20160119175038.GS6588@sirena.org.uk>
References: <1452262172-31861-1-git-send-email-juri.lelli@arm.com>
 <20160119150551.GI6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pA3GpxlsFRhNUARh"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:34152 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755254AbcASRuu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2016 12:50:50 -0500
Content-Disposition: inline
In-Reply-To: <20160119150551.GI6344@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com


--pA3GpxlsFRhNUARh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 19, 2016 at 04:05:51PM +0100, Peter Zijlstra wrote:
> On Fri, Jan 08, 2016 at 02:09:28PM +0000, Juri Lelli wrote:

> >     cons: - not easy to come up with a clean solution, as it seems interaction
> >             with several subsystems (e.g., cpufreq) is required
> >           - not easy to agree upon a single benchmark (that has to be both
> >             representative and simple enough to run at boot)
> >           - numbers might (and do) vary from boot to boot

> This last point is a total pain for benchmarking, it means nothing is
> every reproducible.

> Therefore, I would always augment the above (2) with the below (3), such
> that you can overwrite the results with a known stable set of numbers:

The suggestion when the previous version was being discussed was that
there are supposed to be some other knobs one uses for tuning and one
was never supposed to use these numbers.

--pA3GpxlsFRhNUARh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWnnduAAoJECTWi3JdVIfQrS0H/0AJRa2JXxF8a6YHUgxQCw6E
fAdNBftzxSzZGWdQiZx9V1BI9/9VEz0+zkv2g/LBF6BENq/LcOkB6RhPoD9RrO7V
K+qI2YGecXFcrGQp0XMQ+mH1fAnd4a1W7hoiS9v5WJieItJ+uO7/oxiufh52QV73
qJ37a4yuucWKdNQNtpz80/6Btigjs7aXGBlGbanajHcKnKCsvOesq1xvGHNRndAp
iqZebgKlhg9SLtxHp0ZXzI1Tpm4qJwt8bmb0KM2ZOvK4ArsnotW306PZ0VJ8aQas
2TtxR3bToadisLRpSg6AGXv8usoJtIRkcGxRE19UdLxUo3Nx/sD3UMTbT1+wEmo=
=8GNY
-----END PGP SIGNATURE-----

--pA3GpxlsFRhNUARh--
