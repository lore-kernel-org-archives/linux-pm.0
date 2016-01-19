From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH v2 0/4] CPUs capacity information for heterogeneous
 systems
Date: Tue, 19 Jan 2016 21:10:49 +0000
Message-ID: <20160119211049.GX6588@sirena.org.uk>
References: <1452262172-31861-1-git-send-email-juri.lelli@arm.com>
 <56994D87.6000709@linaro.org>
 <20160118151316.GD7159@e106622-lin>
 <CAKfTPtBFR4cowT-j4qVxfUvh6NDNmi6R=J7z9kywi6bONU3Pow@mail.gmail.com>
 <20160118163014.GA10332@e106622-lin>
 <CAKfTPtDJBAXUz=_-QQSkrqwAvmUJd1bUJ-VfSaNER-0NzWpunA@mail.gmail.com>
 <20160119105941.GA28845@e104818-lin.cambridge.arm.com>
 <20160119112323.GB8573@e106622-lin>
 <20160119142933.GF8573@e106622-lin>
 <569E92FF.4000006@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xzSe+wpn+kb4oFkG"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:34362 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757269AbcASVLJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2016 16:11:09 -0500
Content-Disposition: inline
In-Reply-To: <569E92FF.4000006@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Rob Herring <robh+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, LAK <linux-arm-kernel@lists.infradead.org>


--xzSe+wpn+kb4oFkG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 19, 2016 at 11:48:15AM -0800, Steve Muckle wrote:
> On 01/19/2016 06:29 AM, Juri Lelli wrote:

> > I'm generally seeing ~1sec increase in boot time for 1 and practically
> > no difference for 2 (even after having added patches that provide
> > runtime performance improvements).

> One second is considerable IMO. Aside from the general desire to have
> shorter boot times on any platform there are environments like
> automotive where boot time is critical.

Yeah, definitely.  Is this actually blocking boot and if so can we
arrange to do this in parallel with other activity (with likely knock on
effects on reproducibility...)?

--xzSe+wpn+kb4oFkG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWnqZYAAoJECTWi3JdVIfQq6sH/0dYYzSGQorNniustWzVIFaQ
ZgINqGaDEQnR91pYMeZycfco/du7UpU99z8ncZJWT4ok9oyEJAxVitFmaIV/5IMY
d6N+DNE+diqbz0Yf9QGVMiqAvAFwJPdjrRsazGcXVBR9jB5iJZxZytLJkGfjx3i+
zXFUfHraUGaNua41Nh+iY2uSqHyDDmeJAObWaAKJWNvmBVi5sWG7B/0TuYZTLH0B
vE8VfBk40jMMJvt6m3A0v9dLQr6nyH/g5u7Fjb+cV/CsZEYVi78zKQ7TBby3SWw9
ZpMIOifv2pieDJebMKc1cmMDDUBlDo+be0QS7sAeshNF/6W0Ull1uOAYmSvzLHM=
=j3dl
-----END PGP SIGNATURE-----

--xzSe+wpn+kb4oFkG--
