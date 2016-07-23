From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 7/7] power_supply: make use of new strcpytoupper()
 function
Date: Sat, 23 Jul 2016 02:00:49 +0200
Message-ID: <20160723000048.GB31677@earth>
References: <1469230269-1644-1-git-send-email-mmayer@broadcom.com>
 <1469230269-1644-8-git-send-email-mmayer@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34666 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752334AbcGWAAy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 22 Jul 2016 20:00:54 -0400
Content-Disposition: inline
In-Reply-To: <1469230269-1644-8-git-send-email-mmayer@broadcom.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Markus Mayer <mmayer@broadcom.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 22, 2016 at 04:31:09PM -0700, Markus Mayer wrote:
> Call strcpytoupper() rather than walking the string explicitly to
> convert it to uppercase.
>=20
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  drivers/power/power_supply_sysfs.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/power/power_supply_sysfs.c b/drivers/power/power_sup=
ply_sysfs.c
> index 80fed98..20fdcc5 100644
> --- a/drivers/power/power_supply_sysfs.c
> +++ b/drivers/power/power_supply_sysfs.c
> @@ -256,19 +256,16 @@ void power_supply_init_attrs(struct device_type *de=
v_type)
> =20
>  static char *kstruprdup(const char *str, gfp_t gfp)
>  {
> -	char *ret, *ustr;
> +	char *ustr;
> =20
> -	ustr =3D ret =3D kmalloc(strlen(str) + 1, gfp);
> +	ustr =3D kmalloc(strlen(str) + 1, gfp);
> =20
> -	if (!ret)
> +	if (!ustr)
>  		return NULL;
> =20
> -	while (*str)
> -		*ustr++ =3D toupper(*str++);
> +	strcpytoupper(ustr, str);
> =20
> -	*ustr =3D 0;
> -
> -	return ret;
> +	return ustr;
>  }
> =20
>  int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)

Acked-By: Sebastian Reichel <sre@kernel.org>

Note: I plan to merge [0] (Move power supply subsystem to
drivers/power/supply) directly after 4.8-rc1, which will
result in merge conflicts if this goes into the kernel via
some other subsystem.

[0] https://marc.info/?l=3Dlinux-pm&m=3D146617051028786&w=3D2

-- Sebastian

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXkrOsAAoJENju1/PIO/qaj5kQAJE/G2sSXqA2pQiwN5ePW2qF
73njoECG8dd8TYC/k5UWuXTPKSJZn/7PP1V7o9yFbrNsbRu9WEFpYo9+vmAU3hOD
ILtMpoHDY3OJxGN06OZEQqe+JWilAfRwff1Wcr17jDFbR9nxuYzVunZ+iTdkG+q/
Ul2yL2R8Bhisa9wLMUoejT5YHFh5K5vqQMy1VkiyYgIusS/mNw1ZKejIZ6cANbCM
saDq/NUyQNPLD9wKulmErxaxlgQwaNwUoH628eyfpMaRaMW9i/09imp0Mdb4vyl2
/hjLx8i35K7ZWo2zACW0v/ONUo9bHw24YPAM4qETMS98Byiwr7a7wF/yQndorBZy
fDmAgzhkijleqLYgDZpTi1oCb6/T6veRbhlRvAESU/CiG65hqblj4fIqCvK9q83z
IdAtXFcsCgv91v/el5Wibhraxt9NJ101T9krYsUULmDrM9NMYKcJwyIcVwmmy9ZU
reNbMoz/v2no3Jsx37ihQ84sTIfH+rI73UHBcPX5r1Be0oPdS4cXMBWjGDiiofLR
mhNYbRcuhm6/MYOIFLbMTqgvuyTAyUWwhPDvMCdR55/NAKATj2t7ABaBpncVqIje
PvrTy5hL5blxgWpJimbHrUi+6JHwbClUUCKKfO/WFd+u0sSuYXlIEtyy4sJQZgdh
gxxtnbwvP7QxB2x2M93t
=Mvph
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
