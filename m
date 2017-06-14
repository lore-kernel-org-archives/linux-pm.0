From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2] power: supply: twl4030_charger: Use
 sysfs_match_string() helper
Date: Wed, 14 Jun 2017 22:11:38 +0200
Message-ID: <20170614201138.svwvsaczfpkvpvpu@earth>
References: <20170611151548.7153-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2c2urigmg4zkc2si"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751664AbdFNULo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Jun 2017 16:11:44 -0400
Content-Disposition: inline
In-Reply-To: <20170611151548.7153-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pm@vger.kernel.org


--2c2urigmg4zkc2si
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jun 11, 2017 at 06:15:48PM +0300, Andy Shevchenko wrote:
> Use sysfs_match_string() helper instead of open coded variant.
>=20
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, queued.

-- Sebastian

> ---
>  - constify array of mode names
>  drivers/power/supply/twl4030_charger.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/suppl=
y/twl4030_charger.c
> index 785a07bc4f39..07c70e59f31a 100644
> --- a/drivers/power/supply/twl4030_charger.c
> +++ b/drivers/power/supply/twl4030_charger.c
> @@ -153,7 +153,7 @@ struct twl4030_bci {
>  };
> =20
>  /* strings for 'usb_mode' values */
> -static char *modes[] =3D { "off", "auto", "continuous" };
> +static const char *modes[] =3D { "off", "auto", "continuous" };
> =20
>  /*
>   * clear and set bits on an given register on a given module
> @@ -669,14 +669,10 @@ twl4030_bci_mode_store(struct device *dev, struct d=
evice_attribute *attr,
>  	int mode;
>  	int status;
> =20
> -	if (sysfs_streq(buf, modes[0]))
> -		mode =3D 0;
> -	else if (sysfs_streq(buf, modes[1]))
> -		mode =3D 1;
> -	else if (sysfs_streq(buf, modes[2]))
> -		mode =3D 2;
> -	else
> -		return -EINVAL;
> +	mode =3D sysfs_match_string(modes, buf);
> +	if (mode < 0)
> +		return mode;
> +
>  	if (dev =3D=3D &bci->ac->dev) {
>  		if (mode =3D=3D 2)
>  			return -EINVAL;
> --=20
> 2.11.0
>=20

--2c2urigmg4zkc2si
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllBmHQACgkQ2O7X88g7
+prWEA/+Lf0GSTXhm3z3z1vdLYGhjpv0XyAuZw3WvuFiLKbzl5+tfNp0uil4Ywvr
/csAe4IEACmji1DnnCvr5pjFzCi2SSWP4eKSYwxPqzU9PWv7NDQeDhG8G7hs4JV9
bNqXeheezxt9Or8JPPmPSkGPN5UMidqIQ7CLAQE2UeYsDPpQS3vH6reE+qbS88E+
13ptoaowR9KwTi/z8KUdqpv0JWZB/qpOLAzOSdJRlQGTgf6ALwInEbP9fyfDEuTj
0LiXKfRDFh3MrSdmOD7L3zkA9g9duRNk5JdPnFBjNVpXplERYb7QbykQtfliCxe5
nDcQhHGiSLr0mMA57RJeh3q76IfIRnwX4pMzsCPyQmjkZMc6T6SdXmc8AjtdKmNQ
gvbFuN7xKTMoC/KnEBLZtyVxxq+mmdhYkHAO2fMSzqqr60/lwmMX+gM0eIH4mMlp
IYNrRhII26y+aiLGZmAWKlb/9lqtzDdTEtG+2v13EMpW9LDSD5FZigix4vQsGwwq
rG827KdqLEq3DDLhWpUk1hUITLgWOpiwFkARyZ10XJqHn4l1xyIgVxqOg/b1kYlK
VL8uhdRy7AlGWlhat/PJZNYo1pWVhsm327Q77pkzQlXdtkBbMvuyivb2l2xaHGWg
UeaWF6XEckzLf534dSExguzI1uWYSlnorYDJI+m6fQKiJfaWJCk=
=0bFl
-----END PGP SIGNATURE-----

--2c2urigmg4zkc2si--
