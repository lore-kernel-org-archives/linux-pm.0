From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 1/2] drivers: thermal: Remove ARCH_HAS_BANDGAP dependency
 for samsung
Date: Wed, 10 Dec 2014 10:41:15 -0400
Message-ID: <20141210144112.GA3232@developer>
References: <1417502073-6322-1-git-send-email-a.kesavan@samsung.com>
 <20141208104333.0e044c58@amdc2363>
 <CAM4voamr2yxqWq51-WuiWyVpS7hCyXJY8rE7dH3Xr7WwQoayiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:47909 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756412AbaLJOlZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Dec 2014 09:41:25 -0500
Received: by mail-qc0-f177.google.com with SMTP id x3so2200716qcv.22
        for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2014 06:41:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAM4voamr2yxqWq51-WuiWyVpS7hCyXJY8rE7dH3Xr7WwQoayiw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Amit Kachhap <amit.daniel@samsung.com>


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2014 at 09:26:55AM +0530, Abhilash Kesavan wrote:
> Hi Eduardo,
>=20
> On Mon, Dec 8, 2014 at 3:13 PM, Lukasz Majewski <l.majewski@samsung.com> =
wrote:
> > Hi Abhilash,
> >
> >> As samsung thermal support is enabled only for ARCH_EXYNOS, there is
> >> no need to select ARCH_HAS_BANDGAP from the arch-specific code.
> >> Removing this dependency will also allow the driver to be enabled on
> >> 64-bit SoCs.
> >>
> >> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> >> ---
> >> This was based on the discussion regarding adding ARCH_HAS_BANDGAP
> >> symbol for arm64 here:
> >> http://www.spinics.net/lists/arm-kernel/msg377560.html
> >>
> >>  drivers/thermal/samsung/Kconfig |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/thermal/samsung/Kconfig
> >> b/drivers/thermal/samsung/Kconfig index f760389..c43306e 100644
> >> --- a/drivers/thermal/samsung/Kconfig
> >> +++ b/drivers/thermal/samsung/Kconfig
> >> @@ -1,6 +1,6 @@
> >>  config EXYNOS_THERMAL
> >>       tristate "Exynos thermal management unit driver"
> >> -     depends on ARCH_HAS_BANDGAP && OF
> >> +     depends on OF
> >>       help
> >>         If you say yes here you get support for the TMU (Thermal
> >> Management Unit) driver for SAMSUNG EXYNOS series of SoCs. This
> >> driver initialises
> >
> > Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>
> > Acked-by: Lukasz Majewski <l.majewski@samsung.com>
>=20
> Can you pick up these 2 patches if they look OK ?

OK. Adding to my fixes queue.

>=20
> Regards,
> Abhilash
> >
> > --
> > Best regards,
> >
> > Lukasz Majewski
> >
> > Samsung R&D Institute Poland (SRPOL) | Linux Platform Group

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUiFuAAAoJEMLUO4d9pOJW4qMH/AiQS9h8cThMe4whakQn9+kC
eRVNAWg/UzMVP32xot3PRkLF5ITqtXME4BeYuSqkf1SgxPNFm3UhROG2xkX8ktrG
xhk8zroLWZIVkhdzrI5mUDQVDPNwADu1/9OoM1gcRN5A0qqvG9DiIrxIsLOPwa8n
Cx2yBS0HwF0/ouXeDZoWfIjJr9yRUS2BisfjCXm+Npv6WtCJzFx5mI8SpfpR2O8v
ez182qhNzfBSg3x5q3bn8tYi1ODzf8YUE8t0KK6D189MtcpKxODIUKwe3/7DKHWS
dpWMUkyoqHcQmTdEfL+h8KapR2aVx+K1DADARP3wZ2jCJ1oWdUJhm+btbIvZy+Y=
=ugI8
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
