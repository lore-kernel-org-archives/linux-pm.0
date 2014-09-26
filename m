From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] PM / AVS changes for v3.18 - v2
Date: Fri, 26 Sep 2014 09:15:34 +0100
Message-ID: <20140926081534.GA27755@sirena.org.uk>
References: <7ha95nikqh.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBii9oQw/U9UOygZ"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:42978 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725AbaIZIQD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Sep 2014 04:16:03 -0400
Content-Disposition: inline
In-Reply-To: <7ha95nikqh.fsf@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, dianders@chromium.org, heiko@sntech.de


--gBii9oQw/U9UOygZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 25, 2014 at 12:05:42PM -0700, Kevin Hilman wrote:

> The first pull request was missing a dependency on a feature that went
> in through Mark Brown's regulator tree, so it wouldn't actually compile
> properly by itself.  This version pulls in that topic branch from Marks
> tree (topic/voltage-ev branch, already part of -next), and now compiles fine.

Please in future don't pull anything in from my tree without a signed
tag (speak to me if there isn't one).

--gBii9oQw/U9UOygZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUJSClAAoJECTWi3JdVIfQ/vUH/AgV3nHO0CqM3o1iT0U1Lh8q
jIFYviY63AC2VVIZm6graZpEplsYelOMpSrR6L4a5GW2x4KUQDwsuK+HMilJYxvR
7xsckvqeah3CQxUc2iRYZwqs5UY6lwSJtrYj2Bzzd5lfe8M2Nywfifq4rlV45Bo/
gZrHCCaAR3tcM1wr9PV7J0AQTVwYmLIXsthVbf2TDJosVMtLLYK8ppJRhRwFZobH
zVn0bDVviYUkkC0ZaZ1XrtSgVVRZg0eU6aYN/v4rYEqwqeASMLbRkNYRScb5g35O
Ic18G3sp9w35k6jJLIadBOHkEegmX2zM1X/MVZh89t5+TfXbib3g8Y8qHA5vsmo=
=9WGB
-----END PGP SIGNATURE-----

--gBii9oQw/U9UOygZ--
