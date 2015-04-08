From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V4 3/3] Thermal: do thermal zone update after a cooling
 device registered
Date: Wed, 8 Apr 2015 08:04:21 -0700
Message-ID: <20150408150420.GB28698@localhost.localdomain>
References: <1428373476-14257-1-git-send-email-rui.zhang@intel.com>
 <1428373476-14257-4-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:32894 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440AbbDHPEL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Apr 2015 11:04:11 -0400
Received: by pdbnk13 with SMTP id nk13so118322513pdb.0
        for <linux-pm@vger.kernel.org>; Wed, 08 Apr 2015 08:04:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1428373476-14257-4-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rui,

On Tue, Apr 07, 2015 at 10:24:36AM +0800, Zhang Rui wrote:
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
> index 875a9bb..e37042c 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1140,6 +1140,7 @@ __thermal_cooling_device_register(struct device_nod=
e *np,
>  				  const struct thermal_cooling_device_ops *ops)
>  {
>  	struct thermal_cooling_device *cdev;
> +	struct thermal_instance *pos, *next;
>  	int result;
> =20
>  	if (type && strlen(type) >=3D THERMAL_NAME_LENGTH)
> @@ -1184,6 +1185,15 @@ __thermal_cooling_device_register(struct device_no=
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
> +	}

Maybe the reasoning for not calling only when initialized =3D=3D false is
because at this point all instances are initialized =3D=3D false.=20

Then why not moving this thermal_zone_device_update(tz) to the
thermal_zone_bind_cooling_device(), where we create the
thermal_instance?

> +

Besides, Can you please elaborate more on why we need to specifically call
thermal_zone_device_update(tz) here and not simply wait until next
tz->poll_queue work is called?

Any particular reason for the problem not be solved byt the call
of thermal_zone_device_update(tz) from the poll_queue of each tz?



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

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVJUNvAAoJEMLUO4d9pOJWrrAIAI6iBQZcWzOv1DK3tkVCV7fl
SlGlhSn9KMhtclyyioIqsLb4gmVP+Ojq58Jj58plOAqCU216It4s8w0r8zgs6+0G
pg5OBOqgpQuLqCoRTlGe+HkRe6o1/W2x068ylnhUXmui4JtxEu1XsOfkNZ3ye3f9
h9Bmcj6CWVgWdSXeLSYMwrsfAnOMST0pNJFnYmqj0Bh2nrQmyEn+RsSA9q5Xq2na
9tFELIUra4gK7jBW/xtX9GsecJJaRiuei2IwVdXAVf2vXW/r+Ek+KVagkbGUOSHp
ruUSM6ZrnwjoGFDgtLDCGiwLeBwNndT0KG1BGOx3R7bNmeetR7Z35qIR6TC+6oc=
=WYDv
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
