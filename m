From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/8] Documentation: arm: define DT cpu capacity
 bindings
Date: Mon, 21 Mar 2016 17:51:12 +0000
Message-ID: <20160321175112.GY2566@sirena.org.uk>
References: <1458311054-13524-1-git-send-email-juri.lelli@arm.com>
 <1458311054-13524-3-git-send-email-juri.lelli@arm.com>
 <56EC3F9E.4050209@nvidia.com>
 <20160321105330.GB12319@e106622-lin>
 <CAKfTPtDP3zMR+zbvvqJCBvJ5r44do8NS03wC7pAejxPd0zHTMA@mail.gmail.com>
 <20160321114956.GD12319@e106622-lin>
 <20160321121210.GQ2566@sirena.org.uk>
 <20160321172452.GE12319@e106622-lin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7VYoR/Ws5oXf5rNY"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:50498 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756944AbcCURvc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Mar 2016 13:51:32 -0400
Content-Disposition: inline
In-Reply-To: <20160321172452.GE12319@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Sai Gurrappadi <sgurrappadi@nvidia.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Olof


--7VYoR/Ws5oXf5rNY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 21, 2016 at 05:24:52PM +0000, Juri Lelli wrote:

> I think this should work, but we have to understand how do we obtain the
> max frequency of each cluster while parsing DT. OPP bindings are
> helpful, but AFAIK there are platforms for which firmware is responsible
> for setting up and advertise available OPPs. I'm not sure if this
> happens later on during the boot process. We might still be able to use
> the clock-frequency property in this case, but that might need changing
> again if the top OPP gets removed/changed.

> OTH, we might simply want to say that capacity values are to be obtained
> once the platform is "stable" (no additional changes to configuration,
> OPPs, etc.). But this is maybe not acceptable?

How about we just punt and let the cpufreq driver tell us - it can parse
DT, use built in tables or whatever?  We could even remember the raw
values and recalculate if it ever decides to change for some reason.
Until cpufreq comes up we'll be stuck at whatever OPP that we're at on
startup which may not match whatever we define the numbers relative to
anyway.

> Also, I fear that for variants of a particular implementation we will
> still have to redo the profiling anyway (like we alreaady did for Juno
> and Juno-r2 for example).

This sometimes happens either through binning or through board design
decisions rather than through new silicon so we might be able to reuse.

--7VYoR/Ws5oXf5rNY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW8DSOAAoJECTWi3JdVIfQgckH/RC0GXkRbyRMxTrW/r3kn0RN
QLpZ64ZVOmhxHsJj4INT0bbgWLkQ6oiHKZU7X6zGW+YLLJ5pLJhWTnxIamj2PJxV
+u62pgE8cyUl+5jKKlSgupKg2NApLXL3BLeFPaway6oxwWXix7MQfskNXhun+Box
MFqwRNXv7utZCgLSlD4RPzN5JhuuG0h5U66Dt//kGw2e7pgusaLjgZKHP85L1bnI
1asokcceN501lOXXuzM4JsTzLkWSB1ikiFMdFxUbsRWwceg7mVsN8Nl4gvxkU3Ay
tYm9lIWUi7JwOUSkWS1+T3FGxARgURuyKoAwOgKJgQYiFM4/CfOZf+7fxpIfneU=
=r2zq
-----END PGP SIGNATURE-----

--7VYoR/Ws5oXf5rNY--
