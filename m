From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC][PATCH 3/5] PM core: Make async suspend/resume of devices
 use device links
Date: Wed, 8 Jun 2016 13:59:06 +0100
Message-ID: <20160608125906.GI7510@sirena.org.uk>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan>
 <2576341.476ZsjkPgF@vostro.rjw.lan>
 <2464004.VfRsJaNrp3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="McTFpSeH7KqpdXA3"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:50448 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755990AbcFHM7P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jun 2016 08:59:15 -0400
Content-Disposition: inline
In-Reply-To: <2464004.VfRsJaNrp3@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>


--McTFpSeH7KqpdXA3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 14, 2016 at 02:55:25AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Make the device suspend/resume part of the core system
> suspend/resume code use device links to ensure that supplier
> and consumer devices will be suspended and resumed in the right
> order in case of async suspend/resume.
>=20
> The idea, roughly, is to use dpm_wait() to wait for all consumers
> before a supplier device suspend and to wait for all suppliers
> before a consumer device resume.

Same question with parents using their child - I'm thinking that perhaps
we can arrange for the struct device of the parent to get used and
ignore the child device outside of the MFD.

--McTFpSeH7KqpdXA3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXWBaZAAoJECTWi3JdVIfQEGYH/j6MFFPQyPLBOnQriO67Efak
iawGRQBaBIRCwB8UYjLRpOJkpZCPNDdTBKjsdHkDrMR7E+mGXNtuCD6uiKKT6kh/
csQZY8KU1x/xZLN+2o8lxHp7M7RAkVE8Jys4ktrS0kwLBb+X/8FR6HSZgC7f7c7I
1yL7CWckgH4qNI7WdaJhjlW9qQ09uVh6ydv2mzMdS8AJXiMMcR4je0WerU2HtTvF
hJ0mYQ4rAS1lot6IcHyNFic+ki1MGhmepdbX+b8e37DqistcRbu2bQjq19fbzJCM
iQnNImo0dMyCi143M3e9aLZ5mvOteI+I2D332CN35WbxmbC84xa8WX48XSezgBk=
=xbpo
-----END PGP SIGNATURE-----

--McTFpSeH7KqpdXA3--
