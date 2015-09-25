From: Mark Brown <broonie@kernel.org>
Subject: Re: Voltage setting on chained regulators, how?
Date: Fri, 25 Sep 2015 09:47:26 -0700
Message-ID: <20150925164726.GI30445@sirena.org.uk>
References: <20150925090724.GH7858@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZZc4RZLlj7DA0l+0"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:49659 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932234AbbIYQsC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2015 12:48:02 -0400
Content-Disposition: inline
In-Reply-To: <20150925090724.GH7858@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>


--ZZc4RZLlj7DA0l+0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 25, 2015 at 11:07:24AM +0200, Sascha Hauer wrote:

> Any idea how such a scenario could be implemented? The regulator
> framework already has some idea of supply regulators, but it only takes
> care of en/disabling the supplies and will not change the voltage on the
> supplies. Should this be implemented in the regulator framework?  Some
> first experiments brought me into a locking hell quite fast.

It's just a case of implementation, but yes the locking is fun.  I don't
think it's that big a deal to rethink it, it's partly complicated since
the existing locking is designed to be really simple and easy to review.

> For added fun ideally we want to put the LDOs in bypass mode instead of
> configuring them for minimum dropout. The bypass mode doesn't work for
> the 1.2GHz operating point though since the ripple on the switching
> regulator gets too high. So we can't just statically configure bypass
> mode but have to enable it dynamically based on the operating points.

I suspect you always want the LDO in there to clean the supply up, it's
just a more serious issue when more power is being drawn.  Having a DCDC
doing most of the voltage drop for efficiency with a LDO to clean up the
output of the DCDC is pretty common.

--ZZc4RZLlj7DA0l+0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWBXqdAAoJECTWi3JdVIfQAWIH+gILdDFJ0Qwvqz7KQ5YNl1/n
WHqiMVu9OryFzxcGHbszd+0UA+KVHRZtjNMqjwbT4/JoImiyLqgjJhJgWd92pupA
YeRmw/xyCLHnR/0jrjhA1e+eIlUnoya5pqbAb7/rwLVdnY8vyo1NIGd2dnjGfEjP
XjctB8emYPj/FeaHyKxy0BJYyWv2nhxVYXaB/wZteeVPbGHPfJVwRWpO12tkwMfV
w3Y5F6hMbhWRfKbMCh1RfVvFBUuQFK854AyqRrCAefuQNCI8GIL4Ocgo9VjRjPjr
6PFAMUTS3r7isXWiPzl9f/0sreuNodrWd459JkPWnvWBfr1o/nWzzFzCf+4XL68=
=Axoe
-----END PGP SIGNATURE-----

--ZZc4RZLlj7DA0l+0--
