From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFD] Functional dependencies between devices
Date: Sat, 21 Nov 2015 13:26:12 +0000
Message-ID: <20151121132612.GF26072@sirena.org.uk>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan>
 <564B224D.3050904@samsung.com>
 <20151117135549.GR31303@sirena.org.uk>
 <20151119131857.GF21862@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="udcq9yAoWb9A4FsZ"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:42026 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbbKUN1i (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 21 Nov 2015 08:27:38 -0500
Content-Disposition: inline
In-Reply-To: <20151119131857.GF21862@ulmo.nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <treding@nvidia.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>


--udcq9yAoWb9A4FsZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2015 at 02:18:59PM +0100, Thierry Reding wrote:
> On Tue, Nov 17, 2015 at 01:55:49PM +0000, Mark Brown wrote:
> > On Tue, Nov 17, 2015 at 01:49:17PM +0100, Andrzej Hajda wrote:
> > > On 10/27/2015 04:24 PM, Rafael J. Wysocki wrote:

> > > this scenario:
> > > - many clock providers, irq domains are not provided by devices,

> > That seems like something we can and possibly should change if we want.

> It's not very trivial, unfortunately. I had a crack at that a long time
> ago, but the problem is that these devices all need to be available very
> early during boot, at which point devices aren't registered yet. With
> all the progress on probe deferral and the on-demand probing work this
> might be less of an issue nowadays, I haven't looked at it for quite a
> while.

I believe it's a lot easier to do that now but ICBW.  We've started
needing to put these things into firmware so that we can refer to them
=66rom clients so we pretty much have to deal with it.  I've not had to
worry about it too much directly myself recently though.

> That said, one technique I've occasionally resorted to is to have some
> early code, be it one of the OF table things or an initcall, set up a
> basic environment, typically using global variables (yuck!), but then
> provide a proper driver that knows how to take these things over when
> its time comes. That's not a perfect solution, but at least it gives you
> a proper struct device to work with.

Indeed, that's also how things like the console work.

--udcq9yAoWb9A4FsZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWUHD0AAoJECTWi3JdVIfQA0gH/2h3yF+16l/YvIODQoiHkt1V
PdtUR71rzy+EnxCDEkhSqmsb+kcDxSm0vdHBakTR3kRAhqI5F5Lj6aHH7tNbPfFT
amhiJsrSE/ZZQFhokxUe/fUdWJgAtqUS9kv2egCI/55SBHSNbuF5kBe+0jta7kc0
FyN1XrFHjO8mfnKzk3mXpL/nF2DNWFHOuAtywkpKJ8XGg5LPnL8E6vb2UVr/REPB
0ad5lPwTlEuaCcOfmUPkmREICKwoSH8OXYbu/Peirf6nBVz2XMvs+VIrTdJJjeAD
OYeDYq+ZYymwb618BAguV6RuBVdd3eYnWjTsYEX8Fu1Uukvtj0ADUYl+l/l+XdI=
=xZdj
-----END PGP SIGNATURE-----

--udcq9yAoWb9A4FsZ--
