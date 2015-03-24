From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 3/3] Thermal: do thermal zone update after a cooling
 device registered
Date: Tue, 24 Mar 2015 11:12:50 -0400
Message-ID: <20150324151249.GD29155@developer.hsd1.ca.comcast.net>
References: <1427174490-7974-1-git-send-email-rui.zhang@intel.com>
 <1427174490-7974-4-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33229 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbbCXPMX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2015 11:12:23 -0400
Content-Disposition: inline
In-Reply-To: <1427174490-7974-4-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, stable@vger.kernel.org


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 24, 2015 at 01:21:30PM +0800, Zhang Rui wrote:
> When a new cooling device is registered, we need to update the
> thermal zone to set the new registered cooling device to a proper
> state.
>=20
> This fixes a problem that the system is cool, while the fan devices are l=
eft
> running on full speed after boot, if fan device is registered after
> thermal zone device.
>=20
> CC: <stable@vger.kernel.org> #3.18+
> Reference:https://bugzilla.kernel.org/show_bug.cgi?id=3D92431
> Tested-by: Manuel Krause <manuelkrause@netscape.net>
> Tested-by: szegad <szegadlo@poczta.onet.pl>
> Tested-by: prash <prash.n.rao@gmail.com>
> Tested-by: amish <ammdispose-arch@yahoo.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/thermal_core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 9c03561..7cef579 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1141,6 +1141,7 @@ __thermal_cooling_device_register(struct device_nod=
e *np,
>  				  const struct thermal_cooling_device_ops *ops)
>  {
>  	struct thermal_cooling_device *cdev;
> +	struct thermal_instance *pos, *next;
>  	int result;
> =20
>  	if (type && strlen(type) >=3D THERMAL_NAME_LENGTH)
> @@ -1185,6 +1186,15 @@ __thermal_cooling_device_register(struct device_no=
de *np,
>  	/* Update binding information for 'this' new cdev */
>  	bind_cdev(cdev);
> =20
> +	list_for_each_entry_safe(pos, next, &cdev->thermal_instances, cdev_node=
) {
> +			if (next->cdev_node.next =3D=3D &cdev->thermal_instances) {
> +				thermal_zone_device_update(next->tz);
> +				break;
> +			}
> +			if (pos->tz !=3D next->tz)
> +				thermal_zone_device_update(pos->tz);

Shouldn't we simply trigger a thermal_zone_device_update(pos->tz) ? I
mean, we are adding a new cooling device to the zone, so, it might make
sense to update it anyway.

> +	}


> +
>  	return cdev;
>  }
> =20
> --=20
> 1.9.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJVEX7xAAoJEMLUO4d9pOJW20QH+wfS2A2aQSo8cwXiW2Rrnhck
XVX0r5x2GnchG0l3CGa8CEWJUigPBuL9eH34D7gSZuj1wE68vGQh2v4Jiy8DY8yK
Gc464trGdVSMNn6lET+Gyswm7JIIZkDfeaX1m4Bkb2QS6DJyd4DYdgNs12Lnu3OV
wadKPbpA1jgsmaiEI9pyRw9KMvvonXA4Yi/v86XTiBet+wdbMX187iGJmDU4cFOU
J3jIEEScTiUWX6BuTGI+eR6O4H6phUv4mp7EVDXKP4xz69grqxcK/q2QQ+LazC5G
xb30Z7ODL93O0fNDJqOd00+i6WsG9G2gyQC6VoC+u396nsnJsQp+q9n+v5a5gIY=
=GXQg
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--
