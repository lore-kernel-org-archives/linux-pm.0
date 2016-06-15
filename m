From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 1/8] Documentation: arm: define DT cpu
 capacity-dmips-mhz bindings
Date: Wed, 15 Jun 2016 15:04:47 +0100
Message-ID: <20160615140447.GB2282@sirena.org.uk>
References: <1465985877-18271-1-git-send-email-juri.lelli@arm.com>
 <1465985877-18271-2-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hTyD2MSx3HZlTIuF"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:39670 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932432AbcFOOFI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2016 10:05:08 -0400
Content-Disposition: inline
In-Reply-To: <1465985877-18271-2-git-send-email-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, sgurrappadi@nvidia.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Olof Johansson <olof@lixom.net>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Paul Walmsley <paul@pwsan.com>, Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>


--hTyD2MSx3HZlTIuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 15, 2016 at 11:17:50AM +0100, Juri Lelli wrote:

> +CPU capacities are obtained by running a suitable benchmark. This binding makes
> +no aspersions on the validity or suitability of any particular benchmark, the
> +final capacity should, however, be:

Makes no guarantees.  An aspersion is an insult!

> +CPU capacities are obtained by running the Dhrystone benchmark on each CPU at
> +max frequency. The obtained DMIPS score is then divided by the frequency (in
> +MHz) at which the benchmark has been run, so that DMIPS/MHz are obtained.
> +Such values are then normalized w.r.t. the highest score obtained in the
> +system.

Perhaps worth mentioning that caches and so on should be enabled (based
on previous experience with people doing bringup)?

--hTyD2MSx3HZlTIuF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXYWB+AAoJECTWi3JdVIfQ0n0H+QFFGQlAwUqW5r7MeENtno09
xyaKc04bxsEYYXlC1htnknLdPtY13kJ6czFAQ8RHvdQPNfzwG3CcEXaFUiLeIjLP
hT2zdt9eUb+4bUit40dcULVK1UZH9p70s8yR5RmOl2e4Nr/4qebp33ccKwB2po6g
PwZSlbKleMYGSwnGFa0zvfQ/EetzrV+wRrXqPx7JA8I77w5PIQ1RA2xUbUT9ShMx
pXl8vbywOSC1vDwdP/Yzcd81z2NPvspJM6mveWJ562X/wLqtFAfj5JuN7fRKKOpK
iamibu+l1/ALV0rbF8Zhu4gxs4/6o6m+9g5vdtmav3zZvo8FIwNMw6HuA5mcMx4=
=R+jA
-----END PGP SIGNATURE-----

--hTyD2MSx3HZlTIuF--
