From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC][PATCH 0/5] Functional dependencies between devices
Date: Wed, 8 Jun 2016 13:15:17 +0100
Message-ID: <20160608121517.GG7510@sirena.org.uk>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan>
 <2576341.476ZsjkPgF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M8g8Xvd1npd+rU3W"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:50332 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617AbcFHMPk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jun 2016 08:15:40 -0400
Content-Disposition: inline
In-Reply-To: <2576341.476ZsjkPgF@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.og>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>


--M8g8Xvd1npd+rU3W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 14, 2016 at 02:52:11AM +0100, Rafael J. Wysocki wrote:

> What follows is my prototype implementation of this.  It took some time
> to develop (much more than I was hoping for), but here it goes at last.

Might be worth posting this outside the thread with CCs to people
working on system integration like SoC maintainers - I'd completely
missed this as it was buried and looked like the middle of an old
discussion.

--M8g8Xvd1npd+rU3W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXWAxTAAoJECTWi3JdVIfQOr8H/iYRmQbnrKiVxLwdjxwfShps
nSQjZRUPjmdoYL3FOSvwcQTV5jRb30MEZHsEmmjS6XFaRlkYxVTyR2uQzE9OjZjx
dMDoJ7K23DeOc9EqhAnECCBRHLAgEbR66CC8wmsP4dvdGk8TLntn4qa4l3FHXjos
6fAMADxXWCbsH9iWHgxauzSJc6cAiGs5sXLUhjeFFfUzXCXJwjFxuZoIstCjHppC
ONywyHZVW+pYMNXAWhAU8v4LHkOqoMtJGEqZcvsh6maGWihjumSMgk8pVO57vPs+
QKWwsg7y5ZqhlOBBRHWiWIzsy/bc1fS3cGkVPehrp0Y4pTThtOq8i16g2eJGwkc=
=t4Bd
-----END PGP SIGNATURE-----

--M8g8Xvd1npd+rU3W--
