From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH RESEND 1/3 v4] drivers:power:twl4030-charger: don't check
 if battery is present
Date: Mon, 1 May 2017 13:26:31 +0200
Message-ID: <20170501112631.2kz4bbga4hfznhsz@earth>
References: <cd36deb10a769825620828a43d2bab4f949f3370.1492198177.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mpxbloa37urlshgl"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57633 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754599AbdEAL0f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 07:26:35 -0400
Content-Disposition: inline
In-Reply-To: <cd36deb10a769825620828a43d2bab4f949f3370.1492198177.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Grazvydas Ignotas <notasas@gmail.com>, Andreas Kemnade <andreas@kemnade.info>, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org


--mpxbloa37urlshgl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 14, 2017 at 09:29:38PM +0200, H. Nikolaus Schaller wrote:
> We can't assume that the battery is or stays present after probing
> on devices with replaceable battery.
>=20
> On some devices (e.g. GTA04 or OpenPanodra) it can be removed
> and even be hot swapped by the user while device continues to operate
> through external AC or USB power (as long as system power consumption
> remains below ca. 500mA as provided by USB). Under certain conditions
> it is possible to boot without battery.
>=20
> So it makes no sense to check for this situation during probe and make
> the charger driver (and its status reports) completely non-operational if
> the battery can be inserted later.
>=20
> Tested on: GTA04 and OpenPandora.
>=20
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Thanks, queued.

-- Sebastian

--mpxbloa37urlshgl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHG2cACgkQ2O7X88g7
+pr5iQ//UkmtzEoPKOtIwxpngnVydvyj+RtBdKp4f0Z53JbPAlx0w69+x6mei+Np
dRoS7XShzWFjLtH7blAqXOxnfThhDGqkxQdM1cXBZV37MkxA1y6NxWbbxhFbhmW5
5IjohiZvOueiabMhrMSDfzoeiKutS+RqDgzzaPGNGgVPbBuAEvKhDJvcqyT2xkLp
S4lqZXqmS0AZdZ9lTGo/sLV275oPsZzGEf2dAaNCdCVf5kSt5eiAWQyJBpHIXg1n
E2XES7k6EVHGy+A13+9zqaoraFVb5mVxFSEhQsr13LOe9m/OKAvU4p42roZXYNBV
siiV0rJdF1m8aqStTyxu3d6ZgvxbtIWDtaLT0ODVLOn+Qq0sqLvmeKsF8X8UFrKb
3aw+tlME8nzMvdSEMiByonk3vG/jouTSBpONEjjE9ea8V3XVAcVAYmrT13dWYvNj
E7kYruBMHS2Mp9OHjYGLulaFKSCTz6Qsvvwi8HqpcSwWMN0PkfMSa7W2QmJGlhey
FFS63m9jqYal5Qb5iMeifmPPIVqOVTuR+oBk6KEPWhMfVIHj7/BVg5SpDi09fvbA
x4mw/PuXC+fZCGro6vzymyKnwG0BMtsV+Yl2RZVvifocHh3niXJTz6tGgo2fzstH
r0XbMTH4R94zt8bpYtr9Pi71ebhOhM/qGQg+PBeEEW6Z1JpIyzQ=
=RLGT
-----END PGP SIGNATURE-----

--mpxbloa37urlshgl--
