From: Thierry Reding <treding@nvidia.com>
Subject: Re: [RFD] Functional dependencies between devices
Date: Thu, 19 Nov 2015 14:18:59 +0100
Message-ID: <20151119131857.GF21862@ulmo.nvidia.com>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan>
 <564B224D.3050904@samsung.com>
 <20151117135549.GR31303@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10342 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbbKSNTJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2015 08:19:09 -0500
In-Reply-To: <20151117135549.GR31303@sirena.org.uk>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>

--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2015 at 01:55:49PM +0000, Mark Brown wrote:
> On Tue, Nov 17, 2015 at 01:49:17PM +0100, Andrzej Hajda wrote:
> > On 10/27/2015 04:24 PM, Rafael J. Wysocki wrote:
>=20
> > this scenario:
> > - many clock providers, irq domains are not provided by devices,
>=20
> That seems like something we can and possibly should change if we want.

It's not very trivial, unfortunately. I had a crack at that a long time
ago, but the problem is that these devices all need to be available very
early during boot, at which point devices aren't registered yet. With
all the progress on probe deferral and the on-demand probing work this
might be less of an issue nowadays, I haven't looked at it for quite a
while.

But I fully agree that the current state of setting up providers without
a device structure is suboptimal precisely because it prevents generic
infrastructure like the one Rafael proposed from just working.

That said, one technique I've occasionally resorted to is to have some
early code, be it one of the OF table things or an initcall, set up a
basic environment, typically using global variables (yuck!), but then
provide a proper driver that knows how to take these things over when
its time comes. That's not a perfect solution, but at least it gives you
a proper struct device to work with.

Thierry

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWTcw+AAoJEN0jrNd/PrOhIgoP/2NxmIthdW4gSz/3/zR0SRWb
PMOBzWAAf5Glwg1N2SuhdOUKrTjXDJMAru/imfCIFHq+hyKfCzP5JoTFCahdKZXs
d6qW0SN64HFu99fGb4qo71nda3hpJXqY8TNhM+1RZP349OJWardkMSYvLTEXv6hL
iAdyjILr9C7kiYvbrTSnlEk5MGxEI0BAdaMtC4OlU+UtWNOpAnHW6TLKwrEQngFQ
Yc4vooMyJK5zXa+NaySjcjRHbPNK1n6dRBSUCmCITPl/xOZE1nv27JK8/JyWiaKI
+OqO5QJgn5Wy8hyfx1WkjE8NQ7h1c73soWy3X1s3EyOGeqyM9KQ5Od/1H2eOUrdV
E01RoO+mCqVs8EnlRpwFLGcYlbAy09EPGl3XDJq1jVLjYvQxPSLu3rjK3mY41pD6
9s/xlGNry95svNyP9HfhblOE9wPLIYDjObcMji8DpscfuvhiTtviY+O+A7JmkmsG
9TgSaS7eR/lJUl1QpeHsUPGqHSLWOefoRi/rKnl4OkBSVs0ALYwcUvEapmBQqcCa
p2d5UfO2cKYa1f2cTv1KEHvWrQE/lZh5b4RJpKPBNHsi1v02CcZ8zC3qqsQr+IvG
tzr7cjRW3rJAV36G+B0OeQLAf8qFHSplaixhNnIe+RVq8f7rEnvYmNJuffy+g1Ak
LzUyQedKb1MKD2oTu+te
=Atr2
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
