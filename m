From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH v2 0/4] CPUs capacity information for heterogeneous
 systems
Date: Fri, 15 Jan 2016 18:01:07 +0000
Message-ID: <20160115180107.GC6588@sirena.org.uk>
References: <1452262172-31861-1-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kprVLFHawVuICufS"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:56548 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbcAOSBQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jan 2016 13:01:16 -0500
Content-Disposition: inline
In-Reply-To: <1452262172-31861-1-git-send-email-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com


--kprVLFHawVuICufS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 08, 2016 at 02:09:28PM +0000, Juri Lelli wrote:

> Second version of this RFC proposes an alternative solution (w.r.t. v1) t=
o the
> problem of how do we init CPUs original capacity: we run a bogus benchmar=
k (for
> this RFC I simple stole int_sqrt from lib/ and I run that in a loop to pe=
rform
> some integer computation, I'm sure there are better benchmarks around) on=
 the
> first cpu of each frequency domain (assuming no u-arch differences inside
> domains), measure time to complete a fixed number of iterations and then
> normalize results to SCHED_CAPACITY_SCALE (1024). I didn't spend much tim=
e in
> polishing this up or thinking about a better benchmark, as this is an RFC=
 and
> I'd like discussion happening before we make this solution better
> working/looking. However, surprisingly, results are not that bad already:

This approach looks good to me - certainly vastly preferable to putting
the numbers into DT.

>  2. Dynamic profiling at boot (v2)
>=20
>     pros: - does not require a standardized definition of capacity
>           - cannot be incorrectly tuned (once benchmark is fixed)
>           - does not require user/integrator work

>     cons: - not easy to come up with a clean solution, as it seems intera=
ction
>             with several subsystems (e.g., cpufreq) is required

This actually seems to be pretty clean.

>           - not easy to agree upon a single benchmark (that has to be both
>             representative and simple enough to run at boot)
>           - numbers might (and do) vary from boot to boot

This does come back to the question of how accurate the numbers need to
be - is "good enough" fine?

--kprVLFHawVuICufS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWmTPiAAoJECTWi3JdVIfQXIAH/3XAyLX6HyCEyTR0fk5bb95A
aRJlmJ9NLY2I7QFFD+h4mf8mrVTRM+iJdhVZ9V2Yo9zaZEl4xepJNbBlrYuEOttH
F1m8SgElL8b7+reaCbZ45f425z9vUH9gPsMxmihiIhL60T+M39+uR61gXeJiCXAM
x5LBazVJFj1gprF2tsEg9+XiKiNp25F4sVoVXRQXZfeoBx8m6eLR/wJSrNTTJA6c
7PCBxx5YVn8PzuLChicPB07dbR1MoynMbt4VHmjEdg6ywVuD2HPVemd04Txz9xNq
9v08pL4QLnHF3XYlKiyt7b7hOYTR6++1tkLBVy0gegOhv0wQN8hEPIwD8euy3I0=
=EvNW
-----END PGP SIGNATURE-----

--kprVLFHawVuICufS--
