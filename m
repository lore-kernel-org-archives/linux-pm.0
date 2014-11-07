From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] Thermal/int340x: avoid unnecessary pointer casting
Date: Fri, 7 Nov 2014 15:06:55 -0400
Message-ID: <20141107190652.GA27438@developer>
References: <1415145214-2986-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:43348 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017AbaKGTHE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Nov 2014 14:07:04 -0500
Received: by mail-qa0-f52.google.com with SMTP id u7so2779791qaz.11
        for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2014 11:07:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1415145214-2986-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Zhang Rui <rui.zhang@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Nov 04, 2014 at 03:53:34PM -0800, Jacob Pan wrote:
> Avoid pointer casting which may also lead to problems on big endian
> 64 bit systems.
>=20
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/thermal/int340x_thermal/acpi_thermal_rel.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/thermal/int340x_thermal/acpi_thermal_rel.c b/drivers=
/thermal/int340x_thermal/acpi_thermal_rel.c
> index 0d8db80..ac5c405 100644
> --- a/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
> +++ b/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
> @@ -317,21 +317,21 @@ static long acpi_thermal_rel_ioctl(struct file *f, =
unsigned int cmd,
>  {
>  	int ret =3D 0;
>  	unsigned long length =3D 0;
> -	unsigned long count =3D 0;
> +	int count =3D 0;
>  	char __user *arg =3D (void __user *)__arg;
>  	struct trt *trts;
>  	struct art *arts;
> =20
>  	switch (cmd) {
>  	case ACPI_THERMAL_GET_TRT_COUNT:
> -		ret =3D acpi_parse_trt(acpi_thermal_rel_handle, (int *)&count,
> +		ret =3D acpi_parse_trt(acpi_thermal_rel_handle, &count,
>  				&trts, false);
>  		kfree(trts);
>  		if (!ret)
>  			return put_user(count, (unsigned long __user *)__arg);
>  		return ret;
>  	case ACPI_THERMAL_GET_TRT_LEN:
> -		ret =3D acpi_parse_trt(acpi_thermal_rel_handle, (int *)&count,
> +		ret =3D acpi_parse_trt(acpi_thermal_rel_handle, &count,
>  				&trts, false);
>  		kfree(trts);
>  		length =3D count * sizeof(union trt_object);
> @@ -341,14 +341,14 @@ static long acpi_thermal_rel_ioctl(struct file *f, =
unsigned int cmd,
>  	case ACPI_THERMAL_GET_TRT:
>  		return fill_trt(arg);
>  	case ACPI_THERMAL_GET_ART_COUNT:
> -		ret =3D acpi_parse_art(acpi_thermal_rel_handle, (int *)&count,
> +		ret =3D acpi_parse_art(acpi_thermal_rel_handle, &count,
>  				&arts, false);
>  		kfree(arts);
>  		if (!ret)
>  			return put_user(count, (unsigned long __user *)__arg);
>  		return ret;
>  	case ACPI_THERMAL_GET_ART_LEN:
> -		ret =3D acpi_parse_art(acpi_thermal_rel_handle, (int *)&count,
> +		ret =3D acpi_parse_art(acpi_thermal_rel_handle, &count,
>  				&arts, false);
>  		kfree(arts);
>  		length =3D count * sizeof(union art_object);


To me, this change is reasonable.

Rui, any comments/objections on this fix?

> --=20
> 1.9.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXRhFAAoJEMLUO4d9pOJW7pAH/07nuPtRTdAGPhHOstN6C1Hz
8eJX/qLaV3CiniEDiPKKtEjzcV4oQr71fW/NqGqLSQ2Y8DZL86T81jK8lYyd1Blp
+GspiUvEi8I5kewHmVEuw0XlD7T6Piajz1+z/UGfn8UyCJtcj1X2HFP9L9qp3BpR
Zj+o6JEKukcP/Xmp7Fm2PIiFZEjgjeVRsxSOvLAH3MZBew+57wML1p3QaYx+5JDn
FfVf7A+S2EOG1F1CpYiAK3IH3KeryYHN0MP3GoXYq6rNrF95RrjJSursxKd6bZDt
ys6wuAOCLs9WsQL4wXMiUTzUyQDqwJdKnAkOkyINaR4v2m7bdzBCi1LxUotk3lE=
=7InV
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
