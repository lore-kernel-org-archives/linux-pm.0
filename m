From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/8] spi: pl022: Don't ignore power domain and amba bus
 at system suspend
Date: Thu, 6 Mar 2014 12:45:49 +0800
Message-ID: <20140306044549.GH13126@sirena.org.uk>
References: <1393671371-2398-1-git-send-email-ulf.hansson@linaro.org>
 <1393671371-2398-5-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3ig2Qzwgjz5TtjrC"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:56639 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbaCFEp5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Mar 2014 23:45:57 -0500
Content-Disposition: inline
In-Reply-To: <1393671371-2398-5-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Alessandro Rubini <rubini@unipv.it>, Josh Cartwright <joshc@codeaurora.org>


--3ig2Qzwgjz5TtjrC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 01, 2014 at 11:56:07AM +0100, Ulf Hansson wrote:
> Previously only the resources controlled by the driver were put into
> low power state at system suspend. Both the amba bus and a potential
> power domain were ignored.

Applied, thanks.

--3ig2Qzwgjz5TtjrC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTF/16AAoJELSic+t+oim9CGUP/RNIx3uBIodmSSVBQnFsfxb9
UT/Ll5fGrbId8CiDChkme9FGKCveJM/zBBk1pGKYYFdSOw/eBPUYh+V4pUQHqZgZ
oYv8G6kjhQxinry6y/rAxtG1XPjWySdpC8LAw6G7ZK1zfey+c0hJ5s/0vxXrgMnp
HSJcGw1/UZ+l0QdG8wFOc7TxweFxNAvfxGr+H1cG8W/n73vjoG6qsaxuWIvHFLL3
bK0NlxxjbajBd4n6SVZ0S6QFoUOj35gyNADEO2dU17yFGAEbC62pCdzwdid7mGpB
JwrywYr8IvrHO3fztIOYyHlgM8TsXMgWkAMecsILcNCqa5q01fCHO+YoX9FzXyCy
EiPneHz4a6ri7WY3h2MLrV4qfJixUtdYwW0fGWh5o2G7yvJUhcOOWhZINrC8I3+X
edFxQ+4bTNcQCNvix82H1a8lzyJbGOYVWIpJEXs6I8LNKy4A6gEzwKRuWEjvacHk
FFM11T2oi3iIM9eGxdxS6WzpniezkRslIRNlOTvC3IW84Pq/nbzZrz9ksNhD1wHI
YtAl4axtcztXH+6GhIHMtswPf5cJQh9QbC65hAhDqBNugXW+r0/3dg+0f5o+UN8S
d2CtwyTCu7nkQaNDJaeRyMGUi+5XEdOjYnInne3xUI4g+dgVnnDLRhd6QxDYKsZg
6MZwWJ7r8S/xIwN5b2ht
=O6m/
-----END PGP SIGNATURE-----

--3ig2Qzwgjz5TtjrC--
