From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 13/13] thermal: of: implement .set_trips for device tree
 thermal zones
Date: Mon, 6 Apr 2015 19:43:08 -0700
Message-ID: <20150407024307.GH4648@localhost.localdomain>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-14-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9ZOS6odDaRI+0hI"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:35077 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbbDGCnA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2015 22:43:00 -0400
Content-Disposition: inline
In-Reply-To: <1427385240-6086-14-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org


--/9ZOS6odDaRI+0hI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2015 at 04:54:00PM +0100, Sascha Hauer wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/thermal/of-thermal.c | 12 ++++++++++++
>  include/linux/thermal.h      |  1 +
>  2 files changed, 13 insertions(+)

Can you please include at least one user of this call back in your patch
series?

>=20
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 9b63193..a3de5de 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -97,6 +97,17 @@ static int of_thermal_get_temp(struct thermal_zone_dev=
ice *tz,
>  	return data->ops->get_temp(data->sensor_data, temp);
>  }
> =20
> +static int of_thermal_set_trips(struct thermal_zone_device *tz,
> +			       unsigned long low, unsigned long high)
> +{
> +	struct __thermal_zone *data =3D tz->devdata;
> +
> +	if (!data->ops || !data->ops->set_trips)
> +		return -ENOSYS;
> +
> +	return data->ops->set_trips(data->sensor_data, low, high);
> +}
> +
>  /**
>   * of_thermal_get_ntrips - function to export number of available trip
>   *			   points.
> @@ -367,6 +378,7 @@ static int of_thermal_get_crit_temp(struct thermal_zo=
ne_device *tz,
> =20
>  static const struct thermal_zone_device_ops of_thermal_ops =3D {
>  	.get_temp =3D of_thermal_get_temp,
> +	.set_trips =3D of_thermal_set_trips,
>  	.get_trend =3D of_thermal_get_trend,
>  	.set_emul_temp =3D of_thermal_set_emul_temp,
> =20
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index b870702..84a5b5d 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -276,6 +276,7 @@ struct thermal_genl_event {
>   */
>  struct thermal_zone_of_device_ops {
>  	int (*get_temp)(void *, unsigned long *);
> +	int (*set_trips)(void *, unsigned long, unsigned long);

Could you please keep the kernel doc entry up to date? I know we donot
have entries for all structs, but I am working in improving this.

>  	int (*get_trend)(void *, int trend, enum thermal_trend *);
>  	int (*set_emul_temp)(void *, unsigned long);
>  };
> --=20
> 2.1.4
>=20

--/9ZOS6odDaRI+0hI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVI0Q4AAoJEMLUO4d9pOJW5UcH/01txPxO8jBRWLK1cVn8m66T
hQkmPAZba9scUBJUD40Ez1dY2RVO9Fp61Szd2CZed8sYCljaPQ69K5gQHceGdZPN
ry/jq9YZlLvnRJ2tsIvHaNWkhrUU5OS2YRefqeSeaLIVpTHhv9dm4kF8t90DOy6K
YEw9hhFRn/hl0XYYTMhSrrs/cFU6UtnkG8IAzxbFd6p+a/EhLZ+SoBpMxMEW2avl
sRsuM21JmUD2FsP+XqRHcQ2U8ydZPM+HHnM3V+NEpGtZhmyshY2TBzLhm476e2cf
r1kpE6uYvc9f2/51PhvJ+9UjM+ZqwLTdLPcTJyBRjkV4ZZgZm+YizI95NkKUGX0=
=DHYs
-----END PGP SIGNATURE-----

--/9ZOS6odDaRI+0hI--
