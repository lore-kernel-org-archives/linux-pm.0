From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] PM / OPP: Initialize regulator pointer to an error value
Date: Tue, 16 Feb 2016 16:51:35 +0000
Message-ID: <20160216165135.GB7544@sirena.org.uk>
References: <1455544758-7718-1-git-send-email-jonathanh@nvidia.com>
 <2628515.OmmYzoeulx@wuerfel>
 <20160216131108.GK18327@sirena.org.uk>
 <10492578.n5ZTGbvbYE@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:54185 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932568AbcBPQvu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Feb 2016 11:51:50 -0500
Content-Disposition: inline
In-Reply-To: <10492578.n5ZTGbvbYE@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linaro-kernel@lists.linaro.org, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>, Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 16, 2016 at 04:12:39PM +0100, Arnd Bergmann wrote:
> On Tuesday 16 February 2016 13:11:08 Mark Brown wrote:

> > No, we always return an error pointer if we fail to get a regulator.
> > The difference with optional regulators is in how we handle the
> > situation where we have full constraints and a regulator is not mapped
> > in, normally we assume there must be one with no software control but we
> > need to work around buggy bindings as the device would be non-functional
> > without power.

> Sorry, I should not have said "optional" here, which has a specific
> meaning in the API. I meant a driver that can work with either
> CONFIG_REGULATOR enabled or disabled (which is something slightly
> different).

Ah, right!

> I guess a driver needing to know whether regulators are built-in
> should check 'if (IS_ENABLED(CONFIG_REGULATOR))' rather than
> checking the return code for NULL.

Yes, that's the expected interface here if anyone does need to check
although for most users it's expected that the stubs will be sufficient
and they don't need to check at all.

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWw1OWAAoJECTWi3JdVIfQgQAH/0ddLZb6noddHvg8jQo558bQ
74YEkSDtv7hi/t4fHWQWnxmSMxfhppub5XPrCbZz2BPDLH/bTLmthQO6Glx8Xx8a
AwCTphZJ49lRZsfOkNlCyNRGgzS1kdtKJhk5ZxEYZXuXbTSsUEXdGi9HIfgXeYkZ
QK202a0/9/iPZOt4nLIs00ugwZm63EONOyK42MCxnqWS4ZXwo4ppY+V5viJWGKMt
5eKw9rZTsItIDr3goYvZ/w1cjTL+uETVJ7tlDDHGiAk6/J51sD9kJ7IvAu8I4hre
NfGIeFBWbc8cMeFKyTxmtPjpde5TQCXT1P+3u7PNN61pAX3gmv6qA14c+8YAW6k=
=Ik5T
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
