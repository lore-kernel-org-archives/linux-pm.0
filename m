From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/8] thermal: Provide stub for thermal_cdev_update()
 function
Date: Fri, 2 Jan 2015 14:40:29 -0400
Message-ID: <20150102184028.GA12371@developer>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1419265668-32283-1-git-send-email-l.majewski@samsung.com>
 <1419265668-32283-3-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1419265668-32283-3-git-send-email-l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lukasz Majewski <l.majewski-AM3owJQeAb5mR6Xm/wNWPw@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Abhilash Kesavan <kesavan.abhilash-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2014 at 05:27:42PM +0100, Lukasz Majewski wrote:
> Odroid U3 fan can work without being registered as OF cooling device
> (with CONFIG_THERMAL_OF disabled).
> In this situation it can be controlled via PWM entry at
> /sys/class/hwmon/hwmon0/pwm1.
>=20
> Therefore, the thermal_cdev_update() function needs a stub
> to allow clean compilation.

I am not sure I understand what you are attempting to do here. What is
the relation that you see between CONFIG_OF_THERMAL and
thermal_cdev_update?=20

>=20
> Signed-off-by: Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
> Changes for v2:
> - New patch
> ---
>  include/linux/thermal.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 871123c..b3515b5 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -332,6 +332,7 @@ struct thermal_cooling_device *
>  thermal_of_cooling_device_register(struct device_node *np,
>  				   char *type, void *devdata,
>  				   const struct thermal_cooling_device_ops *);
> +void thermal_cdev_update(struct thermal_cooling_device *);
>  #else
>  static inline struct thermal_zone_device *
>  thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
> @@ -353,6 +354,10 @@ thermal_of_cooling_device_register(struct device_nod=
e *np,
>  {
>  	return NULL;
>  }
> +
> +static inline void thermal_cdev_update(struct thermal_cooling_device *cd=
ev)
> +{
> +}
>  #endif
>  struct thermal_zone_device *thermal_zone_device_register(const char *, i=
nt, int,
>  		void *, struct thermal_zone_device_ops *,
> @@ -375,7 +380,6 @@ int thermal_zone_get_temp(struct thermal_zone_device =
*tz, unsigned long *temp);
>  int get_tz_trend(struct thermal_zone_device *, int);
>  struct thermal_instance *get_thermal_instance(struct thermal_zone_device=
 *,
>  		struct thermal_cooling_device *, int);
> -void thermal_cdev_update(struct thermal_cooling_device *);
>  void thermal_notify_framework(struct thermal_zone_device *, int);
> =20
>  #ifdef CONFIG_NET
> --=20
> 2.0.0.rc2
>=20

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUpuYSAAoJEMLUO4d9pOJWor4IAINd5mQoeQJ/awjaWQXnVnYl
JGk6RFP7Ai9JY7QP4udjOmievjqlIG5RMlarb5jF5DdJ6rBUiIz4a2WypCazUZv6
A65X9xnemOuMb3jBGw8afE5VcFp3NZ3jo/AxNRHufDoo441P82U/ysvwS3yhQ2/F
htsuIL/14ltdWELzO87pgI3vEshSawi+0Eyv8J6hbWIX9b+DinCGwm/+npVI5z74
kyDktfZNxYLaJ/R/a4XdwPRXmbAerLABLuYqT8B9vq7zrB1myKVYCqOzr0xNXg/R
Wv7lCGQVNS7Bg5YOhvurJ7FMxbhxJJAgv8ySj8hj2AC+PDabmJBXLlagbXobMBE=
=x4Gp
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
