From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 0/2] power: max17042-battery: Modify max17042 battery
 driver
Date: Mon, 6 Apr 2015 17:54:29 +0200
Message-ID: <20150406155429.GA18145@earth>
References: <1428049570-3295-1-git-send-email-beomho.seo@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36729 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753357AbbDFPzB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 6 Apr 2015 11:55:01 -0400
Content-Disposition: inline
In-Reply-To: <1428049570-3295-1-git-send-email-beomho.seo@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>
Cc: k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cw00.choi@samsung.com, inki.dae@samsung.com, sangbae90.lee@samsung.com


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Beomho,

On Fri, Apr 03, 2015 at 05:26:07PM +0900, Beomho Seo wrote:
> This patch modify max17042-battery.c fuel gauge driver for use max77843 f=
uel
> gauge. and then, fix minor cording style issue.
>=20
> This patchset is written based on recently battery git tree.

Thanks, pulled:

http://git.infradead.org/battery-2.6.git/commit/709c2c70c8ea73f488971f1de3c=
39fbdac995951
http://git.infradead.org/battery-2.6.git/commit/bbaeeaaf314aaf5e32e20070378=
bc14792ae3752

-- Sebastian

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVIqwyAAoJENju1/PIO/qafHwQAJcGfwuVyCVjK8mTHHE+8Bga
hMGmgLuESJG3iO17B4qGvAiYqJ576ceZUT3YomXeZVCDd836R2RBv09b2j6wcVaM
Xsb2Q5xcIjukQx/l65HaXdOv3F8zgWuoywK5UuHVXVczxJmkc7cUEGFJYD35SrN2
bhWb4ULJfnoBRJpJzICClbRcT/nyzlMdhDaArGP4xnQfeXB5wlwYmN7Yr1yFy/bW
lcdKtZn1D1P3rNgQKC4OPGsLiuSs0KfS6snl20v9p2ilO4p+tVHQ4YZreWPjjfUV
7RYkgrMjz7RcqLKdY5GBVaL9et1Il+3TcTCmjPe1uIi66/A2luZJcTZoGFzePd4v
g//RGQyfaRMl2wqqE50Rir2+huXBcsciknSHNE2pjzn1/LFB9tIiw1uzi4GbJgVq
mzsjO72sfiBOxsOQ8pqO4OQxV75DZphEo0+rfpOZ1gshOh9qzWAF9TZHF/CLUxFC
gnAimln2+MmnTIVet1ptHoGvnwrZOa0yPprV/acmwyYdGUYQshehid9UEZNI7P7K
wOpW26E8DslOApYHv2dCXbHztsr0pqLYn5VQhhgp/WhhttW//EaVQRVKGyeI2LWh
wx3OHsXEWpkveuCVfHYFnAeuk7Ug4EwToHb59zhZZ2RA2bqnU6tbIjVQHmEVfp57
cZprr9X97rEIM51P8UAf
=xMZm
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
