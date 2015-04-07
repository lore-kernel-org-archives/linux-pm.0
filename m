From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 11/13] thermal: of: make of_thermal_ops const
Date: Mon, 6 Apr 2015 20:27:40 -0700
Message-ID: <20150407032739.GM4648@localhost.localdomain>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-12-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pz/qqzCPDfGwIFOg"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33902 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbbDGD1c (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2015 23:27:32 -0400
Content-Disposition: inline
In-Reply-To: <1427385240-6086-12-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org


--Pz/qqzCPDfGwIFOg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2015 at 04:53:58PM +0100, Sascha Hauer wrote:
> Now that we no longer modify the ops they can be const again. Also
> we no longer have to duplicate them.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Should this one be merged to patch 09/13?

> ---
>  drivers/thermal/of-thermal.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index df14fdd..9b63193 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -365,7 +365,7 @@ static int of_thermal_get_crit_temp(struct thermal_zo=
ne_device *tz,
>  	return -EINVAL;
>  }
> =20
> -static struct thermal_zone_device_ops of_thermal_ops =3D {
> +static const struct thermal_zone_device_ops of_thermal_ops =3D {
>  	.get_temp =3D of_thermal_get_temp,
>  	.get_trend =3D of_thermal_get_trend,
>  	.set_emul_temp =3D of_thermal_set_emul_temp,
> @@ -539,10 +539,6 @@ void thermal_zone_of_sensor_unregister(struct device=
 *dev,
>  		return;
> =20
>  	mutex_lock(&tzd->lock);
> -	tzd->ops->get_temp =3D NULL;
> -	tzd->ops->get_trend =3D NULL;
> -	tzd->ops->set_emul_temp =3D NULL;
> -
>  	tz->ops =3D NULL;
>  	tz->sensor_data =3D NULL;
>  	mutex_unlock(&tzd->lock);
> @@ -849,7 +845,6 @@ int __init of_parse_thermal_zones(void)
>  {
>  	struct device_node *np, *child;
>  	struct __thermal_zone *tz;
> -	struct thermal_zone_device_ops *ops;
> =20
>  	np =3D of_find_node_by_name(NULL, "thermal-zones");
>  	if (!np) {
> @@ -873,29 +868,22 @@ int __init of_parse_thermal_zones(void)
>  			continue;
>  		}
> =20
> -		ops =3D kmemdup(&of_thermal_ops, sizeof(*ops), GFP_KERNEL);
> -		if (!ops)
> -			goto exit_free;
> -
>  		tzp =3D kzalloc(sizeof(*tzp), GFP_KERNEL);
> -		if (!tzp) {
> -			kfree(ops);
> +		if (!tzp)
>  			goto exit_free;
> -		}
> =20
>  		/* No hwmon because there might be hwmon drivers registering */
>  		tzp->no_hwmon =3D true;
> =20
>  		zone =3D thermal_zone_device_register(child->name, tz->ntrips,
>  						    0, tz,
> -						    ops, tzp,
> +						    &of_thermal_ops, tzp,
>  						    tz->passive_delay,
>  						    tz->polling_delay);
>  		if (IS_ERR(zone)) {
>  			pr_err("Failed to build %s zone %ld\n", child->name,
>  			       PTR_ERR(zone));
>  			kfree(tzp);
> -			kfree(ops);
>  			of_thermal_free_zone(tz);
>  			/* attempting to build remaining zones still */
>  		}
> --=20
> 2.1.4
>=20

--Pz/qqzCPDfGwIFOg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVI06mAAoJEMLUO4d9pOJW2twH/0BdBfsOqTY75gBUdK4bh1JO
nMHyCpe9DnDz6mStLlvZPqrG1VXxWUTC0/OuuuFU+OMiFcAcLdNV20itjOzGixOi
tBLB6PB/mMfopu/mjRjUCL9kQLYzV+YLsnUIlqv/K/G/XLxO6CsN80xIM6cR3I/k
x/e7dlq81ogy/wQzHWUKQ2PGHQwP48/U5+OrwNKAMKOzoF25zWgV2kWPcWYc8mhD
OVLJc4S9yRA1lxVpEN5OxgIK6HGpZy8Fg8wJUFp9vIYPUILwcGlV7oYo9ncpVrIb
fXu42MZ4QsSBR1luY+fjOmySJUEkapi1TulFFOVHurh0cZspoGK8QcFLYLr6xG8=
=2C63
-----END PGP SIGNATURE-----

--Pz/qqzCPDfGwIFOg--
