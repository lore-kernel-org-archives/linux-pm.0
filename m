From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFD] Functional dependencies between devices
Date: Sat, 21 Nov 2015 14:04:28 +0000
Message-ID: <20151121140428.GJ26072@sirena.org.uk>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan>
 <564B224D.3050904@samsung.com>
 <20151117135549.GR31303@sirena.org.uk>
 <564D7145.40300@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1y6imfT/xHuCvpN0"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:42143 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbbKUOEt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 21 Nov 2015 09:04:49 -0500
Content-Disposition: inline
In-Reply-To: <564D7145.40300@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>


--1y6imfT/xHuCvpN0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 19, 2015 at 07:50:45AM +0100, Andrzej Hajda wrote:
> On 11/17/2015 02:55 PM, Mark Brown wrote:

> > This is going to be really common but I'm not sure I see a problem with
> > it in terms of what Raphael is proposing - could you go into more detail
> > on the problem you see here?

> If clock provider is not a device driver and it depends on clocks of
> another clock
> provider you cannot 'translate' this dependency as dependency between
> devices,

What makes you say that this is the case?  There should be nothing
stopping us having dependencies between two devices of the same type.

> so this RFD does not cover them.
> Additionally if you look into kernel there are many calls in form
> 'clk_get(NULL, name)',
> it suggests that not only clock providers are consumers without
> underlying device driver.

Like I said in my earlier reply:

| > - many clock providers, irq domains are not provided by devices,

| That seems like something we can and possibly should change if we want.

This applies just as much to consumers as to providers.

--1y6imfT/xHuCvpN0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWUHnrAAoJECTWi3JdVIfQciIH/ipDdzjSrOXd6CaLdm53jcZX
0Mfefv79IH7Yl6vKW8OhHqicF0Bc3d3mNTZrKTIsAFjThsWlHyyoZqLS9PI6mPcM
himFNqpWu2vvMGQPoneN5lLRljKcMA9sFyi/PBZYHNI9/D/PUATy5LYcUlaoghEq
gYxcTEeB12qoEJI5+pLVHZmnUNKOLjQ/CDCITTpD5LUUb+Z+p1LbAxwRfNEGXILe
c7dzRttYEBIO5Xfh3EvXk3s0DXl4QgMTDlBJohN7XFFM/f6n58PVvGcSjeYNdKm1
r83hBZBf8sZb+3ZsyaxMPCrhC0ZAbhYm8pOZCZlvpbaJ08GAn4J8IjkMNWrQTP0=
=VOLN
-----END PGP SIGNATURE-----

--1y6imfT/xHuCvpN0--
