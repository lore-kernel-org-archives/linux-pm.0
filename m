From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v1 2/3] PM / sysfs: Remove redundant 'else' keyword.
Date: Wed, 15 Nov 2017 13:01:46 +0100
Message-ID: <20171115120146.GB8336@amd>
References: <20171110182809.85953-1-andriy.shevchenko@linux.intel.com>
 <20171110182809.85953-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59142 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932180AbdKOMBs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 07:01:48 -0500
Content-Disposition: inline
In-Reply-To: <20171110182809.85953-2-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-11-10 20:28:08, Andy Shevchenko wrote:
> There is no need to use 'else' if in main branch 'return' is present.
>=20
> No functional change intended.

Acked-by: Pavel Machek <pavel@ucw.cz>

>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/power/sysfs.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index 662632ac5e0e..1bf5e163ef1f 100644
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -216,7 +216,7 @@ static ssize_t pm_qos_resume_latency_show(struct devi=
ce *dev,
> =20
>  	if (value =3D=3D 0)
>  		return sprintf(buf, "n/a\n");
> -	else if (value =3D=3D PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
> +	if (value =3D=3D PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
>  		value =3D 0;
> =20
>  	return sprintf(buf, "%d\n", value);
> @@ -261,7 +261,7 @@ static ssize_t pm_qos_latency_tolerance_show(struct d=
evice *dev,
> =20
>  	if (value < 0)
>  		return sprintf(buf, "auto\n");
> -	else if (value =3D=3D PM_QOS_LATENCY_ANY)
> +	if (value =3D=3D PM_QOS_LATENCY_ANY)
>  		return sprintf(buf, "any\n");
> =20
>  	return sprintf(buf, "%d\n", value);
> @@ -527,11 +527,11 @@ static ssize_t rtpm_children_show(struct device *de=
v,
>  static ssize_t rtpm_enabled_show(struct device *dev,
>  				 struct device_attribute *attr, char *buf)
>  {
> -	if ((dev->power.disable_depth) && (dev->power.runtime_auto =3D=3D false=
))
> +	if (dev->power.disable_depth && (dev->power.runtime_auto =3D=3D false))
>  		return sprintf(buf, "disabled & forbidden\n");
> -	else if (dev->power.disable_depth)
> +	if (dev->power.disable_depth)
>  		return sprintf(buf, "disabled\n");
> -	else if (dev->power.runtime_auto =3D=3D false)
> +	if (dev->power.runtime_auto =3D=3D false)
>  		return sprintf(buf, "forbidden\n");
>  	return sprintf(buf, "enabled\n");
>  }

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAloMLKoACgkQMOfwapXb+vL94wCfbMBpKgzxxXWu0B9X/yYtrYhM
STcAoLIRMQQuVXqTmSGQB5zT2vZFdeY1
=wYt3
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
