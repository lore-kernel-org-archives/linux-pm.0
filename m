From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] arm64: Add big.LITTLE switcher stub
Date: Fri, 9 May 2014 19:01:21 +0100
Message-ID: <20140509180121.GU12304@sirena.org.uk>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org>
 <1399653631-4938-2-git-send-email-broonie@kernel.org>
 <20140509174738.GP7950@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vpveOQQQ2RTKqiPQ"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:39514 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756942AbaEISBk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 May 2014 14:01:40 -0400
Content-Disposition: inline
In-Reply-To: <20140509174738.GP7950@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <Will.Deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>


--vpveOQQQ2RTKqiPQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 09, 2014 at 06:47:38PM +0100, Catalin Marinas wrote:
> On Fri, May 09, 2014 at 05:40:30PM +0100, Mark Brown wrote:

> > The big.LITTLE cpufreq driver is useful on arm64 big.LITTLE systems even
> > without IKS support since it implements support for clusters with shared
> > clocks (a common big.LITTLE configuration). In order to allow it to be
> > built provide the non-IKS stubs for arm64, enabling cpufreq with all the
> > cores available.

> Have you thought of patching the actual cpufreq driver? Are you adding
> this code just to avoid compiler errors on arm64 with this driver?

Yes, that was actually my first thought but I wasn't loving the
ifdeferry - it's fairly easy to do IIRC but the general taste seems to
be towards having stubs rather than ifdefs and the code seemed to be
lending itself to that.  There was also the fact that ifdefs could have
been done for the non-IKS case on 32 bit but instead stubs were
provided.  If people prefer I can do an ifdeffed version though, it
doesn't make much odds.

This was purely to get the driver compiling and hopefully running on
ARMv8, there is some user demand for deploying the driver on big.LITTLE
systems.

> > It may make sense to make an asm-generic version of these stubs instead

> asm-generic/bL_switcher.h? I take it as a good joke ;)

Hey, perhaps other hardware architectures are implementing similar
concepts even now in order to keep up!  :P

--vpveOQQQ2RTKqiPQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTbRftAAoJELSic+t+oim9ywcQAIdZmJv4MXoHPsQcUR6fCH8I
jETr5hO9LIDlIW5RjmglqXGIoNvjVpEVBFSKQAg8Pty2DERXPu9tmx9t9L0BUdYv
cbxn/27FfGQXyYmVW3uSF3KoR728X7KMuU/CwxfSYtTmzhC/EIHYpCSOHK3ndB97
qJufTv8K4nFpA3Anr2n0mwlAQvHc8UieiQJp6jrpnR6oHmddNkqJQNdPi55c3O3p
WOdn8DzH2YSW5NG5r5Eb7TeNTFgyfUt3kHXNaA1wCDGwzYFCFLOojRAQg3XeKz+u
fWrJvSu04ibw9Xw1SWAr+Er4V8xUjNEotu5hx+FQzdnIWCFNYHNwgCZcwv6TTK7X
dIACpAbbA8JJJT3acWIcS9JniYfVgiN1ULlPdZXIRRGjUII7B4XO84L9AdPx2YyN
teWpiGsMcT60qZq6U7YjFoc2kkmrDfbGeufP/++ywB11fKTb3Vf6WpY89xqlVs1o
SIApTciZ0pI+pDmJIup22P9S48lIBrcdhMv9uwMoyrRLwogYjACKIC3SvREDPcUt
de+0pV174C6fN+JEsPlKUhzrdaVjYqq172RT4HE3OqPKZb/uPjSAsFQ0n4CDbKQL
Eyxo7V4jFdZ/fSzo++/OlTYdImwuyK6xiPHmVPS2iEr3Hc541jZnXvolqCM/hm08
aKD/lmYB46LtMXAABNOc
=aTyz
-----END PGP SIGNATURE-----

--vpveOQQQ2RTKqiPQ--
