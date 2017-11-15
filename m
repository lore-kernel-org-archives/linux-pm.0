From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v1 1/3] PM / sysfs: Convert to use sysfs_streq()
Date: Wed, 15 Nov 2017 13:01:12 +0100
Message-ID: <20171115120111.GA8336@amd>
References: <20171110182809.85953-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59123 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755415AbdKOMBN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 07:01:13 -0500
Content-Disposition: inline
In-Reply-To: <20171110182809.85953-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-11-10 20:28:07, Andy Shevchenko wrote:
> ...instead of custom approach.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

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
> @@ -245,7 +239,7 @@ static ssize_t pm_qos_resume_latency_store(struct dev=
ice *dev,
> =20
>  		if (value =3D=3D 0)
>  			value =3D PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
> -	} else if (!strcmp(buf, "n/a") || !strcmp(buf, "n/a\n")) {
> +	} else if (sysfs_streq(buf, "n/a")) {
>  		value =3D 0;
>  	} else {
>  		return -EINVAL;
> @@ -285,9 +279,9 @@ static ssize_t pm_qos_latency_tolerance_store(struct =
device *dev,
>  		if (value < 0)
>  			return -EINVAL;
>  	} else {
> -		if (!strcmp(buf, "auto") || !strcmp(buf, "auto\n"))
> +		if (sysfs_streq(buf, "auto"))
>  			value =3D PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT;
> -		else if (!strcmp(buf, "any") || !strcmp(buf, "any\n"))
> +		else if (sysfs_streq(buf, "any"))
>  			value =3D PM_QOS_LATENCY_ANY;
>  		else
>  			return -EINVAL;
> @@ -342,20 +336,12 @@ static ssize_t
>  wake_store(struct device * dev, struct device_attribute *attr,
>  	const char * buf, size_t n)
>  {
> -	char *cp;
> -	int len =3D n;
> -
>  	if (!device_can_wakeup(dev))
>  		return -EINVAL;
> =20
> -	cp =3D memchr(buf, '\n', n);
> -	if (cp)
> -		len =3D cp - buf;
> -	if (len =3D=3D sizeof _enabled - 1
> -			&& strncmp(buf, _enabled, sizeof _enabled - 1) =3D=3D 0)
> +	if (sysfs_streq(buf, _enabled))
>  		device_set_wakeup_enable(dev, 1);
> -	else if (len =3D=3D sizeof _disabled - 1
> -			&& strncmp(buf, _disabled, sizeof _disabled - 1) =3D=3D 0)
> +	else if (sysfs_streq(buf, _disabled))
>  		device_set_wakeup_enable(dev, 0);
>  	else
>  		return -EINVAL;
> @@ -566,16 +552,9 @@ static ssize_t async_show(struct device *dev, struct=
 device_attribute *attr,
>  static ssize_t async_store(struct device *dev, struct device_attribute *=
attr,
>  			   const char *buf, size_t n)
>  {
> -	char *cp;
> -	int len =3D n;
> -
> -	cp =3D memchr(buf, '\n', n);
> -	if (cp)
> -		len =3D cp - buf;
> -	if (len =3D=3D sizeof _enabled - 1 && strncmp(buf, _enabled, len) =3D=
=3D 0)
> +	if (sysfs_streq(buf, _enabled))
>  		device_enable_async_suspend(dev);
> -	else if (len =3D=3D sizeof _disabled - 1 &&
> -		 strncmp(buf, _disabled, len) =3D=3D 0)
> +	else if (sysfs_streq(buf, _disabled))
>  		device_disable_async_suspend(dev);
>  	else
>  		return -EINVAL;

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAloMLIcACgkQMOfwapXb+vJF6wCaA+uqg4bYeeBtMXJjuiHEuDtm
WAQAoJfuwdpx2pfc5nRiJvmmDFIMCMvb
=6b9p
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
