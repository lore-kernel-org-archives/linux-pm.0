From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] thermal: tegra: mark PM functions __maybe_unused
Date: Tue, 19 Apr 2016 14:43:19 +0200
Message-ID: <20160419124319.GG8284@ulmo.ba.sec>
References: <1460838026-1242452-1-git-send-email-arnd@arndb.de>
 <20160418071513.GA13078@ulmo.ba.sec>
 <5715998B.6080607@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yZnyZsPjQYjG7xG7"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35777 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856AbcDSMnZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Apr 2016 08:43:25 -0400
Content-Disposition: inline
In-Reply-To: <5715998B.6080607@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Ni <wni@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org


--yZnyZsPjQYjG7xG7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 19, 2016 at 10:35:55AM +0800, Wei Ni wrote:
>=20
>=20
> On 2016=E5=B9=B404=E6=9C=8818=E6=97=A5 15:15, Thierry Reding wrote:
> > * PGP Signed by an unknown key
> >=20
> > On Sat, Apr 16, 2016 at 10:19:33PM +0200, Arnd Bergmann wrote:
> >> After the PM support has been added to this driver, we get
> >> a harmless warning when that support is disabled at compile
> >> time:
> >>
> >> drivers/thermal/tegra/soctherm.c:641:12: error: 'soctherm_resume' defi=
ned but not used [-Werror=3Dunused-function]
> >>  static int soctherm_resume(struct device *dev)
> >>
> >> This marks the two PM functions as __maybe_unused to shut up
> >> the warning. This is preferred over adding an #ifdef around
> >> them, as it is harder to get wrong, and provides better
> >> compile-time coverage.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> Fixes: a134b4143b65 ("thermal: tegra: add PM support")
> >> ---
> >>  drivers/thermal/tegra/soctherm.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > The need for this should go away when Jon's generic power domain series
>=20
> Hi Thierry,
> Could you please show me the Jon's generic power domain series, so that I=
 can
> verify it.

Here are the remaining patches from Jon's series:

	https://patchwork.ozlabs.org/patch/603285/
	https://patchwork.ozlabs.org/patch/603287/
	https://patchwork.ozlabs.org/patch/603284/

Thierry

--yZnyZsPjQYjG7xG7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXFifnAAoJEN0jrNd/PrOhuZAQALvCpZ/+wYwjTvwmi8mdzo/N
P3COQO/s3uCdXRAglavgD5CQDOuomEyjwYdRjmVySHzjaR4pJhca3og2OCOwWOjG
IToID+J8epq0Z3lv5ZoX1jhTj/LQDglxQlUkfpHlZCAyvERZiFQYmPANvix8e9ME
WHw+0ReFB6JBXJUzd8cxHWNknYiVRxaJT3QqTdKEjQprRf2/Aoh1Ockkk6kpTYdR
GAKB0JoiM8rpG2v23LEQvdTd4YWqKf6BRunJA9r/khDgkHN4O+XUVlViMiWI4Rt8
vtYGfz101SHpLF82Hix9syb1JqDXGubCEmD2ZZE4x7+AwmHCwcVmIo5wevxokON+
79s5wpbMkKiSVmc+KU5KYaJDH+T8mMhObdtr7MQWpXro2SEBeXEbTl5E+S38H0nW
uDmKMC5vA/wc86IHL76rnKe5bHpvmaVXoFP7gOlEQu6La3hJMJZdsOO0xgCT8d4L
WFgzrnzTMjXwByDNpJh2XIRagFCKrYWm1JItd3IkMh0C6cIEZMzIi+I4LkKa/Qvo
ED49D3CQU9zRZdNh6B0pynOEmIlFpzxz8wndXW1AZcq22hLZoMmfZ2aVlx1+Bn/b
9jFfh2E4D0mCX8FQJ90KeishnWQWDsyx6c5RvzGMuLwLVTPWqBzVewPkrJsyv8z4
E2imF/BUSFM38BwhVQbZ
=krCg
-----END PGP SIGNATURE-----

--yZnyZsPjQYjG7xG7--
