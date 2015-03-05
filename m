From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: Make sysfs attributes of cooling devices
 default attributes
Date: Thu, 5 Mar 2015 01:56:22 -0400
Message-ID: <20150305055620.GB3632@developer.hsd1.ca.comcast.net>
References: <1424484608-20181-1-git-send-email-mka@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36153 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbbCEFza (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Mar 2015 00:55:30 -0500
Received: by padfa1 with SMTP id fa1so33658649pad.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2015 21:55:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1424484608-20181-1-git-send-email-mka@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2015 at 06:10:08PM -0800, Matthias Kaehlcke wrote:
> Default attributes are created when the device is registered. Attributes
> created after device registration can lead to race conditions, where user=
 space
> (e.g. udev) sees the device but not the attributes.
>=20
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

applied into -fixes branch. Thanks.

> ---
>  drivers/thermal/thermal_core.c | 37 +++++++++++++++++--------------------
>  1 file changed, 17 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 48491d1..174d3bc 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -899,6 +899,22 @@ thermal_cooling_device_trip_point_show(struct device=
 *dev,
>  		return sprintf(buf, "%d\n", instance->trip);
>  }
> =20
> +static struct attribute *cooling_device_attrs[] =3D {
> +	&dev_attr_cdev_type.attr,
> +	&dev_attr_max_state.attr,
> +	&dev_attr_cur_state.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group cooling_device_attr_group =3D {
> +	.attrs =3D cooling_device_attrs,
> +};
> +
> +static const struct attribute_group *cooling_device_attr_groups[] =3D {
> +	&cooling_device_attr_group,
> +	NULL,
> +};
> +
>  /* Device management */
> =20
>  /**
> @@ -1130,6 +1146,7 @@ __thermal_cooling_device_register(struct device_nod=
e *np,
>  	cdev->ops =3D ops;
>  	cdev->updated =3D false;
>  	cdev->device.class =3D &thermal_class;
> +	cdev->device.groups =3D cooling_device_attr_groups;
>  	cdev->devdata =3D devdata;
>  	dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
>  	result =3D device_register(&cdev->device);
> @@ -1139,21 +1156,6 @@ __thermal_cooling_device_register(struct device_no=
de *np,
>  		return ERR_PTR(result);
>  	}
> =20
> -	/* sys I/F */
> -	if (type) {
> -		result =3D device_create_file(&cdev->device, &dev_attr_cdev_type);
> -		if (result)
> -			goto unregister;
> -	}
> -
> -	result =3D device_create_file(&cdev->device, &dev_attr_max_state);
> -	if (result)
> -		goto unregister;
> -
> -	result =3D device_create_file(&cdev->device, &dev_attr_cur_state);
> -	if (result)
> -		goto unregister;
> -
>  	/* Add 'this' new cdev to the global cdev list */
>  	mutex_lock(&thermal_list_lock);
>  	list_add(&cdev->node, &thermal_cdev_list);
> @@ -1163,11 +1165,6 @@ __thermal_cooling_device_register(struct device_no=
de *np,
>  	bind_cdev(cdev);
> =20
>  	return cdev;
> -
> -unregister:
> -	release_idr(&thermal_cdev_idr, &thermal_idr_lock, cdev->id);
> -	device_unregister(&cdev->device);
> -	return ERR_PTR(result);
>  }
> =20
>  /**
> --=20
> 2.2.0.rc0.207.ga3a616c
>=20

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU9+/8AAoJEMLUO4d9pOJWl4UH/1FZABNtqiZTXz6YvahU4ZFA
4NeVjz8QOVz3nIcSjs+Oh/TSEsBSw6ZUekcxGhrhpIQjHgJY3O6KcWwTCVb5m6fk
7LYYmRvQnjvGzOEIqmVeL2Ljxduj3O6Psv81TXyWrpB/gCMMf+SlZULbtoDg5EUJ
QaNS0uFTdlPpdWG7ANdFXd8ta1slkTB52t4B0TimFXQfLzhA8gKc6MBo78spuJhG
N9D+1nM4qnwAIqIpG04SntjpKBml/nQl2tGtBsGmNx/VTtRPiFe3VvSo8uqK6t2r
gvgjbU53bMOnk/abaqz0JJp0h9ipmYWDPdlUaDnmlLZKM1+YMCGpkB332x0r+E8=
=QJVR
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
