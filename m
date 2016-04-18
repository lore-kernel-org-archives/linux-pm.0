From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] thermal: tegra: mark PM functions __maybe_unused
Date: Mon, 18 Apr 2016 09:15:13 +0200
Message-ID: <20160418071513.GA13078@ulmo.ba.sec>
References: <1460838026-1242452-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38445 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbcDRHPQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Apr 2016 03:15:16 -0400
Content-Disposition: inline
In-Reply-To: <1460838026-1242452-1-git-send-email-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Eduardo Valentin <edubezval@gmail.com>, Wei Ni <wni@nvidia.com>, Zhang Rui <rui.zhang@intel.com>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 16, 2016 at 10:19:33PM +0200, Arnd Bergmann wrote:
> After the PM support has been added to this driver, we get
> a harmless warning when that support is disabled at compile
> time:
>=20
> drivers/thermal/tegra/soctherm.c:641:12: error: 'soctherm_resume' defined=
 but not used [-Werror=3Dunused-function]
>  static int soctherm_resume(struct device *dev)
>=20
> This marks the two PM functions as __maybe_unused to shut up
> the warning. This is preferred over adding an #ifdef around
> them, as it is harder to get wrong, and provides better
> compile-time coverage.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: a134b4143b65 ("thermal: tegra: add PM support")
> ---
>  drivers/thermal/tegra/soctherm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

The need for this should go away when Jon's generic power domain series
gets merged (hopefully very soon now) and enabled on 32-bit ARM. In the
meantime:

Acked-by: Thierry Reding <treding@nvidia.com>

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXFImBAAoJEN0jrNd/PrOh5jMP/22Y1tJfiD6Yp8OvE+6eIqeO
i2FRrGik4l0jvzoUASH5O05yCq8aN4DI4Ieut/HC+/mOFj6ektDKOOu3Kz+fI76u
Ia5xDRvygbVaLDLjtdWvaceKa+XZxVx+iLQuEOL8KVPZwH3QAHeZp8b0udv4JkMk
g+9v4dBrmQhsDsfNKsUcW2bS7/0jaW9ZhorNR7/80JmAFr5mZCxQV1rklRoFPbR5
dPZKvDyiboKVRLSnmGGuF6Y/rhb43TA8sUPCaU1GRJlzryWpAEy6U4z0gtpyfboN
bsOR9ulIJsSy00+5u3x7x0YYZnC6gFHLi8Qpn3orlnimyfYPCPp9LYNU6Unz7JqA
Z7lOfWtrVIYoemnpPUMevk9D2uuI3/rPb2sOOnFLrbUuP1NhAEKsR4upiJo4Dmzs
NCSU5pMyutblHIZz3bi9mpsUMZEs9e79rUSy05BdqjxYCZdDdFBPqyVNW5aGm9ko
oG2/hZEHn3klhEp2uqq2uWwCC97dVJpwhSQdMdpnE3QHJPHD8gv10+mkaWKU4Azh
KVTbuThXRaPDR44IcyhFyLVUhbBnuGQQ4TQlLE8Yx343i2Zis0tcJyxDJc6/xhXF
7MSIvcQCiUpnLl0uTme/EnZRL+R8ACCgp5HnFwkd2kLz0gdp09PIJUE+6UKAOtmE
/6QnzBkwk80H+32dUPBP
=Peyb
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
