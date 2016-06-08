From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC][PATCH 2/5] driver core: Functional dependencies tracking
 support
Date: Wed, 8 Jun 2016 13:48:44 +0100
Message-ID: <20160608124844.GH7510@sirena.org.uk>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan>
 <2576341.476ZsjkPgF@vostro.rjw.lan>
 <1816598.SuJvGrVRJK@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zVyz+SkbhTrRQGHt"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:50410 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161596AbcFHMsz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jun 2016 08:48:55 -0400
Content-Disposition: inline
In-Reply-To: <1816598.SuJvGrVRJK@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.og>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>


--zVyz+SkbhTrRQGHt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 14, 2016 at 02:54:17AM +0100, Rafael J. Wysocki wrote:

> + * A side effect of the link creation is re-ordering of dpm_list and the
> + * devices_kset list by moving the consumer device and all devices depending
> + * on it to the ends of those lists.

How does this work in the scenario where a device instantiates a child
device then uses services that child provides to complete the
initializiation?  We do have that scenario currently for on chip
regulators to allow external regulators to be used.

--zVyz+SkbhTrRQGHt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXWBQrAAoJECTWi3JdVIfQajkH/jw5EUoF3PNra/WBqzTU4x1L
bB1yS5Mydnl5zPHltpTyHhxgGRrQTsq9GXFLZqcciFncQjG8gE7K2w76FlK25vJs
yzM+Uq/mCFFqE/cWq3f+TX59K96LhHCCblUc6N/W7ktMPq1boUJ49IrANmo64YWe
Qpj/O54DEg3Gf30e6L2pLHIPMdw3gAfme8JWdH4rcThIgmmy4GCT/+4Uz2WVaPYy
FRrfPzrSb313zc3jYxEWL7FQHhwA3ZtHdWgBuwYyzL+yrZ+D7b91y3Fu0zWkZgJn
rpI9D+0Ofh4hAKDaJsJB0F3QSDxLIDmzV/uipo6S04f7PXXP/KvC9BX2atQuEo4=
=Nl1g
-----END PGP SIGNATURE-----

--zVyz+SkbhTrRQGHt--
