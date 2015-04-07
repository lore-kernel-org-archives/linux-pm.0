From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 10/13] thermal: Make struct thermal_zone_device_ops const
Date: Mon, 6 Apr 2015 20:29:49 -0700
Message-ID: <20150407032948.GN4648@localhost.localdomain>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-11-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nRwNdQxTdQ7rZk9A"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35171 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160AbbDGD3l (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2015 23:29:41 -0400
Content-Disposition: inline
In-Reply-To: <1427385240-6086-11-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org


--nRwNdQxTdQ7rZk9A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2015 at 04:53:57PM +0100, Sascha Hauer wrote:
> Now that the of thermal support no longer changes the
> thermal_zone_device_ops it can be const again.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/thermal/thermal_core.c | 2 +-
>  include/linux/thermal.h        | 6 +++---

I believe this change deserves to be done together with the required driver=
=20
updates on those parts that calls this function.

>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index acf00b5..dcdf45e 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1455,7 +1455,7 @@ static void remove_trip_attrs(struct thermal_zone_d=
evice *tz)
>   */
>  struct thermal_zone_device *thermal_zone_device_register(const char *typ=
e,
>  	int trips, int mask, void *devdata,
> -	struct thermal_zone_device_ops *ops,
> +	const struct thermal_zone_device_ops *ops,
>  	const struct thermal_zone_params *tzp,
>  	int passive_delay, int polling_delay)
>  {
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 2f77091..ac2897c 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -185,7 +185,7 @@ struct thermal_zone_device {
>  	unsigned long emul_temperature;
>  	int passive;
>  	unsigned int forced_passive;
> -	struct thermal_zone_device_ops *ops;
> +	const struct thermal_zone_device_ops *ops;
>  	const struct thermal_zone_params *tzp;
>  	struct thermal_governor *governor;
>  	struct list_head thermal_instances;
> @@ -317,7 +317,7 @@ void thermal_zone_of_sensor_unregister(struct device =
*dev,
> =20
>  #if IS_ENABLED(CONFIG_THERMAL)
>  struct thermal_zone_device *thermal_zone_device_register(const char *, i=
nt, int,
> -		void *, struct thermal_zone_device_ops *,
> +		void *, const struct thermal_zone_device_ops *,
>  		const struct thermal_zone_params *, int, int);
>  void thermal_zone_device_unregister(struct thermal_zone_device *);
> =20
> @@ -345,7 +345,7 @@ void thermal_notify_framework(struct thermal_zone_dev=
ice *, int);
>  #else
>  static inline struct thermal_zone_device *thermal_zone_device_register(
>  	const char *type, int trips, int mask, void *devdata,
> -	struct thermal_zone_device_ops *ops,
> +	const struct thermal_zone_device_ops *ops,
>  	const struct thermal_zone_params *tzp,
>  	int passive_delay, int polling_delay)
>  { return ERR_PTR(-ENODEV); }
> --=20
> 2.1.4
>=20

--nRwNdQxTdQ7rZk9A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVI08lAAoJEMLUO4d9pOJWyJQH/i4Ih5803Oj9REwGKmScmdcR
yClv35cFFhn12178CUHWl1nOHq6uLXWLfTQ6YusGwWYKQTLhFCV3ezFII9DQX7Mb
zqVYKow9LvFNbj9HMS+8h1UlNTr5RaSazZaXHdenUR39C3YVtqQE1OEuOLbOAQdy
mzkUZT6ytU2zwMYqgMdk7b7Byqh71+LxDth8RIsDP8aMAG2QcKPk4OZssqShYGK6
jBxDI+4CmAXW2iM7z1ibwGKihtb82uHaEgrWsIHr8+pnVkjq4zsVwKdPAfDieWSw
8lP/JpZQREwho3zzo0vbk/RNZVaiJ58b6kBBK81R1sVk2AlNm8ZRwng6QksNnsY=
=dKXq
-----END PGP SIGNATURE-----

--nRwNdQxTdQ7rZk9A--
