From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 01/13] thermal: Make temperatures consistently unsigned
 long
Date: Mon, 6 Apr 2015 18:45:48 -0700
Message-ID: <20150407014546.GA4648@localhost.localdomain>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-2-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33964 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787AbbDGBpk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2015 21:45:40 -0400
Content-Disposition: inline
In-Reply-To: <1427385240-6086-2-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2015 at 04:53:48PM +0100, Sascha Hauer wrote:
> The thermal framework uses int, long and unsigned long for temperatures
> in millicelsius. The majority of functions uses unsigned long, so change
> the remaining functions to use this type aswell.

I believe it make sense to change all to be int. int covers for the
required temperature range.=20

Rui is just introducing the concept of invalid temp, which is below 0 K.

>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/thermal/thermal_core.c | 10 +++++-----
>  include/linux/thermal.h        |  6 +++---

This change is not that straight forward as it looks like.=20

In order to standardize this, apart from the thermal core
we will need to make drivers aware of the change too.
That will require changing the thermal zone device ops and all its
users, for the trip temperature, temperature, and hysteresis cases.

>  2 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 174d3bc..0e4ad7c 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -378,7 +378,7 @@ static void handle_critical_trips(struct thermal_zone=
_device *tz,
> =20
>  	if (trip_type =3D=3D THERMAL_TRIP_CRITICAL) {
>  		dev_emerg(&tz->device,
> -			  "critical temperature reached(%d C),shutting down\n",
> +			  "critical temperature reached(%lu C),shutting down\n",
>  			  tz->temperature / 1000);
>  		orderly_poweroff(true);
>  	}
> @@ -453,7 +453,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
> =20
>  static void update_temperature(struct thermal_zone_device *tz)
>  {
> -	long temp;
> +	unsigned long temp;
>  	int ret;
> =20
>  	ret =3D thermal_zone_get_temp(tz, &temp);
> @@ -469,7 +469,7 @@ static void update_temperature(struct thermal_zone_de=
vice *tz)
>  	mutex_unlock(&tz->lock);
> =20
>  	trace_thermal_temperature(tz);
> -	dev_dbg(&tz->device, "last_temperature=3D%d, current_temperature=3D%d\n=
",
> +	dev_dbg(&tz->device, "last_temperature=3D%lu, current_temperature=3D%lu=
\n",
>  				tz->last_temperature, tz->temperature);
>  }
> =20
> @@ -512,7 +512,7 @@ static ssize_t
>  temp_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
>  	struct thermal_zone_device *tz =3D to_thermal_zone(dev);
> -	long temperature;
> +	unsigned long temperature;
>  	int ret;
> =20
>  	ret =3D thermal_zone_get_temp(tz, &temperature);
> @@ -520,7 +520,7 @@ temp_show(struct device *dev, struct device_attribute=
 *attr, char *buf)
>  	if (ret)
>  		return ret;
> =20
> -	return sprintf(buf, "%ld\n", temperature);
> +	return sprintf(buf, "%lu\n", temperature);
>  }
> =20
>  static ssize_t
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 5eac316..db6c12b 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -180,9 +180,9 @@ struct thermal_zone_device {
>  	int trips;
>  	int passive_delay;
>  	int polling_delay;
> -	int temperature;
> -	int last_temperature;
> -	int emul_temperature;
> +	unsigned long temperature;
> +	unsigned long last_temperature;
> +	unsigned long emul_temperature;
>  	int passive;
>  	unsigned int forced_passive;
>  	struct thermal_zone_device_ops *ops;

Something like the following would be required to do a standardization.
Of course, the code below requires changing drivers too:

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 6bbe11c..84c9777 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -92,7 +92,7 @@ struct thermal_zone_device_ops {
 		     struct thermal_cooling_device *);
 	int (*unbind) (struct thermal_zone_device *,
 		       struct thermal_cooling_device *);
-	int (*get_temp) (struct thermal_zone_device *, unsigned long *);
+	int (*get_temp) (struct thermal_zone_device *, int *);
 	int (*get_mode) (struct thermal_zone_device *,
 			 enum thermal_device_mode *);
 	int (*set_mode) (struct thermal_zone_device *,
@@ -100,15 +100,15 @@ struct thermal_zone_device_ops {
 	int (*get_trip_type) (struct thermal_zone_device *, int,
 		enum thermal_trip_type *);
 	int (*get_trip_temp) (struct thermal_zone_device *, int,
-			      unsigned long *);
+			      int *);
 	int (*set_trip_temp) (struct thermal_zone_device *, int,
-			      unsigned long);
+			      int);
 	int (*get_trip_hyst) (struct thermal_zone_device *, int,
-			      unsigned long *);
+			      int *);
 	int (*set_trip_hyst) (struct thermal_zone_device *, int,
-			      unsigned long);
-	int (*get_crit_temp) (struct thermal_zone_device *, unsigned long *);
-	int (*set_emul_temp) (struct thermal_zone_device *, unsigned long);
+			      int);
+	int (*get_crit_temp) (struct thermal_zone_device *, int *);
+	int (*set_emul_temp) (struct thermal_zone_device *, int);
 	int (*get_trend) (struct thermal_zone_device *, int,
 			  enum thermal_trend *);
 	int (*notify) (struct thermal_zone_device *, int,
@@ -321,9 +321,9 @@ struct thermal_genl_event {
  *		   temperature.
  */
 struct thermal_zone_of_device_ops {
-	int (*get_temp)(void *, long *);
-	int (*get_trend)(void *, long *);
-	int (*set_emul_temp)(void *, unsigned long);
+	int (*get_temp)(void *, int *);
+	int (*get_trend)(void *, int *);
+	int (*set_emul_temp)(void *, int);
 };
=20
 /**
@@ -336,8 +336,8 @@ struct thermal_zone_of_device_ops {
=20
 struct thermal_trip {
 	struct device_node *np;
-	unsigned long int temperature;
-	unsigned long int hysteresis;
+	int temperature;
+	int hysteresis;
 	enum thermal_trip_type type;
 };
=20
@@ -395,7 +395,7 @@ thermal_of_cooling_device_register(struct device_node *=
np, char *, void *,
 				   const struct thermal_cooling_device_ops *);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
 struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name=
);
-int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned long *t=
emp);
+int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
=20
 int get_tz_trend(struct thermal_zone_device *, int);
 struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
@@ -446,7 +446,7 @@ static inline struct thermal_zone_device *thermal_zone_=
get_zone_by_name(
 		const char *name)
 { return ERR_PTR(-ENODEV); }
 static inline int thermal_zone_get_temp(
-		struct thermal_zone_device *tz, unsigned long *temp)
+		struct thermal_zone_device *tz, int *temp)
 { return -ENODEV; }
 static inline int get_tz_trend(struct thermal_zone_device *tz, int trip)
 { return -ENODEV; }


> --=20
> 2.1.4
>=20

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVIzbDAAoJEMLUO4d9pOJWSCEIAIy1adw+hp4ohsSKNUOhn4cS
8I3V7txCDCCq3lrK7Cc2kR1ttMjJ2uJ/GmZLjXWscuyLMjKdqIBqOTLEorckV/+j
Y0CdNSyaTheVztY+Pm2JdhF4dUCzaSM9S5EjhbcBID0KYDIH/4xncPdV2f/ZAeCO
scJenFeTMsoXooQnd+hdO2dRAjNn7STDiACUcYLDTE7Fmc7hyK0b/bN/TsuHDr8d
RihYx97nnx0dCqPag/TBHoh5d1iYDCI5FdXKXJe/vN0pFf1aH6w61+9kyy7bA7eV
Y76b9rpTMK9d2i/63dxOP/s7/IM5rT9EsYNTxTxjAUzmpf1+1Jysl3TW+cJuePY=
=45zT
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
