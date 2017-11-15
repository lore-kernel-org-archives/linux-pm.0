From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v1 1/3] PM / sysfs: Convert to use sysfs_streq()
Date: Wed, 15 Nov 2017 11:32:52 +0100
Message-ID: <20171115103252.GA32656@amd>
References: <20171110182809.85953-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56887 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757494AbdKOKcy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 05:32:54 -0500
Content-Disposition: inline
In-Reply-To: <20171110182809.85953-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> ...instead of custom approach.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/power/sysfs.c | 39 +++++++++------------------------------
>  1 file changed, 9 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index e153e28b1857..662632ac5e0e 100644
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -108,16 +108,10 @@ static ssize_t control_show(struct device *dev, str=
uct device_attribute *attr,
>  static ssize_t control_store(struct device * dev, struct device_attribut=
e *attr,
>  			     const char * buf, size_t n)
>  {
> -	char *cp;
> -	int len =3D n;
> -
> -	cp =3D memchr(buf, '\n', n);
> -	if (cp)
> -		len =3D cp - buf;
>  	device_lock(dev);
> -	if (len =3D=3D sizeof ctrl_auto - 1 && strncmp(buf, ctrl_auto, len) =3D=
=3D 0)
> +	if (sysfs_streq(buf, ctrl_auto))
>  		pm_runtime_allow(dev);
> -	else if (len =3D=3D sizeof ctrl_on - 1 && strncmp(buf, ctrl_on, len) =
=3D=3D 0)
> +	else if (sysfs_streq(buf, ctrl_on))
>  		pm_runtime_forbid(dev);
>  	else
>  		n =3D -EINVAL;

Are you sure? _streq does not get passed size_t n; how does it
guarantee no out-of-bounds access?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAloMF9QACgkQMOfwapXb+vK0kwCeJnQ+TCHQI76tn2jbU5Jx7mCR
2zkAn2DavjsqVXWyr8Z8k02lXam2Yvfu
=5EeW
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
