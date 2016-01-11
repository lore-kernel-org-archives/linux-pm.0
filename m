From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: max8973: add THERMAL_OF dependency
Date: Mon, 11 Jan 2016 16:47:44 +0000
Message-ID: <20160111164744.GM6588@sirena.org.uk>
References: <7607130.s0M7SSqlJV@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="onwk0SivC/dtQkFp"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:47888 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933393AbcAKQr6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2016 11:47:58 -0500
Content-Disposition: inline
In-Reply-To: <7607130.s0M7SSqlJV@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>


--onwk0SivC/dtQkFp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 08, 2016 at 09:06:43PM +0100, Arnd Bergmann wrote:

> I've run into the same problem a couple of times now, with every driver
> that calls thermal_zone_of_sensor_register(). I think we need a better
> solution in general, but this fixes the immediate build error for now.

Yes, this doesn't feel very clever especially in this use case where
we're mostly providing data into the thermal framework and not really
relying on it for anything.

> Maybe we should replace the "#ifdef CONFIG_THERMAL_OF" with "#if
> IS_REACHABLE(CONFIG_THERMAL) && IS_ENABLED(CONFIG_THERMAL_OF)"?
> The disadvantage of that is that the thermal management would be
> silently disabled rather than cause a link error, and that may also
> not be desired.

Perhaps we should ensure that at least some glue code is bool rather
than modular?  That's got downsides too, it increases the amount of code
that gets built into the kernel but perhaps that's an acceptable
tradeoff here.

--onwk0SivC/dtQkFp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWk9yvAAoJECTWi3JdVIfQbgsH/RAvyucImi+oTbbwIJ/kXNpz
zr8fDlaHs92d79F4xrghoGXcWXkbhozRaNQBXOIC74163Crn25vla/3JBk0jjCDJ
AnGSs+t6/6Q7YzNmPnzlvTe+ZGwZf2bF/n1Bm4svgt/2Qtuy9/6AQBK2AGtFcAK3
SU7gkL/27VRAfNkK52hOZ18ms2F8Ga8fLBr12kuIOVUnQbtFOd5gYEiIc6buv1ty
izc+jw/MuzxEhnIVeHQC5ZBYBibTmmEmBWaE8UGzTH7didZl6mOfYdwus6iqoTfP
YBUWf6HxaKS6qyHwtPbUv6wY+aKb3t1EMu0L+1FWeZk8VBKOrJbR5Oho8ghV+5I=
=18Bt
-----END PGP SIGNATURE-----

--onwk0SivC/dtQkFp--
